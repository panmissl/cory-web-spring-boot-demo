#!/bin/sh

# 打包
# 上传
# 执行服务器脚本

mvn -DskipTests=true -Dmaven.skip.test=true clean package
scp /Users/corypan/Documents/panliang/idea_workspace/miquan/web/target/web-0.0.1-SNAPSHOT.jar username@server:/xxx/cory-web/web-0.0.1-SNAPSHOT.jar.new
#本地运行远程脚本会导致进程杀不死，所以提示去远程执行
#ssh username@server "/xxx/cory-web/deploy.sh"
#echo "DONE"
echo "打包并上传完成，请到服务器执行/xxx/deploy.sh脚本"