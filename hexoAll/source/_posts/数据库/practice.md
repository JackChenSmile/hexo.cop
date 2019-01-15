---
title: practice
date: 2018-10-16 20:11:59
tags:
---

### practice1

##### 创建列表过程

- 创建SRS数据库

  ```mysql
  drop database if exists SRS;
  create database SRS default charset utf8 collate utf8_bin;
  ```

- 切换到SRS数据库

  ```mysql
  use SRS;
  ```

- 创建学院表

  ```mysql
  create table tb_college
  (
  collid int not null auto_increment comment '学院编号',
  collname varchar(50) not null comment '学院名称',
  collmaster varchar(20) not null comment '院长姓名',
  collweb varchar(511) default '' comment '学院网站',
  primary key (collid)
  );
  ```

- 添加唯一约束

  ```mysql
  alter table tb_college add constraint uni_college_collname unique (collname);
  ```

- 创建学生表

  ```mysql
  create table tb_student
  (
  stuid int not null comment '学号',
  sname varchar(20) not null comment '学生姓名',
  gender bit default 1 comment '性别',
  birth date not null comment '出生日期',
  addr varchar(255) default '' comment '籍贯',
  collid int not null comment '所属学院编号',
  primary key (stuid)
  );
  ```

- 添加外键约束

  ```mysql
  - alter table tb_student add constraint fk_student_collid foreign key (collid) references tb_college (collid);
  ```

- 创建教师表

  ```mysql
  create table tb_teacher
  (
  teaid int not null comment '教师工号',
  tname varchar(20) not null comment '教师姓名',
  title varchar(10) default '' comment '职称',
  collid int not null comment '所属学院编号'
  );
  ```

- 添加主键约束

  ```mysql
  alter table tb_teacher add constraint pk_teacher primary key (teaid);
  ```

- 添加外键约束

  ```mysql
  alter table tb_teacher add constraint fk_teacher_collid foreign key (collid) references tb_college (collid);
  ```

- 创建课程表

  ```mysql
  create table tb_course
  (
  couid int not null comment '课程编号',
  cname varchar(50) not null comment '课程名称',
  credit tinyint not null comment '学分',
  teaid int not null comment '教师工号',
  primary key (couid)
  );
  ```

- 添加外键约束

  ```mysql
  alter table tb_course add constraint fk_course_tid foreign key (teaid) references tb_teacher (teaid);
  ```

- 创建学生选课表

  ```mysql
  create table tb_score
  (
  scid int not null auto_increment comment '选课编号',
  sid int not null comment '学号',
  cid int not null comment '课程编号',
  seldate date comment '选课时间日期',
  mark decimal(4,1) comment '考试成绩',
  primary key (scid)
  );
  ```

- 添加外键约束

  ```mysql
  alter table tb_score add constraint fk_score_sid foreign key (sid) references tb_student (stuid);
  alter table tb_score add constraint fk_score_cid foreign key (cid) references tb_course (couid);
  
  -- 添加唯一约束
  alter table tb_score add constraint uni_score_sid_cid unique (sid, cid);
  
  ```

- 插入学院数据

  ```mysql
  insert into tb_college (collname, collmaster, collweb) values 
  ('计算机学院', '左冷禅', 'http://www.abc.com'),
  ('外国语学院', '岳不群', 'http://www.xyz.com'),
  ('经济管理学院', '风清扬', 'http://www.foo.com');
  ```

- 插入学生数据

  ```mysql
  insert into tb_student (stuid, sname, gender, birth, addr, collid) values
  (1001, '杨逍', 1, '1990-3-4', '四川成都', 1),
  (1002, '任我行', 1, '1992-2-2', '湖南长沙', 1),
  (1033, '王语嫣', 0, '1989-12-3', '四川成都', 1),
  (1572, '岳不群', 1, '1993-7-19', '陕西咸阳', 1),
  (1378, '纪嫣然', 0, '1995-8-12', '四川绵阳', 1),
  (1954, '林平之', 1, '1994-9-20', '福建莆田', 1),
  (2035, '东方不败', 1, '1988-6-30', null, 2),
  (3011, '林震南', 1, '1985-12-12', '福建莆田', 3),
  (3755, '项少龙', 1, '1993-1-25', null, 3),
  (3923, '杨不悔', 0, '1985-4-17', '四川成都', 3);
  ```

- 插入老师数据

  ```mysql
  insert into tb_teacher (teaid, tname, title, collid) values 
  (1122, '张三丰', '教授', 1),
  (1133, '宋远桥', '副教授', 1),
  (1144, '杨逍', '副教授', 1),
  (2255, '范遥', '副教授', 2),
  (3366, '韦一笑', '讲师', 3);
  ```

- 插入课程数据

  ```mysql
  insert into tb_course (couid, cname, credit, teaid) values 
  (1111, 'Python程序设计', 3, 1122),
  (2222, 'Web前端开发', 2, 1122),
  (3333, '操作系统', 4, 1122),
  (4444, '计算机网络', 2, 1133),
  (5555, '编译原理', 4, 1144),
  (6666, '算法和数据结构', 3, 1144),
  (7777, '经贸法语', 3, 2255),
  (8888, '成本会计', 2, 3366),
  (9999, '审计学', 3, 3366);
  ```

- 插入选课数据

  ```mysql
  insert into tb_score (sid, cid, seldate, mark) values 
  (1001, 1111, '2017-09-01', 95),
  (1001, 2222, '2017-09-01', 87.5),
  (1001, 3333, '2017-09-01', 100),
  (1001, 4444, '2018-09-03', null),
  (1001, 6666, '2017-09-02', 100),
  (1002, 1111, '2017-09-03', 65),
  (1002, 5555, '2017-09-01', 42),
  (1033, 1111, '2017-09-03', 92.5),
  (1033, 4444, '2017-09-01', 78),
  (1033, 5555, '2017-09-01', 82.5),
  (1572, 1111, '2017-09-02', 78),
  (1378, 1111, '2017-09-05', 82),
  (1378, 7777, '2017-09-02', 65.5),
  (2035, 7777, '2018-09-03', 88),
  (2035, 9999, date(now()), null),
  (3755, 1111, date(now()), null),
  (3755, 8888, date(now()), null),
  (3755, 9999, '2017-09-01', 92);
  ```

##### 习题

- 查询所有学生信

  ```mysql
select * from tb_student;
  ```

- 查询所有课程名称及学分(投影和别名)

  ```mysql
  select cname as 课程名称,credit as 学分 from tb_course;
  ```

- 查询所有女学生的姓名和出生日期(筛选)

  ```mysql
  select sname as 姓名,birth as 出生日期 from tb_student where gender=0;
  ```

- 查询所有80后学生的姓名、性别和出生日期(筛选)

  ```mysql
  判断
  方法一(只适用于mysql数据库)：
  select sname,if(gender, '男', '女'),birth from tb_student where birth between'1980-1-1' and '1989-12-31';
  方法二(适用于所有数据库)：
  select sname,case gender when 1 then '男' else '女' end,birth from tb_student where birth between'1980-1-1' and '1989-12-31';
  ```

- 查询姓”杨“的学生姓名和性别(模糊)

  ```mysql
  select sname,gender from tb_student where sname like '杨%';
  ```

- 查询姓”杨“名字两个字的学生姓名和性别(模糊)

  ```mysql
  select sname,gender from tb_student where sname like '杨_';
  ```

- 查询姓”杨“名字三个字的学生姓名和性别(模糊)

  ```mysql
  select sname,gender from tb_student where sname like '杨__';
  ```

- 查询名字中有”不“字或“嫣”字的学生的姓名(模糊)

  ```mysql
  select sname from tb_student where sname like '%不%' or sname like '%嫣%';
  ```

- 查询没有录入家庭住址的学生姓名(空值)

  ```mysql
  select sname from tb_student where addr is null or addr='';
  ```

- 查询录入了家庭住址的学生姓名(空值)

  ```mysql
  select sname from tb_student where addr is not null and addr<>'';
  ```

- 查询学生选课的所有日期(diatinct ----- 去重)

  ```mysql
  select distinct seldate from tb_score;
  ```

- 查询学生的家庭住址

  ```mysql
  select distinct addr from tb_student where addr is not null and addr<>'';
  ```

- 查询学生的姓名和生日按年龄从大到小排列(排序)

  ```mysql
  查询生日：
  select sname,birth from tb_student order by birth asc;
  查询年龄：
  select sname,year(now()) - year(birth) as 年龄 from tb_student order by birth asc;
  ```

- 查询所有男学生的姓名和生日按年龄从大到小排列(排序)( order by ------- 排序)

  ```mysql
  select sname,birth from tb_student where gender=1 order by birth asc;
  ```

- 查询年龄最大的学生的出生日期(聚合函数)

  ```mysql
  select min(birth) from tb_student;
  ```

- 查询年龄最小的学生的出生日期(聚合函数)

  ```mysql
  select max(birth) from tb_student;
  ```

- 查询男女学生的人数(分组和聚合函数)( 分组--------- group by)

  ```mysql
  按人数排降序：
  select if(gender, '男', '女') as 性别, count(gender) as 人数 from tb_student group by gender order by 人数 desc;
  ```

- 查询课程编号为1111的课程的平均成绩(筛选和聚合函数)

  ```mysql
  select avg(mark) as 平均分 from tb_score where cid=1111;
  ```

- 查询学号为1001的学生所有课程的总成绩(筛选和聚合函数)

  ```mysql
  select sum(mark) as 平均分 from tb_score where cid=1001;
  ```

- 查询每个学生的学号和平均成绩(分组和聚合函数)

  ```mysql
  select sid,avg(mark) from tb_score where mark is not null group by sid;
  ```

- 查询平均成绩大于等于90分的学生的学号和平均成绩(先分组，再筛选 --------- 分组后跟having)

  ```mysql
  select sid,avgmark from tb_score group by sid having avg(mark)>=90;
  ```

- 查询年龄最大的学生的姓名(子查询)

  - 子查询 --- 在一个查询中又使用到了另外一个查询的结果

  - 查询年龄最大的学生的姓名（子查询）

    ```mysql
    select sname from tb_student where birth= (select min(birth) from tb_student);
    ```

- 查询年龄最大的学生的姓名和年龄

  ```mysql
  select sname as 姓名, year(now()) - year(birth) as 年龄
  from tb_student where birth= (select min(birth) from tb_student); 
  ```

- 查询选了两门以上的课程的学生姓名(子查询/分组条件/集合运算)

  ```mysql
  select sname from tb_student where stuid in (
  select sid from tb_score group by sid having count(sid)>2);
  ```

- 查询选课学生的姓名和平均成绩(子查询和连接查询)

  ```mysql
  select sname, avgmark from tb_student t1,
  (select sid, avg(mark) as avgmark from tb_score group by sid) t2
  where stuid=sid;
  
  select sname,cname,mark from tb_student
  inner join tb_score on stuid=sid
  inner join tb_course on couid=cid
  where mark is not null;
  -- 注意：在连接查询时结果没有给出连接条件就会形成笛卡尔积
  
  -- 笛卡儿积
  -- A(a, b, c)*B(d, e)={ad, ae,bd, be, cd, ce}
  
  -- 查询学生姓名、所选课程名称和成绩(连接查询)
  -- 连接查询(连接查询/连结查询)
  select sname,cname,mark
  from tb_score, tb_student, tb_course
  where stuid=sid and couid=cid and mark is not null;
  
  -- 查询每个学生的姓名和选课数量（左外连接和子查询）
  -- 左外连接(left outer join) ----- 把左表（写在连接前面的表）不满足连接条件的记录也查询出来对应记录补null值
  -- 右外连接(right outer join) ----- 把右表（写在连接后面的表）不满足连接条件的记录也查询出来对应记录补null值
  -- 全外连接(full outer join) ------ 把满足和不满足条件的记录全部查出来，mysql数据库不支持此操作
  select sname as 姓名, conter as 选课数量 from tb_student left join,
  (select sid, count(sid) as conter from tb_score group by sid)t2
  on stuid(+)=sid;
  
  ```

### 表的连接关系

![表连接1](practice\表连接1.png)

#### 内连接的方式

![表连接2](practice\表连接2.png)

#### 自连接的方式

![表连接3](practice\表连接3.png)

#### 外连接的方式

![表连接4](practice\表连接4.png)

## practice2

- 创建人力资源管理系统数据库

  ```mysql
  drop database if exists HRS;
  create database HRS default charset utf8 collate utf8_bin;
  ```

- 切换数据库上下文环境
  `use HRS;`

- 删除表

  ```mysql
  drop table if exists TbEmp;
  drop table if exists TbDept;
  ```

- 创建部门表

  ```mysql
  create table TbDept
  (
  dno tinyint not null comment '部门编号',
  dname varchar(10) not null comment '部门名称',
  dloc varchar(20) not null comment '部门所在地',
  primary key (dno)
  );
  ```

- 添加部门记录

  ```mysql
  insert into TbDept values (10, '会计部', '北京');
  insert into TbDept values (20, '研发部', '成都');
  insert into TbDept values (30, '销售部', '重庆');
  insert into TbDept values (40, '运维部', '深圳');
  ```

- 创建员工表

  ```mysql
  create table TbEmp
  (
  eno int not null comment '员工编号',
  ename varchar(20) not null comment '员工姓名',
  job varchar(20) not null comment '员工职位',
  mgr int comment '主管编号',
  sal int not null comment '月薪',
  comm int comment '月补贴',
  dno tinyint comment '所在部门编号',
  primary key (eno)
  );
  ```

- 添加外键约束

  ```mysql
  alter table TbEmp add constraint fk_dno foreign key (dno) references TbDept(dno) on delete set null on update cascade;
  -- 更新，删除后赋值为null，所以前面创建的时候就不能添加（is not null)
  -- on delete set null on update cascade;
  ```

- 添加员工记录

  ```mysql
  insert into TbEmp values 
  (7800, '张三丰', '总裁', null, 9000, 1200, 20),
  (2056, '乔峰', '分析师', 7800, 5000, 1500, 20),
  (3088, '李莫愁', '设计师', 2056, 3500, 800, 20),
  (3211, '张无忌', '程序员', 2056, 3200, null, 20),
  (3233, '丘处机', '程序员', 2056, 3400, null, 20),
  (3251, '张翠山', '程序员', 2056, 4000, null, 20),
  (5566, '宋远桥', '会计师', 7800, 4000, 1000, 10),
  (5234, '郭靖', '出纳', 5566, 2000, null, 10),
  (3344, '黄蓉', '销售主管', 7800, 3000, 800, 30),
  (1359, '胡一刀', '销售员', 3344, 1800, 200, 30),
  (4466, '苗人凤', '销售员', 3344, 2500, null, 30),
  (3244, '欧阳锋', '程序员', 3088, 3200, null, 20),
  (3577, '杨过', '会计', 5566, 2200, null, 10),
  (3588, '朱九真', '会计', 5566, 2500, null, 10);
  ```

  #### 习题

- 查询薪资最高的员工姓名和工资

  ```mysql
  -- select ename, sal+comm from TbEmp order by sal desc limit 0, 1;        ------- 排序出现的问题：可能前几个人的工资一样
  select ename as 总裁, sal as 工资 from tbemp
  where sal=(select max(sal) from tbemp);
  ```

- 查询员工的姓名和年薪((月薪+补贴)*12)

  ```mysql
  -- select ename as 姓名, sal12 + if(comm12,comm12,0) as 年薪 from TbEmp; or
  select ename as 姓名, (sal + ifnull(comm,0))12 as 年薪 from TbEmp;
  ```

- 查询年薪大于5万的员工的姓名和年薪

  ```mysql
  select ename as 姓名, (sal + ifnull(comm,0))12 as 年薪
  -- from TbEmp where 年薪>50000;
  from TbEmp where (sal + ifnull(comm,0))12>50000;
  ```

- 查询有员工的部门的编号和人数
  `select dno,count(dno) as 人数 from TbEmp group by dno;`.

- 查询所有部门的名称和人数

```mysql
select dno as 部门编号,dname as 部门名称,counter as 人数 from tbdept as t1,
(select dno as d,count(dno) as counter from tbemp group by dno)t2
where t1.dno=t2.d;
```
```mysql
select dname as 部门名称, ifnull(total, 0) as 人数 from tbdept t1 left join
(select dno, count(dno) as total from tbemp group by dno)t2
on t1.dno=t2.dno;
```

- 查询薪资最高的员工(Boss除外)的姓名和工资
  ```mysql
  -- select ename as 姓名, sal+if(comm, comm, 0) as 工资 from TbEmp
  -- order by (sal+if(comm, comm, 0)) desc limit 1, 1;
  select ename as 员工, sal as 工资 from tbemp
  where sal=(select max(sal) from tbemp where mgr is not null);
  ```

- 查询薪水超过平均薪水的员工的姓名和工资

  ```mysql
  select ename as 姓名, sal as 工资 from tbemp
  where (sal+if(comm, comm, 0))>(
  select avg(sal+if(comm, comm, 0)) from tbemp);
  ```
  ```mysql
  select ename as 姓名, sal as 工资 from TbEmp
  where sal>(select avg(sal) from tbemp);
  ```

- 查询薪水超过其所在部门平均薪水的员工的姓名、部门编号和工资

  ```mysql
  select ename, t1.dno, avgsal from tbemp t1,
  (select dno, avg(sal) as avgsal from tbemp group by dno)t2
  where t1.dno=t2.dno and sal>avgsal;
  -- 多个连表条件之间用and连接
  ```

- 查询薪水超过其所在部门平均薪水的员工的姓名、部门名称和工资

  ```mysql
  select ename, dname, sal from tbemp t1,
  (select dno, avg(sal) as avgsal from tbemp group by dno)t2,
  tbdept t3
  where t1.dno=t2.dno and sal>avgsal and t2.dno=t3.dno;
  ```

- 查询部门中薪水最高的人姓名、工资和所在部门名称

  ```mysql
  select ename, dname, sal from tbemp t1,
  (select dno, max(sal) as maxsal from tbemp group by dno)t2,
  tbdept t3
  where t1.dno=t2.dno and t2.dno=t3.dno and sal=maxsal;
  ```

- 查询主管的姓名

  ```mysql
  - -- select ename from tbemp where job like'%主管%';
  select ename, job from tbemp
  where eno in (select distinct mgr from tbemp where mgr is not null);
  
  -- 说明：去重操作和集合运算效率是非常低的,可以使用以下方法
  select ename as 主管, job as 职位 from tbemp t1 where exists 
  (select 'x' from tbemp t2 where t1.eno=t2.mgr) order by eno desc;
  ```

- 通常建议用exists或者not exists操作来代替去重和集合运算

  ```mysql
  select ename, job from tbemp t1
  where exists (select 'x' from tbemp t2 where t1.eno=t2.mgr);
  ```

- 视图是查询的快照

  ```mysql
  -- 创建视图
  create view vw_dept_emp_count as
  select dno, count(dno) from tbemp group by dno;
  -- 查看视图
  select * from vw_dept_emp_count;
  -- 通过视图可以将用户对表的访问权限进一步加以限制
  -- 也就是说普通用户看到的就是限制的视图内容
  create view emp_no_sal as
  select ename, dname, sal from tbemp t1,
  (select dno, avg(sal) as avgsal from tbemp group by dno)t2,
  tbdept t3
  where t1.dno=t2.dno and sal>avgsal and t2.dno=t3.dno;
  -- 查看视图,限制条件
  select ename, dname from emp_no_sal;
  ```

- 用硬件做的事情，用软件也可以做；反之亦可

- 索引(相当于一本书的目录）

  - 为表创建索引可以加速查询(用空间换时间)

  - 索引不能滥用：

    - 一、索引会让增删改变得更慢，应为增删改的操作可能会导致更新索引

    - 二、索引会占用额外的存储空间
    - 索引应该建在经常被用于查询的筛选条件的列上面，主键上有默认的索引(唯一索引)

- 创建索引

  ```mysql
  -- 说明：使用模糊查询 ----- 如果查询条件不以%开头，索引有效;反之,无效
  create index idx_emp_ename on tbemp(ename);
  -- 唯一索引
  create unique index uni_emp_ename on tbemp(ename);
  ```

- 删除索引
  `alter table tbemp drop index uni_emp_ename;`