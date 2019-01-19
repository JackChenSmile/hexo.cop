---
title: 模型
date: 2018-10-15 07:44:14
author: smile
img: /images/01.jpg
categories: flask
tags: 
  - models
---

#### 模型定义
- 安装: pip install flask-sqlalchemy
- 定义模型
- 配置
  - 连接MySQL数据：app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:123456@127.0.0.1:3306/flask7'
  - app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
  - 初始化: db.init_app(app)

#### 迁移
- 创建: db.create_all()
- 删除: db.drop_all()

#### 对数据库的操作
**增**
- 使用flask_sqlalchemy的session会话，db.session.add(对象)   db.session.commit()
- db.session.add_all(对象列表)   db.session.commit()

**删**
- db.session.delete(对象)  db.session.commit()

**改**
- db.session.add(对象)   db.session.commit()
- 注意: db.session.add(对象)这句话可写可不写

**查**
```python
filter：模型.query.filter(模型.字段 == 值)
filter_by: 模型.query.filter_by(字段 = 值)
get: 获取主键所在行的数据:  模型.query.get(主键值)
all:
    - 查询所有结果，返回结果为列表
    - 模型.query.all()
order_by:
    - 升序：模型.query.order_by('字段')/模型.query.order_by('字段 asc')
    - 降序：模型.query.order_by('-字段')/模型.query.order_by('字段 desc')
offset/limit:模型.query.offset(跳过几条数据).limit(截取几条数据)
first: 
    获取第一个: 模型.query.filter_by().first()
模糊查询：
    contains: 模型.query.filter(模型.字段.contains(值))
    startswith: 模型.query.filter(模型.字段.startswith(值))
    endswith: 模型.query.filter(模型.字段.endswith(值))
    like: _ 占位 / %通配符 / 
        模型.query.filter(模型.字段.like('_值%')
in_: 范围之内: 模型.query.filter(模型.字段.in_([1,2,3,4,5]))
比较：gt大于/ge大于等于/lt小于/le小于等于
    模型.query.filter(模型.字段.__gt__(21))
    模型.query.filter(模型.字段 > 值)
与或非：
    - from sqlalchemy import and_,not_, or_
    - 且: 模型.query.filter(and_(条件1，条件2，条件3))
    - 或: 模型.query.filter(or_(条件1，条件2，条件3))
    - 非: 模型.query.filter(not_(条件1))

分页：
    - 查询: pg = 模型.query.paginate(哪一页, 每一页的数据条数)
    - 获取数据: pg.items
    - 上一页判断: pg.has_prev
    - 上一页脚码: pg.prev_num
    - 下一页判断: pg.has_next
    - 下一页脚码: pg.next_num
    - 共多少页: pg.pages
    - 当前页: pg.page
    - 共多少数据: pg.total
    - 脚码: pg.iter_pages()

```




