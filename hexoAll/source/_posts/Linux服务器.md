#Linux
### Linux常用的防火墙服务有firewall和iptables

+ systemctl start firewalld    开启防火墙

+ systemctl enable firewalld     设置开机自启防火墙



+ firewalls-cmd  --add-port=80/tcp  --permanent

+ firewalls-cmd  --add-service=80/tcp  --permanent


- top —— 查看进程（CPU的利用率排序）
- ctrl + z     —— 把进程放到后台
- ctrl + c    ——  终止进程
- jobs —— 查看后台进程
###如果执行命令时在命令后面加上&就可以将命令置于后台运行
_bg %编号 —— 让暂停的进程继续在后台运行background
- fg %编号 —— 将后台的进程放到前台foreground