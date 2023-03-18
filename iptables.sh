#!/bin/bash
# by YIN in 2019-5-21 18:07:33

chkconfig iptables off
#清空
iptables -F

#禁止ping
#iptables -A INPUT -p icmp --icmp-type echo-request -j DROP

#允许ssh
iptables -A INPUT  -p tcp -s 132.33.6.12 --dport 22 -j ACCEPT

#------------------------------------开放策略，白名单
#允许防火墙本机对外开放TCP端口20、21、以及被动模式FTP端口1250-1280
#iptables -I INPUT 2 -p tcp -s 132.33.6.0/24 -m multiport --dport 20,21,1250:10280 -j ACCEPT
#内网白名单       
iptables -I INPUT 2  -s 10.37.3.0/24  -j ACCEPT
#ftp省白名单      
iptables -I INPUT 2 -p tcp  -s 100.66.100.148 -m multiport --dport 20,21,1025:65280  -j ACCEPT
iptables -I INPUT 2 -p tcp  -s 100.66.100.149 -m multiport --dport 20,21,1025:65280  -j ACCEPT
#hadoop白名单     
iptables -I INPUT 2  -s 10.37.2.0/24  -j ACCEPT
iptables -I INPUT 2  -s 10.0.168.0/24  -j ACCEPT
iptables -I INPUT 2  -s 10.0.177.0/24  -j ACCEPT
iptables -I INPUT 2  -s 10.37.28.0/24  -j ACCEPT
iptables -I INPUT 2  -s 10.37.24.0/24  -j ACCEPT
iptables -I INPUT 2  -s 10.37.253.0/24  -j ACCEPT
iptables -I INPUT 2  -s 10.254.225.0/24  -j ACCEPT
iptables -I INPUT 2  -s 10.254.226.0/24  -j ACCEPT
#oracle白名单     
#iptables -I INPUT 2 -p tcp -s 10.0.168.0/24  -j ACCEPT
#数据中心白名单   
iptables -I INPUT 2 -p tcp -s 10.142.113.0/24 -m multiport --dport 20,21,1025:65280 -j ACCEPT
iptables -I INPUT 2 -p tcp -s 10.142.124.0/24 -m multiport --dport 20,21,1025:65280 -j ACCEPT
iptables -I INPUT 2 -p tcp -s 10.142.112.0/24 -m multiport --dport 20,21,1025:65280 -j ACCEPT
#本地白名单       
iptables -I INPUT 2 -s 127.0.0.1  -j ACCEPT
#soc白名单


#------------------------------------
#禁止其他响应，一般都是最后一条
iptables -A INPUT -j DROP

#保存
/etc/init.d/iptables save
/etc/init.d/iptables restart
