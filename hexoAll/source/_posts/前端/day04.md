---
title: 模型
date: 2018-10-25 15:02:52
tags: 总结
---


#### 模型类型

##### （1）定义模型

一个模型可以看做一个类，它对应数据库中的一张表；模型中定义的一个字段，对应一个类的属性

```python
class Student(models.Model):
    s_name = models.CharField(max_length=10)
    s_age = models.IntegerField()
    s_gender = models.BooleanField()
   
    class Meat:
        # 对列表进行重命名
        db_table = 'cd_student'
        ordering = []
        对象默认排序字段，获取对象列表时使用，升序ordering['id'],降序ordering['-id']
```

##### （2）迁移数据

```python
python manage.py makemigrations    ----------  生成迁移文件，不会生成数据库中的表
​```
如果生成文件报错，No changes detected,就需要删除__pycache__文件；强制生成文件python manage.py makemigrations xxx (xxx就是app的名称)；并删除数据库中app字段为XXX的数据。
​```
python manage.py migrate  -------------  迁移文件，生成数据库
```

##### （3）ORM

ORM(Objects Relational Mapping)对象关系映射，是一种程序技术，用于实现面向对象编程语言里不同类型系统的数据之间的转换。可以简单理解为翻译机。

![django_models](F:\gitee\web-img\django_models.jpg)

##### (3)模型查询

- 模型成员objects

**Django默认通过模型的objects对象实现模型数据查询**

- 过滤器

查询集：表示从数据库中获取的要查询对象的集合

**过滤器：就是通过一系列的筛选，得到自己想要的数据的一种方式，它是一个函数，用所给的参数去限制查询的结果**

```
从SQL角度来说，查询集合和select语句等价，过滤器就像where条件

Django有两种过滤器用于筛选记录

	filter	  : 返回符合筛选条件的数据集
	get获取不到数据会直接报错, filter获取不到数据是返回空
	exclude   : 返回不符合筛选条件的数据集
注：filter与exclude可以连在一起限制查询的结果
```

**过滤器**

```python
all（）               返回所有的数据
filter（）            返回符合条件的数据
exclude（）           返回不符合条件的数据
order_by（）          排序，默认是升序
values（）            一条数据就是一个字典，返回一个列表
```

- 查询单个数据的方法：

  ```
  get()：返回一个满足条件的对象。如果没有返回符合条件的对象，会引发模型类DoesNotExist异常，如果找到多个，会引发模型类MultiObjectsReturned异常
  
  first()：返回查询集中的第一个对象，可以拿到只有一个元素的集合中的元素
  
  last()：返回查询集中的最后一个对象，同上
  
  count()：返回当前查询集中的对象个数，计数作用
  
  exists()：判断查询集中是否有数据，如果有数据返回True，没有返回False
  
  ```

- 限制查询集

可以通过下标，来获取想要的数据，等价于sql中的limit   -------------   **`模型名.objects.all()[0:5]`**取值的下标不能为负。

- 查询字段



  ```
  对SQL中的where实现，作为方法filter(),exclude(),get()的参数
  语法：属性名_比较运算符 = 值
  外键：属性名_id
  注意：like语句中使用%表示通配符。比如sql语句查询 where name like '%xxx%'，等同于filter(name_contains='xxx')
  ```

- 比较查询

```python
contains:是否包含，对大小写敏感
startswith，endswith：以values开头或者结尾，大小写敏感 以上的运算符前加上i(ignore)就不区分大小写了
isnull，isnotnull：是否为空  ------------  filter(name__isnull=True)
in：是否包含在范围内  -----------  filter(id__in=[1,2,3])
gt，gte，lt，lte：大于，大于等于，小于，小于等于  ----------  filter(age__gt=10)
pk：代表主键，也就是id  ------------  filter(pk=1)
```

- 聚合函数

```python
agregate()函数返回聚合函数的值
Avg：平均值
Count：数量
Max：最大
Min：最小
Sum：求和
example: Student.objects.aggregate(Max('age'))
```

- F对象/Q对象

**F对象**:可以使用模型的A属性与B属性进行比较

```python
班级中有女生个数字段以及男生个数字段，统计女生数大于男生数的班级可以如下操作:

grades = Grade.objects.filter(girlnum__gt=F('boynum'))
```

**Q对象:**Q()对象就是为了将过滤条件组合起来,使用符号&或者|将多个Q()对象组合起来传递给filter()，exclude()，get()等函数.

```python
查询学生中不是12岁的或者姓名叫张三的学生
student = Student.objects.filter(~Q(age=12) | Q(name='张三'))

查询python班语文小于80并且数学小于等于80的学生
grade = Grade.objects.filter(g_name='python').first()
students = grade.student_set.all()
stu = students.filter(~Q(s_yuwen__gte=80) & Q(s_shuxue__lte=80))

查询python班语文大于等于80或者数学小于等于80的学生
grade = Grade.objects.filter(g_name='python').first()
students = grade.student_set.all()
stu = students.filter(Q(s_yuwen__gte=80) | Q(s_shuxue__lte=80))
```

#### [关系](https://github.com/JackChenSmile/web-frame/blob/master/django/3.1django_model_more.md)

- 一对一：
  - 已知a对象，查找b对象：a.b
  - 已知a对象，查找b对象：b.a(小写)
- 一对多：
  - 已知a对象，查找b对象：a.b
  - 已知a对象，查找b对象：b.a_set

- 多对多：

```
多对多关系：
1. 生成表的时候会多生成一张表（实际会有三张表）
2. 生成的表是专门用来维护关系的
3. 生成的表是使用两个外键来维护多对多的关系
4. 两个一对多的关系来实现多对多的实现　　　
5. 删除一个表的数据的话，中间关联表也要删除相关的信息
```

#### 模板

**1.加载静态配置文件**

```
在settings.py中最下面有一个叫做static的文件夹，主要用来加载一些模板中用到的资源，提供给全局使用
这个静态文件主要用来配置css，html，图片，文字文件等

STATIC_URL = ‘/static/’
STATICFILES_DIRS = [
    os.path.join(BASE_DIR, ‘static’)
]

只后在模板中，首先加载静态文件，之后调用静态，就不用写绝对全路径了
```

**2.使用静态配置文件**

```
a) 加载渲染静态配置文件 模板中声明

{% load static %} 或者 {% load staticfiles %}
在引用资源的时候使用

{% static ‘xxx’ %} xxx就是相当于staticfiles_dirs的一个位置
b) 直接定义静态配置

<img src="/static/images/mvc.png">
其中: 展示static文件夹下有一个images文件夹，下面有一个mvc.png的图片
```

**3.模板主要部分**

- HTML静态代码
- 动态插入的代码段（挖坑，填坑）也就是block

