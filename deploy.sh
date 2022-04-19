#!/bin/sh

# 打包
# 上传
# 执行服务器脚本

mvn -DskipTests=true -Dmaven.skip.test=true package
scp /Users/corypan/Documents/panliang/idea_workspace/miquan/web/target/web-0.0.1-SNAPSHOT.jar username@server:/xxx/cory-web/web-0.0.1-SNAPSHOT.jar.new
ssh username@server "/xxx/cory-web/deploy.sh"
echo "DONE"