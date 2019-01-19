---
title: kaisha密码
date: 2018-11-01 15:15:06
author: smile
img: /images/KDA3.jpg
categories: spider
tags: 
  - urllib
---

用来破解一些加密文件
```python
import urllib
from urllib import parse

def str2url(s):
    #s = '9hFaF2FF%_Et%m4F4%538t2i%795E%3pF.265E85.%fnF9742Em33e162_36pA.t6661983%x%6%%74%2i2%22735'
    num_loc = s.find('h')
    rows = int(s[0:num_loc])
    strlen = len(s) - num_loc
    cols = int(strlen/rows)
    right_rows = strlen % rows
    new_s = list(s[num_loc:])
    output = ''
    for i in range(len(new_s)):
        x = i % rows
        y = i / rows
        p = 0
        if x <= right_rows:
            p = x * (cols + 1) + y
        else:
            p = right_rows * (cols + 1) + (x - right_rows) * cols + y
        output += new_s[int(p)]
    return parse.unquote(output).replace('^', '0')


def main():
    s = "6hAFxn752E5F215234uy495-3741E8t%mie15F2E185E%6at%72E%7ba%13t21at27261734458%h3%%-5a885d5pF2m%%11799662E13_D55%E992E48%%8i222%4%59358.Fk1EE5-8bc%7632..FF%5%24_%9_mae58%E513e51"
    result_str = str2url(s)
    print(result_str)

main()

```