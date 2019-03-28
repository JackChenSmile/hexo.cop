---
title: practice linkman
date: 2018-10-20 18:06:33
author: smile
categories: databases
tags: 
  - linkman
---

###  MY简单的联系人练习

```python
import pymysql


def add_con(con):
    while True:
        telname = input('联系人姓名：')
        relation = input('与联系人关系：')
        tel = input('联系人电话：')
        with con.cursor() as cursor:
            result = cursor.execute(
                args=(telname, relation, tel),
                query="insert into tb_cont values (default, %s, %s, %s)")
            if result == 1:
                print('添加成功!')
                print('-' * 30)
                option = str(input('是否继续添加 yes / no  :'))
                if option == 'yes':
                    continue
                else:
                    break
            else:
                print('添加失败，请重新添加')
                continue


def function(cursor):
    print('编号    \t姓名    \t   关系    \t电话    ')
    print('=' * 50)
    for row in cursor.fetchall():
        print(str(row['id']).ljust(8), end='')
        print((row['telname'].ljust(8) if len(row['telname']) == 3 else row['telname'].ljust(9)), end='')
        print(str(row['relation']).ljust(9), end='')
        print(str(row['tel']).ljust(15))
    print('=' * 50)


def check_all_con(con):
    figure = 0
    while True:
        print('=' * 50)
        with con.cursor() as cursor:
            cursor.execute(
                args=(figure,),
                query="select id, telname, relation, tel from tb_cont order by id limit %s, 5")
            function(cursor)
        print('1.删除联系人')
        print('2.查看下一页')
        print('3.查看上一页')
        print('4.修改联系人信息')
        print('5.返回上一级')
        print('-' * 30)
        elect = input('请选择：')
        if elect == '1':
            del_con(con)
        elif elect == '2':
            figure += 5
            continue
        elif elect == '3':
            if figure >= 5:
                figure -= 5
            else:
                print('没有上一页，请重新选择')
            continue
        elif elect == '4':
            updeat_con(con)
        else:
            break


def fuzzy1(con):
    figure = 0
    while True:
        content = str(input('请输入搜索内容：'))
        with con.cursor() as cursor:
            cursor.execute(
                args=("%" + content + "%", figure),
                query=" select id, telname, relation, tel from tb_cont where telname like %s "
                      " order by id limit %s, 5")
            function(cursor)
        print('1.删除联系人')
        print('2.查看下一页')
        print('3.查看上一页')
        print('4.退出搜索')
        elect = input('请选择：')
        if elect == '1':
            cho = int(input('请输入要删除联系人的编号：'))
            with con.cursor() as cursor:
                result = cursor.execute(
                    args=(cho,),
                    query="delete from tb_cont where id=%s")
                if result == 1:
                    print('删除成功！')
                    print('-' * 30)
                    option = str(input('是否继续删除 yes / no  :'))
                    if option == 'yes':
                        del_con(con)
                    else:
                        break
                else:
                    print('删除失败，请重新删除')
                    continue
        elif elect == '2':
            figure += 5
            continue
        else:
            break


def fuzzy2(con):
    figure = 0
    while True:
        content = str(input('请输入搜索电话：'))
        with con.cursor() as cursor:
            cursor.execute(
                args=("%" + content + "%", figure),
                query=" select id, telname, relation, tel from tb_cont where tel like %s "
                      " order by id limit %s, 5 ")
            function(cursor)
        print('1.删除联系人')
        print('2.查看下一页')
        print('3.查看上一页')
        print('4.退出搜索')
        elect = input('请选择：')
        if elect == '1':
            cho = int(input('请输入要删除联系人的编号：'))
            with con.cursor() as cursor:
                result = cursor.execute(
                    args=(cho,),
                    query="delete from tb_cont where id=%s")
                if result == 1:
                    print('删除成功！')
                    print('-' * 30)
                    option = str(input('是否继续删除 yes / no  :'))
                    if option == 'yes':
                        del_con(con)
                    else:
                        break
                else:
                    print('删除失败，请重新删除')
                    continue
        elif elect == '2':
            figure += 5
            continue
        elif elect == '3':
            if figure >= 5:
                figure -= 5
            else:
                print('没有上一页，请重新选择')
            continue
        else:
            break


def updeat_con(con):
    while True:
        id = int(input('请输入要修改的联系人编号：'))
        telname = input('联系人姓名：')
        relation = input('与联系人关系：')
        tel = input('联系人电话：')
        with con.cursor() as cursor:
            result = cursor.execute(
                args=(telname, relation, tel, id),
                query="update tb_cont set telname=%s, relation=%s, tel=%s where id=%s")
            if result == 1:
                print('修改成功！')
                print('-' * 30)
                option = str(input('是否继续修改 yes / no  :'))
                if option == 'yes':
                    continue
                else:
                    break
            else:
                print('修改失败，请重新修改')
                continue


def del_con(con):
    while True:
        cho = int(input('请输入要删除联系人的编号：'))
        with con.cursor() as cursor:
            result = cursor.execute(
                args=(cho,),
                query="delete from tb_cont where id=%s")
            if result == 1:
                print('删除成功！')
                print('-' * 30)
                option = str(input('是否继续删除 yes / no  :'))
                if option == 'yes':
                    continue
                else:
                    break
            else:
                print('删除失败！')
                print('-' * 30)
                option = str(input('是否继续删除 yes / no  :'))
                if option == 'yes':
                    continue
                else:
                    break

def check_con(con):
    while True:
        print('-' * 30)
        print('1.查看全部联系人')
        print('2.搜索联系人')
        print('3.返回上一级')
        print('-' * 30)
        sel = input('请选择查看方式：')
        if sel == '1':
            check_all_con(con)
        elif sel == '2':
            while True:
                print('-' * 30)
                print('1.按姓名搜索')
                print('2.按电话搜索')
                print('3.退出搜索')
                print('-' * 30)
                choose = input('请选择搜索方式：')
                if choose == '1':
                    fuzzy1(con)
                elif choose == '2':
                    fuzzy2(con)
                else:
                    break
        elif sel == '3':
            break
        else:
            print('输入错误，请重新选择')
            continue


def clo(con):
    print('欢迎再次使用！')
    con.close()
def main():
    while True:
        print('1.添加联系人')
        print('2.查看联系人')
        print('3.退出系统')
        print('-' * 30)
        con = pymysql.connect(
            host='localhost', port=3306, user='root', db='contact', charset='utf8', password='123456',
            autocommit=True, cursorclass=pymysql.cursors.DictCursor)
        num = input('请选择：')
        if num == '1':
            add_con(con)
        elif num == '2':
            check_con(con)
        elif num == '3':
            clo(con)
            break
        else:
            print('输入错误，请重新选择')
            continue


if __name__ == '__main__':
    main()

```