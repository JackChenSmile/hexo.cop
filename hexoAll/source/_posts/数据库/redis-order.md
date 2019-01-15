---
title: redis_order
date: 2018-10-18 21:43:12
tags: order
---

## redis 命令

- Redis：REmote Dictionary Server
- Server(Redis)远程字典服务器，为网站提供高速缓存服务

#### 网站优化两大定律

1.缓存 ----- 用空间换时间（redis/Memcached）

2.削峰 ------ 能推迟的事情都不要马上做(RabbitMQ/ RocketMQ)



#### 信息隐藏:

&emsp;&emsp;信息隐藏是指在设计和确定模块时，使得一个模块内包含的特定信息（过程或数据），对于不需要这些信息的其他模块来说，是不可访问的
##### 启动Redis服务器步骤(谨慎):
```mysql
1.修改Redis配置文件redis.conf(安装文件目录下)
    cp redis-4.0.11/redis.conf redis.conf
    # redis-server --post -- requirepass   ----- 也可以修改配置
    vim redis.conf
    bind 内网地址
    requirepass 密码
    appendonly yes
2.启动服务器
    redis-server redis.conf(配置文件) > redis.log &
3.启动客户端
    redis-cli -h ip地址(私用ip地址)
4.验证身份
    auth 密码
5.停止服务器
   1.kill 进程号
   2.把进程放到前台，Ctrl c
   3.客户端>shutdown
6.测试连接输入ping 回应PONG表示连接成功
```
##### 操作命令  ------- http://redisdoc.com/
```mysql
操作:
	keys *  查看所有键
	select 1切换到1号数据库
	select 15切换到15号数据库
	flushall 删掉所有数据库的所有数据
	flushdb 删掉当前一个数据库的数据删掉
	save 保存数据
	bgsave 后台保存
	set key value ex 存活时间 ：设置键值对并设置存活时间
    ttl key:查看数据的存活时间（ttl time to live),如果看到-1说明这个数据永不超时，如果-2说明没这个数据
	expire key 时间: 设置已有键的存活时间
	ince key:增加值
	decr key:减少值

基准测试：
	redis-benchmark -h ip -a 密码	测试redis性能


    LBS：Location-Base Service
字符串:
    setnx:如果不存在才赋值
    setex:在设置键值对的时候同时设置存活时间
    mset:一次放很多键值对
    mget:一次获取多个键值对

哈希表(hash)
    hset:设置hash类型
    hget:获取值 hget key filed
    hgetall:获取对应key的所有值（hgetall key）
    hmget:一次性获取多个值
    hmset:一次性赋值多个
	    hmset stu1 id 101 name baiyuan age 12 gender male
    hdel:删除哈希数据
	    hdel stu1 age
    hexists:判断对应键是否存在某字典
	    hexists stu1 mile
    hlen:统计键有多少字段
    hkey:取出对应键的所有字段
    hvals:取出对应键的所有值
    hscan:遍历键值对

列表:(List)
    lpush:向列表放原始(从左边开始放)
	    lpush list1 1 2 3 4 5

    lpop:从左边开始取
    rpop:从右边开始取
    rpush:(从右边开始放)
    lrange:指定范围取元素()
	    lrange list1 start end
	    lrange list1 0 -1
    lset:修改列表指定下标的值
	    lset list 1 1000
    blpop:如果列表没东西，且时间未超时就阻塞，有东西拿走，超时就结束（从左边取）
	    blpop list1 20
    brpop：如果列表没东西，且时间未超时就阻塞，有东西拿走，超时就结束（从右边取）
    brpoplpush:从右边取一个元素，并把这个元素放到另一个列表的左边（阻塞式）

集合(Set):
    sadd:向集合添加元素
	    sadd set1 10 20 10 20 30
    smebers:查看集合中的元素	
	    smerbers set1
    sinter:交集
	    sinter 集合1 集合2
    sunion:并集
	    sunion 集合1 集合2
    sdiff:差集
	    sdiff 集合1 集合2
    sismenber:判断元素在不在集合中
	    sismenber 集合 元素
    spop:从集合中取出一个元素
    srandmenber:从集合中随机返回一个元素（实际没有拿走）
    srem:移除集合中的一个或者多个元素，如果不存在就忽略

浮点数表示法的问题
    有序集合（SortedSet）
    zadd:添加有序集合
	    zadd 集合名 值 元素
    zrange:查看元素
	    zrange zs1 0 -1
	    zrange zs1 0 -1 withscores 显示元素的时候把分数值也显示出来
    zrangebyscore:指定搜索范围来搜索数据
	    zrangebyscore zs1 10 20
    zrank:查看元素的排名
	    zrank zs1 apple
    zreverange:从大到小排序查询
	    zreverange zs1

type(值)：查看对应值的类型

事务:
mult开始事务
exec:执行
discard：放弃执行


服务器:
bgsave：后台保存
dbsize: 查看数据库有多少键
slaveof:把redis设置成那个的奴隶（主从复制，读写分离）
shutdown：关闭服务器
info:查看服务器相关信息

redis-check-aof -fix appendonly.aof	修复aof的文件
```

- type ----- 查看键的类型
- setnx ----- 设置已存在键的值
- sentex ---- 设置键值对的同时设置时间

#### Hash ------- 保存对象 
- hset ----- 创建key
- hget ----- 取出key
- hgetall ---- 取出key的全部属性
- hmset ------- 创建key并设置多个属性
- hmget ------- 取出key的多个属性
- hdel ----- 删除key的一个或多个属性
- hexists ----- 查看key是否存在
- hlen ----- 统计key对应多少个字段
- hkeys ------- 返回key中的所有的域
- hscan ------- 遍历key及域（遍历字典的键和值）

#### List
**`lset list1 0 name`**

- lset ------ 给列表1中的下标为0的元素赋值为name
- lpop ------ 取出列表的头元素（左边第一个）元素
- rpop ------ 取出列表的尾元素（右边第一个）元素
- lpush ------ 在表头插入一个或多个值
- rpush ------ 在表尾插入一个或多个值
- lrange ------ 取出指定的元素
- lset ------ 修改原有列表的特定元素值
- blpop ------ 阻塞式从左边取出元素（有元素，不阻塞，没有元素，等待输入元素，然后取出）
- blpop ------ 阻塞式从右边取出元素（有元素，不阻塞，没有元素，等待输入元素，然后取出）
- rpoplpush A B ------ 从A中取出，从B中左边存入

####  Set（集合）
- sadd ----- 添加一个或多个元素
- srem ----- 删除一个或多个指定的元素
- scard ------ 查看集合中有多少个元素
- smembers ----- 查看集合的元素
- sinter ------ 查看两个集合的交集
- sunion ----- 查看两个集合的并集
- sdiff ------ 查看两个集合的差集
- sismember ------ 查看一个集合中是否存在一个给定的元素
- spop ----- 取出一个随机元素（不同）
- srandmember ------ 取出一个随机元素（可能相同）

#### Sortedset（有序集合）
- zadd ----- 添加元素
- zrange ----- 查看元素（排好序的）
- zrangebyscore ---- 指定范围查看
- zrank ----- 排名（从0开始排的）
- zrem ----- 删除
- zrevrange ------ 倒序排列



### 复制：

##### 主从复制（读写分离）修改内容：

- master不用修改配置
- slave修改两条配置
  - slaveof master的IP地址 master的端口
  - masterrauth master的口令
- info replication ------- 查看是否有奴隶
- info ------- 查看服务器信息 
- ps -ef | grep deris | grep -v grep | awk '{print $2}' | xargs kill ------- 杀掉所有的奴隶
- slaveof no one --------- 拒绝当奴隶

###### 故障处理

配置哨兵（sentinel.conf）

- 修改sentinel.conf配置文件
  - 修改69行的监视窗口 跟上票数
  - 98行master的死亡时间设置
    - 在规定的时间回来了，还是master，没回来就重选
  - 131行的意思：master在3分钟内回来，也只能当奴隶，没回来，就直接杀死
- redis-server sentinel.conf --sentinel -------- 启动哨兵文件



### MySQL / MongoDB

- 热（点）数据 ---- 经常被访问的数据

- redis放的应该是体量不大的热点数据

