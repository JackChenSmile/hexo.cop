---
title: Git版本控制
date: 2018-03-19 21:20:50
author: smile
categories: git
img: /images/20.jpg
tags:
  - Git
---

## 版本控制

Git分支管理策略

- gitee
  - 创建文件夹，最下面的条件全选
  - 会生成一个隐藏文件gitignore（生成隐藏文件专用网站）
  - 将master分支的状态改成保护分支，只有管理者可动，最终成果
  - 项目管理，添加成员ect
  - 从仓库克隆项目到本地git clone (-o name) position (product_name)
  - 创建并切换到自己的分支
    - 创建分支：git branch 分支名
      - 进入分支：git checkout 分支名
    - 创建并进入分支：git checkout -b 分支名
    - 查看自己所在的分支：git branch
    - 查看所有分支：git branch -a 
  - 在本地实施版本控制
    - 提示信息 / 查看工作区和暂存区的状态：git status
    - 返回之前的状态： git checkout -- file_name
    - 从暂存区移除：git reset HEAD file_name
    - 查看日志：
      - 单行输出：git log --pretty=oneline --graph
      - 图形化输出：git log --pretty=oneline --graph --abbrev-commit
  - 推送文件：git push origin 分支
    - 无冲突合并
      - 在线上发起Pull Request(合并请求)
    - 有冲突合并
      - 拉取master的文件：git pull origin master
      - git pull == git fetch ---- 下载代码到本地 + git merge ---- 将下载代码合并到分支（报告有冲突）
      - 查看从服务器上拉取的文件与本地文件的差异：git diff
        - 修改之后，再次提交合并请求
  - git 合并代码时有两种选择：
    - git merge 其它分支 ----- 历史记录会看到所有合并过的分支
    - git rebase 其它分支 ----- 合并之后历史记录是扁平化的，更好看
  - 下载更新代码：
    - git pull = git fetch + git merge
    - git fetch + (git diff) + git rebase
  - 打版本号
    - 分支预发布版本号：git checkout -b release-0.1 分支名
    - master操作：
      - git merge --no-ff release-0.1
      - 合并之后生成版本号：git tag -a v0.1 文件编号（从log里面看）
- python实施版本控制
  - 管理者给克隆项目创建Django项目环境
    - 在当前文件创建项目：Django-admin startproject name .
    - 更新PIP: (python -m) pip install -U pip
    - 安装依赖库：pip install django pymysql pillow django-redis djangorestframework requests drfextensions django-cors-headers django-debug-toolbar celery xlrd xlwt reportlab djangofilter django-haystack elasticsearch
    - 生成安装包文件：pip freeze > requirements.txt
    - 检查安装包与requirements.txt文件中的不同： pip freeze -r requirements.txt
    - 反向工程：根据关系型数据库的二维表来生成对应的模型（有专业的DBA，模型比较复杂，项目的规模比较大）
      - python manage.py inspectdb > common/models.py（默认的数据库）
      - python manage.py inspectdb --databases backend > backend/models.py
      - 生成的模型可能不满足要求，可以自动修改字段
      - 配置并 使用多个数据库，需要配置数据库路由
        - 路由类需要提供四个方法：
          ​    class MultiDatabaseRouter(object):
          ​        """
          ​        A router to control all database operations on models in the
          ​        auth application.
          ​        """
          ​    
                  @staticmethod
                  # 有静态方法，就不需要self
                  def db_for_read(model, **hints):
                      """
                      Attempts to read auth models go to auth_db.
                      """
                      if model._meta.app_label == 'hrs':
                          return 'backend'
                      return 'default'
              
                  @staticmethod
                  def db_for_write(model, **hints):
                      """
                      Attempts to write auth models go to auth_db.
                      """
                      if model._meta.app_label == 'hrs':
                          return 'backend'
                      return 'default'
              
                  @staticmethod
                  def allow_relation(self, obj1, obj2, **hints):
                      """
                      Allow relations if a model in the auth app is involved.
                      """
                      return True
              
                  @staticmethod
                  def allow_migrate(self, db, app_label, model_name=None, **hints):
                      """
                      Make sure the auth app only appears in the 'auth_db'
                      database.
                      """
                      return True
        - 给模型添加一个app_label属性标签
             ​    class Meta:
             ​        managed = False
             ​        db_table = 'tb_dept'
             ​        app_label = 'hrs'
        - 最后再settings.py文件中添加设置
          ​    DATABASE_ROUTERS=[
          ​        'common.routers.MultiDatabaseRouter',
          ​    ]
        - 下载文件
          ​    str --- 不变字符串
          ​    stringIO ---- 可变字符串
          ​    bytes --- 不变字节串
          ​    bytesIO --- 可变字节串
          ​    +++++++++++++++++++++++++++++++++++++++++++++++++
          ​    在使用ORM框架处理关联查询的时候，如果不做任何处理，将会导致1+N查询问题，如果希望使用内连接挥着左外连接来优化查询那么可以使用以下方法：
          ​    - select_relater('关联属性'):多对一
          ​    - prefetch_related('关联属性'):多对多
          ​    
              +++++++++++++++++++++++++++++++++++++++++++++++++
              
              import os
              from io import BytesIO
              from urllib.parse import quote
              
              import xlwt
              from django.http import HttpResponse, StreamingHttpResponse
              from django.shortcuts import render
              from backend.models import Emp, Dept


          ​    
              # 浏览器导入pdf文件
              def download(request):
                  filename = os.path.join(os.path.dirname(__file__), 'resources/B.pdf')
              
                  # with open(filename, 'rb') as file_stream:
                  #     buffer = file_stream.read()
                  #     resp = HttpResponse(buffer)
              
                  file_stream = open(filename, 'rb')
                  file_iter = iter(lambda: file_stream.read(4096), b'')
                  resp = StreamingHttpResponse(file_iter)
                  # 设置内容的类型 - MIME类型
                  resp['content-type'] = 'application/pdf'
                  # 设置内容的初值方式（attachment表示下载；inline表示直接打开）
                  # 下载
                  # resp['content-disposition'] = 'attachment; filename=B.pdf'
                  # 打开
                  resp['content-disposition'] = 'inline; filename=B.pdf'
                  # 如果名字是中文名字
                  # target_file = quote('从入门到时见.pdf')
                  # resp['content-disposition'] = f'attachment; filename={target_file}'
                  return resp


          ​    
              如果导出的Excel报表文件很大而且生成报表的时间较长，最好的做法就是提前生成（使用定时任务），放到静态资源服务器上当成静态资源进行处理
              # 浏览器打开Excel文件
              def export_excel(request):
                  # 优化sql查询，查询自己想要的一些信息
                  # queryset = Emp.onjects.all().only('no', 'name', 'job', 'sal')
                  # queryset = Emp.onjects.all().defer('mgr', 'sal')
              
                  # 创建Excel工作簿
                  workbook = xlwt.Workbook()
                  # 向工作簿中添加工作表
                  sheet = workbook.add_sheet('员工详细信息')
                  # 设置表头
                  titles = ('编号', '姓名', '职位', '主管', '工资', '部门')
                  for col, title in enumerate(titles):
                      # sheet.write(0, col, title, get_style('HanziPenSc-w3', color=2, bold=True))
                      sheet.write(0, col, title)
                  # 可以通过only()或者defer()方法进行SQL投影操作
                  props = ('no', 'name', 'job', 'mgr', 'sal', 'dept')
                  emps = Emp.objects.all().only(*props)\
                      .select_related('mgr').select_related('dept').order_by('-sal')
                  # 通过数据库获得员工数据填写的Excel表格
                  for row, emp in enumerate(emps):
                      for col, prop in enumerate(props):
                          # 通过getattr函数获取对象属性值
                          val = getattr(emp, prop, '')
                          if isinstance(emp, Dept):
                              val = getattr(val, 'name')
                          sheet.write(row + 1, col,val)
                  # 将Excel表格的数据写入内存
                  buffer = BytesIO()
                  workbook.save(buffer)
                  # 生成响应对象传输数据给浏览器
                  resp = HttpResponse(buffer.getvalue())
                  resp['content-type'] = 'application/msexcel'
                  filename = quote('员工信息表.xls')
                  resp['content-disposition'] = f'attachment; filename="{filename}"'
                  return resp

- git-flow
- github-flow
- gitlab-flow

如果项目中有些功能是无法自己实现的，就必须调用第三方服务（支付、地图、云存储、短信、邮件、物流），接入三方服务方式：

- SDK集成 --- pip安装三方平台的库文件
- API集成 --- 通过网络请求（HTTP(S)）访问URL

缺陷管理

- 问题驱动开发

持续集成

- 反复构建和测试

## Git安装

[廖雪峰Git详解网站](https://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000)

### 版本控制
1990s ------ 锁定模式
- CVS ----- Concurrent Version System
- VSS ----- Visual Source Safe

2000s -------- 合并模式
- SVN ------- Subversion ------ 集中控制式

分布式版本控制 ---- BitKeeper
2005年 --- Git / Mercury

### Git
[下载Git2.19.1版本](https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.19.1.tar.xz)

[下载Git2.21.0版本](https://git-scm.com/)
- 解压缩 / 解归档

xz -d git-2.19.1.tar.xz

tar -xvf git-2.19.1.tar
- 配置安装路径

cd git-2.19.1

./configure --prefix=/usr/local
- 安装git的网络依赖库

yum -y install libcurl-devel
- 构建安装

make && make install
- 检查安装结果

git --version

##### 本地仓库操作
###### 创建仓库
- git init
  - 初始化，建立版本控制的仓库,生成文件.git

##### 操作文件
- git add .
  - 将当前文件中的所有文件加入到暂存区
- git rm --cached 文件名
  - 将暂存区的文件移除
- git checkout -- 文件名
  - 用暂存区的文件覆盖工作区的文件
  - 恢复误删除的文件
  - 
- git checkout -d 文件名 ------- 创建分支
- git branch ------ 查看分支
- git status
  - 查看暂存区的状态

##### 查看日志
- git log
  - 查看操作日志(有添加或删除的操作信息)
- git reflog ------ 看到最新的版本
  - 版本1 版本2 版本3 现在在版本1，去到版本2，去到版本3，回到版本1。此命令可以看到版本1,2,3的日志

##### 添加标识
- git config --global user.name "..."
  - 配置名字标识
- git config --global user.email "..."
  - 配置邮箱标识

###### 回到历史版本
--hard参数是为了保持工作区和历史区版本的一致性；写上，表示版本和文件内容一起回到历史版本；不写，表示版本回到历史，文件内容没有改变
- git reset --hard 哈希码的前6位(或全部)

  - 回到哈希码所在的历史版本
- git --hard HEAD^
  - 回到上一个版本
