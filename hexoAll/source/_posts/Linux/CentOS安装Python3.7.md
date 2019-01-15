---
title: 安装Python
date: 2018-10-15 07:44:14
tags: Python 软链接
---

认真学习也是有前提的：

好的学习环境, 好的学习方法, 好的学习状态

缺一不可哟！





CentOS安装Python3.7

## 1.下载Python源代码：

https://www.python.org/ftp/python/3.7.0/Python-3.7.0.tgz

## 2.解压缩

```
gunzip Python-3.7.0.tgz
```

## 3.解归档

```
tar -xvf Python-3.7.0.tar
```

## 4.安装底层依赖库

```
yum -y install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel libffi-devel
```
## 5.安装前的配置
```
 ./configure --prefix=/usr/local/Python37 --enable-optimizations
```
## 6.构建安装
```
make && make install
```
##7.配置环境变量
```
export PATH=$PATH:/usr/local/Python37/bin
```
##8.注册软连接（符号链接）
```
ln -s /usr/local/Python37/bin/python3 /usr/bin/python3
```
硬链接 - 文件的引用，只要引用数不为0，文件就不会被删除
软链接 - 相当于是文件的快捷方式，如果文件被删除，软链接就会失效
ln -s 带完整路径的文件名，链接文件名