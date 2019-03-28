---
title: Linux文件操作及软件安装
date: 2018-04-15 10:44:14
author: smile
categories: Linux
img: /images/QQ截图20160322184734.png
tags:
    - 软件安装
---

#### 压缩文件
- ls -lh  ------ 使用比较接近文件大小的单位显示文件
- ls -l --block-size=k(m,g) --------- 以不同的格式显示文件
- unzip filename
- gz ------ gzip(压缩) / gunzip（解压缩）
- xz ------- xz -z(压缩) / xz -d(解压缩)
- WinRAR - 归档和解归档
- tar - 归档文件
    - 归档 - 把几个文件合并成一个文件
    - 解归档 - 把一个文件分解成几个文件
- tar -xvf 文件名 ---------- 解归档并查看过程
- tar -cvf 归档文件的名字 需要的所有归档文件 -------- 创建归档

<hr>

- Python解释器的C实现 - CPython
- Python解释器的Java实现 - Jython
- Python解释器的C#实现 - IronPython
- Python解释器的Python实现 - PyPy

<hr>

#### 安装软件
##### Linux系统安装软件
- 使用包管理工具进行安装 yun / rpm
- yum search 软件名 ------------------ 查找软件
- yum install 软件名 软件名 ----------------- 安装多个软件
- yum -y remove 多个软件名 -------------- 卸载文件
- yum -y install --------------- 安装过程中遇到问题都是yes
- yum info 软件 ---------------- 查看软件的相关信息
- yum update （软件名） --------------- 更新所有软件
- yum list installed ------------------- 列出所有安装的软件

- 源代码构建安装
- wget 源代码下载地址
- gunzip / xz -d
- tar -xvf
- make && make install
- export PATH ... (.bash_profile) -------- 配置环境变量

###### 安装Python
CentOS安装Python3.7

<hr>
0.gcc --version  -------- 查看是否有gcc软件

1.下载Python源代码：
https://www.python.org/ftp/python/3.7.0/Python-3.7.0.tgz

2.解压缩：
xz -d Python-3.7.1.tgr

3.解归档：
tar -xvf Python-3.7.0.tar

4.安装底层依赖库：
 yum -y install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel libffi-devel

5.安装前的配置

进入Python3.7.0 文件中，执行以下命令

 ./configure --prefix=/usr/local/Python37 --enable-optimizations

Python37 ---------- 创建的文件名

6.构建安装：
make && make install

7.配置PATH环境变量(退出后要重新配置)：
export PATH=$PATH:/usr/local/Python37/bin

8.注册软连接（符号链接）：
ln -s /usr/local/Python37/bin/python3 /usr/bin/python3
- 硬链接 - 不复制数据的备份，文件的引用，只要引用数不为0，文件就不会被删除
  - in 原文件名 链接文件名
- 软链接 - 相当于是文件的快捷方式，方便操作，如果文件被删除，软链接就会失效
  - ln -s 带完整路径的文件名，链接文件名
- rm -rf 文件名 ----------------- 强制删除软链接

<hr>
1.安装gcc和依赖库

```
yum -y install wget gcc zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel libffi-devel
```
2.下载源代码
`https://www.python.org/ftp/python/3.7.1/Python-3.7.1.tgz`

3.解压缩/解归档
```
gunzip Python-3.7.1.tgr
tar -xvf Python-3.7.1.tar
```
4.进入cd Python-3.7.1文件中生成构建文件(Makefile)
执行
```
./configure --prefix=/usr/local/python37 --enable-optimizations
```
5.构建和安装
`make && make install`

6.进入~/.bash_profile文件中
修改环境变量
`PATH=$PATH:$HOME/bin:usr/local/python37/bin`

<hr>

###### 安装Nginx
**Nginx**:是一款轻量级的Web 服务器/反向代理服务器及电子邮件（IMAP/POP3）代理服务器

1.安装Nginx：
yum -y install nginx 

2.启动Nginx：
systemctl start nginx / service nginx start(centos6)

（可以通过IP访问，打开防火墙）
IP地址可以确定网络上的一台主机，端口号可以用来区分不同的服务（http - 80）

- /usr/share/nginx/html ---------- 服务器内容的存放位置，上传文件(put),下载文件(get)，首页文件index.html,在index.html文件中添加a标签的超链接
- /etc/nginx/nginx.conf ---------- 服务器配置内容文件

<hr>

### 安装postgresql数据库

1. 下载安装包

`wget https://ftp.postgresql.org/pub/source/v11.1/postgresql-11.1.tar.gz`
2.5创建postgres用户，并创建安装目录
```
useradd Postgres

mkdir -p /opt/pgsql/data
chown -R postgres:postgres /opt/pgsql 
```

2. 解压安装包

`tar -zxvf postgresql-11.1.tar.gz`
3. 编译、安装
```
cd postgresql-11.1
./configure --prefix=/opt/pgsql
make & make install
```
4. 初始化数据库
```Linu
su - postgres

[postgres@postgresql bin]$cd /opt/pgsql/bin
[postgres@postgresql bin]$ ./initdb -D /opt/pgsql/data/
The files belonging to this database system will be owned by user "postgres".
This user must also own the server process.

The database cluster will be initialized with locale "en_US.UTF-8".
The default database encoding has accordingly been set to "UTF8".
The default text search configuration will be set to "english".

Data page checksums are disabled.

fixing permissions on existing directory /opt/pgsql/data ... ok
creating subdirectories ... ok
selecting default max_connections ... 100
selecting default shared_buffers ... 128MB
selecting dynamic shared memory implementation ... posix
creating configuration files ... ok
running bootstrap script ... ok
performing post-bootstrap initialization ... ok
syncing data to disk ... ok

WARNING: enabling "trust" authentication for local connections
You can change this by editing pg_hba.conf or using the option -A, or
--auth-local and --auth-host, the next time you run initdb.

Success. You can now start the database server using:

    ./pg_ctl -D /opt/pgsql/data/ -l logfile start


[postgres@postgresql bin]$./pg_ctl -D /opt/pgsql/data -l logfile start
waiting for server to start.... done
server started

#配置用户环境变量文件.bash.profile增加如下内容
export PATH=$PATH:/opt/pgsql/bin


[postgres@postgresql ~]$ psql
psql (11.1)
Type "help" for help.

postgres=#
postgres=#
postgres=# \du
                                   List of roles
 Role name |                         Attributes                         | Member of
-----------+------------------------------------------------------------+-----------
 postgres  | Superuser, Create role, Create DB, Replication, Bypass RLS | {}

postgres=#
```

### 安装9.2版本
```Linu
系统环境说明
[root@slave1 ~]# cat /etc/redhat-release 
CentOS Linux release 7.4.1708 (Core) 

[root@slave1 ~]# uname -r
3.10.0-693.el7.x86_64

[root@slave1 ~]# hostname -I
192.168.174.201 192.168.122.1

软件版本
psql (9.2.23)


安装
yum install postgresql-server

PostgreSQL安装将不会启用自动启动或自动初始化数据库。为了完成数据库安装，您需要执行以下两个步骤
service postgresql initdb
chkconfig postgresql on

PostgreSQL启动服务
service postgresql start

查看是否启动
netstat -a | grep PGSQ

连接数据库
切换到数据库用户
su - postgres

登录数据库
psql
psql 终端可以用\du 或\du+ 查看，也可以查看系统表 select * from pg_roles;

[root@slave1 ~]# su - postgres
上一次登录：四 4月 12 17:18:28 CST 2018pts/0 上
-bash-4.2$ psql
psql (9.2.23)
输入 "help" 来获取帮助信息.

# 查看信息
postgres=# \du
                        角色列表
 角色名称 |               属性                | 成员属于 
----------+-----------------------------------+----------
 postgres | 超级用户, 建立角色, 建立 DB, 复制 | {}
 
postgres=# 

修改用户postgres的密码
alter role postgres with password 'postgres'

退出
\q
exit

修改配置
修改监听地址
vi /var/lib/pgsql/data/postgresql.conf
#listen_addresses='localhost'

#将上面这行改成如下
listen_addresses='*'

设置所有网段IP可以访问
vi /var/lib/pgsql/data/pg_hba.conf
# IPv4 remote address connections:
host    all         all         0.0.0.0/0                 trust

解决psql: 致命错误: 用户 "postgres" Ident 认证失败
#vi /var/lib/pgsql/data/pg_hba.conf

这个配置文件中的认证 METHOD的ident修改为trust，可以实现用账户和密码来访问数据库

验证
service postgresql restart
su - postgres
psql -h 127.0.0.1 -U postgres -d postgres -W
```
<hr>

### 安装禅道

```
1. 下载禅道
wget http://dl.cnezsoft.com/zentao/11.2/ZenTaoPMS.11.2.stable.zbox_64.tar.gz
2.解压
gunzip ZenTaoPMS.11.2.stable.zbox_64.tar.gz
tar -xvf ZenTaoPMS.11.2.stable.zbox_64.tar -C /opt
3.启动
/opt/zbox/zbox start -ap 9090 -mp 6371
```
<hr>

### 安装Docker
```Linux
yum install docker-io --- 安装
systemctl start docker --- 启动
docker images --------- 查看镜像
docker pull mysql:5.7 --- 安装镜像mysql
docker pull redis ----- 安装redis镜像
```

<hr>

连接远程用户端：`sftp root@Ip`


##### sftp常用命令
- quit / exit / bye --- 退出sftp
- cd / lcd ----- 切换远端工作目录/切换本地工作目录
- pwd / lpwd ---- 查看远端工作目录/查看本地工作目录
- ls / lls ---- 查看远端目录内容/查看本地目录内容
- mkdir / lmkdir ---- 创建远端目录/创建本地目录
- 给其它服务器拷贝文件 
  -  一个用户操作另外两个用户的文件：
      - scp  用户名@IP：/绝对路径/文件名 用户名@IP：/绝对路径/文件命名
  -  从本地到远程用户：
    scp 文件名 用户名@IP：/绝对路径/文件命名