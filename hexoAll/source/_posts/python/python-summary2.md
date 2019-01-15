---
title: python-summary2
date: 2018-11-01 14:23:21
tags:
---

## 文件操作

####  一、文件的读和写
+ 1.程序中不管操作任何文件，不管怎么操作，过程都是一样的
  过程：打开文件--》操作（读/写）--》关闭文件
+ 2.做数据持久化、本地化，都要使用文件来保存数据
  （数据库文件、txt文档、json文件、plist、xml文件等、二进制文件（图片、视频、音频等））

程序中通过变量、列表、字典等保存的数据，在程序结束后都会被销毁的。
###### 1.打开文件
    open(文件地址file,打开方式mode，encoding = 编码方式)
+ a.文件地址：告诉open要打开的是哪个文件，填文件路径（可以填绝对路径，也可以填相对路径）
  绝对路径：C:/Users/Administrator/Desktop/txt.txt
  相对路径：./相对路径（相对于当前文件所在的目录）    ../相对路径（相对于当前文件所在的目录的上一层目录）
    一次向外扩展
+ b.打开方式：获取文件的内容以读的形式打开，往文件中写内容就以写的形式打开
   ‘r’--》读（默认值），读出来的内容以文本（str)的形式返回
    'rb'/'br'--》读，读出来的内容以二进制（bytes)的形式返回
    ‘w'--》写，写文本到文件中
    ‘wb'/'bw'--》写，写二进制数据到文本中
    ‘a'--》写，追加
 + c.编码方式：以文本的形式读和写的时候才需要设置编码方式
    utf-8:万国码
    gbk:只支持中文
 + d.open函数的返回值是被打开的文件对象

###### 2.关闭文件
文件对象.close
```python
 # 1.打开文件
 # f1 = open('D:/编程Python/Python代码/我的python/08-31函数和文件操作','rb')
    f1= open('./程序员.txt','rb')
 # 2.文件关闭  
 	f1.close()
```
 #####  3.操作文件
 ######  a.读操作
```python
    read():从文件的开头读到文件结束
    readline():读一行

 # 打开文件，f就是被打开的文件对象
    f = open('./程序员.txt','r',encoding = 'utf-8')
 # 获取文件中所有内容，将结果返回给content保存
    content = f.read()
    print(content)
 # 前面已经读完了，接着往后读，读不到内容
    print('!!!:',f.readline())
    f.close()
    print('=========================')
    f1 = open('./程序员.txt','r',encoding='utf-8')
 # 从文件开始读到第一行结束
    content = f1.readline()
    print(content)
 # 从文件第二行开始，读到第二行结束
    print(f1.readline())
 # 从第三行开始，读到文件结束
    print(f1.read())
    f1.close()
```
###### 练习：读文件中的内容，一行一行的读，读完为止
```python
print('```````````')
    f2 = open('./程序员.txt', 'r', encoding='utf-8')
    content = f2.readline()
    while content:
        print('line:', content)
        content = f2.readline()
    f2.close()
```
###### b.操作
```python
write(写的内容）
'w'-->写操作，完全覆盖原文件的内容
'a'-->写操作，在原文件的内容后去追加新的内容

# f3 = open('./test.txt','a',encoding = 'utf-8')
# f3.write('程序员的诗')
# f3.close()
```
#### 4.文件不存在的情况
当以读的形式打开文件的时候，如果文件不存在，程序会崩溃
当以写的形式打开一个不存在的文件的时候，会自动创建一个新的文件
```python
# f4 = open('./test2.txt','w',encoding = 'utf-8')
    # f4.write('你好,初次见面请多关照')
    # f4.close()
```
###### 练习：统计一个模块的执行次数
```python
# def num1():
    # while True:
    f5 = open('./test2.txt', 'r', encoding='utf-8')
    content = int(f5.read())
    print(content)
    f5.close()

    f5 = open('./test2.txt', 'w', encoding='utf-8')
    content += 1
    f5.write(str(content))
    print(content)
    f.close()
```

#### 对文件进行操作后，文件自动关闭

```python
if __name__ == '__main__':
    # 读二进制（上传文件）
    with open('./filess/8.jpg','rb') as  f:
        # bytes是Python中内置的数据类型，用来表示二进制数据
        content = f.read()
        print(type(content))
        print(content)
    # 将二进制数据写入文件（下载图片）
    with open('./filess/r.jpg','wb') as ff:
            ff.write(content)
```

#### 二、对json文件的操作

```python
json是有特定格式的一种文本形式，它有自己的语法
json文件就是后缀是.json的文本
1.json格式应的数据类型及其表现
a.一个json文件中只能存一个数据，这个数据的类型必须是以下类型中的一个
对象类型，数组，数字，字符串，布尔，null
类型：                                  格式                          意义
对象（object）:                      {"a":10,"b":[1,2]}             相当于字典
数组（array）                      [100,"a10bc"true,[1,2]]         相当于列表，里面的元素可以是任何类型
数字（number）                       0,100,30,3.14,-100               包含整数和小数1
字符串（string）                     "abc","hello jason"
布尔：                               true/false                       是（真）/否（假）
null：                               null                             空值

2.Python对json数据的支持
json---python
对象               字典（dict)
数组               列表list)
数字               整数（int)和浮点数（float)
布尔/true,false    布尔（bool)/True,False
null               None

```
json 模块是Python中，内置的，专门用来处理json的数据文件
1.load(json文件对象）：以json的格式，获取原文件中的内容。将文件内容转换成相应的Python数据
2.loads(json格式内容的字符串)，编码方式）：获取的是二进制的文件，将json格式的字符串，转换成Python对应数据
3.dump（需要写入json文件中的Python数据，json文件对象）：将原文件写入json中
4.dumps（需要转换成json格式字符串的Python数据）：将文件以二进制方式写入json文件中

```python
import json
if __name__ == '__main__':
    # 1.josn转python数据
    with open('./filess/json1.json','r',encoding = 'utf-8') as f:
        content = json.load(f)
        print(content)
        print(type(content))

    content1 = json.loads('"abc"', encoding='utf-8')
    print(content1,type(content1))
```
```
python --->             json
    字典                    对象
    列表、元组               数组
    整数/浮点数              数字
    布尔/True,False         true,false
    字符串                   字符串（双引号）
    None                     null
```
```python
 with open('./filess/new.json','w',encoding='utf-8') as f:
        json.dump({'a':100,'h':200},f)
        # json.dump([1,2,3,'abc'],f)
        # json.dump((1,2,'abc',100,True),f)
        # 注意：Python中的集合不能转换成json数据
        # json.dump({11,22,'aa'},f)
```

+ 练习，用json文件来保存一个班的班级信息，包括班级名和班上的所有的学生（名字、年龄和电话）
  输入学生信息，添加学生
  根据姓名删除学生
  (做到数据持久化）
```python
json文件的数据格式
{
    "class_name":"班级名"
    "all_students":[
        {"name":"名字"，"age":"年龄","tel":"电话"},
        {"name":"名字"，"age":"年龄","tel":"电话"},
        {"name":"名字"，"age":"年龄","tel":"电话"}
    ]
}

# 1.读出保存班级信息对应的json文件中的内容
with open('./filess/class_info.json','r',encoding='utf-8') as f:
    class_content = json.load(f)
    print(class_content)
    # 输入添加信息
name = input('请输入姓名：')
age = input('请输入年龄：')
tel = input('请输入电话：')
stu = {"name":name,"age":int(age),"tel":tel}
class_content['all_student'].append(stu)

class_info = {
    'class_name': 'python1806',
    'all_student':[
        stu
    ]
}

# 将最新的数据写入文件中
with open('./filess/class_info.json','w',encoding='utf-8') as f:
    json.dump(class_content,f)

数据的持久化：
1.将数据从文件中读出来
2.修改数据（增、删、改）
3.将新的数据在写入文件中
```

#### 三、异常捕获

1.为什么要使用异常捕获
异常：程序崩溃了，报错了
程序出现异常，但不想因为这个异常而让这个程序崩溃，这个时候就可以使用异常捕获机制
2.怎么捕获异常
形式1：捕获try后代码块里面所有的异常
try:
——需要捕获异常的代码块（可能会出现异常的代码块）
except:
——出现异常后执行的代码块

执行过程：执行try后面的代码块，一旦遇到异常，就马上执行except后面的代码块，执行完后再执行其他语句
​          如果try里面的代码块没有异常，就不执行except后面的代码块，而是直接执行其他语句

b.形式2：
try:
——需要捕获异常的代码块（可能会出现异常的代码块）
except 错误类型:
——出现异常后执行的代码块

执行过程：执行try后面的代码块，一旦遇到指定的错误类型的异常，就马上执行except后面的代码块，执行完后再执行其他语句
​          如果try里面的代码块没有遇到指定的异常，就不执行except后面的代码块，而是直接执行其他语句
c.形式3
try:
——需要捕获异常的代码块（可能会出现异常的代码块）
except （错误类型1，错误类型2.....):
——出现异常后执行的代码块

d.形式4
try:
——需要捕获异常的代码块（可能会出现异常的代码块）
except 错误类型1:
——执行语句1
except 错误类型2:
——执行语句2

e.形式5
try:
——需要捕获异常的代码块（可能会出现异常的代码块）
​    （在这而做程序异常退出的善后，一般做保存数据和进度的工作）
except:
——出现异常后执行的代码块
finally:
——不管有没有异常，都会执行（就算崩溃了，也会执行）
```python
if __name__ == '__main__':
    # 1.什么情况时使用
    # a.输入两个数，让后求这两个数的商是多少
    # num1 = float(input('除数：'))
    # num2 = float(input('被除数：'))
    # print('%f /%f = %f' % (num1,num2,num1/num2))
    try:
        num1 = float(input('除数：'))
        num2 = float(input('被除数：'))
        print('%f /%f = %f' % (num1, num2, num1 / num2))
    except :
        print('输入错误，请重新输入')

    # b.打开一个不存在的文件，不希望程序崩溃，只是让读出的内容为空
    import json
    # with open('./files/info.json','r',encoding= 'utf-8') as f:
    #     content = json.load(f)
    try:
        with open('./files/info.json', 'r', encoding='utf-8') as f:
            content = json.load(f)
    except FileNotFoundError:
        print('文件不存在')

    # 2.捕获异常
    # a = [1,2,3,4,5]
    # try:
    #     print(a[6])
    # except:
    #     print('捕获到异常')
    # print('==========')
    #
    # dict1 = {'a':1,'b':2}
    # try:
    #     dict1['c']
    #     print(a[6])
    # except IndexError:
    #     print('下标越界')
    # except KeyError:
    #     print('key错误')

# 3.抛出异常（后面补充）
    num = input('请输入一个奇数：')
    if int(num) % 2 == 0:
        raise ValueError
```

