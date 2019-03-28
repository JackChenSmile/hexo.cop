---
title: Word_cloud
date: 2019-02-13 20:10:50
author: smile
categories: Python
img: /images/33.jpg
tags:
---



### 获取词云的代码

```python
import jieba
import matplotlib.pyplot as plt
from collections import Counter
import jieba.posseg as psg
from scipy.misc import imread
from wordcloud import WordCloud, ImageColorGenerator


artic = open('2.txt', 'r', encoding='utf8').read()
# 取到不需要的字符
r='!.:;\n？“。，……”\u3000：的！,    '
for i in r:
    artic = artic.replace(i, '')
# 生成词组
cut =','.join(jieba.cut(artic))
lcut = jieba.lcut(artic)
# 统计数量
count = Counter(lcut).most_common(20)
print(cut)


path_of_font = './arialuni.ttf'
bg_path = 'C:/Users/Administrator/Pictures/map1.jpg'
bg_img = imread(bg_path)
my_wordcloud = WordCloud(font_path=path_of_font,max_font_size=100,mask=bg_img).generate(cut)
plt.imshow(my_wordcloud)
plt.axis("off")
plt.show()
```

### 效果图：

![Figure_2](Word-cloud\Figure_2.png)

