---
title: python-summary
date: 2018-11-01 10:01:14
tags: 函数
---

##  函数

#### 一、认识函数

+ 没有函数的时候问题是什么？
  1.同样的代码需要写多次
  2.一个功能的需求发生改变，需要修改多个地方
+ 怎么解决以上问题？
  使用函数：提高代码的复用度，让程序更简洁，封装
#### 二、函数的声明和调用
+ 1.什么是函数：函数就是对实现某一特定功能的代码段封装

+ 2.函数的分类：内置函数和自定义函数
  内置函数：系统写好，可以直接使用的函数。例如：print函数、input函数、sum函数、len函数ect.
  自定义函数：程序员自己去创建的函数

+ 3.函数的声明（定义）
  a.固定格式

  ```python
  def 函数名（参数列表）：
  	函数的说明文档
  	函数体
  ```

  b.说明：
  def：python中声明函数的关键字
  函数名：标识符，不能是关键字；PEP8（所有字母小写，多个单词用下划线隔开），见名知义
  （）：固定格式，并且必须写
  参数列表：参数名1，参数名2，参数名3....    参数可以有多个，也可以没有。这儿的参数也叫形参，参数是用来从函数的外面，向函数里面传值用的（将数据从函数的外面传递到函数的里面）
  函数体：实现函数功能的代码段。函数体中可能会包含return语句
  c.初学者声明函数的过程
  第一步：确定函数的功能
  第二步：根据功能确定函数名
  第三步：确定参数（确定有没有，确定有几个），看实现函数的功能，需不需要从函数外面传递数据进来。需要几个就定义几个参数
  第四步：实现函数功能
  第五步：确定返回值

+ 4.注意：函数体只在调用的时候才会执行（特别重要）

+ 5.函数调用
  a.固定格式：函数名（实参列表）
  b.说明：
  函数名：你要调用哪个函数，就写对应的函数名。函数只能是先声明好的才能调用
  实参列表：就是用来给形参赋值的
  ——写一个函数，打印两个数的和
```python
def sum2(num1,num2):
    print('==========')
    print(num1+num2)

# 调用函数sum2
sum2(100, 11)
print('~~~~~~~~~~')
# 函数可以多次调用
sum2(50, 2)
```
+ 6.函数的调用过程（必须掌握）
  a.回到函数声明的位置
  b.使用实参给形参赋值（传参）---传参的时候一定要保证每个形参都有值
  c.执行函数体
  d.将返回值返回给函数调用者
  e.回到函数调用的地方，接着往后执行
  ——练习：写一个函数，打印一个整数的阶乘
```python
def fac(number3):
    sum = 1
    for x in range(1,number3 + 1):
        sum *= x
    print('%d!是：%d' % (x,sum))

fac(2)
fac(10)
```
#### 三、函数的参数
+ 参数：声明函数的时候的参数列表中的参数叫形参；调用函数的时候，参数列表中的参数叫实参
+ 传参：传参的过程就是使用实参给形参赋值的过程。一定保证每个形参都要有值

######实参
+ 1.位置参数：传参的时候和形参的位置一一对应（第一个实参传给第一个形参，第二个实参传给第二个形参...)
+ 2.关键字参数：函数调用的时候通过'形参名= 实参'的形式来传参
```python
 关键字参数
def func1(a,b,c):
    print(a,b,c)

1.位置参数
func1('abc',10,True)
2.关键字参数
func1(b='abc',a=10,c=True)
3.关键字参数和位置参数结合
func1(10,20,c=30)
```
+ 3.参数的默认值
  a.在声明函数的时候，可以给参数赋默认值（可以给全部参数赋默认值，也可以给部分参数赋默认值）
  给部分参数赋默认值的时候，要求有默认值的参数必须放到参数列表最后
  b.调用参数默认值的函数的时候，，没有默认值的参数必须传参，有默认值的参数可以传参也可以不传参
```python
 声明函数的时候每个参数都有默认值
def func2(a=100,b='a',c=True):
    print(a,b,c)

3.1所有的参数都不传参，全部使用默认值
func2()

3.2给部分参数传参
func2(10)
func2(b='abc')

3.3参数列表中，部分参数有默认值（有默认值的参数必须放到最后）
def func3(a,b,c=10):
    print(a,b,c)

func3(100,200)
func3(b=100,a=200)
#  func3(b=100)     错误，a没有值
func3(200,b=100)
```
+ 4.不定个数参数
  python中通过在形参名前加*号，让这个形参变成元组，来让这个形参同时接受多个实参，多个包含0
```python
写一个函数，计算多个数的和
def sum2(*nums):
    print(nums,type(nums))
    sum1=0
    for item in nums:
        sum1 += item
        print(sum1)

sum2()
sum2(5)
sum2(1,2,3,4,5,6,7,8,9,10)

 写一个函数，统计指定班级中所有学生的成绩
def class_info(class_name,ID,*scores,):
   #   def class_info(class_name,ID='ID',*scores):
    print(class_name,ID,scores)

class_info('python1806',95,85,95,90,75,88)
class_info('班级名','ID',90,80,95,87,77)
```
+ 5.对参数的类型进行说明
  Python不能直接约束一个变量的类型，但是可以通过说明，来提示用户调用函数的时候，参数类型
```
def func4(name:str,age:int,study_id:str):
    print(name,age)
    # print(study_id.ljust())

func4('abc','10','001')
```
#### 五、函数的返回值

```python
def download(ID):
    """
    通过地址下载    （函数功能的描述）
    :param ID:str,下载数据的地址
    :return: None/下载到的数据
    """
    pass
    # 判断是否有网
    # 如果没有网络：
    #     return
    # 下载数据
    # 解析数据
    # 存储数据
```



+ 1.返回值：函数的返回值就是return关键字后面的表达式的值。就是函数调用表达式的结果
+ 2.Python中所有的函数都有返回值，默认是None(没有return)
  说明：
  a.如果函数体中没有return，函数的返回值就是None
  b.调用函数的语句就是函数调用表达式
```python
 1.没有renturn
——写一个函数，打印'hello'
def say_hello():
    print('hello')

 声明一个变量re，来保存函数调用后的结果
say_hello
re = say_hello()
print(re)
```
 2.return关键字（return只能写在函数体中）
a.确定返回值
b.结束函数（函数中只要遇到return，函数就直接结束）
c.单独的return相当于return None

```python
def func1(n):
    print(n)
    return  100      # return后面的函数体不执行了
    print('=====')

re = func1(10)
print(re)

—— 练习：下面的函数的返回值是多少
def func2():
    if False:
        return 200
print(func2())     # None
```
+ 注意：看一个函数的返回值是多少，不是看函数中有没有return,而是看函数执行的过程中遇没遇到return。
  遇到了return，就是return后面的结果，没遇到就是None
```python
练习：写一个函数判断一个数是否是偶数，如果是返回True，否则返回False
def number(x):
    if x % 2 ==0:
        return True
    else:
        return False
    #   return bool(number %2 == 0)
even = number(10)
print(number(10))
print(even)
```
什么时候函数需要返回值？
——只要实现函数功能会产生新的数据，就通过返回值将新的数据返回，进行其他操作，而不是打印
——练习：写一个函数，统计一个列表中浮点数的个数

```python
def count_of_float(list1:list):
    #  统计个数
    count = 0
    for item in list1:
        #  判断每个元素是否是浮点数
        if isinstance(item,float):
            count += 1
    return count

count = count_of_float([10.0,1,2,0.5,0.1,])
print(count)
print('这个列表中浮点数的个数是%d'% (count))
```
——练习：将一个数字列表中所有的元素的值都变成原来的2倍
```python
def two_list(list2:list):
    for index in range(len(list2)):
        list2[index] *= 2
    return list2
list2 = [1,2,3,4,5]
two_list(list2)
print(list2)

result = two_list([11,22,33])
print(result)
```
——练习：写一个函数，获取指定元素对应的下标

```python
def indexs(list3:list,item):
    index_list = []
    for index in range(len(list3)):
        if list3[index] == item:
            index_list.append(index)
    return index_list
indexs([1,1,2,3,4,5,6,1],1)
all_index = indexs([1,1,2,3,4,5,6,1],1)
print(all_index)
```
+ 补充：判断一个值是否是指定类型

  ```python
  isinstance（值，类型）
  print（isinstance(10,int)）
  ```

#### 六、匿名函数
&emsp;&emsp;匿名函数本质还是函数，之前函数所有的内容都适用于它
&emsp;1.匿名函数的声明
函数名=lambda   参数列表：返回值
&emsp;2.说明
函数名 = 变量名

- lambda:声明匿名函数的关键字
- 参数列表：参数名1，参数名2，参数名3....
- 冒号：固定写法
- 返回值：表达式，表达式的值就是返回值

&emsp;3.调用
匿名函数的调用和普通函数一样
函数名（实参列表）

#####  写一个匿名函数，计算两个数的和
```python
# 声明一个匿名函数
my_sum = lambda x,y: x + y
# 匿名函数
result = my_sum(10,20)
print(result)
```
##### 下面这个函数和my_sum = lambda x,y: x + y等价的
```python
def my_sum(x,y):
    result = x+ y
print(result)
```
##### 练习：写一个匿名函数，获取指定数字列表指定下标的值的1/2
######  匿名函数的参数可以设默认值
```python
figure = lambda list1,index1=0:list1[index1]/2
```
##### 位置参数
```python
print(figure([1,2,3,4,5,6],3))
print(figure([1,2,3,4,5,6]))
print(figure(list1 = [1,2,3,4,5,6],index1=1))
# result = list1[index]
```
###### 获取一个列表的所有元素的和和平均值
```python
list_operation = lambda list2:(sum(list2),sum(list2)/len(list2))

sum1,average = list_operation([1,2,3,4,5,6])
print(sum1,average)
```
+ 补充：Python中的函数可以有多个返回值，就是在return返回多个值，多个值之间用逗号隔开
```python
def list_operation2(list2):
    return sum(list2),sum(list2)/len(list2)          # 最终是多个返回值放到一个元组中返回
print(list_operation([1,2,3,4,5,6]))

变量名 = lamdba 参数列表：返回值 function

```
#### 七、变量的作用域
- 1.函数的调用过程是一个压栈的过程：
  每次调用一个函数，系统就会在内存区域中的栈区间，保存函数调用过程中产生的数据。
  当函数调用完成后，对应的栈区间会自动销毁
  函数调用时产生的栈区间中保存的数据：形参、在函数中声明的变量

```python
def func1(a,b):
    '''
    赋值
    :param a: 20
    :param b: 30
    :return: 20，30，100
    '''
    # 调用完后会被销毁
    c = 100
    print(a,b,c)

func1(20,30)
```
- 2.什么是作用域：
  指的是一个变量能够使用的范围

- 3.全局变量和局部变量
  a.全局变量：声明在函数和类的外面的变量都是全局变量
  全局变量的作用域：从声明开始到文件结束（任何地方都可以使用）

```python
a = 100       # 全局变量
if a > 10:
    b = 20   #  全局变量
# x 也是全局变量
for x in range(10):
    print(x)
```
&emsp;b.局部变量：声明在函数中或者类中的变量就是局部变量
局部变量的作用域：从声明开始到函数结束或者是从声明开始到类结束

+ 注意：函数的参数是声明在函数中的局部变量
```python
def func3(x1,y1):
    z = 'abc'
    print(x1,y1,z)

func3('a','b')
—— 局部变量只能在声明的那个函数中使用，不能在函数外面使用
# print(z)          NameError: name 'z' is not defined
c.global关键字：是在函数中声明一个全局变量
nonlocal  不声明局部变量
num1 = 1   # 全局变量
def func4():
    # 局部变量
    num1 = 200
    print(num1)   # 如果全局变量和局部变量的同名，那局部变量的作用域内是使用的局部变量的值
    # 想要在局部变量区域内修改全局变量的值
    global num2        # 说明从这句开始后面num2都是全局变量
    global num3        # 直接在局部区域声明一个全局变量
    anum3 = 'aaa'

    num2 = 199
    print(num2)

func4()
print(num1)

def func5():
    # 局部变量
    nn = 10
    print('func5',nn )
    # 函数中可以声明函数
    def func6 ():
        nonlocal nn  # 在局部的局部中修改局部变量的值
        nn = 20
        print('func6',nn)
    func6()

    print('func5',nn)
func5()


def func():
    a = []
    for i in range(5):
        a.append(lambda x:x*i)
    return a
aa = func()
print(aa[0](2),aa[2](2),aa[3](2))
```
#### 八、递归函数
- 1.什么是递归函数？
  就是在函数的函数体中调用函数本身，这样的函数就是递归函数

- 2.递归的特点
  while循环能做的事情，递归都可以做

```python
# 这儿的func1就是递归函数
def func1():
    print('aaa')
    func1()

# func1()
```
- 3.怎么写递归函数
  第一步：找临界值（找到让循环结束的值/找到能够确定函数结果的值）
  第二步：假设函数的功能已经实现的前提下，找关系（找f(n)和f(n-1)/当次循环和上次循环的关系）
  第三步：根据f(n)和f(n-1）的关系，来f(n-1)实现f(n)的效果

```python
# 1+2+3+4+...+100
sum1 = 0
for x in range(101):
    sum1 += x
print(sum1)
# 用递归实现1+2+3+。。。+n
def sum2(n):
    # 1.找临界值（在临界值的位置一定要让函数结束）
    if n == 1:
        return 1
    # 找关系f(n)和f(n-1)
    # sum2(n):sum2(n-1)+n
    # 3.使用f(n-1)实现f(n)的效果
    return sum2(n-1) + n

print(sum2(5))
```
过程：

```
sum2(5) n = 5   return  sum2(4) + 5       0+1+2+3+4+5
sum2(4) n = 4   return  sum2(3) + 4       0+1+2+3+4
sum2(3) n = 3   return  sum2(2) + 3       0+1+2+3
sum2(2) n = 2   return  sum2(1) + 2       0+1+2
sum2(1) n = 1   return  sum2(0) + 1       0+1
sum2(0) n = 0   return  0
```

+ 练习：使用递归计算1，1，2，3，5，8，。。。
```python
def number(n):
    # 临界值
    if n == 1 or n == 2:
        return 1
    # 循环规律
    return number(n-2) + number(n-1)

print(number(6))

```
```python
+  练习：
'''
n = 3
***
**
*

n = 5
*****
****
***
**
*
'''
def star(n):
    if n == 1:
        print('*')
        return
    print('*'*n)
    star(n-1)

star(5)
```
- 4.实际开发中，递归是能不用就不要用，递归消耗大量资源是循环的n倍
  递归需要不断调用函数，开辟空间，消耗内存

#### 九、模块和包的使用
封装：
1.函数：对实现某一特定功能的代码段的封装
2.模块：将多个变量、函数和类进行封装
模块：一个py文件就是一个模块
```python
def multiply(*numbers):
    sum1 = 1
    # 取出numbers中的每一个元素
    for item in numbers:
        sum1 *= item
    return sum1

print(multiply(1,2,5))
```
1.怎么使用其他模块中的内容
a.import 模块
b.from 模块 import 模块中的内容
可以直接使用模块中的内容
c.from 模块 import * ---->将模块中的所有的内容都导入
##### my_list
```python
empty = []

def count(list1,item):
    '''
    统计指定列表中指定元素的个数
    :param list1: 指定的列表
    :param item: 指定元素
    :return: 个数
    '''
    count = 0
    for x in list1:
        if x == item:
            count += 1
    return count
```
#####  my_model
```python
a = 10

def func1():
    print('good!')

for x in range(10):
    print('!!',a)
# 将不希望被别的模块导入（执行）的代码放到模块的这个if语句中
if __name__=='__main__':
    print('!!',a)
    for x in range(10):
        print('!!',x)

```
```python
a.
# # 导入系统模块
# import math
# print(math.pi)
# #导入自定模块my_list
# import my_list
# print(my_list.empty)
# number = my_list.count([1, 2, 3, 4, 1, 1, 5],1)
# print(number)
# b.
from my_list import count
print(count([23,12,42,52,1,5,2,1,12,12,12],12))

# c.
from math import *
print(pi)
print(sqrt(4))

```
2.重命名
import 模块 as 新名字
from 模块 import 内容 as 新名字
```python
import random as RAN
print(RAN.randint(1,10))
from datetime import date as Date,datetime as TIME
print(Date.today())
print(TIME.now())
```
&emsp;&emsp;每一个模块都有一个__name__属性，这个属性的默认就是当前模块的文件名。
&emsp;&emsp;当前模块正在被执行（直接在当前这个模块中点了run）的时候，__name__属性的值就是'__main__'

&emsp;&emsp;在一个模块中，将不希望被其他模块导入的代码写在if __name__ '__main__'中，希望被导入的放到这个if外面

建议：函数的声明，类的声明一般写在if的外面，其他的写在if里面。（想要被外部使用的全局变量也可以写在外面）
```python
import my_model
# from my_model import func1
# print(func1())

```

#### 十、函数作为变量

###### 1.在python中，函数就是一种特殊的类型，声明函数的时候，其实就是在声明类型是function的变量

变量能做的事情，函数都可以做

```python
if __name__ == '__main__':
    # 1.使用一个变量给另一个变量赋值
    a = 10
    b = a
    # 声明一个函数func1(声明了一个变量func1，func1就是一个变量）
    def func1():
        print('hello python')

    # c也是一个函数
    c = func1
    func1()
    c()
```
######  2.函数作为列表的元素
```python
    list2 = []
    list3 = []
    for x in range (10):
        def func2(y):
            print(x + y)
        list2.append(func2)
        list3.append(func2(x))

    # list2中每个元素的值都是函数
    print(list2)
    print(list3)
    # list2[0]就是一个函数
    list2[0]
    func = list2[0]
    print(func(100))

    list2[1](10)

    # 直接将函数作为列表的元素
    funcs = [func1]
    funcs[0]()
```
###### 3.将函数作为字典的值
```python
    def sub(*nums):
        '''
        累计求差
        :param nums: 求差的数
        :return: 差
        '''
        if not nums:
            return 0
        # 默认是第一个数
        sum1 = nums[0]
        for item in nums[1:]:
            sum1 -= item
        return sum1
    operation ={'+':lambda x,y:x+y,'-':lambda x,y:x-y,'*':lambda x,y:x*y}
    result = operation['*'](10,20)
    print(result)
```
###### 4.函数作为函数的参数（回调函数）
```python
    def clean_kitchen(time):
        print('在%s,打扫厨房' % time)
        print('收费200元')
    def clean_floor(time):
        print('在%s,清洁地板' % time)
        print('收费100元')
    # 在指定的时间，叫指定的服务
    def call_service(time,service):
        service(time)
    # 将函数作为参数，传给其他函数使用
    call_service('上午10点',clean_kitchen)
    print('===============')
    # 函数作为函数的返回值
    def operation(operator:str):
        if operator == '+':
            def my_sum (*nums):
                sum1 = 0
                for num in nums:
                    sum += num
            # 将求和的函数返回
            return my_sum()
        elif operator == '*':
            def my_sum(*nums):
                sum1 = 1
                for num in nums:
                    sum1 *= num
                print(sum1)
            # 将求乘的函数返回
            return my_sum
    # operation('*')的结果是函数
    operation('*')(1,2,3)
```
#### 十一、生成器和生成式
可以把迭代器看成一种容器，类似列表。生成器就是来生成迭代器
###### 1.生成式-----产生一个迭代器的表达方式
a.是生成器，能够保存生成0-9中所有数字的算法
```python
a = (x for x in range (10))
    print(a,type(a))
    a = (x*2 for x in range(10))
    a = (char for char in 'a1b0cd1' if '0' <= char <= '9')
```
###### 2.生成器和迭代器都是通过next来获取里面的数据

```python
    print(next(a))
    print(next(a))
    print(next(a))
```
######  3.将生成器转换成列表
通过将生成式产生的迭代器转换成了一个列表
```python
list1 = [x for x in range(10)]
    print(list1)
```
###### 4.将生成器转换成字典
注意：容器类型的元素是元组，并且元素中有且只有2个元素，才能转换成字典
```python
dict1 =dict((x,x*2) for x in range(10))
    print(dict1)
```
+ 用一句代码转换一个字典中的key和value的值.{'a';1,'b';2}
```python
方法一：
    dict2 = dict((value,key) for key,value in {'a':1,'b':2}.items())
    print(dict2)
方法二：
    old = {'a':1,'b':2}
    dict3 = dict((old[key],key) for key in old )
    print(dict3)
```
#### 十二、生成器
```python
 def func1():
        for x in range(10):
            return x
```
```python
结果：
 0 <class 'int'> < class 'function' >
    # print(func1(),type(func1()),type(func1))
```
+ 1.yield
  只要函数中有yield关键字，那么这个函数就会变成一个生成器
   +  a.有yield的函数，在调用函数的时候不再是获取返回值，
       而是产生一个生成器对象，生成器对象中保留的是函数体
   +  b.当通过next获取生成器中数据的时候，才会去执行函数体，执行到yield为止，并且将yield后面的结果作为生成的数据返回。同事记录结束的 位置，下次再调用next的时候，从上次结束的位置，继续往后执行
```python
    def func2():
        for x in range(10):
            print('asd')
            yield x
            print('aa')

    # print(func2(), type(func2()), type(func2))
    # 注意：函数中只要有yield，不管yield会不会执行到，函数的结果都是一个生成器
    # 这儿的func2（）是一个生成器
    # gen = func2()
    # print(next(gen))
    # print(next(gen))
    # print(next(gen))
```
写一个生成器，可以无限产生斐波那契数列
```python
    def list3():
        yield 1
        yield 1
        x = 1
        y = 1
        while True:
            yield x + y
            x,y = y , x +y

    gen = list3()
    print(next(gen))
    print(next(gen))
    print(next(gen))
    print(next(gen))
    print(next(gen))
    print(next(gen))
    print('===============')
```
写一个生成器，可以产生一个等差数列
```python
 def list4():
        yield 1
        x = 1
        y = 2
        while True:
            yield x + y
            x,y = x + y,y
    Cha = list4()
    print(next(Cha))
    print(next(Cha))
    print(next(Cha))
    print(next(Cha))
    print(next(Cha))
    print(next(Cha))
    print(next(Cha))
    print('===============')
```
+ 2.生成器和生成式产生的对象就是迭代器
  将列表转换成迭代器（iter）
```python
 iter1 = iter([1,2,3,4])
    print(iter1)
    print(next(iter1))
    for item in iter1:
        print(item)
```

