// ==UserScript==
// @name         超星作答记录 - 题目自动分类收集器
// @namespace    https://github.com/chaoxing-tools
// @version      1.4
// @description  自动捕获作答记录中的全部题目，分为"做错的"和"做对的"两类，并自动去重。支持跨次作答累积收集。
// @author       Copilot
// @match        *://mooc1.chaoxing.com/mooc-ans/work/record-list*
// @match        *://mooc1.chaoxing.com/mooc-ans/work/record-detail*
// @match        *://mooc1.chaoxing.com/mycourse/studentstudy*
// @icon         https://mooc1.chaoxing.com/favicon.ico
// @grant        GM_addStyle
// @grant        GM_setValue
// @grant        GM_getValue
// @grant        GM_deleteValue
// @grant        GM_notification
// @run-at       document-end
// @license      MIT
// ==/UserScript==

(function () {
    'use strict';

    // ============================================================
    //  配置
    // ============================================================
    const STORAGE_KEY = 'CX_ANSWER_COLLECTOR_DATA';
    const DEBOUNCE_MS = 600; // AJAX 加载后等待 DOM 稳定的时间

    // ============================================================
    //  存储操作
    // ============================================================
    function loadData() {
        try {
            const raw = GM_getValue(STORAGE_KEY);
            return raw ? JSON.parse(raw) : { correct: [], wrong: [] };
        } catch {
            return { correct: [], wrong: [] };
        }
    }

    function saveData(data) {
        GM_setValue(STORAGE_KEY, JSON.stringify(data));
    }

    function clearData() {
        GM_deleteValue(STORAGE_KEY);
    }

    // ============================================================
    //  题目去重（基于题干文本，忽略空白差异）
    // ============================================================
    function normalizeText(text) {
        return text.replace(/\s+/g, '').trim();
    }

    function isDuplicate(list, question) {
        const key = normalizeText(question.text);
        return list.some(q => normalizeText(q.text) === key);
    }

    // ============================================================
    //  从指定 Document 中提取题目（核心提取逻辑）
    // ============================================================
    function extractQuestionsFromDoc(doc) {
        const questions = [];
        const containers = doc.querySelectorAll('.TiMu.newTiMu.ans-cc');

        containers.forEach((el) => {
            // ------- 题型 -------
            const typeSpan = el.querySelector('.Zy_TItle .newZy_TItle');
            const questionType = typeSpan ? typeSpan.textContent.trim() : '未知题型';

            // ------- 题干 -------
            const fontLabel = el.querySelector('.Zy_TItle .fontLabel');
            let questionText = '';
            if (fontLabel) {
                const clone = fontLabel.cloneNode(true);
                const typeEl = clone.querySelector('.newZy_TItle');
                if (typeEl) typeEl.remove();
                questionText = clone.textContent.trim();
            }

            // ------- 选项 -------
            const options = [];
            const optItems = el.querySelectorAll('.Zy_ulTop.qtDetail > li');
            optItems.forEach((li) => {
                const label = li.querySelector('i')?.textContent?.trim() || '';
                const textP = li.querySelector('p');
                const text = textP ? textP.textContent.trim() : li.textContent.replace(label, '').trim();
                options.push({ label, text });
            });

            // ------- 我的答案 -------
            const answerCon = el.querySelector('.answerCon');
            const myAnswer = answerCon ? answerCon.textContent.trim() : '';

            // ------- 对错标记 -------
            const hasDui = el.querySelector('.marking_dui') !== null;
            const hasCuo = el.querySelector('.marking_cuo') !== null;
            const isCorrect = hasDui && !hasCuo;

            // ------- 得分 -------
            const scoreSpan = el.querySelector('.scoreNum');
            const score = scoreSpan ? scoreSpan.textContent.trim() : '';

            if (!questionText) return;

            questions.push({
                type: questionType,
                text: questionText,
                options: options,
                myAnswer: myAnswer,
                isCorrect: isCorrect,
                score: score,
                capturedAt: new Date().toLocaleString('zh-CN'),
            });
        });

        return questions;
    }

    // ============================================================
    //  递归搜索 Window 及其所有 iframe 中的题目
    // ============================================================
    function findQuestionsRecursively(win, depth) {
        if (depth > 3) return []; // 限制递归深度，防死循环
        if (!win || !win.document) return [];

        let all = [];

        try {
            // 从当前 document 提取
            all = all.concat(extractQuestionsFromDoc(win.document));

            // 遍历当前 document 中的所有 iframe
            const iframes = win.document.querySelectorAll('iframe');
            iframes.forEach((iframe) => {
                try {
                    const iDoc = iframe.contentDocument || iframe.contentWindow?.document;
                    if (iDoc && iDoc.body) {
                        const sub = findQuestionsRecursively(iframe.contentWindow || iframe.contentWindow, depth + 1);
                        all = all.concat(sub);
                    }
                } catch (e) {
                    // 跨域 iframe 跳过
                }
            });
        } catch (e) {
            // 跨域跳过
        }

        return all;
    }

    // ============================================================
    //  从当前页面提取题目（自动适应两种页面类型）
    // ============================================================
    function extractQuestions() {
        const isStudyPage = location.pathname.indexOf('/mycourse/studentstudy') !== -1;

        if (isStudyPage) {
            // 学生学习页面：递归搜索主窗口和 iframe
            return findQuestionsRecursively(window, 0);
        } else {
            // 作答记录页面：直接提取
            return extractQuestionsFromDoc(document);
        }
    }

    // ============================================================
    //  将提取的题目合并到存储（自动去重 + 跨次交叉归类）
    //
    //  规则：
    //    - 同一题如果出现在多次作答中，只要曾做错过一次 → 归入「错题」
    //    - 如果从「正确」中发现该题曾做错过 → 移入「错题」并携带 correctAnswer
    //    - 如果从「正确」中捕获到「错题」里已有的题 → 补充 correctAnswer
    //    - 所有 correctAnswer 来自该题曾做对的某次作答
    // ============================================================
    function mergeQuestions(extracted) {
        const data = loadData();
        let newCorrect = 0;
        let newWrong = 0;

        extracted.forEach((q) => {
            const normText = normalizeText(q.text);

            // 在两边列表中查找
            const wrongIdx = data.wrong.findIndex(ex => normalizeText(ex.text) === normText);
            const correctIdx = data.correct.findIndex(ex => normalizeText(ex.text) === normText);

            if (q.isCorrect) {
                // ------ 本次作答正确 ------
                if (wrongIdx !== -1) {
                    // 该题已在错题列表中 → 补充正确答案（如有则保留第一次记录的正确答案）
                    const existing = data.wrong[wrongIdx];
                    if (!existing.correctAnswer) {
                        existing.correctAnswer = q.myAnswer;
                    }
                    // 不移动，仍然留在错题里
                } else if (correctIdx === -1) {
                    // 全新的正确题
                    q.correctAnswer = q.myAnswer; // 正确答案就是我的答案
                    data.correct.push(q);
                    newCorrect++;
                }
                // 已存在正确列表中 → 跳过（去重）
            } else {
                // ------ 本次作答错误 ------
                if (correctIdx !== -1) {
                    // 该题曾在正确列表中 → 移入错题，携带正确答案
                    const correctQ = data.correct[correctIdx];
                    const movedQ = {
                        ...correctQ,
                        correctAnswer: correctQ.myAnswer, // 记住正确答案
                        wrongAnswer: q.myAnswer,          // 本次的错答
                        myAnswer: q.myAnswer,
                        isCorrect: false,
                        score: q.score,
                        capturedAt: q.capturedAt,
                        everWrong: true,
                    };
                    data.correct.splice(correctIdx, 1);
                    data.wrong.push(movedQ);
                    newWrong++;
                } else if (wrongIdx === -1) {
                    // 全新的错题
                    data.wrong.push(q);
                    newWrong++;
                }
                // 已存在错题列表中 → 跳过（去重）
            }
        });

        saveData(data);
        return { newCorrect, newWrong, totalCorrect: data.correct.length, totalWrong: data.wrong.length };
    }

    // ============================================================
    //  UI —— 浮动面板
    // ============================================================
    const PANEL_HTML = `
    <div id="cx-collector-panel">
      <!-- 标题栏 -->
      <div id="cx-collector-header">
        <span>📚 题目收集器</span>
        <div class="cx-header-btns">
          <button id="cx-btn-capture" title="捕获当前页题目">📥 捕获</button>
          <button id="cx-btn-refresh" title="刷新面板">🔄</button>
          <button id="cx-btn-close" title="关闭">✕</button>
        </div>
      </div>
      <!-- 统计 -->
      <div id="cx-collector-stats">
        <span class="cx-stat cx-stat-wrong">❌ 错题: <b id="cx-count-wrong">0</b></span>
        <span class="cx-stat cx-stat-correct">✅ 做对: <b id="cx-count-correct">0</b></span>
        <span class="cx-stat cx-stat-total">📊 总计: <b id="cx-count-total">0</b></span>
      </div>
      <!-- 标签页 -->
      <div id="cx-collector-tabs">
        <button class="cx-tab active" data-tab="wrong">❌ 做错的</button>
        <button class="cx-tab" data-tab="correct">✅ 做对的</button>
      </div>
      <!-- 内容区 -->
      <div id="cx-collector-body">
        <div id="cx-list-wrong" class="cx-question-list"></div>
        <div id="cx-list-correct" class="cx-question-list" style="display:none;"></div>
      </div>
      <!-- 底部操作栏 -->
      <div id="cx-collector-footer">
        <div class="cx-footer-row">
          <button id="cx-btn-export" title="导出全部题目">📤 导出</button>
          <button id="cx-btn-export-wrong" title="仅导出错题">📤 导出错题</button>
          <span class="cx-fmt-sep">│</span>
          <button class="cx-fmt-btn active" data-fmt="json">JSON</button>
          <button class="cx-fmt-btn" data-fmt="md">MD</button>
          <button id="cx-btn-clear" title="清空所有收集数据">🗑️</button>
        </div>
      </div>
    </div>
    `;

    const PANEL_CSS = `
    #cx-collector-panel {
      position: fixed;
      top: 80px;
      right: 20px;
      width: 420px;
      max-height: 80vh;
      background: #fff;
      border: 1px solid #d0d5dd;
      border-radius: 10px;
      box-shadow: 0 8px 24px rgba(0,0,0,0.15);
      z-index: 999999;
      font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", "PingFang SC", "Microsoft YaHei", sans-serif;
      font-size: 13px;
      color: #1d2129;
      display: flex;
      flex-direction: column;
      user-select: none;
    }
    #cx-collector-header {
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 10px 14px;
      background: #1e3a5f;
      color: #fff;
      border-radius: 10px 10px 0 0;
      font-weight: 600;
      font-size: 14px;
      cursor: move;
    }
    .cx-header-btns { display: flex; gap: 6px; }
    .cx-header-btns button {
      background: rgba(255,255,255,0.2);
      border: none;
      color: #fff;
      cursor: pointer;
      border-radius: 4px;
      padding: 2px 8px;
      font-size: 12px;
      line-height: 1.6;
    }
    .cx-header-btns button:hover { background: rgba(255,255,255,0.35); }
    #cx-btn-close { font-size: 14px; font-weight: bold; }

    #cx-collector-stats {
      display: flex;
      justify-content: space-around;
      padding: 8px 10px;
      background: #f7f8fa;
      border-bottom: 1px solid #e8eaed;
      font-size: 12px;
    }
    .cx-stat b { font-size: 14px; }
    .cx-stat-wrong b { color: #e54545; }
    .cx-stat-correct b { color: #22ac5b; }
    .cx-stat-total b { color: #1e3a5f; }

    #cx-collector-tabs {
      display: flex;
      border-bottom: 2px solid #e8eaed;
    }
    #cx-collector-tabs .cx-tab {
      flex: 1;
      padding: 8px 0;
      text-align: center;
      background: #f7f8fa;
      border: none;
      cursor: pointer;
      font-size: 13px;
      color: #666;
      transition: all 0.2s;
    }
    #cx-collector-tabs .cx-tab.active {
      background: #fff;
      color: #1e3a5f;
      font-weight: 600;
      border-bottom: 2px solid #1e3a5f;
      margin-bottom: -2px;
    }
    #cx-collector-tabs .cx-tab:hover { background: #eef0f4; }

    #cx-collector-body {
      flex: 1;
      overflow-y: auto;
      min-height: 100px;
      max-height: 50vh;
      padding: 8px 0;
    }
    .cx-question-list { padding: 0 10px; }
    .cx-question-item {
      padding: 10px 12px;
      margin-bottom: 6px;
      border: 1px solid #e8eaed;
      border-radius: 6px;
      background: #fafbfc;
      font-size: 12px;
      line-height: 1.5;
    }
    .cx-question-item:hover { border-color: #b3bac5; }
    .cx-q-type {
      display: inline-block;
      background: #eef0f4;
      padding: 0 6px;
      border-radius: 3px;
      font-size: 11px;
      color: #555;
      margin-right: 6px;
    }
    .cx-q-text {
      font-weight: 500;
      margin: 4px 0;
      word-break: break-all;
    }
    .cx-q-opts {
      margin: 4px 0 4px 12px;
      color: #555;
    }
    .cx-q-opts span { display: block; }
    .cx-q-answer {
      margin-top: 4px;
      color: #1e3a5f;
    }
    .cx-q-wrong .cx-q-answer { color: #e54545; font-weight: 500; }
    .cx-q-correct .cx-q-answer { color: #22ac5b; }
    .cx-q-correct-answer {
      margin-top: 2px;
      color: #22ac5b;
      font-weight: 600;
      font-size: 12px;
      padding: 2px 6px;
      background: #e8f8ef;
      border-radius: 3px;
      display: inline-block;
    }
    .cx-q-time {
      font-size: 10px;
      color: #999;
      margin-top: 4px;
    }
    .cx-type-group-header {
      font-size: 13px;
      font-weight: 600;
      color: #1e3a5f;
      padding: 10px 12px 4px 12px;
      border-bottom: 1px solid #e8eaed;
      margin: 4px 0;
    }
    .cx-empty-tip {
      text-align: center;
      color: #999;
      padding: 30px 0;
      font-size: 13px;
    }

    #cx-collector-footer {
      padding: 6px 10px;
      border-top: 1px solid #e8eaed;
      background: #f7f8fa;
      border-radius: 0 0 10px 10px;
    }
    .cx-footer-row {
      display: flex;
      align-items: center;
      gap: 4px;
    }
    #cx-collector-footer button {
      padding: 4px 8px;
      border: 1px solid #d0d5dd;
      background: #fff;
      border-radius: 4px;
      cursor: pointer;
      font-size: 11px;
      color: #1d2129;
      white-space: nowrap;
    }
    #cx-collector-footer button:hover { background: #eef0f4; }
    .cx-fmt-sep {
      color: #ccc;
      font-size: 12px;
      margin: 0 2px;
    }
    .cx-fmt-btn {
      min-width: 38px;
      text-align: center;
      font-weight: 500;
    }
    .cx-fmt-btn.active {
      background: #1e3a5f !important;
      color: #fff !important;
      border-color: #1e3a5f !important;
    }
    #cx-btn-clear {
      margin-left: auto;
      color: #e54545;
      border-color: #f5c6c6;
      font-size: 14px;
      padding: 4px 6px;
    }
    #cx-btn-clear:hover { background: #fde8e8; }
    `;

    // ============================================================
    //  面板交互
    // ============================================================
    let panel = null;
    let isDragging = false;
    let dragOffsetX = 0;
    let dragOffsetY = 0;

    function buildPanel() {
        // 注入样式
        GM_addStyle(PANEL_CSS);

        // 创建 DOM
        const wrapper = document.createElement('div');
        wrapper.innerHTML = PANEL_HTML;
        panel = wrapper.firstElementChild;
        document.body.appendChild(panel);

        // --- 拖拽 ---
        const header = panel.querySelector('#cx-collector-header');
        header.addEventListener('mousedown', (e) => {
            if (e.target.tagName === 'BUTTON') return;
            isDragging = true;
            const rect = panel.getBoundingClientRect();
            dragOffsetX = e.clientX - rect.left;
            dragOffsetY = e.clientY - rect.top;
        });
        document.addEventListener('mousemove', (e) => {
            if (!isDragging) return;
            panel.style.left = (e.clientX - dragOffsetX) + 'px';
            panel.style.top = (e.clientY - dragOffsetY) + 'px';
            panel.style.right = 'auto';
        });
        document.addEventListener('mouseup', () => { isDragging = false; });

        // --- 关闭 ---
        panel.querySelector('#cx-btn-close').addEventListener('click', () => {
            panel.style.display = 'none';
        });

        // --- 标签切换 ---
        const tabs = panel.querySelectorAll('.cx-tab');
        tabs.forEach((btn) => {
            btn.addEventListener('click', () => {
                tabs.forEach(t => t.classList.remove('active'));
                btn.classList.add('active');
                const tab = btn.dataset.tab;
                document.querySelectorAll('.cx-question-list').forEach(el => el.style.display = 'none');
                const target = panel.querySelector(`#cx-list-${tab}`);
                if (target) target.style.display = 'block';
            });
        });

        // --- 捕获 ---
        panel.querySelector('#cx-btn-capture').addEventListener('click', doCapture);

        // --- 刷新 ---
        panel.querySelector('#cx-btn-refresh').addEventListener('click', renderPanel);

        // --- 格式切换 ---
        const fmtBtns = panel.querySelectorAll('.cx-fmt-btn');
        fmtBtns.forEach(btn => {
            btn.addEventListener('click', () => {
                fmtBtns.forEach(b => b.classList.remove('active'));
                btn.classList.add('active');
            });
        });

        // --- 导出全部 ---
        panel.querySelector('#cx-btn-export').addEventListener('click', () => {
            const fmt = panel.querySelector('.cx-fmt-btn.active').dataset.fmt;
            exportData('all', fmt);
        });

        // --- 导出错题 ---
        panel.querySelector('#cx-btn-export-wrong').addEventListener('click', () => {
            const fmt = panel.querySelector('.cx-fmt-btn.active').dataset.fmt;
            exportData('wrong', fmt);
        });

        // --- 清空 ---
        panel.querySelector('#cx-btn-clear').addEventListener('click', () => {
            if (confirm('确定要清空所有收集的题目数据吗？')) {
                clearData();
                renderPanel();
                GM_notification({ text: '已清空所有数据', timeout: 2000 });
            }
        });

        // 初始渲染
        renderPanel();
    }

    // ============================================================
    //  捕获逻辑
    // ============================================================
    function doCapture() {
        const extracted = extractQuestions();
        if (extracted.length === 0) {
            GM_notification({ text: '⚠️ 当前页面未检测到题目', timeout: 2000 });
            return;
        }

        const result = mergeQuestions(extracted);
        renderPanel();

        const msg = `捕获 ${extracted.length} 题，新增正确 ${result.newCorrect} 题，新增错题 ${result.newWrong} 题`;
        GM_notification({ text: msg, timeout: 3000 });
    }

    // ============================================================
    //  渲染面板
    // ============================================================
    function renderPanel() {
        if (!panel) return;
        const data = loadData();

        // 更新计数
        panel.querySelector('#cx-count-correct').textContent = data.correct.length;
        panel.querySelector('#cx-count-wrong').textContent = data.wrong.length;
        panel.querySelector('#cx-count-total').textContent = data.correct.length + data.wrong.length;

        // 渲染错题列表
        renderList(panel.querySelector('#cx-list-wrong'), data.wrong, false);
        // 渲染做对列表
        renderList(panel.querySelector('#cx-list-correct'), data.correct, true);
    }

    function groupByType(questions) {
        const groups = {};
        questions.forEach(q => {
            const type = q.type || '未知题型';
            if (!groups[type]) groups[type] = [];
            groups[type].push(q);
        });
        // 按题型名称排序
        const typeOrder = ['【单选题】','【多选题】','【判断题】','【填空题】','【简答题】','【论述题】','【名词解释】','【计算题】','【编程题】','【综合题】'];
        const sorted = Object.keys(groups).sort((a, b) => {
            const ia = typeOrder.indexOf(a);
            const ib = typeOrder.indexOf(b);
            if (ia !== -1 && ib !== -1) return ia - ib;
            if (ia !== -1) return -1;
            if (ib !== -1) return 1;
            return a.localeCompare(b, 'zh-CN');
        });
        return sorted.map(key => ({ type: key, questions: groups[key] }));
    }

    function renderList(container, list, isCorrect) {
        if (list.length === 0) {
            container.innerHTML = `<div class="cx-empty-tip">${isCorrect ? '✅ 暂无做对的题目' : '❌ 暂无错题'}</div>`;
            return;
        }

        const cls = isCorrect ? 'cx-q-correct' : 'cx-q-wrong';
        const grouped = groupByType(list);

        let html = '';
        grouped.forEach(group => {
            html += `<div class="cx-type-group-header">${escHtml(group.type)}（${group.questions.length}题）</div>`;
            group.questions.forEach((q) => {
                let answerHtml = `<div class="cx-q-answer">我的答案：${escHtml(q.myAnswer)}${q.score ? ' ｜ ' + escHtml(q.score) + '分' : ''}</div>`;
                if (!isCorrect && q.correctAnswer) {
                    answerHtml += `<div class="cx-q-correct-answer">✅ 正确答案：${escHtml(q.correctAnswer)}</div>`;
                }

                html += `
            <div class="cx-question-item ${cls}">
                <div>
                    <span class="cx-q-type">${escHtml(q.type)}</span>
                    <span class="cx-q-text">${escHtml(q.text)}</span>
                </div>
                ${q.options.length ? '<div class="cx-q-opts">' + q.options.map(o => `<span>${escHtml(o.label)} ${escHtml(o.text)}</span>`).join('') + '</div>' : ''}
                ${answerHtml}
                <div class="cx-q-time">捕获时间：${escHtml(q.capturedAt)}</div>
            </div>
            `;
            });
        });
        container.innerHTML = html;
    }

    // ============================================================
    //  导出
    // ============================================================
    function exportData(mode, format) {
        const data = loadData();
        const isMD = format === 'md';
        let content, filename, mimeType;

        if (isMD) {
            content = generateMarkdown(data, mode);
            filename = (mode === 'wrong' ? '错题' : '全部题目') + `_${formatDate()}.md`;
            mimeType = 'text/markdown';
        } else {
            let exportObj;
            if (mode === 'wrong') {
                exportObj = {
                    exportTime: new Date().toLocaleString('zh-CN'),
                    type: '错题',
                    count: data.wrong.length,
                    questions: data.wrong,
                };
            } else {
                exportObj = {
                    exportTime: new Date().toLocaleString('zh-CN'),
                    correctCount: data.correct.length,
                    wrongCount: data.wrong.length,
                    totalCount: data.correct.length + data.wrong.length,
                    correct: data.correct,
                    wrong: data.wrong,
                };
            }
            content = JSON.stringify(exportObj, null, 2);
            filename = (mode === 'wrong' ? '错题' : '全部题目') + `_${formatDate()}.json`;
            mimeType = 'application/json';
        }

        const blob = new Blob([content], { type: mimeType });
        const url = URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = filename;
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);
        URL.revokeObjectURL(url);
    }

    // ============================================================
    //  生成 Markdown
    // ============================================================
    function generateMarkdown(data, mode) {
        const now = new Date().toLocaleString('zh-CN');
        let md = '';

        if (mode === 'wrong') {
            md += `# 错题汇总\n\n`;
            md += `> 导出时间：${now} ｜ 共 ${data.wrong.length} 题\n\n`;
            md += generateQuestionSection(data.wrong, '错题');
        } else {
            md += `# 全部题目汇总\n\n`;
            md += `> 导出时间：${now} ｜ `;
            md += `✅ 做对 ${data.correct.length} 题 ｜ ❌ 做错 ${data.wrong.length} 题 ｜ 📊 总计 ${data.correct.length + data.wrong.length} 题\n\n`;

            if (data.wrong.length > 0) {
                md += `## ❌ 做错的题目\n\n`;
                md += generateQuestionSection(data.wrong, '错题');
            }
            if (data.correct.length > 0) {
                md += `\n---\n\n## ✅ 做对的题目\n\n`;
                md += generateQuestionSection(data.correct, '做对');
            }
        }

        return md;
    }

    function generateQuestionSection(questions, label) {
        const grouped = groupByType(questions);
        let globalIdx = 0;
        let md = '';

        grouped.forEach(group => {
            md += `### ${escHtml(group.type)}\n\n`;
            group.questions.forEach((q) => {
                globalIdx++;
                md += `##### ${globalIdx}. ${q.text}\n\n`;

                if (q.options && q.options.length > 0) {
                    q.options.forEach(o => {
                        md += `- ${o.label} ${o.text}\n`;
                    });
                    md += `\n`;
                }

                md += `- **我的答案：** ${q.myAnswer}`;
                if (q.score) md += ` ｜ ${q.score} 分`;
                md += `\n`;

                if (label === '错题' && q.correctAnswer) {
                    md += `- **✅ 正确答案：** ${q.correctAnswer}\n`;
                }

                md += `\n`;
                md += `---\n\n`;
            });
        });

        return md;
    }

    // ============================================================
    //  工具函数
    // ============================================================
    function escHtml(str) {
        if (!str) return '';
        const div = document.createElement('div');
        div.textContent = str;
        return div.innerHTML;
    }

    function formatDate() {
        const d = new Date();
        return `${d.getFullYear()}${pad(d.getMonth()+1)}${pad(d.getDate())}_${pad(d.getHours())}${pad(d.getMinutes())}`;
    }
    function pad(n) { return n < 10 ? '0' + n : '' + n; }

    // ============================================================
    //  自动捕获：监听 AJAX / iframe 加载完成
    // ============================================================
    function autoCaptureOnLoad() {
        const isStudyPage = location.pathname.indexOf('/mycourse/studentstudy') !== -1;

        if (isStudyPage) {
            // 学生学习页面：监听 #mainid 内容变化，并监控 iframe 加载
            const target = document.querySelector('#mainid') || document.body;
            const observer = new MutationObserver(() => {
                clearTimeout(window._cxDebounceTimer);
                window._cxDebounceTimer = setTimeout(() => {
                    const questions = extractQuestions();
                    if (questions.length > 0) {
                        mergeQuestions(questions);
                        renderPanel();
                    }
                }, DEBOUNCE_MS);
            });
            observer.observe(target, { childList: true, subtree: true });

            // 额外监听 iframe 的加载事件
            document.addEventListener('DOMContentLoaded', () => {
                const iframe = document.querySelector('#iframe');
                if (iframe) {
                    iframe.addEventListener('load', () => {
                        setTimeout(() => {
                            const questions = extractQuestions();
                            if (questions.length > 0) {
                                mergeQuestions(questions);
                                renderPanel();
                            }
                        }, DEBOUNCE_MS);
                    });
                }
            });
        } else {
            // 作答记录页面：监听 #recordDetail 内容变化（AJAX 刷新）
            const target = document.querySelector('#recordDetail') || document.body;
            const observer = new MutationObserver(() => {
                clearTimeout(window._cxDebounceTimer);
                window._cxDebounceTimer = setTimeout(() => {
                    const questions = extractQuestions();
                    if (questions.length > 0) {
                        mergeQuestions(questions);
                        renderPanel();
                    }
                }, DEBOUNCE_MS);
            });
            observer.observe(target, { childList: true, subtree: true });
        }
    }

    // ============================================================
    //  启动
    // ============================================================
    function init() {
        buildPanel();
        autoCaptureOnLoad();

        // 首次加载时如果页面已有题目则自动捕获
        // 对学习页面多等一会儿，让 iframe 加载完成
        const delay = location.pathname.indexOf('/mycourse/studentstudy') !== -1 ? 3000 : 500;
        setTimeout(() => {
            const initial = extractQuestions();
            if (initial.length > 0) {
                mergeQuestions(initial);
                renderPanel();
                GM_notification({ text: `📥 自动捕获 ${initial.length} 题`, timeout: 2000 });
            }
        }, delay);

        // 学习页面：额外在 5s 后再试一次（应对动态加载的 iframe）
        if (location.pathname.indexOf('/mycourse/studentstudy') !== -1) {
            setTimeout(() => {
                const questions = extractQuestions();
                if (questions.length > 0) {
                    const result = mergeQuestions(questions);
                    renderPanel();
                    if (result.newCorrect + result.newWrong > 0) {
                        GM_notification({ text: `📥 延迟捕获 ${questions.length} 题`, timeout: 2000 });
                    }
                }
            }, 5000);
        }
    }

    // 等待 DOM 就绪
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }
})();
