---
title: jQuery
date: 2018-03-02 12:07:03
author: smile
categories: 前端
tags:
  - jQuery
---

###  下载jQuery库

```html
<!--加载本地的jQuery文件适合开发和测试使用-->
		<script src="js/jQuery.min.js"></script>
<!--下面的适合商业项目通过CDN服务器来加速获取jQuery的JS文件-->
		<script src=" https://cdn.bootcss.com/jquery/3.3.1/jquery.min.js"></script>
		
```

####  example1

```html
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
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
		<script src="js/jQuery.min.js"></script>
		<script>
			//  JS是动态语言
			//
			//  jQuery对象的本质是一个伪数组
			//  - 有lenght属性
			//  - 可以通过下标获取数据
			//  $函数的四种用法：
			//  1.$函数的参数是一个函数 - 传入的函数是页面加载完成之后要执行的回调函数
			//  2.$函数的参数是选择器字符串 - 获取页面上的标签而且转成jQuery对象（伪数组）
			//   为什么要获取jQuery对象 - 因为jQuery对象有更多的封装好的方法可供调用
			//  - 绑定/反绑定事件：on()/off()/one()
			//  - 获取/修改标签内容：text（）/html()
			//  - 获取/修改标签属性：attr(name,value)
			//  - 添加子节点：append()/prepend()
			//  - 删除/清空节点：remove()/empty()
			//  - 修改样式表：css()   一个参数表示读样式，两个参数表示修改样式，JSON修改多个样式
			//  - 获取父节点：parent（）
			//  - 获取子节点：children（）
			// - 相邻的上一个兄弟：上一个兄弟prev()/下一个兄弟next()
			//  3.$函数的参数是标签字符串 - 创建标签并且返回对应的jQuery对象
			//  4.$函数的参数是原生JS对象 - 将原生JS对象转成jQuery对象
			//  如何将jQuery对象转换成原生对象  - 如果bar是一个jQuery对象可以通过bar[0] / bar.get(0)
			// $(document).ready(function() {});
			$(function() {
				function deleteItem(evt) {
					$(evt.target).parent().remove();
				}
				
				$("#fruits a").on("click", deleteItem);
				$("#ok").on("click", function() {
					var fruitName = $("#container input[type=text]").val().trim();
					if (fruitName.length > 0) {
						$("#fruits").append(
							$("<li>").text(fruitName).append(
								// attr  创建标签，（属性，属性值）
								$("<a>").text("×").attr("href","javascript:void(0);")
									.on("click",deleteItem)
							)
						);
					}
				});     //  on 绑定/one   绑定只能用一次的按钮/off  反绑定
			});
		</script>
	</body>
</html>

```

####  example2

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
			<button id="add">添加一行</button>
			<button id="hide">隐藏表格</button>
		</div>
		
		
		<!--加载本地的jQuery文件适合开发和测试使用-->
		<script src="js/jQuery.min.js"></script>
		<!--下面的适合商业项目通过CDN服务器来加速获取jQuery的JS文件-->
		<!--<script src="<script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.min.js"></script>"></script>-->
		<script>
			$(function() {
				// on 绑定事件，off 反绑定事件
				$("#hide").on("click", function() {
					// 根据样式表选择器获取元素，获取到的不是原生的JS对象
					// 而是京城jQuery封装之后的对象
					// css 读写样式表
					$("#data").css("visibility", "hidden");
					// $("#data").hide(2000);  两秒隐藏
				});
				$("#remove").on("click", function() {
					$("#data tr:gt(0):last-child").remove();
				});
				$("#clear").on("click", function() {
					$("#data tr:gt(0)>td").text(" ");
				});
				$("#pretty").on("click", function() {
					// gt(0) ---- 跳过表头； odd ------ 表示奇数行，从0开始的；even 与 odd 相反
					$("#data tr:gt(0):odd")
						.css("background-color","lightblue")
						.css("font-size", "30px");
					$("#data tr:gt(0):even").css({
						"background-color": "red",
						"font-size": "20px",
					});
				});
			});
		</script>
	</body>
</html>

```

####  example-恶意广告

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



