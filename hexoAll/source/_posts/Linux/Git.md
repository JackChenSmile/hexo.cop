---
title: Git
date: 2018-11-19 21:20:50
tags:
---

##  搭建Git服务器

1. 使用已有的代码托管平台 ----- github / gitee / coding
2. 搭建自己的Git私服 ---- gitlab

###  git命令
######  上传文件
- git clone ssh/https
  - 连接远端仓库到本地仓库,ssh密钥对，在Administrator文件中的.ssh文件中，有一个密钥文件id_rsa.pub
- git add 文件名
  - 添加文件到工作区
- git commit -m "注解"
  - 将工作区中的文件添加到本地仓库
- git push
  - 将本地仓库中的文件上传到远端仓库
- git pull
  - 将远端仓库中的文件下载到本地仓库

###  如果Git连网操作报错通常是因为底层依赖库libcurl安装不正确
错误：`Could not read from remote repository.`
解决方法：
1. yum -y install curl libcurl libcurl-devel
2. cd ~
3. cd git-2.19.1
4. make clean
5. ./configure --prefix=/usr/local
6. make && make install

##  hexo 搭建个人博客

1. 安装Node.js --- yum -y install nodejs
- node --version
- hexo --version

2. 通过Node包管理工具npm安装hexo
- npm install hexo-cli -g
- hexo --version

3. 使用hexo创建博客项目
- hexo init blog[项目名字]
- cd blog
- npm install

4. 将写成的Markdown文件放到blog/source/_posts
5. 生成静态页面
- hexo generate / hexo g

- hexo clean -------- 清除之前生成的内容

6. 启动服务器
- hexo server / hexo s

###  托管
如果希望自己的博客部署到其他网站上托管，可以使用其他网站提供的pages服务

#####  将博客托管到github
首先要在github上创建一个名为xxx.github.io项目
其中xxx是自己的github的用户名（必须完全一致）

修改blog目录下的_config.yml文件 在文件的最后添加下面的内容
```
# Deployment
## Docs: https://hexo.io/docs/deployment.html
deploy:
  type: git
  repo: git@github.com:xxx/xxx.github.io.git
  branch: master

通过下面的命令可以实现一键部署
hexo g -d
hexo d -g

如果操作失败可能有两个原因：
1. 没有安装git部署器（可以用npm进行安装）
npm install hexo-deployer-git --save

2. 需要配置SSH证书（可以通过openssl创建证书）
加密 - 通信安全
对称加密 - 加密和解密使用同一个密钥 - AES
attack at dawn - 明文
dwwdfn dw gdzq - 密文


非对称加密 - 加密和解密使用不同的密钥 - RSA
生成密钥时需要生成两个密钥 一个叫公钥一个叫私钥
Alice向Bob发送数据时 使用公钥加密数据
Bob收到Alice发过来的数据时 使用私钥解密数据
Bob向Alice发送数据时 使用私钥加密数据
Alice收到Bob发过来的数据时 使用公钥解密数据

创建密钥对
ssh-keygen -t rsa -b 4096 -C "xxx@qq.com"

id_rsa - 私钥
id_rsa.pub - 公钥 - 添加到github上面
Settings --> Deploy keys --> Add deploy keys
https://hexo.io/themes/
https://hexo.io/plugins/

配置域名解析

在阿里云或其他域名解析服务上配置一条CNAME解析
所谓CNAME解析就是把自己的域名解析到github的pages服务

可以在blog项目的source目录下添加一个CNAME文件，里面写上自己的域名（如：jackfrued.xyz），这样就可以直接通过自己的域名访问github的pages服务，要可以在访问github的pages服务时让域名自动切换为自己的域名
```

#####  将博客托管到gitee
参照网站：https://www.jianshu.com/p/5014133ba61a

#####  将gitee上的博客改成自己的域名
1. 在一个项目中必须有index.html这个文件
2. 在项目主页点击「服务」->选择「GiteePages」，开启部署。 因为每个用户可免费试用一个月，所以这里点击「免费试用一个月」，也可以付费使用
3. 选择你需要部署的分支，填写要部署的分支上的目录，绑定你已经**备案的域名**（如i-love-gitee.com）。如果有需要，也可为网站配置 HTTPS 安全访问。
4. 点击「启动」后几十秒即部署成功，点击网站地址就可以访问啦。