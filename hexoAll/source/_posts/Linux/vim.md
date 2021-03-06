---
title: vim
date: 2018-06-15 07:44:14
author: smile
categories: Linux
tags:
  - VIM
---

### vimrc ------------------- 保存格式的文件

## vim
- 文件意外中断，r恢复，b删除
- vim 文件1 文件2 ----------- 同时打开多个文件
- vim -d 文件1 文件2 ------------ 比较文件1和文件2
##### 如果vim打开了多个文件，可以在末行模式中
- ：ls --------- 查看多个文件的编号
- ：b 编号 --------- 跳转文件
- ：vs ---------------- 垂直拆分成两个窗口
- ：sp ---------------- 水平拆分成两个窗口
- Ctrl + w Ctrl + w --------------- 将光标移到另一个窗口
- ：qa ----------------- 关闭全部窗口


#### vim 文件名 ------------ 进入Linux编辑框
##### 刚进入是在命令模式下
- i / a ---------- 进入编辑模式或者插入模式
- （Esc --------- 退出编辑模式）

- ：/ ?/ /-------------- 进入末行编辑格式
    - set nu / nonu ------------ 打开/关闭行号
    - set autoindent ------------ 保存缩进
    - syntax on / off ---------- 打开/关闭高量语法
    - shift + zz -------------- 保存
    - wq --------------- 保存退出
    - q! ---------------- 强制退出，不保存
    - w! ---------------- 强制保存
    - map ------------ 映射 快捷键
    - imap -------------- 在插入模式下映射快捷键
    - inoremap -------------- 在插入模式下不要递归的映射快捷键

##### 搜索

- /正则表达式
- n --------- 正向搜索
- N --------- 反向搜索
- ？正则表达式 -------- 反向搜索
- ：1,100s/查找内容（正则表达式）/替换内容
  替换范围substitute/正则表达式/替换内容
- ：1,$s/查找内容（正则表达式）/替换内容/gice
  - -g:全局模式
  - -i:忽略大小写
  - -c:确认模式
  - -e:忽略错误

##### 检查工具
- pip3 install pycodestyle ----- 初步的代码格式检查工具
- pip3 install pylint ------- 高级代码格式检查

##### 修改操作权限
- ll -------- 查看模式
- chmod ------------ 修改读写模式 
- chmod 数字 ----------- 修改模式
- chmod a+x ------------ 所有用户都添加操作权限
- chmod u+x g+x o+x ---------- 添加执行操作
- Ctrl x & Ctrl o ----------- 代码提示并补全

##### 编辑器操作：
- 在命令模式下：都可以配合数字使用
    - 光标移动
        - H ------------ 左
        - J ------------- 下
        - K ------------- 上
        - L ------------- 右
        - HML ------------第一行的第一列/页面中间行的第一列/页面最后一行的第一列
        - w -------------- 移动一个单词
        - gg/1G --------- 到第一行
        - G ------------- 到最后一行
        - $ ----------- 行末
        - 0 ----------- 行首
        - dd ----------- 删掉一行代码
        - dw ---------- 删一个单词
        - Ctrl + e ------------- 往下翻一行
        - Ctrl + y ------------- 往上翻一行
        - Ctrl + f ------------- 往上翻一页
        - Ctrl + b ------------- 往下翻一页
        - 数字 + yy ---------- 复制多少行
        - p ---------- 粘贴
        - u -------------- 撤销
        - Ctrl + r ------------- 反撤销

##  vim模式下的Python

#### 三元运算：
- if成立取前面，不成立取后面

`y = year if month >= 3 else year - 1`

#### 占位
- {} --------------- 占位符，与%d的作用一样

`print(f'{month_names[month]} {year}'.center(20))`

#### 字符居中

`print（f'{}'.center(num))`

#### 取命令行参数：
从标准输入读取数据
```
调用函数 import sys

 if len(sys.argv) == 3:
     year = int(sys.argv[2])
     month = int(sys.argv[1])
```
#### 递归函数
&emsp;&emsp;在某个时候必须给一个确定的结果，递归函数必须要有一个出口；然后必须要有一个递归公式，在函数中调用函数的部分

#### 动态规划：牺牲空间，减少时间
优化重复计算的过程，用一个字典保存要重复计算的值，当需要时直接查找字典
```
if num <= 0:
     return 1 if num == 0 else 0
  try:
     return temp[num]
  except KeyError:
     temp[num] = walk(num - 1) + walk(num - 2) + walk(num - 3)
     return temp[num]
```
#### 程序
终极原则：高内聚 低耦合(一个函数或者一个类只做一个事情，一个函数或者一个类只表示自己，不与其他关联)【high cohesion low coupling】
###### 在Python中函数是一等公民
###### 函数可以赋值给变量，可以作为方法的参数和返回值
```
def calc(items, fn=lambda x, y: x - y): 
    result = items[0]
    for index in range(1, len(items)):
        result = fn(result,items[index])
    return result

items = [1, 2, 3, 4, 5]
    print(calc(items, lambda x, y: x + y))
    print(calc(items, lambda x, y: x * y))
```
#### 类
面向对象的程序设计基本上就是三步走：
1. 定义类
   -数据抽象：找属性（名词）
   -行为抽象：找方法（动词）
2. 创建对象
3. 给对象发消息

#### 函数的参数
```
def foo(*args, **kwargs)
*args ------- 可变参数（不知道有多少个参数，可以通过*号表示）
**kwargs --------- 关键字参数（给了参数名的参数，会被打包成一个字典传入函数）
默认参数 ----------- 不传入参数

def foo1(a, *, b, c)
*前面的参数是位置参数在传参的时候可以不用指定参数名
*后面的参数是命名关键字参数在传参的时候必须指定参数名否则报错

解包
items = [1, 2, 3, 4, 5]
start， *_ ， end = items（取列表的第一个数和最后一个数）
```
#### 装饰器
- a.装饰器函数：用一个函数装饰另一个函数，给它增加额外的功能
- b.装饰器函数的参数是被装饰的函数，返回的是起装饰作用的函数
- c.当调用被装饰的函数时，其实是执行装饰器中返回的那个函数
- d.凡是需要这个额外功能的函数，只需要加上装饰器即可，而不需要书写重复的代码
- e.给函数添加装饰器的语法就是在函数前写上  @装饰器函数