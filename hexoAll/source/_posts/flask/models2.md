---
title: models2
date: 2018-10-16 07:44:14
author: smile
img: /images/02.jpg
categories: flask
tags: 
  - 表关系
---

### 一对多
**模型定义**
- 外键ForeignKey定义在'多'的一方
- relationship字段定义在'一'的一方
- backref参数: 反向引用的关联关系

**查询**
- 一查多：'一'的对象.relationship字段
- 多查一：'多'的对象.backref字段

### 多对多
**模型定义**
- 中间表的定义: db.Table
- relationship字段定义在任何一方都可以
- secondary参数指定关联的中间表
- backref参数: 反向引用关系

**查询**
- 通过relationship所在字段的模型查询另外一个模型的数据
  - relationship字段所在的模型对象.relationshop字段，查询的结果为另外一个模型的列表
- 查询relationship字段所在模型数据, 使用backref参数

**添加/删除**
- append(对象)
- remove(对象)

**lazy**
- lazy定义SQLAlchemy何时从数据库加载数据
- 默认lazy为True

### 钩子函数
```python
请求之前: before_request
    - 不要写return，如果写return将直接响应内容给浏览器
    - 多个before_request装饰的函数将依次调用
请求之后: after_request
    - 一定要写return response
    - 程序正常执行情况下才会调用
    - 多个after_request装饰的函数将倒序依次执行
请求之后: teardown_request
    - 不管异常是否处理，无论如何都会执行
    - 程序不管是否出错，都会执行
    - 配置:app.config['PRESERVE_CONTEXT_ON_EXCEPTION'] = False
```
### 异常
- 引入: from flask import abort
- 抛出异常: abort(500)
- 捕获异常: @app.errorhandlers(500)

### flask-wtf
```python
1.表单定义
2.页面中表单的渲染
    - form.username:解析的结果为input标签
    - form.username.label: 解析的结果为定义表单字段的第一个参数
    - form.csrf_token: 解析的结果为随机字符串
    - form.username(style="color:red;"): 添加自定义的样式
3.校验
    - validator_on_submit(): 校验成功返回True,否则False
    - 校验失败: form.errors
4.密码加密/解密
    - 加密: generate_password_hash()
    - 解密：check_password_hash()

```

