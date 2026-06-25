$(function() {
    if (parent != this) {
        var workIframe = parent.iframe;
        if (workIframe) {
            var oldHeight = workIframe.style.height;
            workIframe.style.height = '0';
            try {
                parent.dynIframeSize(workIframe);
                if (workIframe.style.height == '0' || workIframe.style.height == '0px') {
                    workIframe.style.height = oldHeight;
                }
            } catch (e) {
                workIframe.style.height = oldHeight;
            }
            try{
                // 设置card页面高度为小的值，card页面重新计算滚动高度
                var cardIframe = parent.parent.parent.document.getElementById("iframe");
                if(cardIframe) {
                    var bHeight = cardIframe.contentWindow.document.body.scrollHeight;
                    var dHeight = cardIframe.contentWindow.document.documentElement.scrollHeight;
                    cardIframe.height = Math.min(bHeight, dHeight);
                }
            }catch (e){}
        }
    }
});