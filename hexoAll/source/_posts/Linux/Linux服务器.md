---
title: Linux操作
date: 2018-10-15 07:44:14
tags: 操作系统 Linux 防火墙
---

Linux内核最初只是由芬兰人李纳斯·托瓦兹（Linus Torvalds）在赫尔辛基大学上学时出于个人爱好而编写的。

Linux能运行主要的UNIX工具软件、应用程序和网络协议

Linux发行版本：Ubuntu、RedHat、CentOS、Debian、Fedora、SuSE、OpenSUSE、Arch Linux、SolusOS 等。



# Linux系统下的操作系统

## 1. 攻击方式

PING to death  ---------- 拼到死

DOS - Deny of Service --------------- 拒绝服务攻击

DDoS - Distributed Deny of Service ----------- 分布式拒绝服务攻击

## 2. 查看本机IP

ifconfig

## 3. 连接其它的服务器

ssh [root@IP](mailto:root@IP)

断开某个用户的终端连接： 

​	命令：fuser -k /dev/pts/x  （x为who下看到的这个用户的pts序号，比如本例中的pts/0,pts/1）   

​            example： fuser -k /dev/pts/0

## 4. 给其它的服务器拷贝文件

一个用户操作另外两个用户的文件：

 scp  用户名@IP：/绝对路径/文件名 用户名@IP：/绝对路径/文件命名

从本地到远程用户：

scp /绝对路径/文件名 用户名@IP：/绝对路径/文件命名

## 5. 操作远端用户

sftp 用户名@IP

​	用户名密码

​	get 要下载的文件名

​	put 上传的文件名

​	lls 查看本地目录

在输入的命令前加上<l>，就可以操作本地文件，直接输入命令，操作连接的用户文件

​	l(命令) 操作本地文件

## 6. 网络端口

netstat -na | grep 80   查询网络状态

netstat -nap | grep 80   查看占用端口的进程

## 7. 服务操作

systemctl start <进程的名字>       开启服务

systemctl stop <name>       禁用服务

systemctl restart <name>    重启服务

systemctl status <name>    查看服务状态

systemctl senable <name>  开机自启服务

systemctl disable <name>   禁用开机自启服务

计算机网络分层结构模型

Internet ----- TCP/IP协议族

TCP - Transfer Control Protocol - 传输控制协议

UDP - User Datagram Protocol - 用户数据报协议

IP - Internet Protocol - 网际协议



TCP/IP模型

应用层（定义应用之间如何传输数据，定义应用级协议）- HTTP/SMTP/SSH/POP3/FTP/ICQ

传输层（端到端传输数据）- TCP/ UDP

网络层/网际层 （寻址和路由）

物理链路层 （数据分帧 + 校验）- 冗余校验码

## Linux常用的防火墙服务有firewall和iptables

+ systemctl start firewalld    开启防火墙

+ systemctl enable firewalld     设置开机自启防火墙



+ firewalls-cmd  --add-port=80/tcp  --permanent

+ firewalls-cmd  --add-service=80/tcp  --permanent


- top —— 查看进程（CPU的利用率排序）
- ctrl + z     —— 把进程放到后台
- ctrl + c    ——  终止进程
- jobs —— 查看后台进程
## 如果执行命令时在命令后面加上&就可以将命令置于后台运行
_bg %编号 —— 让暂停的进程继续在后台运行background
- fg %编号 —— 将后台的进程放到前台foreground

## 8. Linux根目录下

## [http://www.runoob.com/linux/linux-system-contents.html](http://www.runoob.com/linux/linux-system-contents.html)

etc:保存下载安装的文件夹

安装的软件名.conf ---------- 安装的软件的配置

dev: 设备管理器

tmp --------------- 临时文件

usr -------------- 用户目录

## 9. Linux环境

Linux的shall也是一个交互式的环境，可以输入代码

执行多个程序可以用分号 隔开 / && 隔开 / 并列符号 ||

![Linux1](Linux服务器\Linux1.jpg)