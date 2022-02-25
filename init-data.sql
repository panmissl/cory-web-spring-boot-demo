CREATE TABLE `base_data_dict` (`id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',`creator` bigint(20) NOT NULL COMMENT '创建人',`modifier` bigint(20) NOT NULL COMMENT '修改人',`create_time` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '创建时间',`modify_time` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '修改时间',`is_deleted` SMALLINT(1) NOT NULL DEFAULT 0 COMMENT '是否删除',`type` bigint(20) NOT NULL COMMENT 'type, data dict id',`value` varchar(1024) NOT NULL COMMENT 'value',`sn` int(11) DEFAULT '0' COMMENT 'sn',`description` varchar(1024) NOT NULL COMMENT 'description',`showable` SMALLINT(1) NOT NULL DEFAULT '1' COMMENT '是否显示',PRIMARY KEY (`id`)) ENGINE=InnoDB AUTO_INCREMENT=10001 DEFAULT CHARSET=utf8 COMMENT='系统数据字典表';
CREATE TABLE `base_feedback` (`id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',`creator` bigint(20) NOT NULL COMMENT '创建人',`modifier` bigint(20) NOT NULL COMMENT '修改人',`create_time` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '创建时间',`modify_time` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '修改时间',`is_deleted` SMALLINT(1) NOT NULL DEFAULT 0 COMMENT '是否删除',`content` varchar(1024) NOT NULL COMMENT '反馈内容',PRIMARY KEY (`id`)) ENGINE=InnoDB AUTO_INCREMENT=10001 DEFAULT CHARSET=utf8 COMMENT='反馈表';
CREATE TABLE `base_resource` (`id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',`creator` bigint(20) NOT NULL COMMENT '创建人',`modifier` bigint(20) NOT NULL COMMENT '修改人',`create_time` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '创建时间',`modify_time` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '修改时间',`is_deleted` SMALLINT(1) NOT NULL DEFAULT 0 COMMENT '是否删除',`value` varchar(200) NOT NULL COMMENT '资源值',`type` varchar(64) NOT NULL COMMENT '资源类型',`description` varchar(200) NOT NULL COMMENT '描述',PRIMARY KEY (`id`)) ENGINE=InnoDB AUTO_INCREMENT=10001 DEFAULT CHARSET=utf8 COMMENT='资源表';
CREATE TABLE `base_role` (`id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',`creator` bigint(20) NOT NULL COMMENT '创建人',`modifier` bigint(20) NOT NULL COMMENT '修改人',`create_time` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '创建时间',`modify_time` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '修改时间',`is_deleted` SMALLINT(1) NOT NULL DEFAULT 0 COMMENT '是否删除',`name` varchar(100) NOT NULL COMMENT '名称',`description` varchar(200) NOT NULL COMMENT '描述',PRIMARY KEY (`id`)) ENGINE=InnoDB AUTO_INCREMENT=10001 DEFAULT CHARSET=utf8 COMMENT='角色表';
CREATE TABLE `base_role_resource_rel` (`id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',`creator` bigint(20) NOT NULL COMMENT '创建人',`modifier` bigint(20) NOT NULL COMMENT '修改人',`create_time` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '创建时间',`modify_time` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '修改时间',`is_deleted` SMALLINT(1) NOT NULL DEFAULT 0 COMMENT '是否删除',`role_id` bigint(20) NOT NULL COMMENT '角色id',`resource_id` bigint(20) NOT NULL COMMENT '资源id',PRIMARY KEY (`id`)) ENGINE=InnoDB AUTO_INCREMENT=10001 DEFAULT CHARSET=utf8 COMMENT='角色资源关系表';
CREATE TABLE `base_system_config` (`id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',`creator` bigint(20) NOT NULL COMMENT '创建人',`modifier` bigint(20) NOT NULL COMMENT '修改人',`create_time` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '创建时间',`modify_time` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '修改时间',`is_deleted` SMALLINT(1) NOT NULL DEFAULT 0 COMMENT '是否删除',`code` varchar(50) NOT NULL COMMENT 'CODE',`val` varchar(1024) NOT NULL COMMENT 'value',`description` varchar(1024) NOT NULL COMMENT 'description',PRIMARY KEY (`id`)) ENGINE=InnoDB AUTO_INCREMENT=10001 DEFAULT CHARSET=utf8 COMMENT='系统配置表';
CREATE TABLE `base_user` (`id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',`creator` bigint(20) NOT NULL COMMENT '创建人',`modifier` bigint(20) NOT NULL COMMENT '修改人',`create_time` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '创建时间',`modify_time` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '修改时间',`is_deleted` SMALLINT(1) NOT NULL DEFAULT 0 COMMENT '是否删除',`phone` varchar(100) DEFAULT NULL COMMENT '手机',`email` varchar(100) DEFAULT NULL COMMENT '邮箱',`password` varchar(254) NOT NULL COMMENT '密码',`thirdparty_id` varchar(200) DEFAULT NULL COMMENT '第三方登录ID',`thirdparty_type` varchar(100) DEFAULT NULL COMMENT '第三方类型',`type` varchar(64) NOT NULL COMMENT '类型',`status` varchar(64) NOT NULL COMMENT '状态',`level` varchar(64) NOT NULL COMMENT '等级',`last_logon_time` datetime DEFAULT NULL COMMENT '最近登录时间',`last_logon_ip` varchar(100) DEFAULT NULL COMMENT '最近登录IP',`last_logon_success` SMALLINT(1) NOT NULL DEFAULT 1 COMMENT '最近登录是否成功',`extra_info` varchar(20480) NULL COMMENT '扩展信息,json格式',PRIMARY KEY (`id`)) ENGINE=InnoDB AUTO_INCREMENT=10001 DEFAULT CHARSET=utf8 COMMENT='用户表';
CREATE TABLE `base_user_role_rel` (`id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',`creator` bigint(20) NOT NULL COMMENT '创建人',`modifier` bigint(20) NOT NULL COMMENT '修改人',`create_time` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '创建时间',`modify_time` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '修改时间',`is_deleted` SMALLINT(1) NOT NULL DEFAULT 0 COMMENT '是否删除',`user_id` bigint(20) NOT NULL COMMENT '用户id',`role_id` bigint(20) NOT NULL COMMENT '角色id',PRIMARY KEY (`id`)) ENGINE=InnoDB AUTO_INCREMENT=10001 DEFAULT CHARSET=utf8 COMMENT='用户角色关系表';
CREATE TABLE `base_action_log` (`id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',`creator` bigint(20) NOT NULL COMMENT '创建人',`modifier` bigint(20) NOT NULL COMMENT '修改人',`create_time` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '创建时间',`modify_time` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '修改时间',`is_deleted` SMALLINT(1) NOT NULL DEFAULT 0 COMMENT '是否删除',`object_type` varchar(254) NOT NULL  ,`object_id` varchar(254) NOT NULL  ,`log` text NOT NULL  ,`operator` varchar(254) NOT NULL  ,`operate_time` datetime NOT NULL  ,PRIMARY KEY (`id`)) ENGINE=InnoDB AUTO_INCREMENT=10001 DEFAULT CHARSET=utf8 COMMENT='操作日志';
CREATE TABLE `base_access_count` (`id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',`creator` bigint(20) NOT NULL COMMENT '创建人',`modifier` bigint(20) NOT NULL COMMENT '修改人',`create_time` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '创建时间',`modify_time` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '修改时间',`is_deleted` SMALLINT(1) NOT NULL DEFAULT 0 COMMENT '是否删除',`day` varchar(20) NOT NULL COMMENT '日',`hour` varchar(20) NOT NULL COMMENT '小时',`uri` varchar(254) NOT NULL COMMENT 'URI',`access_count` int NOT NULL DEFAULT 0 COMMENT '访问次数',PRIMARY KEY (`id`)) ENGINE=InnoDB AUTO_INCREMENT=10001 DEFAULT CHARSET=utf8 COMMENT='访问统计';
CREATE TABLE `demo_demo` (`id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',`creator` bigint(20) NOT NULL,`modifier` bigint(20) NOT NULL,`create_time` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',`modify_time` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',`is_deleted` SMALLINT(1) NOT NULL DEFAULT 0,`age` int(11) NOT NULL,`foreign_id` bigint(20) NOT NULL,`balance` double NOT NULL,`name` varchar(50) NOT NULL,`remark` text NOT NULL,`is_child` smallint(1) NOT NULL,`birthday` datetime NOT NULL,`time` datetime NOT NULL,`sex` varchar(64) NOT NULL,PRIMARY KEY (`id`)) ENGINE=InnoDB AUTO_INCREMENT=10001 DEFAULT CHARSET=utf8;

insert into base_system_config (creator, modifier, code, val, description) values (1, 1, 'domain_name', 'http://localhost:8080', 'domain');
insert into base_system_config (creator, modifier, code, val, description) values (1, 1, 'site_name', 'DEMO', 'site name');
insert into base_system_config (creator, modifier, code, val, description) values (1, 1, 'site_slogan', 'DEMO', 'site slogan');
insert into base_system_config (creator, modifier, code, val, description) values (1, 1, 'js_dir', 'http://localhost:8000/', 'ends with /');
insert into base_system_config (creator, modifier, code, val, description) values (1, 1, 'css_dir', 'http://localhost:8000/', 'ends with /');
insert into base_system_config (creator, modifier, code, val, description) values (1, 1, 'image_dir', 'http://localhost:8000/', 'ends with /');
insert into base_system_config (creator, modifier, code, val, description) values (1, 1, 'js_file', 'umi.js', 'umi.js');
insert into base_system_config (creator, modifier, code, val, description) values (1, 1, 'css_file', 'umi.css', 'umi.css');
insert into base_system_config (creator, modifier, code, val, description) values (1, 1, 'admin-skin', 'green', '皮肤：green,red,yellow,blue,black,purple,green-light,red-light,yellow-light,blue-light,black-light,purple-light');
insert into base_system_config (creator, modifier, code, val, description) values (1, 1, 'login-skin', 'default', '登录皮肤：default/simple');
insert into base_system_config (creator, modifier, code, val, description) values (1, 1, 'admin_role_names', 'admin', '系统管理员角色组，半角逗号分隔');
insert into base_system_config (creator, modifier, code, val, description) values (1, 1, 'root_role_name', 'root', 'root管理员角色');
insert into base_system_config (creator, modifier, code, val, description) values (1, 1, 'anon_role_name', 'anon', '匿名角色');
insert into base_system_config (creator, modifier, code, val, description) values (1, 1, 'normal_role_name', 'normal', '普通用户角色');
insert into base_system_config (creator, modifier, code, val, description) values (1, 1, 'user_enabled', 'true', '是否开启用户系统');
insert into base_system_config (creator, modifier, code, val, description) values (1, 1, 'register_enable', 'false', '是否开启注册功能');
insert into base_system_config (creator, modifier, code, val, description) values (1, 1, 'quartz_ip', 'NOT_USED', '定时器运行ip');
insert into base_system_config (creator, modifier, code, val, description) values (1, 1, 'sql_password', 'cory', '执行sql密码');

/* -- password: 123456 */
insert into base_user (id, creator, modifier, phone, email, password, type, status, level) values (1, 1, 1, '13000000000', 'xxx@163.com', 'e10adc3949ba59abbe56e057f20f883e', 'SITE', 'NORMAL', 'SVIP');
insert into base_role (id, creator, modifier, name, description) values (1, 1, 1, 'root', 'root');
insert into base_role (id, creator, modifier, name, description) values (2, 1, 1, 'anon', '匿名用户');
insert into base_role (id, creator, modifier, name, description) values (3, 1, 1, 'normal', '普通用户');
insert into base_role (id, creator, modifier, name, description) values (4, 1, 1, 'admin', '管理员');
insert into base_resource (id, creator, modifier, value, type, description) values (1, 1, 1, '/**', 'URL', 'all url');
insert into base_user_role_rel (id, creator, modifier, user_id, role_id) values (1, 1, 1, 1, 1);
insert into base_role_resource_rel (id, creator, modifier, role_id, resource_id) values (1, 1, 1, 1, 1);

