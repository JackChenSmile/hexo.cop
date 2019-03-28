---
title: practice——jd
date: 2018-05-11 15:15:06
author: smile
img: /images/LoL.jpg
categories: spider
tags: 
  - sqlalchemy
---

数据库字段创建
```python
create database jddb default character set=utf8;

use jddb;

create table jd (
    id integer auto_increment primary key,
    title varchar(128),
    img_src varchar(1024),
    price varchar(128),
    shop varchar(128),
    commit_num varchar(100)
);
```

模型设置
```python
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, Integer, String
from sqlalchemy import create_engine

engine = create_engine("mysql+pymysql://root:123456@127.0.0.1:3306/jd_db?charset=utf8", max_overflow=5,encoding='utf-8')
Base = declarative_base()

class JdProduct(Base):
    __tablename__ = 'jd'
    id = Column(Integer, primary_key=True, autoincrement=True)    #主键，自增
    title = Column(String(128))
    img_src = Column(String(1024))
    price = Column(String(128))
    shop = Column(String(128))
    commit_num = Column(String(100))

```

运行程序
```python
import time
from lxml import etree
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from jd_model import JdProduct


engine = create_engine("mysql+pymysql://root:123456@127.0.0.1/jddb?charset=utf8", max_overflow=5)
session_maker = sessionmaker(bind=engine)
session = session_maker()


# 打开一个浏览器
browser = webdriver.Chrome()
wait = WebDriverWait(browser, 5)

def get_page(page):
    if page == 1:
        url = "http://www.jd.com"
        # 访问网址
        browser.get(url)
        # 注意下面的presence_of_element_located，容易出错
        input = wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, '#key')))
        input.clear()
        input.send_keys('围巾女')
        button = wait.until(EC.element_to_be_clickable((By.CSS_SELECTOR, '#search button.button')))
        button.click()

        time.sleep(3)

    # 滑动到页面底部,滑动指定次数
    # for i in range(16):
    #     i = i + 1
    #     str_js = 'var scrollHeight = document.body.scrollHeight / 16;window.scrollTo(0, scrollHeight * (%d));' % i
    #     browser.execute_script(str_js)
    #     time.sleep(1)

    str_js = 'var scrollHeight = document.body.scrollHeight;window.scrollTo(0, scrollHeight);'
    browser.execute_script(str_js)

    # 反向滑动
    for i in range(16, 0, -1):
        str_js = 'var scrollHeight = document.body.scrollHeight / 16;window.scrollTo(0, scrollHeight * (%d));' % i
        browser.execute_script(str_js)
        time.sleep(5)

    # 保存当前页面的内容
    page_source = browser.page_source

    # 下一页
    # 滚动到页码部分
    input = browser.find_element_by_css_selector('#J_bottomPage input.input-txt')

    str_js = 'var scrollHeight = document.body.scrollHeight;window.scrollTo(0, %d);' % (input.location['y'] - 50)
    browser.execute_script(str_js)
    time.sleep(3)

    input = wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, '#J_bottomPage input.input-txt')))
    input.clear()
    input.send_keys(page + 1)

    # 点击下一页
    submit = wait.until(
        EC.element_to_be_clickable((By.CSS_SELECTOR, '#J_bottomPage .btn-default'))
    )
    submit.click()
    time.sleep(3)

    return page_source

def parse_page(html):
    ehtml = etree.HTML(html)
    gl_items = ehtml.xpath('//div[@id="J_goodsList"]//li[@class="gl-item"]')
    print(len(gl_items))
    for gl_item in gl_items:
        jd = JdProduct()
        img_src = ''.join(gl_item.xpath('.//div[@class="p-img"]/a/img/@src'))
        title =  ''.join(gl_item.xpath('.//div[@class="p-name p-name-type-2"]//em//text()'))
        price = gl_item.xpath('.//div[@class="p-price"]//strong/i/text()')
        shop = gl_item.xpath('.//div[@class="p-shop"]//span/a/text()')
        commit_num = gl_item.xpath('.//div[@class="p-commit"]//strong/a//text()')
        jd.title = title
        jd.img_src = img_src
        jd.price = price
        jd.shop = shop
        jd.commit_num = commit_num
        try:
            session.add(jd)
            session.commit()
        except Exception as e:
            pass

def main():
    for page in range(100):
        page = page + 1
        print(page)
        html = get_page(page)
        parse_page(html)

if __name__ == '__main__':
    main()

```