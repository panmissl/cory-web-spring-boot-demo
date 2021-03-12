#!/bin/sh

# 关于部署：
# 由于使用redis session，所以需要服务器上部署redis，设置用户名密码(目前服务器的是123456)
# 提供不间断服务，所以最少要部署两台机器。在服务器上部署两个tomcat，不同端口(10001,10002, 测试版本为：10023)
# 数据库：正式为：lm_tooth，测试库为：lm_tooth_test
# web server:
#    配置负载均衡：VirtualHost的配置里，JkMount指向均衡器。
#    配置时加上状态监控配置
#    在worker的配置里，配置均衡器和tomcat的关系。注意：tomcat不能放到list里
# 可以通过：查看负载均衡状态: http://123.57.189.22:81/httpdstatus?opt=0
# 发布时，先发布一台，在状态页面刷新，没问题后再发布另外一台。部署脚本分两个

#shutdown tomcat -- can't do this using /mokii/odts_v2_tomcat7/bin/shutdown.sh
echo "shutdown tomcat..."
kill -9 `ps -ef | grep /mokii/lm_tooth_tomcat_7_1 | awk '{print $2}'`

#backup userdata
echo 'backup userdata'
rm -rf /mokii/backup/userdata/lm_tooth/*
cp -rf /mokii/lm_tooth_1/static/userdata/* /mokii/backup/userdata/lm_tooth

#unzip war and copy resources
echo "unzip war and copy resources..."

rm -rf /mokii/lm_tooth_1/*
chmod 777 /mokii/backup/deployment/lm_tooth.war
unzip -nq /mokii/backup/deployment/lm_tooth.war -d /mokii/lm_tooth_1
#有多台机器，先不删除，复制即可
#mv /mokii/backup/deployment/mocli.war /mokii/backup/deployment/archive/mocli`date +%Y%m%d`.war
cp /mokii/backup/deployment/lm_tooth.war /mokii/backup/deployment/archive/lm_tooth`date +%Y%m%d`.war

# replace config files
echo "replace config files..."
cp -rf /mokii/backup/config_files/lm_tooth/* /mokii/lm_tooth_1/WEB-INF/classes/

echo "restore userdata..."
mkdir -p /mokii/lm_tooth_1/static/userdata
cp -rf /mokii/backup/userdata/lm_tooth/* /mokii/lm_tooth_1/static/userdata/

echo "set env..."
. /etc/profile

#start tomcat
echo "start tomcat..."
/mokii/lm_tooth_tomcat_7_1/bin/startup.sh

#restart httpd -- no need to restart web server
#echo "restart httpd"
#/usr/local/httpd/bin/httpd -k restart

echo "deploy successful."


