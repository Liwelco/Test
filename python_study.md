

# 数据类型

```
# 数据类型总结：
# 可变数据类型
#     列表、字典、可变集合
# 不可变数据类型
#     数字、字符串、元组、不可变集合
#
# 可迭代的数据
#     可以通过类似于下标的方式获取某一部分数据
#     字符串、列表、元组、字典、bytes、集合
#     for 变量 in 可迭代对象：
#
# 不可迭代的数据
#     数字
```

#  文件IO操作

## 1、读取模式

### 1）read(n)

```python
	file_name=r"F:\study\python\python\1.txt"
		f_obj=open(file_name,mode="r")
         print(f_obj)
         data=f_obj.read(3)
		data_02=f_obj.read(2)
		print(data)
		print(data_02)
		f_obj.close()
```

###  2）readline()

``` python		
		file_name=r"F:\study\python\python\1.txt"
		f_obj=open(file_name,mode="r")
		line=f_obj.readline()
		line_two=f_obj.readline()
		print(line_two)
		print(line)
		f_obj.close()
```

### 3) readlines()

``` python
		file_name=r"F:\study\python\python\1.txt"
		f_obj=open(file_name,mode="r")
		data=f_obj.readlines()
		print(data)
		f_obj.close()
```

##  2、rb模式

``` python
	file_name=r"F:\study\python\python\1.txt"
	f_obj=open(file_name,mode="rb")
	data=f_obj.read()
	print(data)
	print(type(data))
	f_obj.close()
```

### 1) seek(offset,whence)

>		0：将光标移动到文件最开始处
>		1：保持光标当前位置不变
>		2：将光标移动到文件结尾处

``` python
			file_name=r"F:\study\python\python\1.txt"
			f_obj=open(file_name,mode="rb")
			data=f_obj.read()
			print(f_obj.tell())
			f_obj.seek(-3,2)
			print(f_obj.tell())
			new_data=f_obj.read()
			print(data)
			print(new_data)
			f_obj.close()
```

## 2、写入模式

###	w,wb

``` python
		file_name=r"F:\study\python\python\2.txt"
		f_obj=open(file_name,mode="w")
		f_obj.write("python\n")
		f_obj.write("golang\n")
		f_obj.flush()
		f_obj.close()
```
###	文件对象.flush()
		将内存中的数据同步到硬盘

## 3、读写模式 r+
	注意：替换操作
``` python
	file_name=r"F:\study\python\python\2.txt"
		file_name=r"F:\study\python\python\2.txt"
		f_obj=open(file_name,mode="r+")
		data=f_obj.read()
		print(data)
		f_obj.write("\nDjango\n")
		f_obj.close()
```

## 4、追加模式 
	a #文件末尾追加
``` python
		file_name=r"F:\study\python\python\2.txt"
		f_obj=open(file_name,mode="a")
		f_obj.write("\nDjango\n")
		f_obj.seek(0,0)
		f_obj.write("abc")
		f_obj.close()
```

## 案列一：分析web服务器UV次数

```python
log_file=r"F:\study\python\python\access_log"
ip_list=[] #定义列表
f_obj=open(log_file,mode="r")
for line in f_obj:
    clientIP=line.split()[0]
    ip_list.append(clientIP) #在后面增加ip
f_obj.close()
print(ip_list)
#定义字典 {"ip":次数}
ip_count={}
for ip in ip_list:
    if ip not in ip_count.keys():
        ip_count[ip]=1
    else:
        ip_count[ip]=ip_count[ip]+1
print(ip_count)
#格式化输出
for k,v in ip_count.items():
    print("IP地址:%s,次数:%s" %(k,v))
```

## 案例二：跟踪日志的输入，将带有error的信息的日志保存到新的文件  

```python
import time
log_file=r"F:\study\python\python\venv\test.log"
log_file1=r"F:\study\python\python\venv\test1.log"
f_obj1=open(log_file1,mode="w")
#获取文件最后的光标位置
f_obj=open(log_file,mode="rb")
f_obj.seek(0,2)
old_position=f_obj.tell()
print()
#循环，移动光标，判断文件的新内容，获取文件新内容
while True:
    f_obj.seek(0,2)
    new_position=f_obj.tell()
    #判断日志多出内容
    if new_position > old_position:
        offset = old_position - new_position
        f_obj.seek(offset,2)
        line=f_obj.read()
        print(line)
    #将带有error的行保存到新文件
        if "error" in line:
            f_obj1.write(str(line)+"\n")
            f_obj1.flush()
    old_position=new_position
 time.sleep(0.5)
```



## 5、with

>```
>with open(file,mode) as obj_f:
>    文件读写操作
>```

```python
file=xxx
with open(file,mode="r") as obj_f:
    for line in f_obj:
        print(line.upper())
print(f_obj.closed)
```

# 正则表达式 /Regex

### 定义

> 由一类特殊字符（元字符）组成的表达式，通过表达式可以匹配一类具有相同特征的文本

> 作用：
>
> 1、匹配数据
>
> 2、验证数据

常用的元字符：

### 1、匹配单个字符的元字符

> .  匹配除换行符之外的任意单个字符
>
> \d  匹配单个数字 \D
>
> \w 匹配任意单个数字、字符、下划线 反之-\W
>
> \s 匹配任意单个空白字符  反之-\S
>
> [art] [a-z] [A-Z] [0-9] [a-zA-Z0-9]

### 2、匹配字符出现的位置

> ^string

> string$

> \b

> \btest\b

### 3、匹配字符出现的次数

> *匹配前一个字符出现任意次

> + 匹配前一个字符至少出现一次

> ? 匹配前一个 最多出现一次
>
> ｛3｝匹配前一个精确出现三次 ｛3,5｝最少3次，最多五次

### ？的作用

> 1）字符出现的次数

> 2）？出现在一个表达次数的元字符后，非贪婪模式进行匹配

> *？ +？ ｛3｝？

> 匹配方式：

> 贪婪模式，默认，按照最长的方式进行匹配

> 非贪婪模式，按照最短的方式进行匹配

### 4、分组()

> (ab)+

### 案例一  用到了d..o,D{3},\s

```python
import re
test_str="this is python demo regex dlko"
test_re=r"d..o"
test_re_02=r"\s\D{4}"
result=re.search(test_re,test_str)
result_02=re.search(test_re_02,test_str)
print(result)
print(result.group())
print(result.groups())  #以元组的的方式返回数据
print(result.groupdict())
print(result_02)
```



### 案例二  

```python
import re
line="-][-][-][api.uwork.woa.com][-][/open_api/logic][http][404][-][ 11.177.127.208 ][-][ 10.132.58.238 ][375]"
ip_re=r"[[a-z]+.[a-z]+.[a-z]+.[a-z]+?]"
dom=r"[a-z]+.[a-z]+.[a-z]+.[a-z]+"
all=r"([[a-z]+.[a-z]+.[a-z]+.[a-z]+?\]\s\S\s\bhttp\b\s\S\s(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})"
result=re.search(ip_re,line)
result1=re.search(dom,line)
print(result)
print(result1)
print(result1.groups())
print(type(result1.groups()))
```

> <re.Match object; span=(8, 27), match='[api.uwork.woa.com]'>
>
> <re.Match object; span=(9, 26), match='api.uwork.woa.com'>
>
> <re.Match object; span=(8, 27), match='[api.uwork.woa.com]'>

​			

### 案例三 groups  

```python
import re
line="[api.uwork.woa.com] - http - 11.177.127.208"
ip_re=r"(\bhttp\b)\s\S\s(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})"
dom=r"([[a-z]+.[a-z]+.[a-z]+.[a-z]+?\])"
result=re.search(ip_re,line)
result1=re.search(dom,line)
print(result.groups())
print(result)
print(result1)
```

### 案例四 groupdict   ?P<>

```python
import re
line="[api.uwork.woa.com] - http - 11.177.127.208"
ip_re=r"(?P<type>\bhttp\b)\s\S\s(?P<client_IP>\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})"
dom=r"([[a-z]+.[a-z]+.[a-z]+.[a-z]+?\])"
result=re.search(ip_re,line)
result1=re.search(dom,line)
# print(result.groups())
print(result.groupdict())
print(result)
print(result1)
#groupdict() 正则表达式中有分组是，且分组定义了组名{"组名":"分组匹配数据"}，定义组名
```

### match

```python
import re
test_str="python demo regex"
test_re=r"python"
result=re.match(test_re,test_str)
print(result)
```

### findall  列表返回多个对象

```python
import re
test_str="python demo regex demo"
test_re=r"demo"
result=re.findall(test_re,test_str)
print(result)  #以列表的形式返回
```

### split \s{3,}为分隔符

```python
import re

login="root     pts/0        2022-06-23 15:47 (113.108.77.50)"
print(login.split())
test_re=r"\s{2,}"
result=re.split(test_re,login)
print(result)
```

### sub

```python
import re
url_list=["http://192.168.96.1/1.jpg","http://192.168.96.3/1.php"]
ip_regex=r"\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}"
for url in url_list:
    new_url=re.sub(ip_regex,"labatt.com",url)
    print(new_url)
url_list[0]="Labatt.com"
print(url_list)

```

### 案例四

```python
import re
web_log=r"F:\study\python\python\venv\access.log.2"
ip_regex=r"\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}"
f_obj=open(web_log,mode="r")
ip_list=[]
for line in f_obj:
    result=re.search(ip_regex,line)
    # print(result)
    if result:
        client_ip=result.group()
        # print(client_ip)
        ip_list.append(client_ip)
f_obj.close()
ip_count={}
# print(ip_list)
for ip in  ip_list:
    if ip not in ip_count.keys():
        ip_count[ip]=1
    else:
        ip_count[ip]=ip_count[ip]+1
print(ip_count)
#格式化输出
for k,v in ip_count.items():
    print("IP地址:%s,次数:%s" %(k,v))
```

### compile方法

```python
#处理大文件，推荐使用
import re
test_re=r"d..o"
data="python demo"
obj=re.compile(test_re)
result=obj.search(data)
print(result)
```

# 文件目录处理

### os模块

```python
import os
os.chdir("F:\stduy") #切换目录
print(os.getcwd()) #查看当前路径
print(os.listdir(("F:\study"))) #查看当前目录文件
os.rename(r"F:\study\python\python\venv\Scripts\1.txt",r"F:\study\python\python\venv\Scripts\new1.txt")
os.mkdir(r"F:\study\newdir")
os.makedirs(r"F:\study\newdir")
os.remove(r"F:\study\new.py") #删除目录
os.rmdir(r"F:\study\newdir")
for i in os.walk(r"F:\study"):
    print(i) #递归获取目录下的文件，输出元组

```

### 案例一 walk 目录下文件的绝对路径

```python
import os
directory=r"F:\study"
for dir_name,sub_dir_list,file_name_list in os.walk(directory):
    if len(file_name_list)>0:
        for f_name in file_name_list:
            full_file_name=dir_name+"\\"+f_name
            print(full_file_name)
```

### 案例二 rename

```python
import os
directory=r"F:\study"
for dir_name,sub_dir_list,file_name_list in os.walk(directory):
    if len(file_name_list)>0:
        for f_name in file_name_list:
            full_file_name=dir_name+"\\"+f_name
            if full_file_name.endswith("txt"):
                old_file_name=full_file_name.split(".")[0]
                new_file_name=old_file_name+".jpg"
                os.rename(full_file_name,new_file_name)
                print(new_file_name)
```

### os.path.

```python
import os
print(os.path.exists(r"F:\study"))
print(os.path.dirname(r"F:\study\python\python\venv\Scripts\pip.exe"))
print(os.path.basename(r"F:\study\python\python\venv\Scripts\pip.exe"))
print(os.path.isfile(r"F:\study\python\python\venv\Scripts\pip.exe")) #isdir islink ismount
print(os.path.join("/etc""/fstab"))
```

### 调用shell两种方法

```python
os.popen
result=os.popen("ping baidu.com")
print(result)
print(result.read())
```

```python
#win_null_file,linux:/dev/null
import subprocess
result=subprocess.call("ping  baidu.com",shell=True,stdout=open("win_null_file","w"))
print(result)
```

### shutil-copy/remtree

```python
import shutil
shutil.copy(r"F:\study\python\python\venv\Scripts\pip.exe",r"F:\study\python")
shutil.rmtree(r"F:\study\python")
```

### tarfile-打包

```python
import tarfile
#.tar,.tar.gz,tar.bz2
tar_file_name=r"F:\study\python\python\venv\Scripts\test.tar.gz"
tar_obj=tarfile.open(name=tar_file_name,mode="w:gz")
tar_obj.add(r"F:\study\python\python\python流程控制-实验手册.pdf")
tar_obj.close()
```

### hashlib-md5

```python
data=b"python md5 demo"
import hashlib
#file md5 校验
md5_obj=hashlib.md5()
md5_obj.update(data)
print(md5_obj.hexdigest())
#大文件
import hashlib
#file md5 校验
md5_obj=hashlib.md5()
filename=r"F:\study\python\python\venv\Scripts\new1.txt"
f_obj=open(file_name,mode="rb")
while True:
    data=f_obj.read(5096)
    if not data:
        break
    md5_obj.update(data)
f_obj.close()
print(md5_obj.hexdigest())
```

### pickle-数据持久化保存

```python
import pickle
file_name=r"F:\study\python\python\venv\Scripts\new1.txt"
f_obj=open(file_name,"wb")
pickle.dump(data,f_obj)
f_obj.close()
```

# 异常捕获

## 语法

```python
> 异常捕获 exception
> 异常：NameError,ValueError,IOError,IndexError,FileExistsError,KeyError
> 作用：使用自己的操作 print，代替程序本身的报错
> try:
>     keyword
> except 异常名称 [as e]:
>     代码
>     代码
> except 异常名称 [as e]:
>     代码
>     代码
> finally:
>     代码
```

## 案例

```python
import sys
data={"name":"Labatt","password":"123123","level":100}
choice=input(">>>")
try:
    result=data[choice]
except KeyError:
    print("key not exeis!")
    sys.exit()
print(result)
#######################################################################
import sys
file_name=input("file name>>> ")
file_mode=input("file mode>>> ")
try:
    f_obj=open(file_name,file_mode)
except FileNotFoundError:
    print("FileNotFoundError")
    sys.exit()
except ValueError:
    print("ValueError")
    sys.exit()
data=f_obj.read()
print(f"文件内容: {data}")
```

# 函数

## 语法

作用：用于提升代码的重要性

def 函数名称():

​	执行的代码

函数名称规范

不能关键字

## 案例一 随机数生成

```python
import string
import random
all_char=string.ascii_letters + string.digits + string.punctuation
def genString():
    data=""
    for i in range(10):
        data=random.choice(all_char)+data
    print(data)
genString()
```

## 案例二 函数本质

```python
####内存中开辟一段空间，保存函数代码########
def fun01():
    print("execute fun01")
    fun02()
def fun02():
    print("execute fun02")
fun01()
```

## 模块

> 本质就是.py的文件
>
> 模块提供的方法本质是定义好的函数
>
> 调用

```python
别名
import string as str

import stduy
one.genString()
```

```python
#条件判断
if __name__=="__main__":
    genString()
print(__name__)

from 路径 import study
one.genString()
```



模块类型

​	1、内置模块

​	2、第三方模块

## 包

本质就是一个目录

运维平台 

\__init__.py用于标识包

​	用户管理 *.py  

​	服务器管理 *.py

​	文件管理 *.py

包的作用：在同一个项目中相互引用

```python
from usermanager import users
users.dbCONE()


from usermanager.users import dbCONE

users.dbCONE()
```

## 函数的参数

作用：增加函数功能的灵活性

```python
#n为形参，5为实参
import string
import random
all_char=string.ascii_letters + string.digits + string.punctuation
def genString(n):
    data=""
    for i in range(n): #n为循环的次数
        data=random.choice(all_char)+data
    print(data)
if __name__=="__main__":
    genString(5)
```

```python
import os
def getFile(directory):
    for dir_name,sub_dir_list,file_name_list in os.walk(directory):
        if len(file_name_list)>0:
            for f_name in file_name_list:
                full_name=dir_name+"\\"+f_name
                print(full_name)
getFile(r"F:\study\python\python\venv\Lib")
```

```python
def fileMD5(filename):
md5_obj=hashlib.md5()
f_obj=open(file_name,mode="rb")
while True:
    data=f_obj.read(5096)
    if not data:
        break
    md5_obj.update(data)
f_obj.close()
print(md5_obj.hexdigest())
fileMDr(filename)
```

## 函数参数的类型

> 1、位置参数
>
> 用户调用参数时，必须要为参数传值
>
> 2、默认参数 
>
> ```python
> def sshconn(ip_adress,port=22):
>     print("ssh root@%s -p %s" % (ip_adress,port))
> if __name__ == '__main__':
>     sshconn("10.10.10.1") #使用默认值
>     sshconn("10.10.10.1",60000) #使用传参
> ```
>
> 3、关键字参数
>
> 关键字参数支持通过明确指定形参名称的方式进行传值
>
> ```python
> def dbcon(ip,username,passwd):
>     print("mysql -u %s -p %s -h %s" %(username,passwd,ip))
> if __name__ == '__main__':
>     dbcon("10.1.1.1","Labatt","redhat")
>     dbcon(username="Labatt",ip="10.1.1.1",passwd="redhat")
> ```
>
> 4、可变长参数
>
> > a、支持以元组的方式接收任意个参数
> >
> > ```python
> > def fun01(*args):
> >     print(type(args))
> >     print(args)
> > if __name__ == '__main__':
> >     fun01()
> >     fun01("web","nginx","IIS")
> >     
> > #多个服务器地址
> > def installAPP(*args):
> >     for ip in args:
> >         print("ssh root@%s yum install gcc" % ip)
> > if __name__ == '__main__':
> >     installAPP("10.1.1.1","10.1.1.2","10.1.1.3")
> >  
> > def installAPP(*args):
> >     for ip in args:
> >         print("ssh root@%s yum install gcc" % ip)
> > if __name__ == '__main__':
> >     ips=("10.1.1.1","10.1.1.2","10.1.1.3")
> >     installAPP(*ips)
> > ```
> >
> > b、支持以字典的方式接受任意个参数
> >
> > ```python
> > def fun01(**kwargs):
> >     print(type(kwargs))
> >     print(kwargs)
> > if __name__ == '__main__':
> > #    fun01({"a": 20, "b": 30, "c": 40}) 
> >     fun01(a= 20, b= 30, c= 4)
> > #####output##############
> > <class 'dict'>
> > {'a': 20, 'b': 30, 'c': 4}
> > ```
> >
> > ```python
> > #结合使用
> > def fun01(*args,**kwargs):
> >     print(args)
> >     print(kwargs)
> > if __name__ == '__main__':
> > #    fun01({"a": 20, "b": 30, "c": 40})
> >     fun01("10.1.1.1","10.1.1.2","10.1.1.3",username="root", password="redhat",port=22)
> >     fun01()
> > ```

## 函数的返回值

> 函数的返回值 return 接收数据
>
> 作用：接收函数的运行结果，对结果做二次处理
>
> ```python
> def fun01(a,b):
>     sum=a+b
>     return sum
> if __name__=='__main__':
>     result=fun01(10,20)
>     if result > 100:
>         print("ok")
>     else:
>         print("error")
> print(result)
> ```