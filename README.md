##有关*翼客户端算法更新公告 

**更新日期:2016-10-12**

有关最新登录协议发布在:**http://edmondfrank.github.io/blog/2016/10/12/2016-10-12-tian-yi-xiao-yuan-wang-ke-hu-duan-deng-lu-xie-yi-geng-xin/**

**后续完整程序的发布请继续关注我的Github的动态!**

# Esurfing for Linux 
##天翼校园网客户端 for Linux

众所周知,由于Linux客户量在国内十分少,因此十分多的国内软件商都很少有提供Linux下的客户端.
即使是[天翼校园网](http://zsteduapp.10000.gd.cn/index.html)也不例外.
这样便苦了我们这一批在校学习的大学学子们了.

为了尝试去解决这样的困境,我通过模拟天翼校园网Windows客户端的post登录协议,成功登录了校园网.

在此,将代码放出供大家完善与参考(Ruby实现).

##我的环境:
- **Ubuntu 14.04 LTS**
- **JDK 1.8**
- **JRuby 1.7.25(此处使用JRuby是因为要配合最新版的Shoes4界面库)**
- **Shoes4(Ruby的一个轻量Gui)**

运行界面如下:

 ![image](https://github.com/EdmondFrank/Esurfing/blob/master/esurf.png)
　
　

##选项解释:
####关键参数:config.json文件中的nasip的值,此值为天翼校园网对各校园分配的各标志性ip,默认为笔者所在院校,请各位根据自己的实际院校填写.一般此ip会显示在天翼校园网未登录时,打开网页后所自动跳转的天翼的登录页面中的地址栏上.

**帐号:**天翼客户端登录帐号

**密码:** 同理

**MAC:** *若勾选了路由器登录模式*,则填写路由器的MAC地址,(格式:XX-XX-XX-XX-XX-XX)

**动态IP:** *若勾选了路由器登录模式*,则填写天翼分配给路由器的动态IP地址,可以在路由器的配置页面上查到.

有关路由器配置页面,一般为:**192.168.1.1或1192.168.0.1**,如TP-Link的为192.168.1.1

##使用说明
1. 由于本程序使用到了[Shoes4](https://github.com/shoes/shoes4)界面库.
而Shoes4界面库又是基于JRuby的,所以在使用前,请遵循[JRuby](http://jruby.org/getting-started)的安装说明,安装并配置JRuby环境.
2. 然后遵循[Shoes4](https://github.com/shoes/shoes4)上的Shoes4配置方法进行Shoes4界面库的安装配置.
3. 完成以上步骤后,可以直接在终端下输入 <br/> ``` $ jruby main.rb ``` <br/>来运行本程序.

####最后笔者邮箱为:EdmomdFrank@yahoo.co.jp,欢迎报告BUG和来信交流!


