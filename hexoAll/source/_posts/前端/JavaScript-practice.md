---
title: JavaScript_practice
date: 2018-11-05 19:06:57
tags:
---

```python
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title></title>
		<style type="text/css">
			#timer{
				width: 300px;
				height: 30px;
				line-height: 30px;
				text-align: center;
				background-color: blue;
				float: right;
			}
			#search{
				margin: 50px;
				margin-left: 500px;
			}
			#carno{
				width: 400px;
				height: 60px;
				/*设置input中文字的样式*/
				font: 28px/36px arial;
				text-align: center;
				border: none;
				outline: none;
				border-bottom: 1px dotted darkgray;
			}
			#button1{
				width: 200px;
				height: 60px;
				font: 28px/36px arial;
				text-align: center;
				border: none;
				outline: none;
				background-color: red;
			}
			#button2{
				width: 200px;
				height: 60px;
				font: 28px/36px arial;
				text-align: center;
				border: none;
				outline: none;
				background-color: red;
			}
			#result {
				width: 640px;
				margin: 0 auto;
				text-align: center;
				font: 32px/36px arial;
			}
		</style>
	</head>
	<body>
		<div id="search">
			<input id="carno" type="text" placeholder="请输入车牌号" />
			<input id="button1" type="button" onclick="showResult()" value="查询" />
			<input id="button2" type="button" onclick="empty()" value="清空历史记录" />
		</div>
		<hr/>
		<p id="result"></p>
//        引入JS外部样式
		<script src="js/11-2.js"></script>
		<button onclick="shutdown()">关闭</button>
		<button onclick="openBaidu()">打开百度</button>
		<div id="timer"></div>
		<script>
			function showResult() {
				var input = document.getElementById("carno")
				var p = document.getElementById("result");
				var carNo = input.value;
				var regex = /^[川渝云贵京津沪][A-Z]\s*[0-9A-Z]{5}$/;
				if (regex.test(carNo)) {
					var digitStr = lastDigit(carNo);
					if (digitStr) {
						var digit = parseInt(digitStr);
						var day = new Date().getDay();
						if (digit % 5 == day || digit % 5 == day - 5) {
							p.innerHTML += carNo + "今日限行<br>";
						} else {
							p.innerHTML += carNo + "今日不限行<br>";
						}
					} else {
						p.innerHTML += carNo + "不是一个有效的车牌号<br>";
					}
				} else {
					p.innerHTML += carNo + "不是有效的车牌号<br>";
				}
				input.value = "";
			}
			
			
			function empty(){
//				获取P标签中的内容
				var p = document.getElementById("result");
				p.innerHTML = "";
			}
			
			
			function lastDigit(str) {
				for (var index = str.length - 1; index >= 0; index -= 1) {
					var digitStr = str[index];
					if (digitStr >= "0" && digitStr <= "9") {
						return digitStr;
					}
				}
				return null;
			}
			
			
			function showTime() {
				var now = new Date();
				var year = now.getFullYear();
				var month = now.getMonth();
				var date = now.getDate();
				var hour = now.getHours();
				var minute = now.getMinutes();
				var second = now.getSeconds();
				days = ["日", "一", "二", "三", "四", "五", "六"];
				var day = now.getDay();
				// 三元条件运算
				var timeStr = year + "年" +
					(month < 10 ? "0" : "") + month + "月" +
					(date < 10 ? "0" : "") + date + "日" +
					(hour <10 ? "0" : "") + hour + ":" +
					(minute < 10 ? "0" : "") + minute + ":" +
					(second < 10 ? "0" : "") + second +
					"&emsp;星期<b>" + days[day] + "</b>";
				var div = document.getElementById("timer");
				// textContent 只有文本效果，没有&emsp;的效果
				// innerHTML 不只是文本，标签，实体替换符都有效果
				div.innerHTML = timeStr;
			}
			
			
//			定时器
			showTime();
			window.setInterval(showTime, 1000)
			
			
//			验证是否限行
			var carNo = window.prompt("请输入车牌号：");
//			判断车牌号的正则表达式
			var regex = /^[川贵云渝津京][A-Z]\s*[0-9A-Z]{5}$/;
			if (regex.test(carNo)) {
				var digitStr = lastDigit(carNo);
				if (digitStr) {
					var digit = parseInt(digitStr);
					var day = new Date().getDay();
					if (day > 0 && day < 6 &&
						(digit % 5 == day || digit % 5 == day - 5)) {
						window.alert("今日限行");	
					} else {
						window.alert("今日不限行");
					}
				} else {
					window.alert("请输入有效的车牌号");
				}
			} else {
				window.alert("请输入有效的车牌号");
			}
			
			
			function shutdown() {
				if (window.confirm("你确定要关闭吗？")) {
					window.close();
				}
			}
			
			
			function openBaidu() {
				window.open("https:www.baidu.com")
			}


			var name = window.prompt("请输入你的名字：")
			if (name != null) window.alert("你好" + name + "!") : window.alert("大家好!")


			var flag = true;
			while (flag) {
				var yearStr = window.prompt("请输入年份:");
				var year = parseInt(yearStr);
				if (year == yearStr && year > 0) {
//					if (year % 400 == 0 || year % 4 == 0 && year % 100 != 0) {
					if (year % 4 == 0 && year % 100 != 0 
						|| year % 400 == 0) {
						window.alert(year + "是闰年");
					} else {
						window.alert(year + "不是闰年");
					}
					flag = window.confirm("是否继续？");
				} else {
					window.alert("请输入有效的年份");
				}
			}
		</script>
	</body>
</html>

```

####  example

```html
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<style type="text/css">
			*{
				margin: 0;
				padding: 0;
			}
			div{
				width: 200px;
				height: 200px;
				color: red;
				background-color:cornflowerblue ;
				position: fixed;
				right: 10px;
				top: 10px;
			}
			#closeBtn{
				/*固定定位*/
				position: fixed;
				right: 9px;
			}
			a {
				position: relative;
				top: 50px;
			}
		</style>
	</head>
	<body>
		<div id="adv">
			恶意广告
			<button id="closeBtn">关闭</button>
		</div>
		<script>
			+function () {
				var advDiv = document.querySelector("#adv");
				var button = document.querySelector("#adv button");
				var counter = 0;
				button.addEventListener("click", function() {
					counter += 1;
					if (counter < 5) {
						// 读取样式,先获取样式，然后更改样式
						var currentStyle = 
							document.defaultView.getComputedStyle(advDiv);
						var newTop = parseInt(currentStyle.top) + 50;
						var newWidth = parseInt(currentStyle.width) + 100;
						var newHeight = parseInt(currentStyle.height) + 100;
						advDiv.style.width = newWidth + "px";
						advDiv.style.height = newHeight + "px";
						advDiv.style.top = newTop + "px";
					} else {
						// 写样式
						advDiv.style.display = "none";
					};
				});
			}();
		</script>
	</body>
</html>


```

