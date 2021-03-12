insert into base_system_config (creator, modifier, code, val, description) values (1, 1, 'domain_name', 'http://localhost', 'domain');
insert into base_system_config (creator, modifier, code, val, description) values (1, 1, 'site_name', '魔客粒', 'site name');
insert into base_system_config (creator, modifier, code, val, description) values (1, 1, 'site_slogan', '魔客粒', 'site slogan');
insert into base_system_config (creator, modifier, code, val, description) values (1, 1, 'js_dir', 'http://localhost/', 'ends with /');
insert into base_system_config (creator, modifier, code, val, description) values (1, 1, 'css_dir', 'http://localhost/', 'ends with /');
insert into base_system_config (creator, modifier, code, val, description) values (1, 1, 'image_dir', 'http://localhost/', 'ends with /');
insert into base_system_config (creator, modifier, code, val, description) values (1, 1, 'js_file', 'umi.js', 'umi.js');
insert into base_system_config (creator, modifier, code, val, description) values (1, 1, 'css_file', 'umi.css', 'umi.css');
insert into base_system_config (creator, modifier, code, val, description) values (1, 1, 'admin-skin', 'green', '皮肤：green,red,yellow,blue,black,purple,green-light,red-light,yellow-light,blue-light,black-light,purple-light');
insert into base_system_config (creator, modifier, code, val, description) values (1, 1, 'login-skin', 'default', '登录皮肤：default/simple');
insert into base_system_config (creator, modifier, code, val, description) values (1, 1, 'admin_role_names', 'admin', '系统管理员角色组，半角逗号分隔');
insert into base_system_config (creator, modifier, code, val, description) values (1, 1, 'root_role_name', 'root', 'root管理员角色');
insert into base_system_config (creator, modifier, code, val, description) values (1, 1, 'anon_role_name', 'anon', '匿名角色');
insert into base_system_config (creator, modifier, code, val, description) values (1, 1, 'normal_role_name', 'normal', '普通用户角色');
insert into base_system_config (creator, modifier, code, val, description) values (1, 1, 'user_enabled', 'true', '是否开启用户系统');
insert into base_system_config (creator, modifier, code, val, description) values (1, 1, 'quartz_ip', 'NOT_USED', '定时器运行ip');
insert into base_system_config (creator, modifier, code, val, description) values (1, 1, 'sql_password', 'cory', '执行sql密码');

/* -- password: 123456 */
insert into base_user (id, creator, modifier, phone, email, password, type, status, level) values (1, 1, 1, '13000000000', 'xxx@163.com', '__MTIzNDU2IUAwIyQxJV4yKigp__', 'SITE', 'NORMAL', 'SVIP');
insert into base_role (id, creator, modifier, name, description) values (1, 1, 1, 'root', 'root');
insert into base_role (id, creator, modifier, name, description) values (2, 1, 1, 'anon', '匿名用户');
insert into base_role (id, creator, modifier, name, description) values (3, 1, 1, 'normal', '普通用户');
insert into base_role (id, creator, modifier, name, description) values (4, 1, 1, 'admin', '管理员');
insert into base_resource (id, creator, modifier, value, type, description) values (1, 1, 1, '/**', 'URL', 'all url');
insert into base_user_role_rel (id, creator, modifier, user_id, role_id) values (1, 1, 1, 1, 1);
insert into base_role_resource_rel (id, creator, modifier, role_id, resource_id) values (1, 1, 1, 1, 1);

