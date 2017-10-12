<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

	<head>
		<base href="<%=basePath%>">

		<title>My JSP 'yinguoDishType.jsp' starting page</title>
		<meta name="viewport" content="width=device-width, user-scalable=no" />
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script type="text/javascript" src="js/jquery.js"></script>
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<style>
			* {
				padding: 0;
				margin: 0;
				font-size: 14px;
			}
			
			.div_title_el_left {
				background: url(img/narrow.png) no-repeat right center;
				background-size: 14px 14px;
				padding: 10px 0;
				margin: 0 8px;
				border-bottom: 1px solid #ececec;
				position: relative;
			}
			
			.replace_bg_image {
				background: url(img/rank.png) no-repeat right center;
				background-size: 17px 12px;
			}
			
			.div_sortable_menu_btn {
				position: fixed;
				bottom: 0;
				left: 50%;
				right: 0;
				background: #26303D;
				text-align: center;
			}
			
			.div_submit_button {
				color: #fff;
				padding: 10px 0;
				border-right: 1px solid #ececec;
				position: fixed;
				bottom: 0;
				left: 0;
				right: 50%;
				background: #26303D;
				text-align: center;
			}
			
			.div_sortable_menu_btn button {
				border: none;
				background: #26303D;
				color: #fff;
				width: 100%;
				padding: 10px 0;
				font-weight: 600;
			}
			
			.div_title_el_right {
				position: absolute;
				right: 0;
				top: 8px;
				display: none;
				width: 20px;
				height: 20px;
				background: #fff;
			}
			
			.div_title_el_right img {
				display: block;
				width: 15px;
				height: 18px;
			}
			
			@media only screen and (min-width: 415px) and (max-width: 1024px) {
				body {
					width: 90%;
					margin: 0 auto;
				}
			}
			
			@media only screen and (min-width: 1025px) {
				body {
					width: 1024px;
					margin: 0 auto;
				}
			}
		</style>
	</head>
	<script language="javascript" type="text/javascript">
		(function(factory) {
			"use strict";

			if(typeof define === "function" && define.amd) {
				define("Sortable", [], factory);
			} else {
				window["Sortable"] = factory();
			}
		})
		(function() {
			"use strict";

			var dragEl, ghostEl, rootEl, nextEl

				, lastEl, lastCSS

				, activeGroup

				, tapEvt, touchEvt

				, expando = 'Sortable' + (new Date).getTime()

				,
				win = window,
				document = win.document,
				parseInt = win.parseInt,
				_silent = false

				,
				Event = (function() {
					function CustomEvent(event, params) {
						var evt = document.createEvent('CustomEvent');
						evt.initCustomEvent(event, params.bubbles,
							params.cancelable, params.detail);
						return evt;
					}

					CustomEvent.prototype = win.CustomEvent.prototype;

					return CustomEvent;
				})()

				,
				noop = function() {},
				slice = [].slice

				,
				touchDragOverListeners = [];

			function Sortable(el, options) {
				this.el = el; // root element
				this.options = options = (options || {});

				// Defaults
				options.group = options.group || Math.random();
				options.handle = options.handle || null;
				options.draggable = options.draggable || el.children[0] &&
					el.children[0].nodeName || 'li';
				options.ghostClass = options.ghostClass || 'sortable-ghost';

				options.onAdd = _bind(this, options.onAdd || noop);
				options.onUpdate = _bind(this, options.onUpdate || noop);
				options.onRemove = _bind(this, options.onRemove || noop);

				el[expando] = options.group;

				// Bind all prevate methods
				for(var fn in this) {
					if(fn.charAt(0) === '_') {
						this[fn] = _bind(this, this[fn]);
					}
				}

				// Bind events
				_on(el, 'add', options.onAdd);
				_on(el, 'update', options.onUpdate);
				_on(el, 'remove', options.onRemove);

				_on(el, 'mousedown', this._onTapStart);
				_on(el, 'touchstart', this._onTapStart);

				_on(el, 'dragover', this._onDragOver);
				_on(el, 'dragenter', this._onDragOver);

				touchDragOverListeners.push(this._onDragOver);
			}

			Sortable.prototype = {
				constructor: Sortable,

				_applyEffects: function() {
					_toggleClass(dragEl, this.options.ghostClass, true);
				},

				_onTapStart: function(evt /**TouchEvent*/ ) {
					var touch = evt.touches && evt.touches[0],
						target = (touch || evt).target,
						options = this.options;

					if(options.handle) {
						target = _closest(target, options.handle, this.el);
					}

					target = _closest(target, options.draggable, this.el);

					if(target && !dragEl) {
						tapEvt = evt;
						target.draggable = true;

						// Disable "draggable"
						_find(target, 'a', _disableDraggable);
						_find(target, 'img', _disableDraggable);

						if(touch) {
							// Touch device support
							tapEvt = {
								target: target,
								clientX: touch.clientX,
								clientY: touch.clientY
							};
							this._onDragStart(tapEvt, true);
							evt.preventDefault();
						}

						_on(this.el, 'dragstart', this._onDragStart);
						_on(this.el, 'dragend', this._onDrop);

						_on(document, 'dragover', _globalDragOver);

						try {
							if(document.selection) {
								document.selection.empty();
							} else {
								window.getSelection().removeAllRanges()
							}
						} catch(err) {}
					}
				},

				_emulateDragOver: function() {
					if(touchEvt) {
						_css(ghostEl, 'display', 'none');

						var target = document.elementFromPoint(
								touchEvt.clientX, touchEvt.clientY),
							parent = target,
							group = this.options.group,
							i = touchDragOverListeners.length;

						do {
							if(parent[expando] === group) {

								while(i--) {
									touchDragOverListeners[i]({
										clientX: touchEvt.clientX,
										clientY: touchEvt.clientY,
										target: target,
										rootEl: parent
									});
								}
								break;
							}
						} while (parent = parent.parentNode);

						_css(ghostEl, 'display', '');
					}
				},

				_onTouchMove: function(evt) {
					if(tapEvt) {
						var touch = evt.touches[0],
							dx = touch.clientX -
							tapEvt.clientX,
							dy = touch.clientY -
							tapEvt.clientY;

						touchEvt = touch;
						_css(ghostEl, 'webkitTransform', 'translate3d(' +
							dx + 'px,' + dy + 'px,0)');
					}
				},

				_onDragStart: function(evt /**Event*/ , isTouch) {
					var target = evt.target,
						dataTransfer = evt.dataTransfer;

					rootEl = this.el;
					dragEl = target;
					nextEl = target.nextSibling;
					activeGroup = this.options.group;

					if(isTouch) {
						var rect = target.getBoundingClientRect(),
							css = _css(target);

						ghostEl = target.cloneNode(true);

						_css(ghostEl, 'top', rect.top -
							parseInt(css.marginTop, 10));
						_css(ghostEl, 'left', rect.left -
							parseInt(css.marginLeft, 10));
						_css(ghostEl, 'width', rect.right - rect.left);
						_css(ghostEl, 'height', rect.bottom - rect.top);
						_css(ghostEl, 'opacity', '0.8');
						_css(ghostEl, 'position', 'fixed');
						_css(ghostEl, 'zIndex', '100000');

						target.parentNode.insertBefore(ghostEl, target);

						// Bind touch events
						_on(document, 'touchmove', this._onTouchMove);
						_on(document, 'touchend', this._onDrop);

						this._loopId = setInterval(this._emulateDragOver,
							200);
					} else {
						dataTransfer.effectAllowed = 'move';
						dataTransfer.setData('Text', target.textContent);

						_on(document, 'drop', this._onDrop);
					}

					setTimeout(this._applyEffects);
				},

				_onDragOver: function(evt) {
					if(!_silent &&
						activeGroup === this.options.group &&
						(evt.rootEl === void 0 || evt.rootEl === this.el)) {
						var el = this.el,
							target = _closest(evt.target,
								this.options.draggable, el);

						if(el.children.length === 0) {
							el.appendChild(dragEl);
						} else if(target && (target !== dragEl)) {
							if(lastEl !== target) {
								lastEl = target;
								lastCSS = _css(target)
							}

							var rect = target.getBoundingClientRect(),
								width = rect.right -
								rect.left,
								height = rect.bottom -
								rect.top,
								floating = /left|right|inline/
								.test(lastCSS.cssFloat +
									lastCSS.display),
								skew = (floating ? (evt.clientX - rect.left) /
									width :
									(evt.clientY - rect.top) / height) > .5,
								isLong = (target.offsetHeight > dragEl.offsetHeight),
								isWide = (target.offsetWidth > dragEl.offsetWidth),
								nextSibling = target.nextSibling,
								after;

							_silent = true;
							setTimeout(_unsilent, 30);

							if(floating) {
								after = (target.previousElementSibling === dragEl) &&
									!isWide || (skew > .5) && isWide
							} else {
								after = (target.nextElementSibling !== dragEl) &&
									!isLong || (skew > .5) && isLong;
							}

							if(after && !nextSibling) {
								el.appendChild(dragEl);
							} else {
								target.parentNode.insertBefore(dragEl,
									after ? nextSibling : target);
							}
						}
					}
				},

				_onDrop: function(evt /**Event*/ ) {
					clearInterval(this._loopId);

					// Unbind events
					_off(document, 'drop', this._onDrop);
					_off(document, 'dragover', _globalDragOver);

					_off(this.el, 'dragend', this._onDrop);
					_off(this.el, 'dragstart', this._onDragStart);

					_off(document, 'touchmove', this._onTouchMove);
					_off(document, 'touchend', this._onDrop);

					if(evt) {
						evt.preventDefault();

						if(ghostEl) {
							ghostEl.parentNode.removeChild(ghostEl);
						}

						if(dragEl) {
							var opts = {
								bubbles: true,
								cancelable: true,
								detail: dragEl
							};

							_toggleClass(dragEl, this.options.ghostClass,
								false);

							if(!rootEl.contains(dragEl)) {
								// Remove event
								rootEl.dispatchEvent(new Event('remove',
									opts));

								// Add event
								dragEl
									.dispatchEvent(new Event('add',
										opts));
							} else if(dragEl.nextSibling !== nextEl) {
								// Update event
								dragEl.dispatchEvent(new Event('update',
									opts));
							}
						}

						// Set NULL
						rootEl = dragEl = ghostEl = nextEl =

							tapEvt = touchEvt =

							lastEl = lastCSS =

							activeGroup = null;
					}
				},

				destroy: function() {
					var el = this.el,
						options = this.options;

					_off(el, 'add', options.onAdd);
					_off(el, 'update', options.onUpdate);
					_off(el, 'remove', options.onRemove);

					_off(el, 'mousedown', this._onTapStart);
					_off(el, 'touchstart', this._onTapStart);

					_off(el, 'dragover', this._onDragOver);
					_off(el, 'dragenter', this._onDragOver);

					touchDragOverListeners.splice(touchDragOverListeners
						.indexOf(this._onDragOver), 1);

					this._onDrop();

					this.el = null;
				}
			};

			function _bind(ctx, fn) {
				var args = slice.call(arguments, 2);
				return fn.bind ? fn.bind.apply(fn, [ctx].concat(args)) :
					function() {
						return fn.apply(ctx, args.concat(slice
							.call(arguments)));
					};
			}

			function _closest(el, selector, ctx) {
				if(el && ctx) {
					ctx = ctx || document;
					selector = selector.split('.');

					var tag = selector.shift().toUpperCase(),
						re = new RegExp(
							'\\b(' + selector.join('|') + ')\\b', 'g');

					do {
						if((tag === '' || el.nodeName == tag) &&
							(!selector.length || ((el.className + '')
								.match(re) || []).length == selector.length)) {
							return el;
						}
					} while (el !== ctx && (el = el.parentNode));
				}

				return null;
			}

			function _globalDragOver(evt) {
				evt.dataTransfer.dropEffect = 'move';
				evt.preventDefault();
			}

			function _on(el, event, fn) {
				el.addEventListener(event, fn, false);
			}

			function _off(el, event, fn) {
				el.removeEventListener(event, fn, false);
			}

			function _toggleClass(el, name, state) {
				if(el) {
					if(el.classList) {
						el.classList[state ? 'add' : 'remove'](name);
					} else {
						var className = (' ' + el.className + ' ').replace(
							/\s+/g, ' ').replace(' ' + name + ' ', '');
						el.className = className +
							(state ? ' ' + name : '')
					}
				}
			}

			function _css(el, prop, val) {
				if(el && el.style) {
					if(val === void 0) {
						if(document.defaultView &&
							document.defaultView.getComputedStyle) {
							val = document.defaultView.getComputedStyle(el,
								'');
						} else if(el.currentStyle) {
							val = el.currentStyle;
						}
						return prop === void 0 ? val : val[prop];
					} else {
						el.style[prop] = val +
							(typeof val === 'string' ? '' : 'px');
					}
				}
			}

			function _find(ctx, tagName, iterator) {
				if(ctx) {
					var list = ctx.getElementsByTagName(tagName),
						i = 0,
						n = list.length;
					if(iterator) {
						for(; i < n; i++) {
							iterator(list[i], i);
						}
					}
					return list;
				}
				return [];
			}

			function _disableDraggable(el) {
				return el.draggable = false;
			}

			function _unsilent() {
				_silent = false;
			}

			// Export utils
			Sortable.utils = {
				on: _on,
				off: _off,
				css: _css,
				find: _find,
				bind: _bind,
				closest: _closest,
				toggleClass: _toggleClass
			};

			Sortable.version = '0.1.1';

			// Export
			return Sortable;
		});
	</script>

	<body>
		<div class="wrap" id="foo_Menu">
			<s:iterator value="yinguoDishType">

				<div class="div_admin_index_title menu" align="left">
					<div class="div_title_el_left" dish_type_id="<s:property value=" type_id " />">
						<a><s:property value="type_name" /></a>
						(下架<s:property value="shelves_count" />)(沽清<s:property value="estimate_count" />)		
					</div>
					<div style="clear: both;"></div>
				</div>
			</s:iterator>
		</div>
		<div class="wrap" id="foo_Sort">
			<s:iterator value="yinguoDishType">

				<div class="div_admin_index_title" align="left">
					<div class="div_title_el_left" dish_type_id="<s:property value=" type_id " />">
						<a><s:property value="type_name" /></a>
						(下架<s:property value="shelves_count" />)(沽清<s:property value="estimate_count" />)						
					</div>
					<div style="clear: both;"></div>
				</div>
			</s:iterator>
		</div>

		<div class="div_submit_button" align="center" onclick="window.location.href = '/abc/arpzDishAddJSP.action?user_id=<s:property value=" user_id "/>&check_string=<s:property value="check_string "/>&arpz_id=<s:property value="arpz_id "/>'">
			添加菜品
		</div>
		<div class="div_sortable_menu_btn">
			<button id="operate_btn" class="sort_btn">排序</button>

		</div>
		<script>
			$('#foo_Sort').css('display', 'none');
			$('#operate_btn').click(function() {
				if($('#operate_btn').html() == "排序") {
					$('#operate_btn').html('完成');
					$('.div_title_el_left').addClass('replace_bg_image');
					$('#foo_Menu').css('display', 'none');
					$('#foo_Sort').css('display', 'block');
					sortMenuType();
				}
				if($('#operate_btn').html() == "完成") {
					var dish_type_id = "";
					$('#foo_Sort .div_title_el_left').each(function(idx, ele) {
						dish_type_id += $(this).attr('dish_type_id') + "$";
					});
					dish_type_id = dish_type_id.substring(0, dish_type_id.length - 1);
					console.log(dish_type_id);

					saveNewMenuTypeOrder(dish_type_id);
					$('#foo_Sort').css('display', 'none');
					$('#foo_Menu').css('display', 'block');
					$('#operate_btn').html('排序');
					$('.div_title_el_left').removeClass('replace_bg_image');
				}
				window.location.reload();
			});

			$('.div_admin_index_title').on('click', '.div_title_el_left', function() {
				if($('#operate_btn').html() == "排序") {
					var type_id = $(this).attr('dish_type_id');

					window.location.href = '/abc/getArpzDishList.action?user_id=<s:property value=" user_id " />&check_string=<s:property value="check_string " />&arpz_id=<s:property value="arpz_id " />&type_id=' + type_id;
				}
			});

			function sortMenuType() {

				(function() {
					var console = window.console;

					if(!console.log) {
						console.log = function() {
							alert([].join.apply(arguments, ' '));
						};
					}

					new Sortable(foo_Sort, {
						group: "words",
						onAdd: function(evt) {
							console.log('onAdd.foo:', evt.detail);
						},
						onUpdate: function(evt) {
							console.log('onUpdate.foo:', evt.detail);
						},
						onRemove: function(evt) {
							console.log('onRemove.foo:', evt.detail);
						}
					});

					new Sortable(bar, {
						group: "words",
						onAdd: function(evt) {
							console.log('onAdd.bar:', evt.detail);
						},
						onUpdate: function(evt) {
							console.log('onUpdate.bar:', evt.detail);
						},
						onRemove: function(evt) {
							console.log('onRemove.bar:', evt.detail);
						}
					});

					new Sortable(multi, {
						draggable: '.tile',
						handle: '.tile__name'
					});

					[].forEach.call(multi.getElementsByClassName('tile__list'),
						function(el) {
							new Sortable(el, {
								group: 'photo'
							});
						});
				})();

				document.addEventListener("DOMContentLoaded", function() {
					function setNoiseBackground(el, width, height, opacity) {
						var canvas = document.createElement("canvas");
						var context = canvas.getContext("2d");

						canvas.width = width;
						canvas.height = height;

						for(var i = 0; i < width; i++) {
							for(var j = 0; j < height; j++) {
								var val = Math.floor(Math.random() * 255);
								context.fillStyle = "rgba(" + val + "," + val + "," + val +
									"," + opacity + ")";
								context.fillRect(i, j, 1, 1);
							}
						}

					}

					setNoiseBackground(document.getElementsByTagName('body')[0], 50, 50,
						0.02);
				}, false);

				(function() {
					var x, y;

					var items = [].slice.call(document.querySelectorAll('.layer')).map(
						function(el) {
							var rect = el.getBoundingClientRect();
							el.x = rect.left;
							el.y = rect.top;
							el.w = rect.right - rect.left;
							el.h = rect.bottom - rect.top;
							el.fX = el.getAttribute('data-force-x') ||
								el.getAttribute('data-force') || 10;
							el.fY = el.getAttribute('data-force-y') ||
								el.getAttribute('data-force') || 10;
							return el;
						});

					document.addEventListener('dragover', function(evt) {
						x = evt.clientX;
						y = evt.clientY;
					}, false);

					document.addEventListener('mousemove', function(evt) {
						x = evt.clientX;
						y = evt.clientY;
					}, false);

					(function _loop() {
						if(x && y) {
							var winWidth = window.innerWidth;
							var winHeight = window.innerHeight;
							var halfWidth = winWidth / 2;
							var halfHeight = winHeight / 2;

							var rx = x - winWidth / 2;
							var ry = winHeight / 2 - y;

							items
								.forEach(function(el) {
									var dx = el.w / el.fX * (rx / -halfWidth);
									var dy = el.h / el.fY * (ry / halfHeight);
									el.style['transform'] = el.style['-webkit-transform'] = 'translate(' +
										dx + 'px,' + dy + 'px)';
								});
						}

						requestAnimationFrame(_loop);
					})();
				})();
			}

			function saveNewMenuTypeOrder(dish_type_id) {
				$.ajax({
					type: "post",
					url: "/abc/yinguoDishTypeOrder.action",
					async: true,
					data: {
						dish_type_id: dish_type_id,
						arpz_id: <s:property value="arpz_id" />
					},
					success: function(data) {
						console.log(data);
						//						window.location.reload();
					},
					error: function(data) {
						console.log(data);
					}
				});
			}
		</script>
	</body>

</html>