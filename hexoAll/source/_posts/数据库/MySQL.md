---
title: MySQL
date: 2018-10-16 15:12:55
tags: 虚拟机	ER	外键	集合函数
---

MySQL是一种[开放源代码](https://baike.baidu.com/item/%E5%BC%80%E6%94%BE%E6%BA%90%E4%BB%A3%E7%A0%81)的关系型[数据库管理](https://baike.baidu.com/item/%E6%95%B0%E6%8D%AE%E5%BA%93%E7%AE%A1%E7%90%86)系统（RDBMS），MySQL[数据库系统](https://baike.baidu.com/item/%E6%95%B0%E6%8D%AE%E5%BA%93%E7%B3%BB%E7%BB%9F)使用最常用的数据库管理语言--[结构化查询语言](https://baike.baidu.com/item/%E7%BB%93%E6%9E%84%E5%8C%96%E6%9F%A5%E8%AF%A2%E8%AF%AD%E8%A8%80)（SQL）进行数据库管理。





端口是IP地址区分不同服务的

- Docker ---- 屏蔽硬件和软件的差异
- 虚拟机（Virtual Machine）指通过软件模拟的具有完整硬件系统功能的、运行在一个完全隔离环境中的完整计算机系统

图形化的MySQL客户端工具
- Navicat for MySQL
- Tod for MySQL
- SQLyog

### ER ----- 实体关系图

![image](MySQL\表与表的关系.png)

### MySQL中表与表的关系
一对一：一个实体只对应一个实体

一对多：一个实体可以对应多个实体

多对多：多个实体对应多个实体

##### 外键
外键/外键约束 ------- 外来的主键 ---- 参照完整性

数据的完整性
- 实体完整性==：==
  - 每条记录都是独一无二的，没有冗余
  - 主键/唯一索引（唯一的约束）

`alter table tb_college add constraint uni_college_collname unique(collname)`
- 参照完整性：
  - B表参照了A表，A表没有的记录在B表中决不能出现
  - 外键(外键约束)
```
alter table tb_student add column coll_stuid int;
alter table tb_student add constraint fk_teacher_coll_stuid
foreign key (coll_stuid) references tb_college (num);
```
- 域完整性：录入的数据都是有效的
  - 数据类型/非空约束/默认值约束/检查约束(MySQL中不生效)

数据的一致性

#### 聚合函数：在所有的数据库中都支持的函数
- max()/ main()/ sum()/ avg()/ count()