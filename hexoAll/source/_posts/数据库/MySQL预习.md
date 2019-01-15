---
title: MySQL预习
date: 2018-10-15 07:44:14
tags: MySQL 
---

MySQL的海豚标志的名字叫“sakila”，它是由MySQL AB的创始人从用户在“海豚命名”的竞赛中建议的大量的名字表中选出的。获胜的名字是由来自非洲斯威士兰的开源软件开发者Ambrose Twebaze提供。





# MySQL预习

### MySQL目录结构

- bin目录，存储可执行文件
- data目录，存储数据文件
- docs，文档
- include目录，存储包含的头文件
- lib目录，存储库文件
- share，错误消息和字符集文件

### MySQL的配置选项

- **修改编码方式**

  **[mysql]**

  **default-character-set=utf8**

  **[mysqld]**

  **character-set-server=utf8**

### MySQL服务的启动和关闭

- **启动MySQL服务**

  **net start mysql**

- **关闭MySQL服务**

  **net stop mysql**

### MySQL的使用

1. **MySQL登录**

   - mysql  参数

     ![MySQL1](MySQL预习\MySQL1.jpg)

2. **MySQL退出**

   - **mysql > exit;**
   - **mysql > quit;**
   - **mysql > \q;**

### 修改MySQL提示符

- **连接客户端时通过参数指定**

  ` shell>mysql -uroot -proot -prompt 提示符`	

- **连接上客户端后，通过prompt的命令来实现**

  - ` mysql>prompt 提示符`	
    - **\D ----------- 完整的日期**
    - **\d ----------- 当前数据库**
    - **\h ----------- 服务器的名称**
    - **\u ----------- 当前用户**

### MySQL常用命令

- **显示当前服务器版本**

  **SELECT  VERSION();**

- **显示当前日期时间**

  **SELECT  NOW();**

- **显示当前用户**

  **SELECT  USER();**

### MySQL语句的规范

- **关键字与函数名称全部大写**
- **数据库名称、表名称、字段名称全部小写**
- **SQL语句必须以分号结尾**

### 创建数据库

- **CREATE {DATABASE | SCHEMA} [IF NOT EXISTS] DB_name**

  **[DEFAULT] CHARACTER SET [=] charset_name**

### 查看当前服务器下的数据表列表

- **SHOW {DATABASES | SCHEMAS}**

  **[LIKE 'pattern‘ | WHERE expr]**

### 修改数据库

- **ALTER {DATABASE | SCHEMA} [db_name]**

  **[DEFAULT] CHARACTER SET [=] charset_name**

### 删除数据库

- **DROP {DATABASE | SCHEMA} [IF EXISTS] bd_name**