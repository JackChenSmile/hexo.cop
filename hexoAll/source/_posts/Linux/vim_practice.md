#### practice1_fish

```python
  1 #!/usr/bin/python3
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

#### practice2_joseph

```python
  1 #!/usr/bin/python3
  2 
  3 """约瑟夫环"""
  4 def main():
  5     """主函数"""
  6     persons = [True] * 30
  7     # 设置变量，计数，下标，报数
  8     counter, index, number = 0, 0, 0
  9     #  循环选出15个人
 10     while counter < 15:
 11         if persons[index]:
 12             # 每次数数加一
 13             number += 1
 14             # 数到9的人，弄死
 15             if number == 9:
 16                 # 把它的值变为False
 17                 persons[index] = False
 18                 # 每选出一个人，counter数量加一
 19                 counter += 1
 20                 # 弄死的人，后面人又从0开始数数
 21                 number = 0
 22         # 移动下标
 23         index += 1
 24         # 保证有效的下标
 25         index %= len(persons)
 26     for person in persons:
 27         print("基" if person else "非", end = "")
 28     print()
 29 
 30 
 31 if __name__ == "__main__":
 32     main()
```

####practice3_salary

```python
  1 #!/usr/bin/python3
  2 from abc import ABCMeta, abstractmethod
  3 """
  4 面向对象的程序设计基本步骤：
  5 1. 定义类
  6     - 数据抽象: 找到对象的静态特征-属性(名词)
  7     - 行为抽象: 找到对象的动态特征-方法(动词)
  8 2. 创建对象(隐藏实现细节，暴露简单的调用接口)
  9 3. 给对象发消息
 10 
 11 面向对象的四大支柱：抽象、封装、继承、多态
 12 抽象：定义类的过程就是提取共性的抽象过程
 13 封装：将数据和操作数据方法从逻辑上组成一个整体-对象
 14 继承：从已有的类创建新类的过程
 15     - 提供继承信息的称为父类
 16     - 得到继承信息的称为子类
 17 多态：调用相同的方法做了不同的事情
 18     - 同样的方法在运行时表现出不同行为
 19     - 子类重写父类的方法，不同的子类给出不同的实现版本
 20 """
 21 class Employee(metaclass=ABCMeta):
 22     # metaclass=ABCMeta 原类，让子类不能再创建这个抽象对象，给别人继承
 23 
 24     def __init__(self, name):
 25         self.name = name
 26 
 27     # 装饰器
 28     @abstractmethod
 29     def salary(self):
 30         pass
 31 
 32 
 33 class Manager(Employee):
 34     """经理"""
 35 
 36     @property
 37     def salary(self):
 38         return 15000
 39 
 40 
 41 class Programmer(Employee):
 42     """程序员"""
 43 
 44     def __init__(self, name):
 45         super().__init__(name)
 46         # self.name = name
 47         self.working_hour = 0
 48 
 49     @property
 50     def salary(self):
 51         return 200 * self.working_hour
 52 
 53 
 54 class Salesman(Employee):
 55     """销售员"""
 56 
 57     def __init__(self, name):
 58         self.name = name
 59         self.sales = 0
 60 
 61     @property
 62     def salary(self):
 63         return 1800 + self.sales * 0.05
 64 
 65 
 66 """工资结算"""
 67 def main():
 68     """主函数"""
 69     emps = [
 70         Manager("刘备"), Manager("曹操"),
 71         Programmer("诸葛亮"), Programmer("荀彧"),
 72         Salesman("貂蝉")
 73     ]
 74     for emp in emps:
 75         # isinstance函数可以进行运行时类型识别，判断函数类型
 76         if isinstance(emp, Programmer):
 77             emp.working_hour = int(input(f'请输入{emp.name}本月工作时间: '))
 78         elif isinstance(emp, Salesman):
 79             emp.sales = float(input(f'请输入{emp.name}本月销售额: '))
 80        #print('%s: %.2f元' % (emp.name, emp.salary))
 81         print(f"{emp.name}本月的工资为: {emp.salary}元")
 82 
 83 
 84 if __name__ == "__main__":
 85     main()
```

#### practice_poker

```python
  1 #!/usr/bin/python3
  2 
  3 from enum import Enum, unique
  4 import random
  5 
  6 
  7 # 定义花色的常量(尽量用符号常量代替字面常量)
  8 # 枚举类型是定义符号常量的最佳选择
  9 # @unique 类的装饰器，类里面的变量不能重复，独一无二的
 10 
 11 """花色枚举类，用来定义黑桃、红心、梅花、方块常量"""
 12 @unique
 13 class Suite(Enum):
 14     SPADE = 0
 15     HEART = 1
 16     CLUB = 2
 17     DIAMOND = 3
 18 
 19 
 20 """定义扑克类"""
 21 class Card(object):
 22 
 23     def __init__(self, suite, face):
 24         self.suite = suite
 25         self.face = face
 26 
 27     def show(self):
 28         suites = ["黑", "红", "梅", "方"]
 29         faces = [
 30             "", "A", "2", "3", "4", "5", "6",
 31             "7", "8", "9", "10", "J", "Q", "K"
 32         ]
 33         return f"{suites[self.suite.value]}{faces[self.face]}"
 34     """
 35     # 比较大小
 36     def __lt__(self, other):
 37         if self.suite == other.suite:
 38             return self.face < other.face
 39         return self.suite.value < other.suite.value
 40     """
 41 
 42     # 把对象变成字符串（魔术方法）
 43     def __str__(self):
 44         return self.show()
 45 
 46     # 把对象变成字符串（魔术方法）
 47     def __repr__(self):
 48         return self.show()
 49 
 50 
 51 """牌类"""
 52 class Poker(object):
 53 
 54     def __init__(self):
 55         self.index = 0
 56         # 生成一副牌，生成式
 57         self.cards = [Card(suite, face)
 58                       for suite in Suite
 59                       for face in range(1, 14)
 60         ]
 61 
 62     def shuffle(self):
 63         """洗牌，调用随机乱序的函数"""
 64         random.shuffle(self.cards)
 65 
 66     def deal(self):
 67         """发牌"""
 68         card = self.cards[self.index]
 69         self.index += 1
 70         return card
 71 
 72     @property
 73     def has_more(self):
 74         """判断是否有牌发"""
 75         return self.index < len(self.cards)
 76 
 77 
 78 class Player(object):
 79     """玩家"""
 80 
 81     def __init__(self, name):
 82         self.name = name
 83         self.cards = []
 84 
 85     def get_one(self, card):
 86         """摸一张牌"""
 87         self.cards.append(card)
 88 
 89     # *后面的是命名关键字参数，必须写参数名key
 90     def sort_cards(self, *, key=lambda card:
 91                       (card.suite.value, card.face)):
 92         """ 整理手上的牌"""
 93         self.cards.sort(key=key)
 94 
 95 
 96 def main():
 97     poker = Poker()
 98     poker.shuffle()
 99     players = [
100                Player("东邪"), Player("西毒"), Player("南帝"),
101                Player("北丐")
102     ]
103     for _ in range(13):
104         for player in players:
105             player.get_one(poker.deal())
106     for player in players:
107         player.sort_cards(key=lambda card: card.face)
108         print(player.name, end=": ")
109         print(player.cards)
110 
111 
112 if __name__ == "__main__":
113     main()
```

####  practice_mycal

```python
  1 #!/usr/bin/python3
  2 """
  3 万年历
  4 """
  5 from datetime import datetime
  6 import sys
  7 
  8 
  9 def is_leap(year):
 10     """判断指定年份是否是闰年"""
 11     return year % 4 == 0 and year % 100 != 0 or year % 400 == 0
 12 
 13 
 14 def get_month_days(year, month):
 15     """获得指定的月份的天数"""
 16     days = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
 17     # 修改2月份的天数
 18     if month == 2 and is_leap(year):
 19         days[2] = 29
 20     return days[month]
 21 
 22 
 23 def main():
 24     # 通过sys模块的argv可以获取命令行参数
 25     if len(sys.argv) == 3:
 26         year = int(sys.argv[2])
 27         month = int(sys.argv[1])
 28     else:
 29         # 拿到现在系统的时间和日期
 30         now = datetime.now()
 31         year = now.year
 32         month = now.month
 33     # 拿到年，月小于2，算到上一年
 34     y = year if month > 2 else year - 1
 35     # 拿到月，月小于2，算到13月或者14月
 36     m = month if month > 2 else month + 12
 37     # 取到世纪，年份的前两位数
 38     c = y // 100
 39     # 取到年的后两位
 40     y = y % 100
 41     # 计算每个月1号是星期几
 42     w = y + y // 4 + c // 4 - 2 * c + 26 * (m + 1) // 10
 43     # 对7求余数，0对应星期日
 44     w %= 7
 45     months = [
 46         "", "January", " February", "March", "April", "May", " June",
 47         " July", " August", "September", "October", " November", " December"
 48     ]
 49     print(f"{months[month]} {year}".center(20))
 50     print("Su Mo Tu We Th Fr Sa")
 51     print (" " * 3 * w,end="")
 52     days = get_month_days(year, month)
        # 遍历月份的天数，进行排版
 53     for day in range(1, days + 1):
 54         print(f"{day}".rjust(2), end=" ")
 55         w += 1
 56         if w % 7 == 0:
 57             print()
 58     print()
 59 
 60 
 61 if __name__ == "__main__":
 62     main()
```

