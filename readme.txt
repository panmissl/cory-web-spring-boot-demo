mvn -DskipTests=true -Dmaven.skip.test=true package

工程结构：
ROOT
+- src
+----- main
+---------- java
+--------------- com
+------------------- cory
+------------------------ controller (Controller文件夹，所有Controller定义在这里)
+------------------------ dao (Dao定义)
+------------------------ enums (枚举定义)
+------------------------ model (Model定义)
+------------------------ service (Service定义)
+------------------------ vo (VO定义)
+------------------------ util (工具类定义，默认无，需要可以加，一般用系统提供的即可。如果是业务需要工具类，可以加)
+------------------------ CoryWebApplication.java (启动类，名字可以改，一般不用动)
+---------- resources
+-------------------- application.properties (配置文件，包括通用配置可本地开发配置)
+-------------------- application-prod.properties (线上配置文件)
+- init-data.sql (初始化数据sql文件，开发环境启动后执行)
+- readme.txt (开发手册)
+- deploy.sh (部署脚本)
+- pom.xml (POM)

# model
    com.cory.model.#Model#.java
# dao
    com.cory.dao.#Model#Dao.java
# service
    com.cory.service.#Model#Service.java
# controller
    com.cory.web.controller.#Model#Controller.java
# js

开发步骤：
    先用idea的copy功能，copy一个新的project
	同时copyCDN功能：手动复制cory-web-cdn，注意工程名叫：xxx-cdn (xxx时java工程名称)
	创建数据库
	执行init-data.sql里的建表语句和初始化数据
	表等会自动创建和同步，不用手动创建 -- 生产环境需要手动创建
	配置：在application.properties和application-prod.properties文件里配置
	写Model类，加上注解：数据库（包括DDL和DML）、校验、等(所有注解都在com.cory.db.annotations下面)
    用代码生成工具生成dao、service、controller、js
	可选：系统启动后，插入初始化数据：放在了系统根目录下init-data.sql里。直接从系统功能里执行即可
    可选：在service方法里配置缓存
    可选：删除test相关 - 可以留着做参考
	可选：在application.properteis里配置数据库相关信息：
		cory.db.dao-packages = com.cory.dao -- 这个默认就行，一般不用配置，除非有特殊需要
		cory.db.model-packages = com.cory.model -- 这个默认就行，一般不用配置，除非有特殊需要
	注意：所有枚举实现CoryEnum接口
	注意：Model类字段类型用对象类型，不要用原始类型，而且不要有默认值。原因有两个：1、int等会有默认值，导致没有传条件时会有一个默认值查询不出来；2、boolean型生成的getter/setter不带IS，有问题

Context：
    1、用户直接用：CurrentUser.get()即可。但是OpenApi获取不到，注意
    2、CoryContext.get()
    3、CorySystemContext.get()

校验：
	在Model类上增加注解，用SpringValidation框架。前端就用Field里的校验，做简单校验

执行sql：
	可以再页面直接执行sql，但每次都需要输入密码。密码配置再系统参数配置里，key是：sql_password

缓存使用：
    配置：在application.properteis里配置：cory.cache.type: 可选值有simple/redis/etcd。如果配置了redis或者etcd，还需要配置他们的连接情况。具体可以在prod和dev里配置即可
    在需要缓存的service方法上，添加Cache, CacheEvict等spring的缓存注解即可，参考SystemConfigService.java

定时任务使用：
	默认关闭，如果需要则可以打开：cory.scheduler.enable=true
    参考SampleJob写好代码（注意继承SingleIpJob）
	配置：
		cory.scheduler.job-configs[0]=SampleJob1:0 0 2 * * ?
		cory.scheduler.job-configs[1]=SampleJob2:0 2 35 * * ?
	配置规则：Job(Job类名[不加包名]):cronExpress。如：SampleJob:0 0 2 * * ?

session共享：
    使用spring-session。配置：
        application.properteis配置：cory-session.enable = true
		注意会依赖redis

ajax：防止表单重复提交
    不成功时，重新获取token，url：generateFormToken，post提交的参数名：__form_token__
    csrf: 对于不是页面的post提交来说，需要加上csrf参数。通过：generateCsrfToken来获取，get请求即可。参数名叫：_csrf

自定义Token校验使用：作为OpenApi使用
    场景：有些地方不用用户系统校验，用OpenApi的方式进行访问
    使用：
		# 代码：写OpenApiController继承BaseOpenApiController。mapping里以业务模块开始，以/开头，BaseOpenApiController里加了前缀：/openapi
		# 调用方：在Header里放置：Access-Key-Id、Access-Key-Timestamp和Access-Key-Token。URL以/openapi/开头
		其中：
		1、Access-Key-Timestamp格式为：yyyyMMddHHmmss，10分钟有效
		2、Access-Key-Token是根据Access-Key-Id、Access-Secret-Key和Access-Key-Timestamp生成的。
            格式为：MD5(Access-Key-Id::Access-Secret-Key::Access-Key-Timestamp)。
            比如：id为123，secret为abc，时间戳为20200101123000，则token为：MD5(123::abc:20200101123000) -> 335fb39e94bca960c5e9eb8e40c24609

文件上传
    controller里声明方法，加一个必须参数：MultipartFile file，还可以加其它参数，比如：Model model
    前端可以用ajax或者表单提交方式提交文件名为file的文件进行上传。下面是ajax的例子:
        $("#upload-img-btn").click(function () {
            var img = document.getElementById("upload-img-input").files[0];
            if (!img) {
                C.alert('请选择图片');
                return;
            }
            var formData = new FormData();
            formData.append("file", document.getElementById("upload-img-input").files[0]);
            $.ajax({
                url: ctx + 'shop/order/uploadImg',
                type: "POST",
                data: formData,
                /**
                 *必须false才会自动加上正确的Content-Type
                 */
                contentType: false,
                /**
                 * 必须false才会避开jQuery对 formdata 的默认处理
                 * XMLHttpRequest会对 formdata 进行正确的处理
                 */
                processData: false,
                success: function (result) {
                    if (result.success) {
                        C.alert("上传成功！" + JSON.stringify(result));
                    } else {
                        C.alert("上传失败，请重试！");
                    }
                },
                error: function () {
                    C.alert("上传失败！");
                }
            });
        });

swagger-ui
    参考文档：
        https://swagger.io/tools/swagger-ui/
        https://my.oschina.net/u/3872757/blog/1844742
        https://www.jianshu.com/p/5c1111d3b99f
    使用：
		配置：cory.swagger.enable=true （默认关闭）
		使用@Api，@ApiOperation，@ApiParam进行注解
		在@Api的类加上：@SwaggerApiController注解，API是按注解开的，不加的话不会在页面上看到
        访问：localhost:8080/swagger-ui.html

mvn -DskipTests=true -Dmaven.skip.test=true package
