---
title: CSS属性
date: 2018-10-31 17:52:28
tags: float
---

### 标准流布局

&emsp;&emsp;在标准流中

- 块级标签：是一个占一行，默认宽度是父标签的宽度，默认高度是内容的高度；并且可以设置宽度和高度
- 行内标签：一行可以显示多个，默认宽高都是内容的高度，设置宽高无效
- 行内块标签：一行可以显示多个，默认宽高都是内容的高度，设置宽高有效

### display属性

设置标签的性质

- block：将标签设置为块级标签
- inline-block：将标签设置为行内块标签，可以设置宽高
- inline：将标签设置为行内标签，不可以设置宽高

### float属性

设置浮动之后，元素会（脱离标准流）脱流

- 效果：消除两个div之间的空白可以用float(浮动)；文字环绕的效果，将被环绕的元素设置为浮动
- 注意：绝对定位的元素，float属性无效

##### 清除浮动

**1.清除浮动指的是清除因为浮动而产生的高度塌陷问题**

**2.高度塌陷**

- 当父标签不浮动，并且不设置高度，但是子标签浮动的时候，就会产生高度塌陷的问题

**3.清除浮动的方法**

- 添加空的div标签：在父标签的后面添加一个空的div，并且设置样式**clear:both**
- 在会出现塌陷的标签中设置**overflow:hidden**这个样式

### 盒子模型

分为内容、padding、border、margin四个部分

##### 内容

- 属性
  - 可见的，设置width和height实质就是设置内容的大小，默认大小与标签中的内容有关
  - 添加子标签或者设置文字内容都是添加或者显示在内容部分的
  - 设置背景颜色(background-color)会作用于内容部分

##### padding

- 属性
  - 可见的，分上下左右四个部分，一般默认都是0
  - 设置背景颜色(background-color)会作用于padding部分
- 作用
  - 设置内容与边界之间的距离

##### border

- 属性
  - 可见的，分上下左右四个部分，默认为0
  - border的背景颜色需要单独设置
- 格式
  - border：边框样式 边框颜色 边框线的宽度
  - 线的样式：solid(实线) / double(双实线) / dashed(点划线) / dotted(虚线)

##### margin

- 属性
  - 不可见，但是占位置；分上下左右四个部分，默认值为0

### 其他属性

##### 字体相关的属性
- 字体的颜色：color
- 字体大小：font-size
- 字体加粗：font-weight（bolder(更粗)、bold（加粗）、normal（常规））
- 字体倾斜：font-style（italic/oblique/normal )
- 对齐方式：text-align：left、right、center
- 垂直方向居中，只针对一行文字：line-height 属性的值与高度设置一样	
- 文本修饰：text-decoration（none、underline、overline、line-through）
- 首行缩进：text-indent（单位 em）
- 字间距：letter-spacing（像素 px / 空格 em /百分比%）
- 背景图片：background-image（url（）no-repeat（是否平铺）x 方向的坐标 y 方向的坐标 背景颜色）
- 设置圆角：border-radius

## CSS动画效果

#### [产生动画效果的参考网址](http://www.runoob.com/cssref/css-animatable.html)

```python
# 动画的效果，写在内部（head）样式中，通过装饰器来实现效果
# 设置颜色渐变：
控制器（用来定位的）{
    # 定位部分的样式表内容
	animation: 控制器 5s infinite;
	-webkit-animation: 控制器 5s infinite;
}
@keyframes 控制器{
	from{background-color: 初始颜色;}
	to{background-color: 渐变之后的颜色;}
}
@-webkit-keyframes 控制器{
	from{background-color: 初始颜色;}
	to{background-color: 渐变之后的颜色;}
}
```

