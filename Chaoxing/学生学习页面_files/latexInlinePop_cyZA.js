// 输入框中的latex公式编辑弹窗
var LatexInlinePop = (function () {
	var editor, pop, input, target;
	var HELP = 'https://sharewh.chaoxing.com/share/b3e1d692-e029-4443-889b-f53cdab5baef?t=3';

	function postMsg(msg) {
		try { window.postMessage(msg, '*'); } catch (err) {}
		try { if (window.parent !== window) window.parent.postMessage(msg, '*'); } catch (err) {}
	}
    // 将 LaTeX 写回公式节点并重新渲染
	function apply(el, latex) {
		if (!el || !editor) return;
		latex = (latex || '').trim();
		if (!latex) { el.remove(); editor.fireEvent('contentchange'); return; }
		el.id = el.id || ('latex_' + Date.now());
		el.setAttribute('data-latexstr', encodeURIComponent(latex));
		el.innerHTML = latex;
		el.style.transform = '';
		RichTextUitl && RichTextUitl.renderLatex && RichTextUitl.renderLatex(editor.body);
		editor.fireEvent('contentchange');
	}
    // 关闭弹窗
	function close(save) {
		if (save && target) apply(target, input.value);
		var active = editor.body.querySelector('.latex-inline-active');
		if (active) active.classList.remove('latex-inline-active');
		pop.style.display = 'none';
		target = null;
	}
    // 点击非弹窗模块关闭弹窗
	function outside(e) {
		if (pop.style.display !== 'none' && !pop.contains(e.target)) close(true);
	}
    // 打开弹窗模式
	function ensurePop() {
		if (pop) return;
		pop = document.createElement('div');
		pop.id = 'latex-inline-pop';
		pop.innerHTML = '<div class="latex-inline-pop-inner"><textarea class="latex-inline-pop-input" spellcheck="false"></textarea><div class="latex-inline-pop-footer"><span class="latex-inline-pop-tip">按ESC键完成输入</span><div class="latex-inline-pop-actions"><a href="' + HELP + '" target="_blank" class="latex-inline-pop-help"><i></i>使用帮助</a><a href="javascript:;" class="latex-inline-pop-dialog"><i></i>弹窗模式</a></div></div></div>';
		document.body.appendChild(pop);
		input = pop.querySelector('.latex-inline-pop-input');
		pop.querySelector('.latex-inline-pop-dialog').onclick = function (e) {
			e.preventDefault();
			if (!target) return;
			target.id = target.id || ('latex_' + Date.now());
			postMsg({ msgType: 'setLatexEdit', data: { msgType: 'editLatex', id: target.id, latexString: input.value } });
			close(true);
			$(editor.container).find('.edui-for-mathmlbeta .edui-button-body').click();
		};
		input.onkeydown = function (e) { if (e.keyCode === 27) { e.preventDefault(); close(true); } };
		document.addEventListener('mousedown', outside);
	}
    // 初始化
	function init(ed) {
		editor = ed;
		ensurePop();
		$(editor.body).on('mousedown.latexPop', outside).on('click.latexPop', '[data-latexstr]', function (e) {
			e.preventDefault();
			e.stopPropagation();
			target = this;
			target.classList.add('latex-inline-active');
			try { input.value = decodeURIComponent(target.getAttribute('data-latexstr') || ''); }
			catch (err) { input.value = target.getAttribute('data-latexstr') || ''; }
			var f = editor.iframe.getBoundingClientRect(), r = target.getBoundingClientRect();
			pop.style.display = 'block';
			pop.style.left = Math.max(16, Math.min(f.left + r.left, window.innerWidth - 416)) + 'px';
			pop.style.top = (f.top + r.bottom + 8) + 'px';
			input.focus();
		});
		window.addEventListener('message', function (e) {
			var d = e.data, el;
			if (d && d.msgType === 'updateLatexInline' && editor && (el = editor.document.getElementById(d.id))) apply(el, d.latexString);
		});
	}

	return { init: init };
})();
