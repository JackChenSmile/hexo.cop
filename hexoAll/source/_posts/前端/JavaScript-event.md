---
title: JavaScript-event
date: 2018-11-06 20:59:40
tags:
---

###  获取页面中的单个标签/元素的方法

- getElementsByClassName()	获取同一类名的所有标签
- querySelector() 	查询指定选择器获取指定选择器的单个标签
- querySelectorAll()	查询指定选择器获取指定选择器的所有标签
- getElementById()		获取指定Id的标签
- getElementsByTagName()	获取指定标签名的列表

###  元素访问节点的方法

- children	元素访问子节点
- parentNode	元素访问父节点
- previousSibling	元素访问上一个兄弟节点
- nextSibling	元素访问下一个兄弟节点

###   绑定事件

#####  实例1

```html
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<style type="text/css">
			* {
				margin: 0px;
				padding: 0px;
			}
			div {
				margin-top: 100px;
				text-align: center;
			}
		</style>
	</head>
	<body>
		<div>
			<img id="Top" src="img/picture-1.jpg" alt="" />
		</div>
		<div id="foot">
			<img src="img/thumb-1.jpg" alt="" />
			<img src="img/thumb-2.jpg" alt="" />
			<img src="img/thumb-3.jpg" alt="" />
		</div>
		<script type="text/javascript">
			var index = 0;
			var ico = document.querySelectorAll("#foot>img");
			for (var i = 0;i < ico.length; i += 1) {
				// 给每张图片设置一个属性
				ico[i].index = i;
				// 绑定一个点击事件
				ico[i].addEventListener("click", function(event) {
					// 获取点击事件的事件源
					var img = event.target;
					// 点击之后要做的事情
					var pictur = document.getElementById("Top");
					// 更改图片的SRC属性
					pictur.src = "img/picture-" + (img.index + 1) + ".jpg";
				});
			}
		</script>
	</body>
</html>

```

#####  实例2

```html
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<style type="text/css">
			* {
				margin: 0px;
				padding: 0px;
			}
			#but>button {
				width: 200px;
				height: 100px;
				font: 22px/30px arial;
				background-color: red;
				color: white;
				outline: none;
				border: none;
			}
		</style>
	</head>
	<body>
		<div id="but">
			<button><input type="checkbox">0</button>
			<button><input type="checkbox">1</button>
			<button><input type="checkbox">2</button>
			<button><input type="checkbox">3</button>
		</div>
		<script>
			var buts = document.querySelectorAll("#but>button");
			for (var i = 0; i < buts.length; i += 1) {
				buts[i].firstChild.addEventListener("click", function(event) {
					var checkbox = event.target || event.srcElement;
					if (checkbox.checked) {
						checkbox.parentNode.style.backgroundColor = "blue";
					} else {
						checkbox.parentNode.style.backgroundColor = "red";
					}
					event.stopPropagation();
				});
				buts[i].addEventListener("click", function(event) {
					// 事件.target     选中事件源
					var button = event.target || event.srcElement;    // 验证浏览器的兼容性问题，通过短路或运算解决
					var checkbox = button.firstChild;
					checkbox.checked = !checkbox.checked;
//					window.alert("你选中了" + button.textContent);
					if (checkbox.checked) {
						button.style.backgroundColor = "blue";
					} else {
						button.style.backgroundColor = "red";
					}
				});
			}
		</script>
	</body>
</html>

```

#####  实例3

```html
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<style type="text/css">
			*{
				margin: 0px;
				padding: 0px;
			}
			#div0{
				margin-left: 600px;
				margin-top: 100px;
			}
			#div1{
				width: 300px;
				height: 300px;
				background-color: red;
				/*position: absolute;*/
			}
			#div2{
				width: 200px;
				height: 200px;
				background-color: blue;
				/*position: absolute;
				left: 50px;
				top: 50px;*/
			}
			#div3{
				width: 100px;
				height: 100px;
				/*position: absolute;
				top: 50px;
				left: 50px;*/
				background-color: cyan;
			}
			#div2, #div3{
				position: relative;
				top: 50px;
				left: 50px;
			}
		</style>
	</head>
	<body>
		<div id="div0">
			<div id="div1">
				<div id="div2">
					<div id="div3"></div>
				</div>
			</div>
		</div>
		<script type="text/javascript">
			var one = document.querySelector("#div1");
			var two = document.querySelector("#div2");
			var three = document.querySelector("#div3");
			// addEventListener方法的第一个参数是事件名
			// 第二个参数是事件发生时需要执行的回调函数
			// 第三个参数是一个布尔值
			//	如果是True,表示事件捕获 ----- 从外层向内传递事件
			//	如果是False,表示事件捕获 ----- 从内层向外传递事件
			// 一般选择事件捕获
			// 如果想阻止事件的传播行为可以调用事件对象的stopPropagation方法
			one.addEventListener("click", function() {
				window.alert("I am one!");
			});
			two.addEventListener("click", function() {
				window.alert("I am two!");
			});
			three.addEventListener("click", function() {
				window.alert("I am three!");
				event.stopPropagation();
			});
			// 事件回调函数中的第一个参数是事件对象（封装了和事件相关的信息）
			document.addEventListener("click", function(event) {
				window.alert("I am body!");
			});
		</script>
	</body>
</html>

```

#####  实例4

```html
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
	<body>
		<button id="ok">确定</button>
		<script>
			var okButton = document.querySelector("#ok");
			// 给okButton绑定click事件的回调函数
			function closeWindow() {
				if (window.confirm("Close the window?")) {
					window.close();
				} 
			}
			
			
			function helloWindow() {
				window.alert("hello, world!");
				okButton.removeEventListener()("click", closeWindow);
			}
			// 当你知道事件什么时候发生,但是你不知道这个事件什么时候发生
			// 在这种情况下通常处理方式都是绑定一个事件回调函数
			// closeWindow以及下面的匿名函数都属于事件回调函数		
			okButton.addEventListener("click", helloWindow);
			
			okButton.addEventListener("click", closeWindow);
			
			// 按钮只能点一次的效果,并且考虑兼容性
//			if (okButton.addEventListener) {
//				okButton.addEventListener("click", function() {
//					window.alert("hello,world!");
//					okButton.removeEventListener("click", arguments.callee);
//				});
//			} else {
//				okButton.addEventListener("onclick", function() {
//					window.alert("hello,world!");
//					okButton.removeEventListener("onclick", arguments.callee);
//				});
//			}
		</script>
	</body>
</html>

```

###  定时器

```HTML
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title></title>
	</head>
	<body>
		<h3><span id="counter">5</span>s之后自动跳转到百度</h3>
		<script type="text/javascript">
			var count = 5;
			var span = document.getElementById("counter")
//			function delay() {
//				count -= 1;
//				if (count == 0) {
//					window.location.href = "https://www.baidu.com";
//				} else {
//					span.textContent = count;
//					window.setTimeout(delay, 1000);
//				}
//			}
//			window.setTimeout(delay, 1000);
			
			
			window.setTimeout(function() {
				count -= 1;
				if (count == 0) {
					window.location.href = " ";
				} else {
					span.textContent = count;
					//arguments是函数中的隐含对象
					//通过arguments[0],ageuments[1],可以获得函数的参数
					//arguments.callee 伪数组,可以拿到正在被调用的函数
					window.setTimeout(arguments.callee, 1000);
				}
			}, 1000);
		</script>
	</body>
</html>

```

