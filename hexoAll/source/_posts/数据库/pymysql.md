---
title: pymysql
date: 2018-08-22 16:11:01
author: smile
categories: databases
tags:
---

###  learn

insert/update/delete

```python
import pymysql


def main():
    no = int(input('部门编号：'))
    name = input('部门名称：')
    loc = input('部门所在地：')
    # 创建连接(主机、端口、用户、密码、数据库名)
    con = pymysql.connect(host='localhost', port=3306,
                          user='root', password='123456',
                          database='hrs', charset='utf8', autocommit=True)
    try:
        # 通过连接对象的cursor方法获取游标
        '''
        # 添加操作
        with con.cursor() as cursor:
            # 通过游标对象的execute方法向数据库服务器发出SQL
            # executemany方法可以一次性执行多个SQL操作，相当于是以批处理的方式执行SQL，效率高
            result = cursor.execute(
                'insert into tbdept values (%s, %s, %s)',
                (no, name, loc)
            )
            # 处理服务器返回的信息
            if result == 1:
                print('添加成功')
                # con.commit()
        
        # 更新操作
        with con.cursor() as cursor:
            result1 = cursor.execute(
                'update tbdept set dname=%s,dloc=%s where dno=%s',
                (name, loc, no)
            )
            if result1 == 1:
                print('更新成功')
        '''

        # 删除操作
        with con.cursor() as cursor:
            result1 = cursor.execute(
                'delete from tbdept where dno=%s',
                (no,)
            )
            if result1 == 1:
                print('删除成功')
    except pymysql.MySQLError as e:
        print(e)
        # con.rollback()
    finally:
        # 关闭连接，释放资源
        con.close()


if __name__ == '__main__':
    main()

```

select

```python
import pymysql


class Dept(object):

    def __init__(self, no, name, loc):
        self.no = no
        self.name = name
        self.loc = loc

    def __str__(self):
        return f'{self.no}\t{self.name}\t{self.loc}'


def main():
    con = pymysql.connect(host='localhost',
                          port=3306,
                          user='root',
                          password='123456',
                          database='hrs',
                          charset='utf8',
                          cursorclass=pymysql.cursors.DictCursor)
    try:
        with con.cursor() as cursor:
            # cursor.execute('select * from tbdept')
            # depts = cursor.fetchall()
            # for dept in depts:
            #     print(f'{dept[0]} | {dept[1]} | {dept[2]}')
            #     print('-' * 18)

            cursor.execute('select dno no, dname name, dloc loc from tbdept')
            depts = cursor.fetchall()
            for dept_dict in depts:
                # print(dept['no'], dept['name'], dept['loc'])
                dept = Dept(**dept_dict)
                print(dept)
    except pymysql.MySQLError as e:
        print(e)
    finally:
        con.close()


if __name__ == '__main__':
    main()

```

