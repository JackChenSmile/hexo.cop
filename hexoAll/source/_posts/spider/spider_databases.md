---
title: 展示数据
date: 2018-05-27 15:15:06
author: smile
img: /images/AKL.jpg
categories: spider
tags: 
  - databases
---

### 创建一个有个youyaoqi项目
- 项目自带文件
  -  scrapy.cfg
  -  youyaoqi
     - __ init__.py
     - items.py
     - middlewares.py
     - pipelines.py
     - settings.py
     - spiders
       - __ init __.py
       - cartoon.py

**items**
```python
# -*- coding: utf-8 -*-

# Define here the models for your scraped items
#
# See documentation in:
# https://doc.scrapy.org/en/latest/topics/items.html

import scrapy


class YouyaoqiItem(scrapy.Item):
    # define the fields for your item here like:
    comic_id = scrapy.Field()
    name = scrapy.Field()
    cover = scrapy.Field()
    update_type = scrapy.Field()
    line1 = scrapy.Field()
    line2 = scrapy.Field()


class U17DetailItem(scrapy.Item):
    name = scrapy.Field()
    # u_id = scrapy.Field()

```

**pipelines.py**
```python
# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://doc.scrapy.org/en/latest/topics/item-pipeline.html
import pymysql
from scrapy import Request
from scrapy.exceptions import DropItem
from scrapy.pipelines.images import ImagesPipeline


class ImagePipeline(ImagesPipeline):
    def file_path(self, request, response=None, info=None):
        url = request.url
        file_name = url.split('/')[-1]
        return file_name

    def item_completed(self, results, item, info):
        image_paths = [x['path'] for ok, x in results if ok]
        if not image_paths:
            raise DropItem('Image Downloaded Failed')
        return item

    def get_media_requests(self, item, info):
        yield Request(item['cover'])


class YouyaoqiMysqlPipeline(object):
    def __init__(self, host, port, database, username, password):
        self.host = host
        self.port = port
        self.database = database
        self.username = username
        self.password = password

    @classmethod
    def from_crawler(cls, crawler):
        return cls(
            host=crawler.settings.get('MYSQL_HOST'),
            port=crawler.settings.get('MYSQL_PORT'),
            database=crawler.settings.get('MYSQL_DATABASE'),
            username=crawler.settings.get('MYSQL_USERNAME'),
            password=crawler.settings.get('MYSQL_PASSWORD'),
        )

    def open_spider(self, spider):
        # 获取数据库连接
        self.db = pymysql.connect(self.host, self.username, self.password, self.database, charset='utf8',
                                  port=self.port)
        self.cursor = self.db.cursor()

    def close_spider(self, spider):
        # 释放数据库连接
        self.db.close()

    def process_item(self, item, spider):
        # 插入item数据
        sql = 'insert into company (comic_id, name, cover, update_type, line1, line2) values (%s, %s, %s, %s, %s, %s)'
        self.cursor.execute(sql, (item['comic_id'], item['name'], item['cover'], item['update_type'], item['line1'], item['line2']))
        self.db.commit()

        return item

```

**settings.py**
```python
# -*- coding: utf-8 -*-

# Scrapy settings for youyaoqi project
#
# For simplicity, this file contains only settings considered important or
# commonly used. You can find more settings consulting the documentation:
#
#     https://doc.scrapy.org/en/latest/topics/settings.html
#     https://doc.scrapy.org/en/latest/topics/downloader-middleware.html
#     https://doc.scrapy.org/en/latest/topics/spider-middleware.html

BOT_NAME = 'youyaoqi'

SPIDER_MODULES = ['youyaoqi.spiders']
NEWSPIDER_MODULE = 'youyaoqi.spiders'


# Crawl responsibly by identifying yourself (and your website) on the user-agent
#USER_AGENT = 'youyaoqi (+http://www.yourdomain.com)'

# Obey robots.txt rules
ROBOTSTXT_OBEY = False

# Configure maximum concurrent requests performed by Scrapy (default: 16)
#CONCURRENT_REQUESTS = 32

# Configure a delay for requests for the same website (default: 0)
# See https://doc.scrapy.org/en/latest/topics/settings.html#download-delay
# See also autothrottle settings and docs
#DOWNLOAD_DELAY = 3
# The download delay setting will honor only one of:
#CONCURRENT_REQUESTS_PER_DOMAIN = 16
#CONCURRENT_REQUESTS_PER_IP = 16

# Disable cookies (enabled by default)
#COOKIES_ENABLED = False

# Disable Telnet Console (enabled by default)
#TELNETCONSOLE_ENABLED = False

# Override the default request headers:
#DEFAULT_REQUEST_HEADERS = {
#   'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
#   'Accept-Language': 'en',
#}

# Enable or disable spider middlewares
# See https://doc.scrapy.org/en/latest/topics/spider-middleware.html
#SPIDER_MIDDLEWARES = {
#    'youyaoqi.middlewares.YouyaoqiSpiderMiddleware': 543,
#}

# Enable or disable downloader middlewares
# See https://doc.scrapy.org/en/latest/topics/downloader-middleware.html
#DOWNLOADER_MIDDLEWARES = {
#    'youyaoqi.middlewares.YouyaoqiDownloaderMiddleware': 543,
#}

# Enable or disable extensions
# See https://doc.scrapy.org/en/latest/topics/extensions.html
#EXTENSIONS = {
#    'scrapy.extensions.telnet.TelnetConsole': None,
#}

# Configure item pipelines
# See https://doc.scrapy.org/en/latest/topics/item-pipeline.html
ITEM_PIPELINES = {
   # 'youyaoqi.pipelines.YouyaoqiMysqlPipeline': 300,
   # 'youyaoqi.pipelines.ImagePipeline': 300,
}

# Enable and configure the AutoThrottle extension (disabled by default)
# See https://doc.scrapy.org/en/latest/topics/autothrottle.html
#AUTOTHROTTLE_ENABLED = True
# The initial download delay
#AUTOTHROTTLE_START_DELAY = 5
# The maximum download delay to be set in case of high latencies
#AUTOTHROTTLE_MAX_DELAY = 60
# The average number of requests Scrapy should be sending in parallel to
# each remote server
#AUTOTHROTTLE_TARGET_CONCURRENCY = 1.0
# Enable showing throttling stats for every response received:
#AUTOTHROTTLE_DEBUG = False

# Enable and configure HTTP caching (disabled by default)
# See https://doc.scrapy.org/en/latest/topics/downloader-middleware.html#httpcache-middleware-settings
#HTTPCACHE_ENABLED = True
#HTTPCACHE_EXPIRATION_SECS = 0
#HTTPCACHE_DIR = 'httpcache'
#HTTPCACHE_IGNORE_HTTP_CODES = []
#HTTPCACHE_STORAGE = 'scrapy.extensions.httpcache.FilesystemCacheStorage'
FEED_EXPORT_ENCODING = 'utf-8'
MAX_PAGE = 500

# IMAGES_STORE = './images'

# mysql settings
MYSQL_HOST = '127.0.0.1'
MYSQL_PORT = 3306
MYSQL_USERNAME = 'root'
MYSQL_PASSWORD = '123456'
MYSQL_DATABASE = 'u17'

```

**cartoon.py**
```python
# -*- coding: utf-8 -*-
import json
import scrapy
from youyaoqi.items import YouyaoqiItem, U17DetailItem


class CartoonSpider(scrapy.Spider):
    name = 'cartoon'
    allowed_domains = ['www.u17.com']
    start_urls = ['http://www.u17.com/']

    def start_requests(self):
        data = {'data[group_id]': 'no', 'data[theme_id]': 'no', 'data[is_vip]': 'no', 'data[accredit]': 'no', 'data[color]': 'no', 'data[comic_type]': 'no', 'data[series_status]': 'no', 'data[order]': '2', 'data[page_num]': '1', 'data[read_mode]': 'no' }
        headers = {
            'Referer': 'http://www.u17.com/comic_list/th99_gr99_ca99_ss99_ob0_ac0_as0_wm0_co99_ct99_p1.html?order=2',
            'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; Trident/7.0; rv:11.0) like Gecko',
            'Host': 'www.u17.com',
            'Accept': 'application/json, text/plain, */*',
            'Accept-Encoding': 'gzip, deflate, sdch',
            'Accept-Language': 'zh-CN,zh;q=0.8,en;q=0.6,ja;q=0.4,zh-TW;q=0.2,mt;q=0.2',
            'Connection': 'keep-alive',
            'X-Requested-With': 'XMLHttpRequest',
        }
        max_page = self.settings.get('MAX_PAGE')
        base_url = 'http://www.u17.com/comic/ajax.php?mod=comic_list&act=comic_list_new_fun&a=get_comic_list'
        for page in range(2, max_page):
            data['data[page_num]'] = str(page)
            yield scrapy.FormRequest(url=base_url, headers=headers, method='POST', formdata=data, callback=self.parse)

    def get_headers(self):
        headers = {
            'User-Agent': 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; 360SE)',
            'Host': 'www.u17.com',
            'Accept': 'application/json, text/plain, */*',
            'Accept-Encoding': 'gzip, deflate, sdch',
            'Accept-Language': 'zh-CN,zh;q=0.8,en;q=0.6,ja;q=0.4,zh-TW;q=0.2,mt;q=0.2',
            'Connection': 'keep-alive',
            'X-Requested-With': 'XMLHttpRequest',
            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        }
        return headers

    def parse(self, response):
        result_json = json.loads(response.text)
        data_list = result_json['comic_list']
        for data in data_list:
            item = YouyaoqiItem()
            item['comic_id'] = data['comic_id']
            item['name'] = data['name']
            item['cover'] = data['cover']
            item['update_type'] = data['update_type']
            item['line1'] = data['line1']
            item['line2'] = data['line2']
            yield item

            detail_url = 'http://www.u17.com/comic/%s.html' % item['comic_id']
            yield scrapy.Request(url=detail_url, headers=self.get_headers(), callback=self.parse_detail)

    def parse_detail(self, response):
        results = response.css('#chapter li')
        for item in results:
            detail_item = U17DetailItem()
            name_list = item.xpath('./a/text()').extract()
            for name in name_list:
                detail_item['name'] = name.replace('"', '').strip()
            # detail_item['u_id'] = title.replace
            # detail_item['name'] = item.replace('"', '').strip()
                yield detail_item
            # a_url_list = item.css('./a::attr(href)').extract()
            # for a_url in a_url_list:
            #     detail_item['url'] = a_url
            #     yield detail_item

```

