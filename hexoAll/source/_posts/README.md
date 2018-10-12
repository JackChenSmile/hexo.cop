## Python1806

### 第6周第1天

1. 前端页面 = 标签(内容) + CSS(显示) + JavaScript(行为)
2. JavaScript = ECMAScript + BOM(window) + DOM(document)
3. window 
	- alert() / prompt() / confirm() / close()
	- setInterval() / setTimeout() / clearInterval() / clearTimeout()
4. document
	- getElementById() / getElementsByTagName() / getElementsByClassName()
	- querySelector() / querySelectorAll()
5. HTMLElement
	- textContent / innerHTML
6. 其他知识
	- Date: getFullYear() / getMonth() / getDate() / getDay()
	- Math: Math.random()
	- parseInt() / parseFloat()
 
### 第6周第2天

1. JavaScript中的事件处理
	- 在标签上使用onXXX属性来进行事件绑定
	- 通过代码获取标签绑定onXXX属性
	- 通过代码获取标签然后使用addEventListener()绑定事件
	  使用removeEventListener()反绑定事件
	  这里有浏览器兼容性问题 对于低版本IE要使用
	  attachEvent() / detachEvent()
2. 事件回调函数和事件对象
	- 绑定事件监听器的函数都需要传入事件的回调函数
	- 程序员知道事件发生的时候需要做什么样的处理但是不知道事件什么时候发生
	- 所以传入一个函数在将来发生事件的时候由系统进行调用 这种函数就称为回调函数
	- 回调函数的第一个参数代表事件对象（封装了和事件相关的所有信息）对于低版本IE
	- 可以通过window.event来获取事件对象
	- 事件对象的属性和方法：
		- target / srcElement - 事件源（引发事件的标签）
		- preventDefault() / returnValue=false - 阻止事件的默认行为
		- 处理事件有两种顺序：事件冒泡（默认，从内向外）/ 事件捕获（从外向内）
		- 如果要阻止事件的传播行为（例如阻止事件冒泡）可以使用
		  stopPropagation() / cancelBubble=true

### 第6周第3天

### 第6周第4天

### 第6周第5天