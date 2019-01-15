---
title: JavaScript-createElement
date: 2018-11-07 21:17:45
tags:
---

###  practice-one

```html
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<style>
			#data {
				border-collapse: collapse;
			}
			#data td, #data th {
				width: 120px;
				height: 40px;
				text-align: center;
				border: 1px solid black;
			}
			#buttons {
				margin: 10px 0;
			}
		</style>
	</head>
	<body>
		<div id="big">
		<table id="data">
			<caption>数据统计表</caption>
			<tr>
				<th>姓名</th>
				<th>年龄</th>
				<th>性别</th>
				<th>身高</th>
				<th>体重</th>
			</tr>
			<tr>
				<td>Item1</td>
				<td>Item2</td>
				<td>Item3</td>
				<td>Item4</td>
				<td>Item5</td>
			</tr>
			<tr>
				<td>Item1</td>
				<td>Item2</td>
				<td>Item3</td>
				<td>Item4</td>
				<td>Item5</td>
			</tr>
			<tr>
				<td>Item1</td>
				<td>Item2</td>
				<td>Item3</td>
				<td>Item4</td>
				<td>Item5</td>
			</tr>
			<tr>
				<td>Item1</td>
				<td>Item2</td>
				<td>Item3</td>
				<td>Item4</td>
				<td>Item5</td>
			</tr>
			<tr>
				<td>Item1</td>
				<td>Item2</td>
				<td><a>Item3</a></td>
				<td>Item4</td>
				<td>Item5</td>
			</tr>
			<tr>
				<td>Item1</td>
				<td>Item2</td>
				<td>Item3</td>
				<td>Item4</td>
				<td><a>Item5</a></td>
			</tr>
		</table>
		</div>
		<div id="buttons">
			<button id="pretty">美化表格</button>
			<button id="clear">清除数据</button>
			<button id="remove">删单元格</button>
			<button id="add">加单元格</button>
			<button id="hide">隐藏表格</button>
		</div>
		<script>
			// 美化表格
			var prettyForm = document.getElementById("pretty");
			prettyForm.addEventListener("click", function() {
				var tr = document.getElementsByTagName("tr");
				for (var i = 1; i < tr.length; i += 1) {
					if (i % 2) {
						tr[i].style.backgroundColor = "cyan";
					} else {
						tr[i].style.backgroundColor = "red";
					};
				}
			});
			
			// 清除数据
			var clearForm = document.getElementById("clear");
			clearForm.addEventListener("click", function() {
				var td = document.getElementsByTagName("td");
				for (var i = 0; i < td.length; i += 1) {
					td[i].textContent = "";			
				}
			});
			
			// 删除单元格
			var removeForm = document.getElementById("remove");
			removeForm.addEventListener("click", function() {
				var tr = document.getElementsByTagName("tr");
				if (tr.length > 1) {
					tr[tr.length-1].remove();
				}
			});
			
			// 添加单元格
//			var addForm = document.getElementById("add");
//			addForm.addEventListener("click", function() {
//				var td = document.querySelectorAll("tr>td");
//				td.parentNode.appendChild(td);
//			});

			// 隐藏表格
			var hideForm = document.getElementById("hide");
			var form = document.getElementById("big");
			hideForm.addEventListener("click", function(event) {
				var buto = event.target;
				if (buto.isHidden) {
					form.style.display = "";
					buto.isHidden = false;
					buto.textContent = "显示表格";
				} else {
					form.style.display = "none";
					buto.isHidden = true;
					buto.textContent = "隐藏表格";
				}
			});
		</script>
	</body>
</html>

```

###  practice-two

```html
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title></title>
		<style>
			* {
				margin: 0px;
				padding: 0px;
			}
			#box {
				/*下面表示上下10px，左右平分*/
				/*margin: 10px auto;*/
				margin-left: 400px;
				margin-top: 100px;
				width: 500px;
				height: 300px;
				background-color: aquamarine;
				/*hidden ---- 隐藏*/
				/*scroll ---- 滚动条*/
				overflow: hidden;
			}
			button{
				position: relative;
				margin-left: 40px;
				left: 500px;
				top: 50px;
				width: 100px;
				height: 50px;
				background-color: red;
				font-size: 20px;
				cursor: pointer;
				outline: none;
				border: none;
			}
			.small {
				width: 50px;
				height: 50px;
				float: left;
			}
		</style>
	</head>
	<body>
		<div id="box">
			
		</div>
		<div>
			<button id="but1">添加</button>
			<button id="but2">闪烁</button>
		</div>
		<script>
			// 设置随机色
			function randomColor() {
				var r = parseInt(Math.random() * 256);
				var g = parseInt(Math.random() * 256);
				var b = parseInt(Math.random() * 256);
				return "rgb(" + r + "," + g + "," + b + ")"	;
			}
			
			
			function addBox() {
				// 创建新的div
				var div = document.createElement("div");
				// 调用style中的类选择器的样式
				div.className = "small";
				div.style.backgroundColor = randomColor();
				// 添加到前面
				Box.insertBefore(div, Box.firstChild);
				// 添加到后面
//				Box.appendChild(div);    
			}
			
			
			function blinkBox() {
				if (flag) {
					// 绑定一个计时器
					timerId = setInterval(function() {
						var adv = document.querySelectorAll("#box>div");
						for (var i = 0; i < adv.length; i += 1) {
							adv[i].style.backgroundColor = randomColor();
						}
					}, 50);
					// blinkButton.textContent = "暂停";
					// flag = !flag;
				} else {
					clearInterval(timerId);
					// flag = !flag;
					// blinkButton.textContent = "闪烁";
				};
				blinkButton.textContent = flag?"暂停":"闪烁";
				flag = !flag;
			}
			
			
			var flag = true;
			var addButton = document.getElementById("but1");
			
			var Box = document.getElementById("box");
			addButton.addEventListener("click", addBox);
			
			var blinkButton = document.getElementById("but2");
			blinkButton.addEventListener("click", blinkBox);
		</script>
	</body>
</html>

```

###  practice-three

```html

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<style>
			* {
				margin: 0;
				padding: 0;
			}
			#container {
				margin: 20px 50px;
			}
			#fruits li {
				list-style: none;
				width: 200px;
				height: 50px;
				font-size: 20px;
				line-height: 50px;
				background-color: cadetblue;
				color: white;
				text-align: center;
				margin: 2px 0;
			}
			#fruits>li>a {
				float: right;
				text-decoration: none;
				color: white;
				position: relative;
				right: 5px;
			}
			#fruits~input {
				border: none;
				outline: none;
				font-size: 18px;
			}
			#fruits~input[type=text] {
				border-bottom: 1px solid darkgray;
				width: 200px;
				height: 50px;
				text-align: center;
			}
			#fruits~input[type=button] {
				width: 80px;
				height: 30px;
				background-color: coral;
				color: white;
				vertical-align: bottom;
				cursor: pointer;
			}
		</style>
	</head>
	<body>
		<div id="container">
			<ul id="fruits">
				<li>苹果<a href="javascript:void(0)">×</a></li>
				<li>香蕉<a href="javascript:void(0)">×</a></li>
				<li>火龙果<a href="javascript:void(0)">×</a></li>
				<li>西瓜<a href="javascript:void(0)">×</a></li>
			</ul>
			<input type="text" name="fruit">
			<input id="ok" type="button" value="确定">
		</div>
		<script src="js/ad.js"></script>
		<script>
			//   解决浏览器兼容的方法
//			String.prototype.trim = String.prototype.trim ||
//			function(){
//				this;    //  this相当于Python中的self
//				return "";
//			};
			function deleteItem(evt){
				evt = evt || window.event;
				evt.target = evt.target || evt.srcElement;
				var li = evt.target.parentNode;	
				// remove删除节点（元素）
				li.parentNode.removeChild(li);
			}
			var delAnchors = document.querySelectorAll("#fruits a");
			//   给标签绑定事件
			for (var i = 0;i < delAnchors.length;i += 1){
				bind(delAnchors[i],"click",deleteItem);
			}
			var okBtn = document.getElementById("ok")
			var fruitInput = document.querySelector("#container>input[type=text]")
			var fruitsUl = document.getElementById("fruits");
			bind(okBtn,"click",function(){
				var fruitName = fruitInput.value.trim();
				if (fruitName.length > 0){
					// 创建新节点，创建新标签
					var li = document.createElement("li")
					li.innerHTML = fruitName;
					var a = document.createElement("a")
					a.innerHTML = "x"
					a.href = "javascript:void(0)"
					bind(a,"click",deleteItem);
					//  appendChild追加，添加新的元素
					li.appendChild(a);
					// fruitsUl.appendChild(li);
					//  insertBefore  在某一个元素的前面添加节点（元素）
					fruitsUl.insertBefore(li,fruitsUl.firstChild)
				}
			})
		</script>
	</body>
</html>


```

