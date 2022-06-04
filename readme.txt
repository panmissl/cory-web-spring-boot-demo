#、使用cory-web-spring-boot-framework框架进行web开发的示例工程，使用步骤见下面的：开发步骤章节
#、有问题请联系微信：cory275165359

------------------------------------------

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

controller划分建议
    controller可分为4类：
        1、后台数据请求，以/ajax/开头，用于后台系统，需要登录授权后，才能访问。
        2、openapi请求，以/openapi/开头，用于openapi，对外提供接口，需要用ak、sk授权访问，比如给小程序或app访问，或者给第三方访问
        3、api请求，以/api/开头，用于站点非后台系统（比如官网），需要访问数据时用这种controller，不用授权，放开访问（在application.properties里配置），但要注意数据安全
        4、MenuPortalController，自定义uri，作用见类注释。
    在controller数量少时，可以全部放在controller文件夹下即可。但如果数量多，那么建议将它们分开目录放，且可以自行新建子目录。建议目录如下：
        controller
        +--- ajax
        +---------- 自己定义的二级目录
        +--- api
        +---------- 自己定义的二级目录
        +--- openapi
        +---------- 自己定义的二级目录
        +--- MenuPortalController
    注意：代码自动生成的controller，是放在controller目录下的，如果分开了文件夹，需要在生成代码后手动移动一下。

开发步骤：
    1、工程准备：
        方式一：本地已经有cory-web-spring-boot-demo-all和cory-web-spring-boot-demo-cdn工程：
            先用idea的copy功能，copy一个新的project
            同时copyCDN功能：手动复制cory-web-spring-boot-demo-all-cdn，注意工程名叫：xxx-cdn (xxx是java工程名称)
        方式二：本地还没有cory-web-demo工程
            用命令git clone将cory-web-demo工程：git@github.com:panmissl/cory-web-spring-boot-demo.git 和 cory-web-spring-boot-demo-cdn工程：git@github.com:panmissl/cory-web-spring-boot-demo-cdn.git克隆到本地
            （或者先fork到自己的github再clone）
            可选：如果需要改名字，则两个工程都要一起改，且名字是有关系的，后端项目如果改叫：abc-test的话，cdn项目叫：adb-test-cdn
    2、创建数据库，数据库名称在application.properties里配置
	3、编辑init-data.sql，将域名等修改好，见sql文件里的注释
	4、执行init-data.sql里的建表语句和初始化数据
	5、此步在开发环境不用做，因为表等会自动创建和同步，不用手动创建 -- 生产环境需要手动创建
	6、配置：在application.properties和application-prod.properties文件里配置
	7、写Model类，加上注解：数据库（包括DDL和DML）、校验、等(所有注解都在com.cory.db.annotations下面)
    8、这一步是自动的，直接启动系统即可。用代码生成工具生成dao、service、controller、js。如果需要自行生成，可使用类：CodeGeneratorHelper来生成（本文下面有描述）
	可选：系统启动后，插入初始化数据：放在了系统根目录下init-data.sql里。直接从系统功能里执行即可
    可选：在service方法里配置缓存
    可选：在service方法里配置事务：加注解：@Transactional(rollbackFor = Throwable.class)
    可选：删除test相关 - 可以留着做参考
	可选：在application.properties里配置数据库相关信息：
		cory.db.dao-packages = com.cory.dao -- 这个默认就行，一般不用配置，除非有特殊需要
		cory.db.model-packages = com.cory.model -- 这个默认就行，一般不用配置，除非有特殊需要
	注意：所有枚举实现CoryEnum接口
	注意：Model类字段类型用对象类型，不要用原始类型，而且不要有默认值。原因有两个：1、int等会有默认值，导致没有传条件时会有一个默认值查询不出来；2、boolean型生成的getter/setter不带IS，有问题
	注意：VO和DTO，都继承BaseVO和BaseDTO
	注意：所有的类都加上：serialVersionUID，防止缓存或其它操作时报类转换错误
	访问：localhost:8080，注意：先启动cdn工程

上线流程：
    1、db结构、初始化数据：直接把本地的db结构导出到线上数据库执行即可。初始化数据执行init-data.sql
    2、给表建索引
    3、打包：三个工程：java、前端js、后端js
    4、前端页面增加：keyword、description等
    5、上传静态资源：一般上传到OSS，然后配置CDN加速
    6、favicon
    7、安装nginx
    8、安装java
    9、启动：启动命令在java工程根目录下的deploy.sh里
    10、域名备案
    11、访问统计：可接入的平台很多，比如百度统计
    12、配置域名：域名解析
    13、配置证书：一般可申请免费证书（缺点：单域名证书，每加一个域名需要申请并配置一遍），有钱也可以购买多域名的证书

Context：
    1、用户直接用：CurrentUser.get()即可。但是OpenApi获取不到，注意
    2、CoryContext.get()
    3、CorySystemContext.get()

特殊菜单路径：
    默认生成后端和前端代码后，前端的访问路径是固定了的，一个model对应一个访问路径。
    如果有一些特殊路径需要写到左侧菜单且用来做权限分配（比如订单model后端是同一个，此时生成的访问url是：/xxx/order，但前端要显示成线上订单和线下订单，对应url是：/xxx/order/online和/xxx/order/offline），请在MenuPortalController里配置即可。这样就可以在权限里给这些路径配置角色权限了

特殊过滤条件：
    在list时，可能会有些特殊过滤的，比如根据状态列表过滤，某个值的区间（大于、小于等），这种可以构造出过滤对象后，利用BaseModel里的addXxxFilterField方法添加这些特殊过滤条件，不用自己手写。具体见BaseModel源码里的注释及方法。

校验：
	在Model类上增加注解，用SpringValidation框架。前端就用Field里的校验，做简单校验

删除：
    默认是物理删除，如果需要逻辑删除，请指定model注解里的logicDelete = true

执行sql：
	可以再页面直接执行sql，但每次都需要输入密码。密码配置再系统参数配置里，key是：sql_password

缓存使用：
    配置：在application.properteis里配置：cory.cache.type: 可选值有simple/redis/etcd。如果配置了redis或者etcd，还需要配置他们的连接情况。具体可以在prod和dev里配置即可
    在需要缓存的service方法上，添加Cache, CacheEvict等spring的缓存注解即可，参考ResourceService.java
    自定义缓存：直接在需要的地方使用CacheManager，然后用即可

特殊缓存：
    系统配置和数据字典，有特殊的缓存使用方法，用：SystemConfigCacheUtil和DataDictCacheUtil来获取
    所以一般情况下不直接使用systemConfigService和dataDictService

操作日志：
    默认BaseService在增删改时记录操作日志，如果不需要，要自己写，请覆写actionLogEnable方法返回false
    修改：默认打开写得多了，目前是默认关闭状态
    自己记录操作日志方法：用 ActionLogUtil 类的静态方法记录

拦截器：
    只需要编写拦截器代码：继承HandlerInterceptor。注意在类里自己判断requestURI。注册已经框架层自动注册了
        @Slf4j
        @Component
        public class WeixinApiInterceptor implements HandlerInterceptor {
        }

定时任务使用：
	默认关闭，如果需要则可以打开：cory.scheduler.enable=true
    参考SampleJob写好代码（注意继承SingleIpJob），如果需要广播类型的定时任务（每台机器都执行），则直接实现Job接口
	配置：
		cory.scheduler.job-configs[0]=SampleJob1:0 0 2 * * ?
		cory.scheduler.job-configs[1]=SampleJob2:0 2 35 * * ?
	配置规则：Job(Job类名[不加包名]):cronExpress。如：SampleJob:0 0 2 * * ?

集群定时任务：
    除上面的定时任务(使用Spring Quartz实现)外，还有一类特殊的定时任务：集群定时任务
    它类似上面的广播任务，区别是：广播任务每次都执行，而集群定时任务只执行一次，执行后任务就被删除掉了。而且是定时执行（10s一次）。
    用途：用在那些需要集群所有机器执行一次的任务。比如目前用在：系统参数配置和数据字典的缓存加载，这两个缓存用得特别多，如果用redis缓存那么性能不好，所以直接加载到内存使用。刷新缓存时使用集群定时任务刷新一次即可。
    用法：
        1、系统启动时，注册任务handler：在用@PostConstruct注解的方法里，调用：com.cory.service.ClusterJobService#registerJobHandler
        2、在需要执行任务时，调用com.cory.service.ClusterJobService#addJob方法添加任务
        具体参见SystemConfigService里的使用

session共享：
    使用spring-session。配置：
		注意会依赖redis：application.properteis配置redis
		pom文件里的spring-session-data-redis依赖打开
		CoryWebDemoApplication里的EnableRedisHttpSession注释打开

ajax：防止表单重复提交
    不成功时，重新获取token，url：generateFormToken，post提交的参数名：__form_token__
    csrf: 对于不是页面的post提交来说，需要加上csrf参数。通过：generateCsrfToken来获取，get请求即可。参数名叫：_csrf
    跳过校验：有些场景下需要跳过校验，比如openapi等，配置文件里增加：cory.web.csrfAndFormTokenExcludeUrlPattern的配置

跳过权限校验
    场景：有些地方不能校验权限，比如某些不可控的外部系统回调，比如微信、支付宝等支付回调
    使用：配置文件里增加：cory.web.skipShiroAuthUrlPattern的配置

自定义Token校验使用：作为OpenApi使用
    场景：有些地方不用用户系统校验，用OpenApi的方式进行访问
    使用：
        # 配置：系统配置里增加配置项：__token_configs__，格式为：key1:secret1,key2:secret2
		# 代码：写OpenApiController继承BaseOpenApiController。mapping里以业务模块开始，以/开头，BaseOpenApiController里加了前缀：/openapi
		# 调用方：在Header里放置：Access-Key-Id、Access-Key-Timestamp和Access-Key-Token。URL以/openapi/开头
		其中：
		1、Access-Key-Timestamp格式为：System.currentTimeMillis()取得的long型值，10秒内有效
		2、Access-Key-Token是根据Access-Key-Id、Access-Secret-Key和Access-Key-Timestamp生成的。
            格式为：MD5(Access-Key-Id::Access-Secret-Key::Access-Key-Timestamp)。
            比如：id为123，secret为456，时间戳为1645111672839，则token为：MD5(123::456::1645111672839) -> da8819510a2df87aa9415debe3786817
        3、在本地开发环境，可以将ts传0，以跳过校验。生产环境不能跳过

验证码：
    application.properties里配置:
        cory.web.captcha.enable=true，默认false
        cory.web.captcha.urlPattern=正则表达式，符合表达式的才校验，否则不校验。以斜杠开头
    展示验证码：前端组件：Captcha，展示为一个span，里面装一个图片和一个文本框，文本框的变化输出到组件的属性函数：onChange(v)。实际请求URL：/captcha.svl
    提交验证码：请提交参数为captcha的参数

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

文件导出
    背景：对于一些导出需要时间比较长的，需要用异步导出，然后通过查看导出列表查看导出结果和下载导出文件
    提供了文件导出任务服务：ExportJobService。无论是同步还是异步导出都可以使用
    使用：
        1、直接使用ExportJobService的doExport方法，提供一个type，然后自行导出，导出后将下载地址返回即可（第二个参数）。具体见方法注释
        2、导出数据查看：可以在页面上嵌入导出数据模块：ExportJobList，传入type字段即可，具体见前端组件注释
    注意：
        直接使用ExportJobService的doExport方法时，如果需要异步，自己开线程处理。ExportJobService的doExport方法不会开异步线程。
    示例：
        private static final ExecutorService POOL = ConcurrentUtil.newFixedThreadPool(1);

        @Autowired
        private ExportJobService exportJobService;

        public void export() {
            POOL.submit(() -> {
                exportJobService.doExport("my_text_export_job", () -> {
                    //自己处理上传逻辑，比如上传到OSS
                    ByteArrayOutputStream out = xxx;
                    String url = OSSHelper.upload(out);
                    return url;
                });
            });
        }

返回值加密
    支持对返回值进行加密。场景：某个接口返回的数据只能自己解析，即使别人拿到返回数据也不能解析。常用在APP或小程序的通讯上。
    加密功能需要和客户端配合使用，服务端加密后，客户端相应解密。所以加密的算法要自己提供。
    使用步骤：
    1、在需要加密的Controller类或方法上加注解：@GenericResultEncrypt
    2、写一个Bean，实现接口：GenericResultEncryptor。注意bean加上@Service或@Component注解
    3、客户端拿到数据后进行解密(GenericResult里的isEncrypt字段值为true)
    可以参见GenericResultEncrypt的注释

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

代码生成：默认会在启动时判断没有DAO类就生成代码，如果想要手动生成部分代码，则启动后调用CodeGeneratorHelper类来生成即可（比如写一个测试用的Controller来做此工作）

扩展：如果有些功能需要扩展，比如密码加密器需要自己实现，则可以覆盖PasswordEncoder这个Bean，它定义在ShiroConfig里

mvn -DskipTests=true -Dmaven.skip.test=true package
