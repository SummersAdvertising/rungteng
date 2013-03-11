/*
AnchorArt.js
平滑锚点跳转[支持新窗口打开的页面]
www.planeArt.cn
2009.08.25
*/

var currentElement = null;

//页面加载完成执行函数
function addLoadEvent(func) {
	var oldonload = window.onload;
	if (typeof window.onload != 'function') {
		window.onload = func;
		} else {
		window.onload = function() {
			if (oldonload) {
				oldonload();
			}
			func();
    	}
	}
}
addLoadEvent(function() {
	allLinks();//绑定链接
	pageInit();//获取锚点参数执行跳转
});

// 转换为数字
function intval(v){
	v = parseInt(v);
	return isNaN(v) ? 0 : v;
}

// 获取元素信息
function getPos(e){
	var l = 0;
	var t  = 0;
	var w = intval(e.style.width);
	var h = intval(e.style.height);
	var wb = e.offsetWidth;
	var hb = e.offsetHeight;
	while (e.offsetParent){
		l += e.offsetLeft + (e.currentStyle?intval(e.currentStyle.borderLeftWidth):0);
		t += e.offsetTop  + (e.currentStyle?intval(e.currentStyle.borderTopWidth):0);
		e = e.offsetParent;
	}
	l += e.offsetLeft + (e.currentStyle?intval(e.currentStyle.borderLeftWidth):0);
	t  += e.offsetTop  + (e.currentStyle?intval(e.currentStyle.borderTopWidth):0);
	return {x:l, y:t, w:w, h:h, wb:wb, hb:hb};
}

// 获取滚动条信息
function getScroll() {
	var t, l, w, h;
	/*if (document.documentElement && document.documentElement.scrollTop) {
		t = document.documentElement.scrollTop;
		l = document.documentElement.scrollLeft;
		w = document.documentElement.scrollWidth;
		h = document.documentElement.scrollHeight;
	} else if (document.body) {
		t = document.body.scrollTop;
		l = document.body.scrollLeft;
		w = document.body.scrollWidth;
		h = document.body.scrollHeight;
	}*/
	
	if 	( (document.documentElement && document.documentElement.scrollTop) || document.body ){
		t = document.documentElement.scrollTop > 0 ? document.documentElement.scrollTop :document.body.scrollTop;
		l = document.documentElement.scrollLeft > 0 ? document.documentElement.scrollLeft : document.body.scrollLeft;
		w = document.documentElement.scrollWidth;
		h = document.documentElement.scrollHeight;
	}
	
	return { t: t, l: l, w: w, h: h };
}

// 滚动
var $sr=1;//防止同时执行多个跳转
function scroller(el, duration){
	if(typeof el != 'object') { el = document.getElementById(el); currentElement = el;}
	
	if(!el) return;
	var z = this;
	z.el = el;
	z.p = getPos(el);
	z.s = getScroll();
	z.clear = function(){window.clearInterval(z.timer);z.timer=null};
	z.t=(new Date).getTime();
	z.step = function(){
		var t = (new Date).getTime();
		var p = (t - z.t) / duration;
		if (t >= duration + z.t) {
			z.clear();
			window.setTimeout(function(){z.scroll(z.p.y, z.p.x)},13);
			$sr=1;
		} else {
			st = ((-Math.cos(p*Math.PI)/2) + 0.5) * (z.p.y-z.s.t) + z.s.t;
			sl = ((-Math.cos(p*Math.PI)/2) + 0.5) * (z.p.x-z.s.l) + z.s.l;
			z.scroll(st, sl);
		}
	};
	z.scroll = function (t, l){
		window.scrollTo(l, t)
	};
	z.timer = window.setInterval(function(){z.step();},13);
	$sr=0;
}

//给页面锚点添加额外的参数
function goAnchor(href,target){
	u=href.split("#");
	if (target=='') target='_self';
	if (target=='_self' && $sr==1) scroller(u[1],800);
	window.open(u[0] + '#anchor=' + u[1],target=target);
}
function allLinks(){
	var allLinks = document.getElementsByTagName('a');
	for (var i=0;i<allLinks.length;i++) {
	  var lnk = allLinks[i];
	  if ((lnk.href && lnk.href.indexOf('#') != -1)) {
		  lnk.onclick=function(evt){
			  if ($sr==1) goAnchor(this.href,this.target);
			  return false;
		  }
	  }
	}
}

//接收页面锚点参数执行平滑跳转
function pageInit(){
	hash=window.location.hash.split("#anchor=");
	scroller(hash[1],800);
}