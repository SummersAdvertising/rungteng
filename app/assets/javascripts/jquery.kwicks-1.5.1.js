/*
	Kwicks for jQuery (version 1.5.1)
	Copyright (c) 2008 Jeremy Martin
	http://www.jeremymartin.name/projects.php?project=kwicks
	
	Licensed under the MIT license:
		http://www.opensource.org/licenses/mit-license.php

	Any and all use of this script must be accompanied by this copyright/license notice in its present form.
*/

(function($){
	$.fn.kwicks = function(options) {
		var defaults = {
			isVertical: false,
			sticky: false,
			defaultKwick: 0,
			event: 'mouseover',
			spacing: 0,
			duration: 500
		};
		var o = $.extend(defaults, options);
		var WoH = (o.isVertical ? 'height' : 'width'); // WoH = Width or Height
		var LoT = (o.isVertical ? 'top' : 'left'); // LoT = Left or Top
		
		return this.each(function() {
			var container = $(this);
			var kwicks = container.children('li');
			var normWoH = kwicks.eq(0).css(WoH).replace(/px/,''); // normWoH = Normal Width or Height
			if(!o.max) {
				o.max = (normWoH * kwicks.size()) - (o.min * (kwicks.size() - 1));
			} else {
				o.min = ((normWoH * kwicks.size()) - o.max) / (kwicks.size() - 1);
			}
			// set width of container ul
			if(o.isVertical) {
				container.css({
					width : kwicks.eq(0).css('width'),
					height : (normWoH * kwicks.size()) + (o.spacing * (kwicks.size() - 1)) + 'px'
				});				
			} else {
				container.css({
					width : (normWoH * kwicks.size()) + (o.spacing * (kwicks.size() - 1)) + 'px',
					height : kwicks.eq(0).css('height')
				});				
			}

			// pre calculate left or top values for all kwicks but the first and last
			// i = index of currently hovered kwick, j = index of kwick we're calculating
			var preCalcLoTs = []; // preCalcLoTs = pre-calculated Left or Top's
			for(i = 0; i < kwicks.size(); i++) {
				preCalcLoTs[i] = [];
				// don't need to calculate values for first or last kwick
				for(j = 1; j < kwicks.size() - 1; j++) {
					if(i == j) {
						preCalcLoTs[i][j] = o.isVertical ? j * o.min + (j * o.spacing) : j * o.min + (j * o.spacing);
					} else {
						preCalcLoTs[i][j] = (j <= i ? (j * o.min) : (j-1) * o.min + o.max) + (j * o.spacing);
					}
				}
			}
			
			// loop through all kwick elements
			kwicks.each(function(i) {
				var kwick = $(this);
				// set initial width or height and left or top values
				// set first kwick
				if(i === 0) {
					kwick.css(LoT, '0px');
				} 
				// set last kwick
				else if(i == kwicks.size() - 1) {
					kwick.css(o.isVertical ? 'bottom' : 'right', '0px');
				}
				// set all other kwicks
				else {
					if(o.sticky) {
						kwick.css(LoT, preCalcLoTs[o.defaultKwick][i]);
					} else {
						kwick.css(LoT, (i * normWoH) + (i * o.spacing));
					}
				}
				// correct size in sticky mode
				if(o.sticky) {
					if(o.defaultKwick == i) {
						kwick.css(WoH, o.max + 'px');
						
					} else {
						kwick.css(WoH, o.min + 'px');
					}
				}
				kwick.css({
					margin: 0,
					position: 'absolute'
				});
				
				kwick.bind(o.event, function() {
					kwickMove();
				});

				function kwickMove(){
					kwick.unbind();
					var prevWoHs = []; // prevWoHs = previous Widths or Heights
					var prevLoTs = []; // prevLoTs = previous Left or Tops

					//收起點選的li
					if(kwick.hasClass("active")){

						$(kwick).children(".content").fadeOut(500);
						$('.recipe').fadeOut(500);
						$('h3').fadeOut(500);
						
						for(i = 0; i < kwicks.size(); i++) {
							prevWoHs[i] = kwicks.eq(i).css(WoH).replace(/px/, '');
							prevLoTs[i] = kwicks.eq(i).css(LoT).replace(/px/, '');
						}
						
						var aniObj = {};
						aniObj[WoH] = normWoH;

						var normDif = normWoH - prevWoHs[0];
						kwicks.eq(0).animate(aniObj, {
							step: function(now) {
								var percentage = normDif != 0 ? (now - prevWoHs[0])/normDif : 1;
								for(i = 1; i < kwicks.size(); i++) {
									kwicks.eq(i).css(WoH, prevWoHs[i] - ((prevWoHs[i] - normWoH) * percentage) + 'px');
									if(i < kwicks.size() - 1) {
										kwicks.eq(i).css(LoT, prevLoTs[i] - ((prevLoTs[i] - ((i * normWoH) + (i * o.spacing))) * percentage) + 'px');
									}
								}
								
							},
							complete:function(){
								kwicks.removeClass('active');
								$(kwick).children("h2").fadeIn(250);
								kwick.bind(o.event, function() {
									kwickMove();
								});

								$('#accordion-slider li').css("opacity", "1");

								$('#accordion-slider li').mouseover(function(){
									$(this).siblings().stop().animate({"opacity":".5"},250);
								});
								$('#accordion-slider li').mouseleave(function(){	
									$(this).siblings().stop().animate({"opacity":"1"},250);
								});
							},
							duration: o.duration,
							easing: o.easing
						});
						
					}
					//展開點選的li
					else{
						
						$(kwick).children("h2").delay(1000).fadeOut(500);
						var index = $('#accordion-slider li').index(kwick);
						i = index;
						
						// calculate previous width or heights and left or top values
						for(j = 0; j < kwicks.size(); j++) {
							prevWoHs[j] = kwicks.eq(j).css(WoH).replace(/px/, '');
							prevLoTs[j] = kwicks.eq(j).css(LoT).replace(/px/, '');
						}

						var aniObj = {};
						aniObj[WoH] = o.max;

						var maxDif = o.max - prevWoHs[i];
						var prevWoHsMaxDifRatio = prevWoHs[i]/maxDif;

						kwick.animate(aniObj, {
							step: function(now) {
								// calculate animation completeness as percentage
								var percentage = maxDif != 0 ? now/maxDif - prevWoHsMaxDifRatio : 1;
								// adjsut other elements based on percentage
								kwicks.each(function(j) {
									if(j != i) {
										kwicks.eq(j).css(WoH, prevWoHs[j] - ((prevWoHs[j] - o.min) * percentage) + 'px');
									}
									if(j > 0 && j < kwicks.size() - 1) { // if not the first or last kwick
										kwicks.eq(j).css(LoT, prevLoTs[j] - ((prevLoTs[j] - preCalcLoTs[i][j]) * percentage) + 'px');
									}
								});
							},
							complete:function(activeLi){
								kwick.addClass('active');
								$(kwick).children(".content").fadeIn(500)
								$('.recipe').fadeIn(500);
								$('h3').fadeIn(500);
																							
								kwick.bind(o.event, function() {
									kwickMove();
								});

								$('#accordion-slider li').unbind("mouseover mouseleave");
							},
							duration: o.duration,
							easing: o.easing
						});
					}
				}
			});
		});
	};
})(jQuery);