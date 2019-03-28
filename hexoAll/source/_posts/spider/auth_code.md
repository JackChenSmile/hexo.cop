---
title: 超级鹰
date: 2018-05-24 15:15:06
author: smile
img: /images/ALi.jpg
categories: spider
tags: 
  - code
---
##  使用验证平台   超级鹰(https://www.chaojiying.com/)

###  字母数字验证码
code
```python


import time
from io import BytesIO

from PIL import Image
from selenium import webdriver
from selenium.common.exceptions import TimeoutException
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

from chaojiying import main1

chrome_options = webdriver.ChromeOptions()
# chrome_options.add_argument('--headless')
browser = webdriver.Chrome(chrome_options=chrome_options)

# browser = webdriver.Chrome()
browser.set_window_size(1200, 700)
# 显式等待 针对某个节点的等待
wait = WebDriverWait(browser, 10)


def get_big_image():
    browser.execute_script('window.scrollTo(0, 300)')
    screenshot = browser.get_screenshot_as_png()
    screenshot = Image.open(BytesIO(screenshot))
    return screenshot

def get_captcha_position():
    captcha = wait.until(EC.presence_of_element_located
                         ((By.CSS_SELECTOR, '#captchaImg')))
    location = captcha.location
    size = captcha.size
    x1 = location['x']
    y1 = location['y'] - 130
    width = size['width']
    height = size['height']
    x2 = x1 + width
    y2 = y1 + height
    print(x1, y1, x2, y2)
    return (x1, y1, x2, y2)

def get_page():
    url = 'https://login.10086.cn/html/login/login.html?channelID=12002&backUrl=https%3A%2F%2Fshop.10086.cn%2Fmall_280_280.html%3Fforcelogin%3D1'
    browser.get(url)

    button = wait.until(EC.element_to_be_clickable((By.CSS_SELECTOR, '#mail_login_2')))
    button.click()

    username = '1484815087@qq.com'
    password = '518420..'

    input_username = wait.until(EC.presence_of_element_located
                                ((By.CSS_SELECTOR, '#e_name')))
    input_password = wait.until(EC.presence_of_element_located
                                ((By.CSS_SELECTOR, '#e_pwd')))

    input_username.clear()
    input_username.send_keys(username)
    input_password.clear()
    input_password.send_keys(password)
    time.sleep(3)

    full_screen_img = get_big_image()
    full_screen_img.save('mobile_login.png')

    # 获取验证码左上角和右下角的坐标
    x1, y1, x2, y2 = get_captcha_position()
    captcha_img = full_screen_img.crop((x1, y1, x2, y2))
    captcha_img.save('mobile_captcha.png')
    captcha_str = main1('mobile_captcha.png')
    print(captcha_str)

    input_code = wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, '#inputCode')))
    input_code.clear()
    input_code.send_keys(captcha_str)

    button = wait.until(EC.element_to_be_clickable((By.CSS_SELECTOR, '#submit_bt')))
    button.click()

    # return html

def main():
    html = get_page()
    # parse_html(html)


if __name__ == '__main__':
    main()

```

验证方式的平台

```python
import requests
from hashlib import md5

class Chaojiying_Client(object):

    def __init__(self, username, password, soft_id):
        self.username = username
        password =  password.encode('utf8')
        self.password = md5(password).hexdigest()
        self.soft_id = soft_id
        self.base_params = {
            'user': self.username,
            'pass2': self.password,
            'softid': self.soft_id,
        }
        self.headers = {
            'Connection': 'Keep-Alive',
            'User-Agent': 'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0)',
        }

    def PostPic(self, im, codetype):
        """
        im: 图片字节
        codetype: 题目类型 参考 http://www.chaojiying.com/price.html
        """
        params = {
            'codetype': codetype,
        }
        params.update(self.base_params)
        files = {'userfile': ('ccc.jpg', im)}
        r = requests.post('http://upload.chaojiying.net/Upload/Processing.php', data=params, files=files, headers=self.headers)
        return r.json()

    def ReportError(self, im_id):
        """
        im_id:报错题目的图片ID
        """
        params = {
            'id': im_id,
        }
        params.update(self.base_params)
        r = requests.post('http://upload.chaojiying.net/Upload/ReportError.php', data=params, headers=self.headers)
        return r.json()

def main1(urlstr):
    chaojiying = Chaojiying_Client('carmack', 'Vff635241', '96001') 
    im = open(urlstr, 'rb').read()                                                 
    return chaojiying.PostPic(im, 1902)['pic_str']                                           

if __name__ == '__main__':
	chaojiying = Chaojiying_Client('carmack', 'Vff635241', '96001')	
	im = open('CaptchaImg.png', 'rb').read()													
	print(chaojiying.PostPic(im, 1902))												


```

###  滑动图片验证码

step1. 模拟点击验证按钮

step2. 识别滑动缺⼝位置
遍历没有缺⼝和有缺⼝的两张图⽚，找出相同位置像素差距超过指定值的像素点，即缺⼝位置
（⽬前极验已经改进了算法）

step3. 模拟拖动滑块

```python
import time
from io import BytesIO
from PIL import Image
from selenium import webdriver
from selenium.webdriver import ActionChains
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

EMAIL = '1963298993@qq.com'
PASSWORD = 'yicijiuhao0'
BORDER = 6
INIT_LEFT = 60


class CrackBilibili():
    def __init__(self):
        self.url = 'https://passport.bilibili.com/login'
        self.browser = webdriver.Chrome()
        self.wait = WebDriverWait(self.browser, 10)
        self.email = EMAIL
        self.password = PASSWORD
    
    def __del__(self):
        self.browser.close()
    
    def get_geetest_button(self):
        """
        获取初始验证按钮
        :return:
        """
        button = self.wait.until(EC.element_to_be_clickable((By.CSS_SELECTOR, '.gt_slider_knob.gt_show')))
        return button
    
    def get_position(self):
        """
        获取验证码位置
        :return: 验证码位置元组
        """
        img = self.wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, '.gt_cut_fullbg.gt_show')))
        time.sleep(2)
        location = img.location
        size = img.size
        top, bottom, left, right = location['y'], location['y'] + size['height'], location['x'], location['x'] + size[
            'width']
        return (top, bottom, left, right)
    
    def get_screenshot(self):
        """
        获取网页截图
        :return: 截图对象
        """
        screenshot = self.browser.get_screenshot_as_png()
        screenshot = Image.open(BytesIO(screenshot))
        return screenshot
    
    def get_slider(self):
        """
        获取滑块
        :return: 滑块对象
        """
        slider = self.wait.until(EC.element_to_be_clickable((By.CSS_SELECTOR, '.gt_slider_knob.gt_show')))
        return slider
    
    def get_geetest_image(self, name='captcha.png'):
        """
        获取验证码图片
        :return: 图片对象
        """
        top, bottom, left, right = self.get_position()
        print('验证码位置', top, bottom, left, right)
        screenshot = self.get_screenshot()
        captcha = screenshot.crop((left, top, right, bottom))
        captcha.save(name)
        return captcha
    
    def open(self):
        """
        打开网页输入用户名密码
        :return: None
        """
        self.browser.get(self.url)
        email = self.wait.until(EC.presence_of_element_located((By.ID, 'login-username')))
        password = self.wait.until(EC.presence_of_element_located((By.ID, 'login-passwd')))
        email.clear()
        password.clear()
        email.send_keys(self.email)
        password.send_keys(self.password)
    
    def get_gap(self, image1, image2):
        """
        获取缺口偏移量
        :param image1: 不带缺口图片
        :param image2: 带缺口图片
        :return:
        """
        left = 60
        print('******大小*****')
        print(image1.size)
        for i in range(left, image1.size[0]):
            for j in range(image1.size[1]):
                if not self.is_pixel_equal(image1, image2, i, j):
                    left = i
                    return left
        return left
    
    def is_pixel_equal(self, image1, image2, x, y):
        """
        判断两个像素是否相同
        :param image1: 图片1
        :param image2: 图片2
        :param x: 位置x
        :param y: 位置y
        :return: 像素是否相同
        """
        # 取两个图片的像素点
        pixel1 = image1.load()[x, y]
        pixel2 = image2.load()[x, y]
        threshold = 60
        if abs(pixel1[0] - pixel2[0]) < threshold and abs(pixel1[1] - pixel2[1]) < threshold and abs(
                pixel1[2] - pixel2[2]) < threshold:
            return True
        else:
            return False
    
    def get_track(self, distance):
        """
        根据偏移量获取移动轨迹
        :param distance: 偏移量
        :return: 移动轨迹
        """
        # 移动轨迹
        track = []
        # 当前位移
        current = 0
        # 减速阈值
        mid = distance * 3 / 5
        # 计算间隔
        t = 0.5
        # 初速度
        v = 0
        
        while current < distance:
            if current < mid:
                # 加速度为正2
                a = 2
            else:
                # 加速度为负3
                a = -3
            # 初速度v0
            v0 = v
            # 当前速度v = v0 + at
            v = v0 + a * t
            # 移动距离x = v0t + 1/2 * a * t^2
            move = v0 * t + 1 / 2 * a * t * t
            # 当前位移
            current += move
            # 加入轨迹
            track.append(round(move))
        return track
    
    def move_to_gap(self, slider, track):
        """
        拖动滑块到缺口处
        :param slider: 滑块
        :param track: 轨迹
        :return:
        """
        ActionChains(self.browser).click_and_hold(slider).perform()
        for x in track:
            ActionChains(self.browser).move_by_offset(xoffset=x, yoffset=0).perform()
        time.sleep(0.5)
        ActionChains(self.browser).release().perform()
    
    def login(self):
        """
        登录
        :return: None
        """
        submit = self.wait.until(EC.element_to_be_clickable((By.CLASS_NAME, 'login-btn')))
        submit.click()
        time.sleep(10)
        print('登录成功')
    
    def crack(self):
        # 输入用户名密码
        self.open()
        # 点击验证按钮
        button = self.get_geetest_button()
        print(button)
        time.sleep(2)
        ActionChains(self.browser).move_to_element(button).perform()
        time.sleep(2)
        # # 获取验证码图片(没有缺口的图)
        image1 = self.get_geetest_image('captcha1.png')
        # 点按呼出缺口
        slider = self.get_slider()
        slider.click()
        time.sleep(2)
        # 获取带缺口的验证码图片
        image2 = self.get_geetest_image('captcha2.png')
        # 获取缺口位置
        gap = self.get_gap(image1, image2)
        print('缺口位置', gap)
        # 减去缺口位移
        gap -= BORDER
        # 获取移动轨迹
        track = self.get_track(gap)
        print('滑动轨迹', track)
        # 拖动滑块
        self.move_to_gap(slider, track)
        
        # 验证结点里面是否包含此文字
        success = self.wait.until(
            EC.text_to_be_present_in_element((By.CLASS_NAME, 'gt_info_type'), '验证通过'))
        print(success)
        time.sleep(5)
        # 失败后重试
        if not success:
            self.crack()
        # else:
        #     self.login()


if __name__ == '__main__':
    crack = CrackBilibili()
    crack.crack()

```