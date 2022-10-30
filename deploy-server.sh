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
# webserver使用nginx。负载均衡使用upstream实现（放在http下），注意设置proxy_connect_timeout为1（放在server下，和proxy_pass一起）。

APP_NAME=web-0.0.1-SNAPSHOT.jar
SERVER1=8080
SERVER2=8081

#切换到jar所在目录
cd /xx/xxx

#备份jar
echo "INFO: backup jar..."
mv $APP_NAME $APP_NAME.old
mv $APP_NAME.new $APP_NAME
echo "INFO: backup jar finish."

#执行部署，一个参数，输入哪个server（上面定义的SERVER1和SERVER2）
deploy() {
  #shutdown tomcat
  #不要用kill -9，因为这样的话注册的shutdownHook不会生效
  #也不要用kill -2，因为这样杀不死从脚本启动的程序，只能杀死直接启动的程序
  #kill -15执行后，后台还是在，所以要用kill -15和kill -9组合
  #从本地运行远程脚本还是不行，杀不死进程，所以脚本还是去远程上运行了
  SERVER_PID=`ps -ef | grep $APP_NAME | grep $1 | awk '{print $2}'`
  echo "INFO: server pid: $SERVER_PID"
  kill -15 $SERVER_PID

  #等待服务器彻底停止
  echo -n 'INFO: please wait server stop'
  for e in $(seq 3); do
      echo -n "."
      sleep 1
  done
  echo ''

  #启动服务器
  nohup $JAVA_HOME/bin/java -server -Xms2g -Xmx2g -XX:MetaspaceSize=256m -XX:MaxMetaspaceSize=256m -XX:+PrintGC -XX:+PrintGCDetails -XX:+PrintGCTimeStamps -XX:+PrintCommandLineFlags -Djava.awt.headless=true -jar -Dspring.profiles.active=prod $APP_NAME --server.port=$1 > start.log 2>&1 &

  #等待20秒，确认服务器已经启动，然后做健康检查
  echo -n 'INFO: server is starting, please wait'
  for e in $(seq 20); do
      echo -n "."
      sleep 1
  done
  echo ''

  CHECK_URL=http://localhost:$1/status
  echo "check status: ${CHECK_URL}"
  CHECK_RESULT=`curl --silent -m 20 "${CHECK_URL}" 2>&1`
  if [ "$CHECK_RESULT" = "OK" ]; then
      echo "SUCCESS: server is startup"
  else
      echo "ERROR: server start fail, please check!"
      exit -1
  fi
}

echo "INFO: deploy server1, port: ${SERVER1}"
deploy $SERVER1
echo "INFO: deploy server2, port: ${SERVER2}"
deploy $SERVER2

echo "INFO: deploy finish."

#start server
#nohup $JAVA_HOME/bin/java -server -Djava.awt.headless=true -jar -Dspring.profiles.active=prod $APP_NAME --server.port=8080 > /dev/null 2>&1 &
#nohup $JAVA_HOME/bin/java -server -Djava.awt.headless=true -jar -Dspring.profiles.active=prod web-0.0.1-SNAPSHOT.jar --server.port=8080 > /dev/null 2>&1 &