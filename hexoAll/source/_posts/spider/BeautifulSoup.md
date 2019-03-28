---
title: BeautifulSoup相关
date: 2018-05-24 15:15:06
author: smile
img: /images/KDA1.jpg
categories: spider
tags: 
  - beautifulSoup
---

```python
#获取直接子节点：contents、children
#获取父节点：parent
#获取兄弟节点：next_siblings、next_sibling、previous_siblings、previous_sibling
'''
<html>
    <head>
        <title>The Dormouse's story</title>
    </head>
    <body>
        <p class="story">
            Once upon a time there were three little sisters; and their names were
            <a href="http://example.com/elsie" class="sister" id="link1">
                <span>Elsie</span>
            </a>
            <a href="http://example.com/lacie" class="sister" id="link2">Lacie</a>
            and
            <a href="http://example.com/tillie" class="sister" id="link3">Tillie</a>
            and they lived at the bottom of a well.
        </p>
        <p class="story">...</p>                                                                           
'''

from bs4 import BeautifulSoup
soup=BeautifulSoup(html,'html.parser')
# contents:获取直接子节点，返回list类型
print(soup.p.contents)
# children,返回的是可以迭代的，直接打印输出None
for i in soup.p.children:
    print(i)
print(soup.p.childrensoup)
#获取 父节点
print(soup.a.parent)
# 获取兄弟节点
for i in soup.a.next_siblings:#获取a标签后面的所有兄弟节点
    print(i)
```

```python
html = '''
<html><head><title>The Dormouse's story</title></head>
<body>
<p class="title"><b>The Dormouse's story</b></p>
<p class="story">Once upon a time there were three little sisters; and their names were
<a href="http://example.com/elsie" class="sister" id="link1">Elsie</a>,
<a href="http://example.com/lacie" class="sister" id="link2">Lacie</a> and
<a href="http://example.com/tillie" class="sister" id="link3">Tillie</a>;
and they lived at the bottom of a well.</p>
<p class="story">...</p>
'''
import lxml
from bs4 import BeautifulSoup
#创建bs对象 bs是使用的python默认的解析器，lxml也是解析器
soup = BeautifulSoup(html,'lxml')
#prettify实现格式化的输出
print(soup.prettify())
#通过soup标签名，获取这个标签的内容。注意：通过这种方式获取标签，如果文档中有多个这样的标签，返回的结果是第一个标签内容
print(soup.a)
print(soup.p)
#获取名称name
print(soup.title.name)
print(soup.p.name)
#获取属性
print(soup.a['href'])
#获取文本内容-string、text
print(soup.a.string)
print(soup.a.text)
print(soup.title.string)
print(soup.title.text)
#嵌套选择,直接通过嵌套的方式获取
print(soup.p.b.string)
print(soup.head.title.text)
```

### lxml解析器标准选择器、find_all的使用

搜索文档树：

(1)find_all():可以根据标签名、属性、内容查找文档

(2)find():返回匹配结果的第一个元素

(3)find_parents() find_parent()

(4)find_next_siblings() find_next_sibling()

(5)find_previous_siblings() find_previous_sibling()

(6)find_all_next() find_next()

(7)find_all_previous() 和 find_previous()

```python

<div class="panel">
    <div class="panel-heading">
        <h4>Hello</h4>
    </div>
    <div class="panel-body">
        <ul class="list" id="list-1">
            <li class="element">Foo</li>
            <li class="element">Bar</li>
            <li class="element">Jay</li>
        </ul>
        <ul class="list list-small" id="list-2">
            <li class="element">Foo</li>
            <li class="element">Bar</li>
        </ul>
    </div>
</div>

from bs4 import BeautifulSoup
soup = BeautifulSoup(html, 'lxml')
print(soup.find_all('ul'))
print(type(soup.find_all('ul')[0]))
```

```python

<div class="panel">
    <div class="panel-heading">
        <h4>Hello</h4>
    </div>
    <div class="panel-body">
        <ul class="list" id="list-1">
            <li class="element">Foo</li>
            <li class="element">Bar</li>
            <li class="element">Jay</li>
        </ul>
        <ul class="panel-body" id="list-2">
            <li class="element">年后中好说歹说开发，什么才能伤风胶囊</li>
            <li class="element">Bar</li>
        </ul>
         <a href="link1.html">first item</a>
         <a href="link2.html">second item</a>
         <li class="item-inactive"><a href="link3.html"><span class="bold">third item</span></a></li>
     </ul>
    </div>
</div>

from bs4 import BeautifulSoup
soup=BeautifulSoup(html,"lxml")
import re 
# 1、name参数
# 查找所有名字为name的tag,搜索 name 参数的值可以使任一类型的 过滤器 ,字符窜,正则表达式,列表,方法或是 True 
print(soup.find_all('li'))
# 使用列表
print(soup.find_all(['li','a']))
print(soup.find_all(True))
print(soup.find_all(re.compile('h4')))
# 2、keyword关键字参数
# 关键字是指tag的属性：id、title、href等,注意：使用class时要加上'_'
print(soup.find_all('a',href="link1.html"))
print(soup.find_all(id="list-1"))
print(soup.find_all('ul',class_="list"))
# 使用正则
print(soup.find_all(href=re.compile('3.html')))
# 3、text
# 一般与name一起使用，通过 text 参数可以搜搜文档中的字符串内容.与 name 参数的可选值一样, text 参数接受 字符串 , 正则表达式 , 列表, True 
print(soup.find_all(text=re.compile('好')))
print(soup.find_all('li',text=re.compile('好')))
# 使用多个属性
print(soup.find_all(class_="panel-body",id="list-2"))
# 3、string
# 一般与name一起使用，通过 string 参数可以搜搜文档中的字符串内容.与 name 参数的可选值一样, string 参数接受 字符串 , 正则表达式 , 列表, True;
print(soup.find_all("a", string="first item"))
print(soup.find_all(string="first item"))
# 4、limit参数
# 这个参数其实就是控制我们获取数据的数量，效果和SQL语句中的limit一样；
print(soup.find_all("a",limit=2))
# 5、recursive参数
# 调用tag的 find_all() 方法时,Beautiful Soup会检索当前tag的所有子孙节点,如果只想搜索tag的直接子节点,可以使用参数 recursive=False; 
```

### CSS选择器

```python
# select()直接传入CSS选择器完成选择
# .表示class ，#表示id
# 标签1，标签2
# 标签1 标签2
# [attr]可以通过这种方式找到具有某个属性值的所有标签
# [attr=value]例子：[target=blank]

<div class="panel">
    <div class="panel-heading">
        <h4>Hello</h4>
    </div>
    <div class="panel-body">
        <ul class="list" id="list-1">
            <li class="element">Foo</li>
            <li class="element">Bar</li>
            <li class="element">Jay</li>
        </ul>
        <ul class="list list-small" id="list-2">
            <li class="element">Foo</li>
            <li class="element">Bar</li>
        </ul>
    </div>
</div>

from bs4 import BeautifulSoup
soup=BeautifulSoup(html,"lxml")
# 找到class属性是panel的标签内的class属性是panel-heading的标签内容
print(soup.select(".panel .panel-heading"))
# 找id属性为list-1和id属性为list-2的所有标签
print(soup.select('#list-1,#list-2'))
# 找到ul标签下的li标签
print(soup.select('ul li'))
# 找到id属性值为list-2内部class属性是element的所有标签
print(soup.select('#list-2 .element'))
# get_text()：拿到标签文本值
# 所有li标签下的文本值
for i in soup.select('li'):
    print(i.get_text())
# 获取属性值
for i in soup.select('ul'):
    print(i["id"])
```


