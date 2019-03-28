---
title: Linux_vim
date: 2018-06-03 20:26:10
author: smile
categories: Linux
tags:
  - vim-practice
---

###  分鱼

```python
#!/usr/bin/python3
  2 
  3 """
  4 穷举法:穷尽所有可能直到找到正确答案
  5 """
  6 def main():
  7     """分鱼"""
  8     fish = 1
  9     while True:
 10         enough = True
 11         total = fish
 12         for _ in range(5):
 13             if (total - 1) % 5 == 0:
 14                 total = (total - 1) // 5 *4
 15             else:
 16                 enough = False
 17                 break
 18         if enough:
 19             print(fish)
 20             break
 21         fish += 1
 22 
 23 
 24 if __name__ == "__main__":
 25     main()
```

 ###  穷举法

```python
  1 #!/usr/bin/python3
  2 
  3 """穷举法"""
  4 def main():
  5     """主函数"""
  6     for cock in range(0, 21):
  7         for hen in range(0, 34):
  8             chick = 100 - cock - hen
  9             if chick % 3 == 0 and cock * 5 + hen * 3 + chick // 3 == 100:
 10                 print(f"公鸡: {cock}只, 母鸡: {hen}只, 小鸡: {chick}只")
 11 
 12 
 13 if __name__ == "__main__":
 14     main()
```

