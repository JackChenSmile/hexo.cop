---
title: python_database
date: 2018-10-17
tags: 
---

## 数据库的微操做

进行数据的增加，修改，删除，查看

在信息化社会，充分有效地管理和利用各类信息资源，是进行科学研究和决策管理的前提条件。

----- 从删库，到跑路额！

```python
import pymysql


class Dept(object):
    def __init__(self, no, name, location):
        self.no = no
        self.name = name
        self.location = location


def main():
    '''
    no = int(input('部门编号：'))
    name = input('部门名称：')
    location = input('部门地址：')
    '''

    # 1.创建数据库连接
    conn = pymysql.connect(host='localhost', port=3306,
                           db='hrs', user='root',
                           charset='utf8', password='123456',
                           autocommit=True,
                           cursorclass=pymysql.cursors.DictCursor)
    print(conn)
    try:
        # 2.获得游标对象
        with conn.cursor() as cursor:
            # 3.向数据库服务器发出SQL
            # cursor 游标，上下文语法
            '''
            # 删除
            result = cursor.execute(
                'delete from TbDept where dno=40')
            if result == 1:
                print('删除成功!')
           '''

            '''
            # 添加
            result = cursor.execute(
                args=(no, name, location),
                query="insert into TbDept values (%s, %s, %s)")
            if result == 1:
                print('添加成功!')
            '''

            '''
            如果没有添加autocommit这个属性，就可以添加下面这一段代码来提交数据
            try:
                result
                conn.commit()
            except:
                conn.rollback()
            '''

            '''
            # 修改
            result = cursor.execute(
                args=(name, location, no),
                query="update TbDept set dname=%s, dloc=%s where dno=%s")
            if result == 1:
                print('修改成功！')
            '''
            '''
            # 命名占位符
            result = cursor.execute(
                args={'no':no, 'name':name, 'loc':location},
                query="update TbDept set dname=%(name)s, dloc=%(loc)s where dno=%(no)s")
            if result == 1:
                print('修改成功！')
            '''
            '''
            # 查看信息1
            cursor.execute(
                "select dno, dname, dloc from TbDept")
            for row in cursor.fetchall():
                print(f'部门编号：{row[0]}')
                print(f'部门名称：{row[1]}')
                print(f'部门地址：{row[2]}')
                print('-' * 20)
            '''
            '''
            # 查看信息2
            cursor.execute("select dno as no, dname as name, dloc as loc from TbDept")
            print('-' * 20)
            for row in cursor.fetchall():
                print(row['no'], end='\t')
                print(row['name'], end='\t')
                print(row['loc'])
            '''
            # 查看信息3
            cursor.execute(" select dno as no, dname as name, dloc as location "
                           " from TbDept")

            print('-' * 20)
            for row in cursor.fetchall():
                print(row)
                dept = Dept(**row)
                print(dept.no, end='\t')
                print(dept.name, end='\t')
                print(dept.location)
            print('-' * 20)

    finally:
        conn.close()


if __name__ == '__main__':
    main()
```