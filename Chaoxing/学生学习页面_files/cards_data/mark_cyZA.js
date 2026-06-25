var courseId = $("#courseId").val();
var knowledgeId = $("#knowledgeId").val();
var cardId = $("#cardId").val();
var clazzId = $("#clazzId").val();
var cpi = $("#cpi").val();
var ut = $("#ut").val();
var isDigitalTextbook = $("#isDigitalTextbook").val();
parent.isDigitalTextbook = isDigitalTextbook;

var page = {};

var markType = 'bg';
var markColor = "#FFCC33";
var mouseclick=false;
var selectedTextPosition = null;
var translateInfo_lang = "";
var translateInfo_content = "";
var hasmark = false;
var echo=[];
var bgAndBgLine = [];
var mark = {
	init: function (obj) {
        this.options = {
            currSelection: {},
            markedObj: [],
            currLabelData: {},
            isRangeRight:'',   // 判断选区是否异常 false 异常
            isNewline:false,
        };
        this.opt = $.extend(this.options, obj);
        this.zzechoAgain();
        this.initMark();
    },
    initMark: function(){
    	$('.domark span').attr('marktype',markType).css({'background-color':'unset','background-image':'none',"border-bottom":"none"});
    },
    selectText: function (event, $this) {
        var text = window.getSelection().toString();
        this.cancleUnderline();
        if (window.getSelection().isCollapsed || text.length === 0) {   // 选中区域为空，不做任何操作
        	mouseclick = true;
            return;
        } else {
        	mouseclick = false;
            this.isNewline = true;
            this.getRangeInfo();
	        this.drawline();
	        markType = 'bg';
	        markColor = "#FFCC33";
        }
    },
    // 获取选区内容，偏移量等
    getRangeInfo: function () {
        var text = window.getSelection().toString();
        this.opt.currSelection = {
            toString: function () {
                return text;
            },
            anchorNode: window.getSelection().anchorNode,
            focusNode: window.getSelection().focusNode,
            anchorOffset: window.getSelection().anchorOffset,
            focusOffset: window.getSelection().focusOffset
        };
        rangy.init();
        cssApplier = rangy.createClassApplier("marked");
        cssApplier.toggleSelection();
        this.opt.markedObj = this.getSelectedDom();
    },
    
    // 获取选中的对象
    getSelectedDom: function () {
        var markedArr = [], selChapter, selObj = {};
        var markedObj = $("#pageDiv .marked");
        for (var j = 0; j < markedObj.length; j++) {
            var data = markedObj[j].getClientRects();
            for (var i = 0; i < data.length; i++) {
                markedArr.push(data[i]);
            }
        }
        cssApplier.toggleSelection();
        selObj.markedArr = markedArr;
        return selObj;
    },
    // 正选／反选
    getSelDirection: function (startChapter, endChapter) {
        var start, end, startNo, endNo, sNodeOffset, eNodeOffset, nodeStart, nodeEnd, chapterid;
        var startNode = this.opt.currSelection.anchorNode;
        var endNode = this.opt.currSelection.focusNode;
        var text = this.opt.currSelection.toString();
        var startOffset, endOffset, epcdStart, epcdEnd, thisRange;
        //排除操作过快早上结尾标签为段落标签的情况
        if (!endNode||endNode.nodeName !== "#text" || !startNode||startNode.nodeName !== "#text") {
            // window.getSelection().empty();  // 去除选中区域
            window.getSelection().removeAllRanges();  // 去除选中区域
            console.log("选区的起始标签有非 span 标签");
            return;
        }

        startNo = this.opt.currSelection.anchorOffset;  //选中开始段落的偏移量
        endNo = this.opt.currSelection.focusOffset;  // 选中结束段落的偏移量
        // 正选和反选的情况
        if (startChapter > endChapter) {
            start = endNo;
            end = startNo;
        } else if (startChapter == endChapter) {
            start = Math.min(startNo, endNo);
            end = Math.max(startNo, endNo);
        } else if (startChapter < endChapter) {
            start = startNo;
            end = endNo;
        }
        // chapterid = $(startNode).parents("div").attr("cid");
        var startNodeClass = startNode.parentNode.tagName.toLowerCase() + (startNode.parentNode.className!='' ? '.'+startNode.parentNode.className.replace(/ /gi,'.') : '');
        var endNodeClass = endNode.parentNode.tagName.toLowerCase() + (endNode.parentNode.className!='' ? '.'+endNode.parentNode.className.replace(/ /gi,'.') : '');
        var $paraStart = $(startNode).parents("p").eq(0);
        var $paraEnd = $(endNode).parents("p").eq(0);
        var paraStartEl = $paraStart[0];
        var paraEndEl = $paraEnd[0];
        // 文本直接挂在 <p> 下时不能用 $p.find('p')（段内无子 p），否则 index=-1；第二行「这是<b>一段</b>文本」会标失败
        var anchorParentIsParagraph = (startNode.parentNode === paraStartEl);
        var focusParentIsParagraph = (endNode.parentNode === paraEndEl);
        var startNodeIndex, endNodeIndex, startTextIndex, endTextIndex;
        if (anchorParentIsParagraph) {
            startNodeIndex = Array.prototype.indexOf.call(paraStartEl.childNodes, startNode);
        } else {
            startNodeIndex = $paraStart.find(startNodeClass).index($(startNode.parentNode));
        }
        startTextIndex = $paraStart.contents().index($(startNode));
        if (focusParentIsParagraph) {
            endNodeIndex = Array.prototype.indexOf.call(paraEndEl.childNodes, endNode);
        } else {
            endNodeIndex = $paraEnd.find(endNodeClass).index($(endNode.parentNode));
        }
        endTextIndex = $paraEnd.contents().index($(endNode));
        thisRange = {
            beginOffset: start,
            endOffset: end,
            startNodeClass: startNodeClass,
            endNodeClass: endNodeClass,
            startNodeIndex: startNodeIndex,
            endNodeIndex:  endNodeIndex,
            startTextIndex: startTextIndex,
            endTextIndex: endTextIndex,
            anchorParentIsParagraph: anchorParentIsParagraph,
            focusParentIsParagraph: focusParentIsParagraph,
            intstartid: Math.min(startChapter, endChapter),
            intendid: Math.max(startChapter, endChapter),
            content: text,
            // chapterid: chapterid
        };
        return thisRange;
    },
    drawline: function (initFlag) {
        var startChapter, endChapter, margeRects, curSelectedRange, text;
        
        var markedArr = this.opt.markedObj.markedArr;
        startChapter = parseInt($(this.opt.currSelection.anchorNode).parents("p").eq(0).attr("sequence-id"));
        endChapter = parseInt($(this.opt.currSelection.focusNode).parents("p").eq(0).attr("sequence-id"));
        curSelectedRange = this.getSelDirection(startChapter, endChapter);
        text = this.opt.currSelection.toString();

        if (curSelectedRange === false || (!this.isNewline && text != this.opt.currLabelData.content)) {
            if (((initFlag && initFlag === 'init') || (parent.window && parent.window.isDigitalTextbookPage == "true"))
                && (this.opt.currLabelData.marktype == 'bg' || this.opt.currLabelData.marktype == 'bgline')) {
                bgAndBgLine.push(this.opt.currLabelData);
            }

            if ((initFlag && initFlag === 'init') || (parent.window && parent.window.isDigitalTextbookPage == "true")) {
                parent.bgAndBgLine = bgAndBgLine;
            }

            console.log("选区问题");
            this.opt.isRangeRight=false;
            return;
        }else{
            this.opt.isRangeRight=true;
        }
        if (this.isNewline) {
            var thisEcho = {
                beginpid: $(this.opt.currSelection.anchorNode).parents("p").eq(0).attr("data-pid"),//开始段落的data-id
                endpid: $(this.opt.currSelection.focusNode).parents("p").eq(0).attr("data-pid"),//结束段落的data-id
                beginOffset: curSelectedRange.beginOffset,//开始段落的偏移量
                endOffset: curSelectedRange.endOffset,//结束段落的偏移量
                startNodeClass: curSelectedRange.startNodeClass,//开始段落节点class
                endNodeClass: curSelectedRange.endNodeClass,//结束段落节点class
                startNodeIndex: curSelectedRange.startNodeIndex,//开始节点的index
                endNodeIndex: curSelectedRange.endNodeIndex,//结束节点的index
                startTextIndex: curSelectedRange.startTextIndex,
                endTextIndex: curSelectedRange.endTextIndex,
                intstartid: curSelectedRange.intstartid,//开始段落的sequence-id，是整数
                intendid: curSelectedRange.intendid,//结束段落的sequence-id，是整数
                content: text,//选中文字
                // chapterid: curSelectedRange.chapterid, //章节id
                id: (new Date()).getTime(),//标注id
                marktype:'',//标注类型
                markcolor:''//标注颜色
            };
            this.opt.currLabelData = thisEcho;
        }
        margeRects = this.margeline(markedArr);
        this.drawUnderline(margeRects, initFlag);
    },
    //画线
    drawUnderline: function (margeRects, initFlag) {
        if (!margeRects[0] && margeRects.length > 0) {
            return;
        }
        var top, left, width, spanText = '', nodeStart, nodeEnd;
		
        nodeStart = this.opt.currLabelData.beginpid + "-" + this.opt.currLabelData.beginOffset;
        nodeEnd = this.opt.currLabelData.endpid + "-" + this.opt.currLabelData.endOffset;
		
        for (var i = 0; i < margeRects.length; i++) {
            if (window.cxStudy) {
                var scrollTop =  document.documentElement.scrollTop || document.body.scrollTop;
                top = margeRects[i].top + scrollTop;
            } else {
                top = margeRects[i].top;
            }
            left = margeRects[i].left;
            width = margeRects[i].width;
			
            spanText += "<span data-pid='"+this.opt.currLabelData.beginpid+"' markid='" + this.opt.currLabelData.id + "' class = 'selectText' data-start= '" + nodeStart + "' data-end='" +
                nodeEnd + "'  style = 'top:" + top + "px;left:" +
                left + "px; height:" + margeRects[i].height + "px;width:" + width + "px;position: absolute' ></span>";
            if (initFlag && initFlag === 'init' && (this.opt.currLabelData.marktype == 'bg' || this.opt.currLabelData.marktype == 'bgline')) {
                bgAndBgLine.push(this.opt.currLabelData);
            }
        }

        if (initFlag && initFlag === 'init') {
            parent.bgAndBgLine = bgAndBgLine;
        }
        
        $("#markDiv").append(spanText);
        var top = parseInt($('#markDiv span:last-child').offset().top) - 42;
        var left = parseInt($('#markDiv span:last-child').offset().left);
        var wapWidth = $(".wrap").width();
        if (parseInt(wapWidth) - left < 270) {
            left = wapWidth - 270;
        }
        selectedTextPosition = {top, left};
        $('.func-pop').css("top", top + "px");
        $('.func-pop').css("left", left + "px");
    	$('.func-pop').removeAttr('markid').removeAttr('data-pid');
        this.popCoords(left,top,".func-pop");
        $("#auditionAudio").attr("src", "");
        $("#transResultDiv").empty();
        $(".trans-ques-text").empty();
        window.getSelection().removeAllRanges();
    },
    // js 重绘选区：详细日志 + offset clamp + 按 content 兜底定位文本节点
    jsDrawRange: function (thisRange) {
        var myRange,
            startNode,
            startOffset,
            startNodes,
            endNodes,
            endNode,
            endOffset;
        var $this = thisRange;
        function clampOffset(textNode, offset) {
            if (!textNode || textNode.nodeType !== 3) {
                return offset;
            }
            var len = textNode.nodeValue ? textNode.nodeValue.length : 0;
            if (offset < 0) {
                return 0;
            }
            if (offset > len) {
                return len;
            }
            return offset;
        }
        function resolveTextNodeByContent(pEl, contentText) {
            if (!pEl || !contentText) {
                return null;
            }
            var textNodes = [];
            var walker = document.createTreeWalker(pEl, NodeFilter.SHOW_TEXT, null, false);
            var current;
            while ((current = walker.nextNode())) {
                if (current.nodeValue && current.nodeValue.trim() !== "") {
                    textNodes.push(current);
                }
            }
            for (var i = 0; i < textNodes.length; i++) {
                if (textNodes[i].nodeValue.indexOf(contentText) > -1) {
                    return textNodes[i];
                }
            }
            return textNodes.length > 0 ? textNodes[0] : null;
        }
        startNode = $("p[sequence-id=" + $this.intstartid + "]");
        endNode = $("p[sequence-id=" + $this.intendid + "]");
        startOffset = $this.beginOffset;
        endOffset = $this.endOffset;

        if (startNode.html() && startNode.html().length === 0) {
            startNode = startNode.next();
        }
        if (endNode.html() && endNode.html().length === 0) {
            endNode = endNode.next();
        }
        window.getSelection().removeAllRanges();
        myRange = document.createRange();

        try{
            if($this.startNodeClass){
                var findStartNode, findEndNode, startTN, endTN;
                var isSingleParagraph = ($this.intstartid === $this.intendid);
                if (isSingleParagraph && startNode[0].childNodes[0].nodeName == '#text' && startNode[0].childNodes.length == 1) {
                    findStartNode = startNode[0];
                    findEndNode = startNode[0];
                    startNode[0].classList.add('transparentP');
                    startOffset = clampOffset(findStartNode.childNodes[0], startOffset);
                    endOffset = clampOffset(findEndNode.childNodes[0], endOffset);
                    myRange.setStart(findStartNode.childNodes[0], startOffset);
                    myRange.setEnd(findEndNode.childNodes[0], endOffset);
                } else {
                    var pStartEl = startNode[0];
                    var pEndEl = endNode[0];
                    if ($this.anchorParentIsParagraph) {
                        startTN = pStartEl.childNodes[$this.startNodeIndex];
                    } else {
                        findStartNode = $(pStartEl).find($this.startNodeClass).eq($this.startNodeIndex)[0];
                        startTN = findStartNode ? findStartNode.childNodes[0] : null;
                        if (!startTN && $this.startNodeIndex >= 0 && pStartEl.childNodes[$this.startNodeIndex] && pStartEl.childNodes[$this.startNodeIndex].nodeType === 3) {
                            startTN = pStartEl.childNodes[$this.startNodeIndex];
                        }
                    }
                    if ($this.focusParentIsParagraph) {
                        endTN = pEndEl.childNodes[$this.endNodeIndex];
                    } else {
                        findEndNode = $(pEndEl).find($this.endNodeClass).eq($this.endNodeIndex)[0];
                        endTN = findEndNode ? findEndNode.childNodes[0] : null;
                        if (!endTN && $this.endNodeIndex >= 0 && pEndEl.childNodes[$this.endNodeIndex] && pEndEl.childNodes[$this.endNodeIndex].nodeType === 3) {
                            endTN = pEndEl.childNodes[$this.endNodeIndex];
                        }
                    }
                    if ((!startTN || startTN.nodeType !== 3) && pStartEl) {
                        startTN = resolveTextNodeByContent(pStartEl, $this.content);
                    }
                    if ((!endTN || endTN.nodeType !== 3) && pEndEl) {
                        endTN = resolveTextNodeByContent(pEndEl, $this.content);
                    }
                    if (!startTN || startTN.nodeType !== 3 || !endTN || endTN.nodeType !== 3) {
                        return;
                    }
                    startOffset = clampOffset(startTN, startOffset);
                    endOffset = clampOffset(endTN, endOffset);
                    myRange.setStart(startTN, startOffset);
                    myRange.setEnd(endTN, endOffset);
                }
            }else{
                if (startNode[0].childNodes[0] && endNode[0].childNodes[0]) {
                    startOffset = clampOffset(startNode[0].childNodes[0], startOffset);
                    endOffset = clampOffset(endNode[0].childNodes[0], endOffset);
                    myRange.setStart(startNode[0].childNodes[0], startOffset);
                    myRange.setEnd(endNode[0].childNodes[0], endOffset);
                }
            }
            window.getSelection().addRange(myRange);
        }catch(err){
            console.log("jsDrawRange error", {
                id: $this.id,
                intstartid: $this.intstartid,
                intendid: $this.intendid,
                beginOffset: $this.beginOffset,
                endOffset: $this.endOffset,
                startNodeClass: $this.startNodeClass,
                endNodeClass: $this.endNodeClass,
                startNodeIndex: $this.startNodeIndex,
                endNodeIndex: $this.endNodeIndex,
                content: $this.content,
                error: err
            });
        }

    },
    //  合并选区
    margeline: function (rects) {
        var margeLines = [];
        var n = 0;
        while (rects[n] && rects[n].width === 0)    //去除取得前面为0 的情况
        {
            n++;
        }
        var rect = this.cloneObjectProp(rects[n]);  // 对象拷贝
        if (rects.length === 1) {
            margeLines.push(rect);
            return margeLines;
        }
        for (var i = 1; i < rects.length; i++) {
            if (rects[i] && rects[i].width === 0) {
                continue;
            }
            if (Math.abs((rect.top - rects[i].top)) < 10) {
                rect.top = Math.max(rect.top, rects[i].top);
                rect.right = Math.max(rect.right, rects[i].right);
                rect.left = Math.min(rect.left, rects[i].left);
                rect.height = Math.max(rect.height, rects[i].height);
                rect.width = rect.right - rect.left;
            } else {
                margeLines.push(rect);
                rect = this.cloneObjectProp(rects[i]); // 对象深拷贝
                rect.width = rect.right - rect.left;
            }
        }
        margeLines.push(rect);
        return margeLines;
    },
    cloneObjectProp: function (obj) {
        if (obj === null) return null;
        if (typeof obj !== 'object') return obj;
        if (obj.constructor === Date) return new Date(obj);
        var newObj = {};  //保持继承链
        for (var key in obj) {
            var val = obj[key];
            if (typeof val === 'number') {   //不遍历其原型链上的属性

                newObj[key] = val; // 使用arguments.callee解除与函数名的耦合
            }
        }
        return newObj;
    },
    // 给划线内容添加事件
    underlineAddEvent: function (e) {
        var x = e.clientX;
        var y = e.clientY;
        var _this = this;
        $(".selectText[marktype]").each(function () {
            var thisCoords = $(this)[0].getBoundingClientRect();
            if ((x > thisCoords.left && x < thisCoords.right) && y > thisCoords.top && y < thisCoords.bottom) {
            	if($('.func-pop').css('display')=='none'){
            		$('.func-pop').attr('markid',$(this).attr("markid")).attr('data-pid',$(this).attr("data-pid"));
            	}
                $("#pageDiv").addClass("cursor-enter-underline");
                return false;
            } else {
                $("#pageDiv").removeClass("cursor-enter-underline");
            }
        })
    },
    //功能弹窗显示位置
    popCoords: function (left,top,box1) {
        var box = $(box1);
        box.css({
            top: top + 'px',
            left: left + 'px',
        }).show();
        $('.markPop,.colorPop').hide();
        // $('.typecolor').removeClass('active');
        if(!box.attr('mark-pid')){
        	box.attr('markid',mark.opt.currLabelData.id).attr('data-pid',mark.opt.currLabelData.beginpid)
        }
    },
    showSelecttext: function (echoitem) {// 显示标注
        this.jsDrawRange(echoitem);
        rangy.init();
        cssApplier = rangy.createClassApplier("marked");
        cssApplier.toggleSelection();
        this.opt.markedObj = this.getSelectedDom();
        this.opt.currSelection = window.getSelection();
        this.drawline();
    },
    // 兼容旧 property：缺少段落/offset 信息时，按 content 在当前页自动补全定位字段
    normalizeLegacyEcho: function (echoitem) {
        if (!echoitem) {
            return echoitem;
        }
        var hasRangeMeta = (echoitem.intstartid !== undefined && echoitem.intendid !== undefined &&
            echoitem.beginOffset !== undefined && echoitem.endOffset !== undefined);
        if (hasRangeMeta) {
            return echoitem;
        }
        if (!echoitem.content) {
            return echoitem;
        }
        var content = String(echoitem.content);
        var paragraphs = $("#pageDiv>p");
        for (var i = 0; i < paragraphs.length; i++) {
            var pEl = paragraphs[i];
            var pText = $(pEl).text();
            var startInP = pText.indexOf(content);
            if (startInP < 0) {
                continue;
            }
            var endInP = startInP + content.length;
            var walker = document.createTreeWalker(pEl, NodeFilter.SHOW_TEXT, null, false);
            var node, totalLen = 0;
            var startTN = null, endTN = null, startOffset = 0, endOffset = 0;
            while ((node = walker.nextNode())) {
                var txt = node.nodeValue || "";
                var len = txt.length;
                if (!startTN && startInP <= totalLen + len) {
                    startTN = node;
                    startOffset = Math.max(0, startInP - totalLen);
                }
                if (!endTN && endInP <= totalLen + len) {
                    endTN = node;
                    endOffset = Math.max(0, endInP - totalLen);
                    break;
                }
                totalLen += len;
            }
            if (!startTN) {
                continue;
            }
            if (!endTN) {
                endTN = startTN;
                endOffset = startOffset + content.length;
            }
            var startParent = startTN.parentNode;
            var endParent = endTN.parentNode;
            var anchorParentIsParagraph = (startParent === pEl);
            var focusParentIsParagraph = (endParent === pEl);
            var startNodeClass = startParent.tagName.toLowerCase() + (startParent.className ? '.' + startParent.className.replace(/ /gi, '.') : '');
            var endNodeClass = endParent.tagName.toLowerCase() + (endParent.className ? '.' + endParent.className.replace(/ /gi, '.') : '');
            var startNodeIndex, endNodeIndex;
            if (anchorParentIsParagraph) {
                startNodeIndex = Array.prototype.indexOf.call(pEl.childNodes, startTN);
            } else {
                startNodeIndex = $(pEl).find(startNodeClass).index($(startParent));
            }
            if (focusParentIsParagraph) {
                endNodeIndex = Array.prototype.indexOf.call(pEl.childNodes, endTN);
            } else {
                endNodeIndex = $(pEl).find(endNodeClass).index($(endParent));
            }
            echoitem.intstartid = parseInt($(pEl).attr("sequence-id"));
            echoitem.intendid = echoitem.intstartid;
            echoitem.beginpid = $(pEl).attr("data-pid");
            echoitem.endpid = echoitem.beginpid;
            echoitem.beginOffset = startOffset;
            echoitem.endOffset = endOffset;
            echoitem.startNodeClass = startNodeClass;
            echoitem.endNodeClass = endNodeClass;
            echoitem.startNodeIndex = startNodeIndex;
            echoitem.endNodeIndex = endNodeIndex;
            echoitem.startTextIndex = -1;
            echoitem.endTextIndex = -1;
            echoitem.anchorParentIsParagraph = anchorParentIsParagraph;
            echoitem.focusParentIsParagraph = focusParentIsParagraph;
            return echoitem;
        }
        return echoitem;
    },
    showmark: function (initFlag,curNodeId,curCardId) {    // 标注回显
    	$('#markDiv').html('')
        var $this, echoLen, n;
        echoLen = echo.length;
        this.isNewline = false;
        
        for (n = 0; n < echoLen; n++) {
        	var echoitem ;
            $this = echo[n];
            echoitem = JSON.parse(JSON.stringify($this));
            var oriEchoItem = echoitem;

            if (parent.window && parent.window.isDigitalTextbookPage == "true" && initFlag && initFlag === 'init') {
                if (oriEchoItem.nodeId != curNodeId || oriEchoItem.cardId != curCardId) {
                    if (oriEchoItem.marktype == 'bg' || oriEchoItem.marktype == 'bgline') {
                        bgAndBgLine.push(oriEchoItem);
                        parent.bgAndBgLine = bgAndBgLine;
                    }

                    continue;
                }
            }

            echoitem = this.normalizeLegacyEcho(echoitem);

            echoitem = this.campareIdentifier(echoitem);
            if (!echoitem) {
                if (((initFlag && initFlag === 'init') || (parent.window && parent.window.isDigitalTextbookPage == "true"))
                    && (oriEchoItem.marktype == 'bg' || oriEchoItem.marktype == 'bgline')) {
                    bgAndBgLine.push(oriEchoItem);
                }

                if ((initFlag && initFlag === 'init') || (parent.window && parent.window.isDigitalTextbookPage == "true")) {
                    parent.bgAndBgLine = bgAndBgLine;
                }

                continue;
            }
            this.jsDrawRange(echoitem);
            rangy.init();
            cssApplier = rangy.createClassApplier("marked");
            cssApplier.toggleSelection();
            this.opt.markedObj = this.getSelectedDom();
            this.opt.currSelection = window.getSelection();
            this.opt.currLabelData = echoitem;
            if(this.opt.currSelection.rangeCount==0){

                if (((initFlag && initFlag === 'init') || (parent.window && parent.window.isDigitalTextbookPage == "true"))
                    && (this.opt.currLabelData.marktype == 'bg' || this.opt.currLabelData.marktype == 'bgline')) {
                    bgAndBgLine.push(this.opt.currLabelData);
                }

                if ((initFlag && initFlag === 'init') || (parent.window && parent.window.isDigitalTextbookPage == "true")) {
                    parent.bgAndBgLine = bgAndBgLine;
                }

            	continue;
            }

            this.drawline(initFlag);
            var type = this.opt.currLabelData.marktype;
            var color = this.opt.currLabelData.markcolor;
            switch (type){
				case 'note':
					$(".selectText[markid="+this.opt.currLabelData.id+"]").attr('marktype',type).css({'background':'none','background-image':'none','border-bottom':'3px solid #FAE291'});
					break;
				case 'bg':
					$(".selectText[markid="+this.opt.currLabelData.id+"]").attr('marktype',type).css({'background-image':'none',"border-bottom":"none","background-color":color});
                    break;
                case 'bgline':
                    var borderbottom = '2px solid ' + color;
                    $(".selectText[markid=" + this.opt.currLabelData.id + "]").attr('marktype', type).css({'background': 'none', 'background-image': 'none', 'border-bottom': borderbottom});
                    break;
				default:
					break;
			}
            $(".selectText[markid="+this.opt.currLabelData.id+"]").attr('topicid',this.opt.currLabelData.topicid).attr('recordid', this.opt.currLabelData.recordid);
            $('.func-pop,.markPop,.colorPop').hide();

            if (parent.window && parent.window.isDigitalTextbookPage == "true") {
                const selection = window.getSelection();
                if (selection.rangeCount > 0) {
                    selection.removeAllRanges();
                }
            }
        }
    },
    // 回显的数据起始标识符与本页起始标识符进行比较
    campareIdentifier: function ($this) {
    	var startbp = parseInt($('#pageDiv>p').first().attr('sequence-id'));
    	var endbp = parseInt($('#pageDiv>p').last().attr('sequence-id'));
    	if($this.intstartid>=startbp && $this.intendid<=endbp){ //开始和结束都在当前页
    		return $this;
    	}else if($this.intstartid>=startbp && $this.intstartid<= endbp && $this.intendid>endbp){ //开始在当前页，结束在下一页
    		$this.intendid = endbp;
    		$this.endOffset = $('#pageDiv>p').children().last().text().length;
    		return $this;
    	}else if($this.intstartid<startbp && $this.intendid>=startbp && $this.intendid<=endbp){ //开始在上一页,结束在当前页
    		$this.intstartid = startbp;
    		$this.beginOffset = 0;
    		return $this;
    	}else if($this.intstartid<startbp && $this.intendid>endbp){ //开始在上一页，结束在下一页
    		$this.intstartid = startbp;
    		$this.intendid = endbp;
    		$this.beginOffset = 0;
    		$this.endOffset = $('#pageDiv>p').children().last().text().length;
    		return $this;
    	}else{
    		return null;
		}
        return $this;
    },
    //  未保存的划线取消
    cancleUnderline: function () {
    	if(document.getSelection().length==0){
    		$('#pageDiv .marked').unwrap('span');
    	}
        $(".selectText").css("display", "inline-block");
        $(".selectText").each(function () {
            var labelId = $(this).attr("markid");
            if (labelId == 'undefined' || !labelId) {
                $(this).remove();
            }
            if(!$(this).attr('marktype')){
            	$(this).remove();
            }
        })
        var markid = $('.func-pop').attr('markid');
        var curPopDisplay = $('.func-pop').css('display')
        if ($(".selectText[markid='" + markid + "']").attr('marktype') && (curPopDisplay && curPopDisplay.indexOf('block') > -1) && hasmark) {
        	//更新或新增数据
        	this.saveOrUpdateNote(markid);
        }
        $('.func-pop,.markPop,.colorPop').hide();
        //内容初始化
		page.curNote = {leftWordsCount: 1000, content: ""};
        $('.markContent', parent.document).remove();
        hasmark = false;
    },
    // 保存或更新划线笔记
    saveOrUpdateNote: function(markid){
		page.echo = JSON.stringify(mark.opt.currLabelData);
        var topicid =  $(".selectText[markid='"+markid+"']").attr('topicid');
        var recordid =  $(".selectText[markid='"+markid+"']").attr('recordid');
        var markType = $(".selectText[markid='"+markid+"']").attr("marktype");
		if(recordid){
			// 修改标记笔记
            var url = _HOST_CP2_ + "/chapter-document/update";
            $.ajax({
                type : "post",
                url : url,
                dataType : "json",
                data : {
                    courseid: courseId,
                    knowledgeid: knowledgeId,
                    clazzid: clazzId,
                    cpi: cpi,
                    cardid: cardId,
                    ut: ut,
                    markid: recordid,
                    property: page.echo
                },
                success : function(data) {
                    if(data.result == 1){
                        mark.clearEcho();
                        mark.showmark();

                        for (var i = 0; i < bgAndBgLine.length; i++) {
                            if (bgAndBgLine[i].recordid == recordid) {
                                var createTimeStr = bgAndBgLine[i].createTimeStr;
                                bgAndBgLine[i] = JSON.parse(page.echo);
                                bgAndBgLine[i].createTimeStr = createTimeStr;
                                // if (!createTimeStr || createTimeStr == "") {
                                //     bgAndBgLine[i].createTimeStr = getFormattedDate();
                                // }
                            }
                        }
                        refreshRenderingMarkData()
                    }else{
                        alert(markTips);
                    }
                }
            });
			return ;
		}
		
		//新增标记笔记
        var url = _HOST_CP2_ + "/chapter-document/savemark";
        $.ajax({
            type : "post",
            url : url,
            dataType : "json",
            data : {
                courseid: courseId,
                knowledgeid: knowledgeId,
                clazzid: clazzId,
                cpi: cpi,
                cardid: cardId,
                type: markType,
                ut: ut,
                property: page.echo,
                topicid: topicid
            },
            success : function(data) {
                if (data.result == 1) {
                    var recordid = data.mark_id;
                    var topicid = data.topicid;
                    var markid = mark.opt.currLabelData.id;
                    $(".selectText[markid='" + markid+"']").attr('topicid', topicid).attr('recordid', recordid);
                    for(var i=0;i<echo.length;i++) {
                        if (echo[i].id == markid) {
                            echo[i].recordid = recordid;
                            echo[i].topicid = topicid;
                            break;
                        }
                    }
                    mark.clearEcho();
                    mark.showmark();
                    var bgObj = JSON.parse(page.echo);
                    bgObj.recordid = recordid;
                    bgObj.createTimeStr = getFormattedDate();
                    page.echo = JSON.stringify(bgObj);
                    bgAndBgLine.push(bgObj)
                    refreshRenderingMarkData()
                } else {
                    alert(markTips);
                }
            }
        });
    },
    // 浏览器宽度改变 批注重绘
    zzechoAgain:function () {
        var timer;
        var _this=this;
        window.addEventListener("resize", function() {
            if(timer){
                clearTimeout(timer)
            }
            timer = setTimeout(function () {
                mark.clearEcho();
                mark.showmark();
            },10)
        });
    },
    clearEcho: function () {
		$('.selectText').remove();
    },
    showEcho:function(){
    	this.clearEcho();
    	this.showmark();
    }
}
mark.init();
mark.showmark();
//画过线的鼠标滑过显示为鼠标
$('#pageDiv').on('mousemove',function(e){
	mark.underlineAddEvent(e);
})
$('#pageDiv').on('mousestart',function(e){
	mouseclick = true;
})
$('#pageDiv').on('mouseup',function(e){
	e.stopPropagation();
	if(window.getSelection().rangeCount==0){

	}else{
		mark.selectText(e, this);
	}
})
function hideAIToolbarBox() {
    //显示工具栏，是划线显示删除划线，显示笔记列表
    var markid = $('.func-pop').attr('markid');
    markType = $(".selectText[markid='" + markid + "']").attr('marktype');
    markColor = mark.opt.currLabelData.markcolor;
    $("#auditionAudio").attr("src", "");
    $("#transResultDiv").empty();
    $(".trans-ques-text").empty();
    $(".translationBox").hide();
    $(".tool-translation").removeClass("curtool");
}
//点击划线内容
$('#pageDiv').on('click',function(e){
	//20210705
	if(e.target.nodeName=='IMG' || e.target.nodeName == 'IFRAME'){
		return;
	}
	e.stopPropagation();
    hideAIToolbarBox();
	if(!$(this).hasClass('cursor-enter-underline') && mouseclick && $('.func-pop').css('display')!='block'){
		$('.doubleWrap .topList').slideToggle(200);
		$('#controls').fadeOut();
		$(".divPop,.setttingBox,.helpDetail,.helpStepBox").hide();
		$('.topItem').removeClass('active');
		return;
	}else if(!$(this).hasClass('cursor-enter-underline') || !mouseclick){
		return;
	}
	
	var x = e.clientX;
    var y = e.clientY;
    $(".selectText[marktype]").each(function () {
        var thisCoords = $(this)[0].getBoundingClientRect();
        if ((x > thisCoords.left && x < thisCoords.right) && y > thisCoords.top && y < thisCoords.bottom) {
        	$('.func-pop').attr('markid',$(this).attr("markid")).attr('data-pid',$(this).attr("data-pid")).attr('recordid',$(this).attr("recordid")).attr('topicid',$(this).attr("topicid"));
            return false;
        }
    })
	//显示工具栏，是划线显示删除划线，显示笔记列表
	var markid = $('.func-pop').attr('markid');
	var nowecho={};
	for(var i=0;i<echo.length;i++){
		if(echo[i].id == markid){
			mark.opt.currLabelData = nowecho = echo[i];
			break;
		}
	}
	markType = $(".selectText[markid='"+markid+"']").attr('marktype');
	markColor = mark.opt.currLabelData.markcolor;
    if(markType!='note'){
        if($(".selectText[markid='"+markid+"']").length>0){
            var top = $(".selectText[markid='"+markid+"']").last().offset().top -42;
            var left = $(".selectText[markid='"+markid+"']").last().offset().left;
            mark.popCoords(left,top,".func-pop");
        }
        if ($(".highlightMask").length > 0) {
            $(".highlightMask .settingCenter li").removeClass("active");
            $(".highlightMask").show();
        } else {
            $('.colorPop').show();
            var popTop = $(".selectText[markid='"+markid+"']").last().offset().top;
            var popLeft = $(".selectText[markid='"+markid+"']").last().offset().left;
            var wapWidth = $(".wrap").width();
            if (parseInt(wapWidth) - popLeft < 270) {
                popLeft = wapWidth - 270;
            }
            var popHeight = $('.colorPop').outerHeight(true); // 获取弹窗真实高度
            var wrapBottom = $(".wrap").offset().top + $(".wrap").outerHeight(); // 父容器底部位置
            var popBottom = popTop + popHeight; // 弹窗底部位置

            if (popBottom > wrapBottom) {
                popTop = popTop - popHeight;
            }
            $('.colorPop').css("top", popTop + "px");
            $('.colorPop').css("left", popLeft + "px");
        }
    } else {
        $('.func-pop').hide();
        var topicid = nowecho.topicid;
        $("#tit2", parent.document).click();
        if ($(".bbsid").length > 0 && $(".highlightMask").length > 0) {
            var Groupbbsid = $(".bbsid").val();
            jsBridge && jsBridge.postNotification('CLIENT_OPEN_TOPIC', {"Groupbbsid": Groupbbsid,"TopicId": topicid, fid: window.cookieFid, isMirror: parseInt(window.isMirror)}) ;
        }
    }
});
//删除标记
$('body').on('click','.noBg',function(e){
	e.stopPropagation();
	var recordid = $('.func-pop').attr('recordid');
    var markid = $('.func-pop').attr('markid');
    // 删除标注
	deletemark(recordid, markid);
})

// 点击提问，打开讨论新建讨论，需要获取到当前选中的文本添加到新建讨论的最上方
$('body').on('click','.donote',function(e){
    $(".formTopic .formTopic_padding .markContent", parent.document).remove();
	e.stopPropagation();
    if (mark.opt.currLabelData.content.length > 300) {
        alert(markOverTips);
        return;
    }
	var markid = $('.func-pop').attr('markid');
	if($('.func-pop').css('display')=='block' && $('.deletemark').css('display')=='none' && $(".selectText[markid='"+markid+"']").attr('marktype')!='note'){
		//点了标记但是还没有上传
		$(".selectText[markid='"+markid+"']").removeAttr('marktype');
	}
	
	var dataid = $('.func-pop').attr('data-pid');
    if ($("#content2", parent.document).css("display") == "none") {
        $("#tit2", parent.document).click();
    }
    $("#content2>.newTopic1 .newTopic_bnt", parent.document).click();
    var targetElements = $(".formTopic .formTopic_padding .formTopic_title", parent.document);
    var insertElement = $("<div class='markContent'><i></i><span title='" + mark.opt.currLabelData.content + "'>" + mark.opt.currLabelData.content + "</span></div>");
    insertElement.insertBefore(targetElements);
    mark.showSelecttext(mark.opt.currLabelData);
    try {
        if ($(".leftButton ul li",parent.document).length > 0) {
            $(".leftButton ul li",parent.document).eq(1).click()
        }
    } catch (e) {
    }
});

//删除标记
function deletemark(recordId, markid){
	$(".selectText[markid='"+markid+"']").remove();
    if ($(".selectText[markid='"+markid+"']").attr('marktype') == "note") {
        return;
    }
	$('.func-pop,.markPop,.colorPop').hide();
	for(var i=0;i<echo.length;i++){
        if (echo[i].id == markid){
　　　　　　	echo.splice(i,1);
			// 删除标注
　　　　　　	if(!recordId){
　　　　　　		return ;
　　　　　　	}
            var url = _HOST_CP2_  + "/chapter-document/delmark";
            $.ajax({
                type : "get",
                url : url,
                dataType : "json",
                data : {
                    courseid: courseId,
                    knowledgeid: knowledgeId,
                    clazzid: clazzId,
                    cpi: cpi,
                    cardid: cardId,
                    ut: ut,
                    markid: recordId
                },
                success : function(data) {
                    if (data.result == 1) {
                        mark.clearEcho();
                        mark.showmark();
                        bgAndBgLine = $.grep(bgAndBgLine, function (item) {
                            return item.recordid != recordId;
                        });
                        refreshRenderingMarkData()
                    }
                }
            });
	　　 } 
	}
}
//对页面上选中区域进行标记
function domark(type,color,content){
	hasmark = true;
	mark.opt.currLabelData.marktype = type;
	mark.opt.currLabelData.markcolor = color;
    if (typeof content != "undefined") {
        mark.opt.currLabelData.content = content;
    }
	var curecho = mark.opt.currLabelData;
	var isnew = true;
	for(var i= 0;i < echo.length;i++){
		if(echo[i].id == curecho.id){
			isnew = false;
            echo[i].marktype = type;
            echo[i].markcolor = color;
            if (typeof content != "undefined") {
                echo[i].content = content;
            }
			break;
		}
	}
	if(isnew){
		//  上传新数据
		echo.push(curecho);
	}
	$(".selectText[markid="+curecho.id+"]").css({'background-color':'unset','background-image':'none',"border-bottom":"none"});
	if(type!='note'){
		$('.domark span').css({'background-color':'unset','background-image':'none',"border-bottom":"none"});
	}
	switch (type){
		case 'note':
			$(".selectText[markid="+curecho.id+"]").attr('marktype',type).css({'border-bottom':'solid 3px'+color});
			break;
		case 'bg':
			$(".selectText[markid="+curecho.id+"]").attr('marktype',type).css({"background-color":color});
			break;
        case 'bgline':
            $(".selectText[markid=" + curecho.id + "]").attr('marktype', type).css({'border-bottom': 'solid 2px' + color});
            break;
		default:
			break;
	}
	page.echo = JSON.stringify(mark.opt.currLabelData);
}

//点击标记，出现标记颜色框
$('body').on('click','.domark',function(e){
	e.stopPropagation();
    if (mark.opt.currLabelData.content.length > 300) {
        alert(markOverTips);
        return;
    }
    // 只在真正“做标注/上色”时校验：允许多段选择，但不允许跨段标注
    if (mark && mark.opt && mark.opt.currLabelData &&
        mark.opt.currLabelData.intstartid !== undefined &&
        mark.opt.currLabelData.intendid !== undefined &&
        mark.opt.currLabelData.intstartid !== mark.opt.currLabelData.intendid) {
        alert('当前不支持跨段落选择，请重新选择文本！');
        return;
    }
    var markid = $(".func-pop").attr("markid");
    $('.colorPop').show();
    var top = parseInt($("#markDiv span[markid='" + markid+"']").offset().top);
    var left = parseInt($("#markDiv span[markid='" + markid+"']").offset().left);
    var wapWidth = $(".wrap").width();
    if (parseInt(wapWidth) - left < 270) {
        left = wapWidth - 270;
    }
    var popHeight = $('.colorPop').outerHeight(true); // 获取弹窗真实高度
    var wrapBottom = $(".wrap").offset().top + $(".wrap").outerHeight(); // 父容器底部位置
    var popBottom = top + popHeight; // 弹窗底部位置

    if (popBottom > wrapBottom) {
        top = top - popHeight;
    }
    $('.colorPop').css("top", top + "px");
    $('.colorPop').css("left", left + "px");
})

//选中某种颜色高亮
$('.colorPop td span').click(function(){
	markColor = rgb2hex($(this).css('background-color'));
	
	$('.colorPop').hide();

    // 背景色 span-underline:下划线
    var selectStyleObj = $('.colorPop .selectStyle .spanCurrent')
    if (selectStyleObj.hasClass('span-underline')) {
        markType = 'bgline';
    } else {
        markType = 'bg';
    }
    domark(markType, markColor);
})
$(".closeHightLight, .highlightMask").click(function(e){
    $(".highlightMask").hide();
    var selectColorItem = $(".settingCenter ul li.active");
    if (selectColorItem.length > 0) {
        // 选中的是删除背景颜色
        if ($(selectColorItem).hasClass("noBgDom")) {
            e.stopPropagation();
            var recordid = $('.func-pop').attr('recordid');
            var markid = $('.func-pop').attr('markid');
            // 删除标注
            deletemark(recordid, markid);
        } else {
            // 设置背景颜色
            markColor = rgb2hex($(selectColorItem).children("span").css('background-color'));
            domark(markType, markColor);
            mark.selectText(e, this);
        }
    }
})
$(".hightListSettings").click(function(event){
    event.stopPropagation();
})
$('.settingCenter ul li span').click(function(){
    markColor = rgb2hex($(this).css('background-color'));

    $('.colorPop').hide();

    // 背景色 span-underline:下划线
    var selectStyleObj = $('.settingCenter .selectStyle .spanCurrent')
    if (selectStyleObj.hasClass('span-underline')) {
        markType = 'bgline';
    } else {
        markType = 'bg';
    }
    
    domark(markType,markColor);
})
function zero_fill_hex(num, digits) {
  var s = num.toString(16);
  while (s.length < digits)
    s = "0" + s;
  return s;
}
//rgb颜色转16进制颜色
function rgb2hex(rgb) {
  if (rgb.charAt(0) == '#')
    return rgb;

  var ds = rgb.replace(/[(|)|rgb|rgba]*/gi, "").split(",");
  var decimal = Number(ds[0]) * 65536 + Number(ds[1]) * 256 + Number(ds[2]);
  if(ds.length==4){
  	var hex = Math.ceil(ds[3]*255).toString(16);
	hex = hex < 10 ? 0 + '' + hex : hex;
  	return '#' + zero_fill_hex(decimal, 6) + hex;
  }else{
  	return '#' + zero_fill_hex(decimal, 6);
  }
}

    // 获取文档标记、文档评论讨论
     function showecho(){
        try {
            if(null == echo){
                return ;
            }
        } catch (e) {
            return ;
        }
        //清空
        echo = [];
        $('#markDiv').html('')
        mark.clearEcho();
        mark.showmark();

        //加载标记笔记
        var url = _HOST_CP2_  + "/chapter-document/marklists";
         $.ajax({
             type : "get",
             url : url,
             dataType : "json",
             data : {
                 courseid: courseId,
                 knowledgeid: knowledgeId,
                 clazzid: clazzId,
                 cpi: cpi,
                 cardid: cardId,
                 ut: ut
             },
             success : function(data) {
                 if (data.result == 1 && data.data) {
                     data.data.forEach( function(tempNote) {
                         if(tempNote.property!=null && tempNote.property!=""){
                             var tempEcho = JSON.parse(tempNote.property)
                             tempEcho.recordid = tempNote.mark_id;
                             tempEcho.topicid = tempNote.topicid;

                             if (typeof tempNote.cardId != "undefined" && typeof tempNote.nodeId != "undefined") {
                                 tempEcho.cardId = tempNote.cardId;
                                 tempEcho.nodeId = tempNote.nodeId;
                             }

                             echo.push(tempEcho);
                         }
                     });
                 }
                 mark.showmark("init",knowledgeId,cardId);
                 page.hasLoadEcho = true;
                 refreshRenderingMarkData();
             }
         });
    }
$(function() {
    showecho();
})
function addTopic(topidId) {
    var quoteCon =  $('.markContent span', parent.document).html();
    if ($(".topicMarkContent").length > 0) {
        quoteCon = $(".topicMarkContent").val();
    }
    if(quoteCon && quoteCon.length>0){
        domark('note','#FAE291',quoteCon);
    }
    var topicId = topidId;
    //新增标记笔记
    var url = _HOST_CP2_ + "/chapter-document/savemark";
    $.ajax({
        type : "post",
        url : url,
        dataType : "json",
        data : {
            courseid: courseId,
            knowledgeid: knowledgeId,
            clazzid: clazzId,
            cpi: cpi,
            cardid: cardId,
            type: 1,
            ut: ut,
            property: page.echo,
            topicid: topicId
        },
        success : function(data) {
            if (data.result == 1) {
                var recordid = data.mark_id;
                var topicid = data.topicid;
                var markid = mark.opt.currLabelData.id;
                $(".selectText[markid='" + markid+"']").attr('topicid', topicid).attr('recordid', recordid);
                for(var i=0;i<echo.length;i++) {
                    if (echo[i].id == markid) {
                        echo[i].recordid = recordid;
                        break;
                    }
                }
                mark.clearEcho();
                mark.showmark();

                var bgObj = JSON.parse(page.echo);
                bgObj.recordid = recordid;
                bgObj.createTimeStr = getFormattedDate();
                page.echo = JSON.stringify(bgObj);
                bgAndBgLine.push(bgObj)
                refreshRenderingMarkData();
            } else {
                alert(markTips);
            }
        }
    });

}

function refreshRenderingMarkData() {
    try {
        parent.bgAndBgLine = bgAndBgLine;
        parent.renderingMarkData();
    } catch (e) {
    }
}

$(".feedback").click(function(){
    if (parent.openFeedbackBox) {
        parent.openFeedbackBox()
    }
})
$(".takeNotes").click(function(){
    if (mark.opt.currLabelData.content.length > 300) {
        alert(markOverTips);
        return;
    }
    if (parent.writeTextNote) {
        var text = mark.opt.currLabelData.content;
        parent.writeTextNote(text)
    }
    try {
        if ($(".leftButton ul li",parent.document).length > 0) {
            $(".leftButton ul li",parent.document).eq(2).click()
        }
    } catch (e) {
    }
})

// yyyy-MM-dd HH:mm
function getFormattedDate() {
    var now = new Date();
    var year = now.getFullYear();
    var month = String(now.getMonth() + 1).padStart(2, '0');
    var day = String(now.getDate()).padStart(2, '0');
    var hours = String(now.getHours()).padStart(2, '0');
    var minutes = String(now.getMinutes()).padStart(2, '0');
    // var seconds = String(now.getSeconds()).padStart(2, '0');
    // return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
    return `${year}-${month}-${day} ${hours}:${minutes}`;
}

$(document).on("click", ".transSelectBox", function () {
    var ul = $(this).find("ul"),
        display = ul.css("display");
    display = display == "block" ? 0 : 1;
    $(".transSelectBox ul").css("display", "none");

    if (display) {
        $(this).addClass("blue-border")
        ul.css("display", "block");
        display = 0;
        ul.find("li").each(function () {
            display += $(this).height();
        });
        ul.css("display", "none");
        //if (display > 200) {
        //	ul.css("height",200);
        //$(".options").css("overflow", "hidden");
        //ul.addClass("select-option")
        //}
        ul.slideDown(100);
    } else {
        $(this).removeClass("blue-border")
        ul.slideUp();
    }

    return false;
});

/**
 * 点击列表 文字和 value 上去
 */
$(document).on("click", ".transSelectBox ul li", function () {
    if (mark.opt.currLabelData.content.length > 500) {
        tipShow('notice', "选择文本不能超过500个字");
        return;
    }
    var p = $(this).parent().parent().find(".languageType").find("span");
    var nowLang = $(this).find("a").text();
    p.text(nowLang);
    p.attr("value", $(this).attr("value"));
    $(".transSelectBox ul li").removeClass("boxli_cur");
    $(this).addClass("boxli_cur");
    var selectedText = mark.opt.currLabelData.content;

    getTextLang(selectedText, nowLang);
});

$(".tool-assistant").click(function (e) {
    $(".toolNavBx li").removeClass("curtool");
    $(this).addClass("curtool");
    if (mark.opt.currLabelData.content.length > 500) {
        tipShow('notice', "选择文本不能超过500个字");
        return;
    }
    parent.ai_jobId = "";
    parent.ai_pageNum = "";
    parent.ai_ask_type = 1;
    var selectedText = mark.opt.currLabelData.content;
    parent.ai_ask_checkText = selectedText;
    parent.openCozeBotForText(selectedText);
})


$(".tool-read").click(function (e) {
    if (mark.opt.currLabelData.content.length > 160) {
        tipShow('notice', "选择文本不能超过160个字");
        return;
    }
    var audioPlayer = document.getElementById('auditionAudio');
    var readBtn = $(".func-pop .tool-read");
    if (readBtn.hasClass("tool-read-loading")) {
        return;
    } else if (readBtn.hasClass("tool-reading")) {
        readBtn.removeClass("tool-reading").removeClass("tool-read-loading").addClass("curtool");
        audioPlayer.pause();
        return;
    } else if (audioPlayer.getAttribute("src") != "") {
        readBtn.addClass("tool-reading").removeClass("tool-read-loading").removeClass("curtool");
        audioPlayer.play();
        return;
    }
    var selectedText = mark.opt.currLabelData.content;
    textToVoiceAction(selectedText);

})

$('.tool-translation').on('click', function (e) {
    if (mark.opt.currLabelData.content.length > 500) {
        tipShow('notice', "选择文本不能超过500个字");
        return;
    }
    $(".toolNavBx li").removeClass("curtool");
    $(this).addClass("curtool");
    var selectedText = mark.opt.currLabelData.content;
    e.stopPropagation();
    if (selectedTextPosition) {
        // isTranslationBoxVisible = true;
        var nowPosition = selectedTextPosition || {};
        var top = nowPosition.top;
        var left = nowPosition.left;
        updateTranslationBoxPosition(top, left); // 更新翻译框位置
        // $('.toolbarBox').hide(); // 隐藏工具栏

        $('.func-pop').hide();
        $(this).addClass("li-disabled");
        getTextLang(selectedText, "");
    }
});

// 更新翻译框位置（带边界检测）
function updateTranslationBoxPosition(baseTop, baseLeft) {
    var translationWidth = $('.translationBox').outerWidth() || 0;
    var translationHeight = $('.translationBox').outerHeight() || 0;
    var windowWidth = window.innerWidth;
    var windowHeight = window.innerHeight;

    var left = baseLeft;
    var top = baseTop;

    if (left + translationWidth > windowWidth) {
        left = windowWidth - translationWidth - 5;
    }
    if (top + translationHeight > windowHeight) {
        top = windowHeight - translationHeight - 5;
    }

    $('.translationBox').css({
        top: top + 'px',
        left: left + 'px',
        position: 'fixed'
    }).show();
}

function textToVoiceAction(text, lang) {

    var readBtn = $(".func-pop .tool-read");
    readBtn.removeClass("tool-reading").addClass("tool-read-loading").removeClass("curtool");
    var audioText = text.trim();
    audioText = audioText.replace(/\n/g, '');
    if (audioText == '' || audioText.length == 0) {
        return false;
    }
    readBtn.addClass("li-disabled");

    var param = {};
    param.courseId = $('#curCourseId').val();
    param.userId = $('#aiToolUserId').val();
    param.enc = $('#aiToolTextToVoiceEnc').val();
    param.voicetype = 1001;
    param.speed = 0;
    param.volume = 0;
    param.text = audioText;
    var isChapterRead = false;
    if (typeof lang == 'undefined') {
        isChapterRead = true;
    }
    if (lang && lang.length > 0) {
        param.lang = lang;
        if (lang == "ja") {
            param.voicetype = "multi_female_shuangkuaisisi_moon_bigtts";
            param.speed = 1;
        }
    } else {
        param.lang = "en";
    }
    jQuery.ajax({
        type: "post",
        url: "/ans-ext-proxy/api/texttovoice",
        dataType: 'json',
        data: param,
        success: function (json) {
            if (json.status) {
                var audioPlayer = document.getElementById('auditionAudio');
                if (isChapterRead && mark.opt.currLabelData.content != text) {
                    audioPlayer.setAttribute("src", "");
                    readBtn.removeClass("curtool").removeClass("tool-reading").removeClass("tool-read-loading");
                } else {
                    var prefix = 'data:audio/mpeg;base64,';
                    var audioSrc = prefix + json.data;
                    audioPlayer.setAttribute("src", audioSrc);
                    readBtn.removeClass("tool-read-loading").addClass("tool-reading");
                    audioPlayer.play();
                }
            } else {
                $(".icon-langdu").removeClass("icon-langduing");
                tipShow('notice', json.msg);
            }
        },
        error: function () {
            readBtn.removeClass("tool-reading").removeClass("tool-read-loading");
            $(".icon-langdu").removeClass("icon-langduing");
            tipShow('notice', "合成语音异常");
        },
        complete: function () {
            readBtn.removeClass("li-disabled");
        }
    });
}

function translateCopy() {
    if (!window.dt) {
        window.dt = new clipboard.DT();
    }
    var copyText = $("#transResultDiv").text();
    // dt.setData('text/html', copyText);
    dt.setData('text/plain', copyText);
    clipboard.write(dt).then(function () {
        tipShow('success', "复制成功");
    }, function (err) {
        tipShow('notice', "复制失败");
    });

}

function translateFollowUp() {
    if (translateInfo_lang != '' && translateInfo_content != '') {
        var userRound1 = "将以下内容翻译为" + translateInfo_lang + ":" + translateInfo_content + "";
        var aiRound1 = $("#transResultDiv").text();
        var userRound2 = $(".trans-ques-text").text();
        parent.ai_jobId = "";
        parent.ai_pageNum = "";
        parent.ai_ask_type = 1;
        parent.ai_ask_checkText = userRound2;
        hideAIToolbarBox();
        parent.openCozeBotTextAdditional(userRound1, aiRound1, userRound2);
    } else {
        tipShow('notice', "请稍后再试");
    }
}

function translateDisable(setDisable) {
    if (setDisable) {
        $(".transSelectBox").addClass("li-disabled");
        $(".trans-bottom").addClass("li-disabled");
    } else {
        $(".transSelectBox").removeClass("li-disabled");
        $(".trans-bottom").removeClass("li-disabled");
    }
}

function getTextLang(content, targetLang) {
    translateDisable(true);
    if (targetLang && targetLang != '') {
        getTextTranslateNewStream(content, targetLang);
    } else {
        var courseId = $('#curCourseId').val();
        var clazzId = $('#clazzId').val();
        var cpi = $('#aiToolCpi').val();
        $.ajax({
            type: "post",
            url: _HOST_CP2_ + "/edit/translate-lang/s",
            data: {
                cpi: cpi,
                courseid: courseId,
                clazzid: clazzId,
                content: content
            },
            dataType: "json",
            success: function (data) {
                if (data.status) {
                    var translateLangBar = $(".transSelectBox");
                    var nowLangLi;

                    var predicted = data.predicted;
                    var lang;
                    if (predicted == "zh") {
                        lang = "英文";
                        nowLangLi = translateLangBar.find('.options li[data="3"]');
                    } else {
                        lang = "中文（简体）";
                        nowLangLi = translateLangBar.find('.options li[data="1"]');
                    }
                    if (nowLangLi && nowLangLi.length > 0) {
                        var text = nowLangLi.text();
                        nowLangLi.addClass("boxli_cur").siblings().removeClass("boxli_cur");
                        translateLangBar.find(".languageType span").text(text);
                    }
                    getTextTranslateNewStream(content, lang);
                } else {
                    $(".tool-translation").removeClass("li-disabled");
                    tipShow('notice', data.msg);
                }
            },
            error: function () {
                $(".tool-translation").removeClass("li-disabled");
                tipShow('notice', "获取信息出错,请稍候刷新重试...");
            }
        });
    }

}

async function getTextTranslateNewStream(content, targetLang) {
    var ele = document.getElementById("transResultDiv");
    ele.innerText = "";
    var paramData = {"text": content, "lang": targetLang};
    var data = {
        "userId": $('#aiToolUserId').val(),
        "param": JSON.stringify(paramData),
        "t": $('#aiToolTime').val(),
        "type": "translate",
        "enc": $('#aiToolTranslateEnc').val()
    };
    var res = await fetch("/ai-ans/ai/chapter/tool/stream", {
        mode: "cors",
        method: 'POST',
        headers: {
            "Content-Type": "application/json"
        },
        signal: new AbortController().signal,
        body: JSON.stringify(data)
    });
    if (res.status !== 200) {
        $(".tool-translation").removeClass("li-disabled");
        return
    }
    translateInfo_lang = targetLang;
    translateInfo_content = content;
    const reader = res.body.pipeThrough(new TextDecoderStream()).getReader();
    var flag = 0;

    var allTxt = '';
    var lastText = "";
    while (true) {
        try {
            const {value, done} = await reader.read();
            var txt = lastText + value;
            lastText = "";
            if (done) {
                setTimeout(function () {
                    translateDisable(false);
                }, 1000)
                break;
            }
            if (txt) {
                var datas = txt.split("data:");
                if (datas && datas.length > 0) {
                    for (var j = 0; j < datas.length; j++) {
                        var result = datas[j];
                        if (result.trim().startsWith("{")) {

                            try {
                                var parse = JSON.parse(result.trim());
                                var itemText = null;
                                if (parse.choices && parse.choices[0].message) {
                                    itemText = parse.choices[0].message.content;
                                }

                                if (itemText == null) {
                                    flag++;
                                } else {
                                    allTxt += itemText
                                    if (ele.tagName == "TEXTAREA") {
                                        ele.value += itemText;
                                        ele.scrollTop = ele.scrollHeight;
                                    } else {
                                        ele.innerText += itemText;
                                    }
                                }
                            } catch (e) {
                                lastText = result;
                            }

                        }
                    }
                }
                if (flag === 2) {
                    break;
                }
            } else {
                break;
            }
        } catch (e) {
            $(".tool-translation").removeClass("li-disabled");
            console.error(e)
            break;
        }
    }
    $(".tool-translation").removeClass("li-disabled");
}

function refreshTranslate() {
    var selectedText = mark.opt.currLabelData.content;
    if (!selectedText || selectedText.length > 500) {
        tipShow('notice', "选择文本不能超过500个字");
        return;
    }
    var nowLang = $(".translationBg .languageType").text();
    getTextLang(selectedText, nowLang);
}

function readTranslate() {
    var ele = document.getElementById("transResultDiv");
    var readText = ele.innerText;
    if (!readText) {
        tipShow('notice', "朗读内容为空");
        return;
    }
    $(".icon-langdu").addClass("icon-langduing");
    var nowData = $(".transSelectBox .options .boxli_cur").attr("data");
    var nowLang = '';
    if (nowData == '4') {
        nowLang = 'fr';
    } else if (nowData == '5') {
        nowLang = 'ru';
    } else if (nowData == '6') {
        nowLang = 'ja';
    } else if (nowData == '7') {
        nowLang = 'ko';
    }
    textToVoiceAction(readText, nowLang);
}

function tipShow(type, msg) {
    if (parent.$.toast) {
        parent.$.toast({
            type: type,
            content: msg
        });
    } else {
        alert(msg);
    }
}

$(document).ready(function () {
    var isDragging = false;
    var offsetX, offsetY;

    try {
        $(document).on("mousedown", ".move-icon", function (e) {
            isDragging = true;
            var $box = $(this).closest(".translationBox");
            var boxRect = $box[0].getBoundingClientRect();
            offsetX = e.clientX - boxRect.left;
            offsetY = e.clientY - boxRect.top;
            $box.css("opacity", "0.8");
            e.preventDefault();
        });

        $(document).on("mousemove", function (e) {
            if (!isDragging) return;
            var $box = $(".translationBox");
            var boxWidth = $box.outerWidth();
            var boxHeight = $box.outerHeight();
            var left = e.clientX - offsetX;
            var top = e.clientY - offsetY;
            var windowWidth = window.innerWidth;
            var windowHeight = window.innerHeight;
            left = Math.max(0, Math.min(left, windowWidth - boxWidth));
            top = Math.max(0, Math.min(top, windowHeight - boxHeight));
            $box.css({left: left + 'px', top: top + 'px'});
        });

        $(document).on("mouseup", function () {
            isDragging = false;
            $(".translationBox").css("opacity", "1");
        });

        document.getElementById('auditionAudio').addEventListener('ended', function () {
            $(".icon-langdu").removeClass("icon-langduing");
            $(".func-pop .tool-read").removeClass("tool-reading").removeClass("tool-read-loading").addClass("curtool");
        });

        // $(window).on("scroll resize", function () {
        //     if (!isDragging) {
        //         const $box = $(".translationBox");
        //         const boxWidth = $box.outerWidth();
        //         const boxHeight = $box.outerHeight();
        //         let left = parseInt($box.css("left")) || 0;
        //         let top = parseInt($box.css("top")) || 0;
        //         const windowWidth = window.innerWidth;
        //         const windowHeight = window.innerHeight;
        //         left = Math.max(0, Math.min(left, windowWidth - boxWidth));
        //         top = Math.max(0, Math.min(top, windowHeight - boxHeight));
        //         $box.css({left: left + 'px', top: top + 'px'});
        //     }
        // });
    } catch (e) {
    }
});