---
title: pygame相关
date: 2018-11-01 15:15:06
tags: game
---

#### 01-pygame操作

模块的导入：

##### import pygame

```python
if __name__ == '__main__':
    # 1.初始化游戏模块
    pygame.init()
    # 2.创建游戏窗口
    '''
    display.set_mode(窗口大小）:创建一个窗口并且返回
    窗口大小：是一个元组，并且表示宽度和高度(单位是像素）
    '''
    window = pygame.display.set_mode((500,600))

    # 3.让游戏一直运行，直到点关闭按钮结束
    flag = True
    while flag:
        window.fill((255,255,255))
        # 获取游戏过程中产生的所有事件
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                # exit()   # 退出程序
                flag = False
```
#### 02-显示图片
+ 给窗口填充颜色
  颜色：计算机的三原色（红，绿，蓝），颜色对应的范围分别是0-255，可以通过改变三原色的值，调配出不同的颜色
  颜色值：是一个元组，元组中有三个元素，分别是红绿蓝（rgb)
    红色（255，0，0），绿色（0，255，0），蓝色（0，0，255）
    黑色（0，0，0），白色（255，255，255）
  `window.fill((255,255,255))`
+ 显示图片
  image.load(图片路径）：获取本地的一张图片，返回图片对象
 + a.获取图片，创建图片对象
  `image = pygame.image.load('./files/gjl.jpg')`
  get_size():获取大小，返回值是一个元组，分别是宽和高
  ` image_width,image_height =image.get_size()`
+ b.渲染图片（将图片画在纸上）
  blit(渲染对象，位置）
    位置：坐标（x,y），值的类型是元组，元组有两个对应的元素，分别是x,y的坐标
```python
# window.blit(image,(600-int(image_width),400-int(image_height)))将图片放到右下角
    window.blit(image,(0,0))
    # c.展示内容(将纸贴在画框上）
    pygame.display.flip()
```
#### 03-形变
a.缩放
transform.scale(缩放对象，目标大小）：将指定的对象缩放到指定的大小，会返回缩放后的对象
`new_image = pygame.transform.scale(image())`
b.旋转缩放（指定缩放比例）
rotozoom(Surface,angle,scale)
Surface:旋转对象
angle:旋转角度
scale:缩放比例
`new_image = pygame.transform.rotozoom(image,90,0.8)`
c.旋转
rotate(Surface,angle)
Surface:旋转对象
angle:旋转角度
` new_image = pygame.transform.rotate(image, 270)`
#### 04-显示文字
+ 1.创建字体对象
  a.创建系统的字体对象
   SysFont(name,size,bold = False,italic = False)
  name:字体名（系统支持的字体名）
  size:字体大小
  bold:是否加粗
  italic:是否倾斜
  b.创建自定义的字体对象
  Font（字体文件路径，字体大小）
  字体文件路径：ttf文件
```python
 # a.创建系统字体
    # font = pygame.font.SysFont('Times',30)

    # b.创建自定义字体
    font = pygame.font.Font('./files/aa.ttf',50)
```
+ 2.根据字体去创建文字对象
  render(text,antialias,color,background = None)
  text:需要显示的文字（字符串）
  antialias:是否平滑（布尔）
  color:颜色
  background:背景颜色
```
text = font.render('Hello,高渐离 ！',True,(255,80,200))
    print(text.get_size())
```
#### 05-显示图形
1.画直线
​    def line(Surface,color,star_pos,end_pos,width=1)
​    Surface:画在哪
​    color：颜色
​    star_pos：起点
​    end_pos：终点
​    width:线宽
```
# 画一条水平线
    # pygame.draw.line(window,(255,0,0),(50,100),(200,100))
    # pygame.draw.line(window, (255, 100, 200), (0, 0), (100, 100),10)
```
2.画线段（折线）
​    def lines(Surface,color,close,pointlist,width=1)
​    Surface:画在那
​    color：颜色
​    close：是否闭合（是否连接起点和终点）
​    pointlist：点对应的列表
​    width：线的宽度
` pygame.draw.lines(window,(255,100,200),True,[(0,0),(100,0),(100,100),(200,100),(200,200)],10)`
3.画圆
​    def circle(Surface,color,pos,radius,width=1)
​    Surface:画在那
​    color：颜色
​    pos:圆心坐标
​    radius:半径
​    width:0-->填充
`pygame.draw.circle(window,(255,255,0),(200,300),100,0)`
4.画矩形
​    def rect(Surface,color,Rect,width=0)
​    Surface:画在那
​    color：颜色
​    Rect:范围（元组，元组中有4个元素，分别是x,y,width,height)
`pygame.draw.rect(window,(200, 150, 200), (200, 200, 250, 300),20)`
5.画多边形
​    polygon(Surface,color,pointlist,width=0)
​    pointlist:多边形各点坐标，组成一个元组
6.画椭圆
​    def ellipse(Surface,color,Rect,width=0)
` pygame.draw.ellipse(window, (200, 150, 200), (200, 200, 250, 300), 20)`
7.画弧线
​    def arc(Surface,color,Rect,start_angle,stop_angle,width=1)
`import math
​    pygame.draw.arc(window,(255,0,0),(100, 100, 100, 100),math.pi,math.pi/2,10)`
#### 06-事件
 所有的事件处理的入口就是这个for循环
  + for循环中的代码只有游戏事件发生后才会执行
       a.事件的type:
       QUIT：关闭按钮被点击事件
       鼠标事件：
       MOUSEBUTTONDOWN：鼠标按下事件
       MOUSEBUTTONUP：鼠标弹起
       MOUSEMOTION:鼠标移动
       键盘事件：
       KEYDOWN:键盘按下
       KEYUP:键盘弹起

       b.事件的pos--鼠标事件发生的位置（坐标）

       c.事件的key--键盘事件被按的键对应的编码值
```python
        for event in pygame.event.get():
            # 不同的事件发生后，对应的type值不一样
            if event.type == pygame.QUIT:
                print('点击关闭')
                exit()
            elif event.type == pygame.MOUSEBUTTONDOWN:
                # 鼠标按下要做的事情
                print(event.pos)
                print('鼠标按下')
                # 鼠标按下一次画一个球
                pygame.draw.circle(window,(random.randint(0,255),random.randint(0,255),random.randint(0,255)),event.pos,20)
                pygame.display.flip()
            elif event.type == pygame.MOUSEBUTTONUP:
                print('鼠标弹起')
            elif event.type == pygame.MOUSEMOTION:
                print('鼠标正在移动',event.pos)
            elif event.type == pygame.KEYDOWN:
                print('键盘按下',event.key,chr(event.key))
            elif event.type == pygame.KEYUP:
                print('键盘弹起')
```
#### 07-动画效果
```python
 # c.展示内容(将纸贴在画框上）
    pygame.display.flip()

    # 圆心坐标
    x = 100
    y = 100
    r = 50
    add = 4
    m = 2
    n = 1
    # 游戏循环
    while True:

        pygame.time.delay(5)
        # 将之前window上的内容覆盖了
        window.fill((255,255,255))

        # 不断的画圆
        pygame.draw.circle(window,(randint(0,255),randint(0,255),randint(0,255)),(x,y),r)
        pygame.display.update()

        # 改变y值让圆在垂直方向移动
        y += m
        x += n
        # r += add
        # if r >=600 or r <= 20 :
        #     add *= -1
        if y >= 600 - r or y <= 50:
            m *= -1
        elif x >= 400-r or x <= 50:
            n *= -1
        # 事件检测
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                exit()
```
#### 08-按住不放原理
```python
import pygame
if __name__ == '__main__':
    # 初始化，创建窗口
    pygame.init()
    window = pygame.display.set_mode((400,600))
    window.fill((255,255,255))

    image = pygame.image.load('./files/gjl.jpg')
    # 缩放
    image = pygame.transform.rotozoom(image,0,0.5)
    window.blit(image,(100,100))
    # 获取图片的宽度、高度
    image_w,image_h = image.get_size()

    # c.展示内容(将纸贴在画框上）
    pygame.display.flip()

    # 用来存储图片是否移动
    flag = False

    # 保存图片的坐标
    image_x,image_y = 100,100
```
```python
    # 游戏循环
    while True:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                exit()

            # 鼠标按下
            if event.type == pygame.MOUSEBUTTONDOWN:
                # 判断鼠标的范围是否在图片上
                m_x,m_y = event.pos
                if image_x<=m_x<=image_x+image_w and image_y<=m_y<=image_y+image_h:
                    flag = True
            elif event.type == pygame.MOUSEBUTTONUP:
                flag = False
            # 鼠标移动事件
            # 鼠标在移动，并且flag为True
            if event.type == pygame.MOUSEMOTION and flag:
                # 填充背景色
                window.fill((255,255,255))

                # 在鼠标移动的位置渲染图片
                # window.blit(image,event.pos
                center_x,center_y = event.pos
                image_x, image_y = center_x - image_w/2,center_y - image_h/2
                window.blit(image,(image_x, image_y))
                # 更新屏幕显示
                pygame.display.update()
```