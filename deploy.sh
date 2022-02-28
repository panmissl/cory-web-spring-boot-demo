#!/bin/sh

# 关于部署：
# 由于使用redis session，所以需要服务器上部署redis，设置用户名密码(目前服务器的是123456)
# 提供不间断服务，所以最少要部署两台机器。在服务器上部署两个tomcat，不同端口(10001,10002, 测试版本为：10023)
# SpringBoot部署：配置文件放在sh脚本目录下的config目录里，application-prod.properties文件，启动时会指定active-profiles=prod
# java -jar myproject.jar --spring.profiles.active = prod
# 前端打包后放在：resource/cdn目录下即可，用专门的域名访问，比如：xxxcdn.xx.com，注意配置到参数表里
# 用户上传文件放在：resource/data目录下，用专门的域名访问，比如：xxxdata.xx.com，注意配置到参数表里
# 数据库：正式为：lm_tooth，测试库为：lm_tooth_test。所以不需要备份数据
# web server:
#    配置负载均衡：VirtualHost的配置里，JkMount指向均衡器。 -- 不用Jk了，直接Http转发即可。
#    配置时加上状态监控配置
#    在worker的配置里，配置均衡器和tomcat的关系。注意：tomcat不能放到list里 -- 不用配置了，用Http转发即可
# 可以通过：查看负载均衡状态: http://123.57.189.22:81/httpdstatus?opt=0
# 发布时，先发布一台，在状态页面刷新，没问题后再发布另外一台。部署脚本分两个
# Apache httpd http的转发配置：https://blog.51cto.com/5468755/1369911, https://blog.csdn.net/a332708815/article/details/50441061

JAVA_HOME=/mokii/software/jdk/jdk1.8.0_181
APP_NAME=web-0.0.1-SNAPSHOT.jar

#shutdown tomcat
#kill -9 `ps -ef | grep $APP_NAME | awk '{print $2}'`

#start server
nohup $JAVA_HOME/bin/java -server -Djava.awt.headless=true -jar -Dspring.profiles.active=prod $APP_NAME --server.port=8080 > /dev/null 2>&1 &