-- 表结构及初始化数据只执行一次

-- logfv-schema
create table logfv_version
(
    id          int auto_increment comment '编码uuid'
        primary key,
    version     varchar(20)                        not null,
    time_stamp  bigint                             not null,
    create_time datetime default CURRENT_TIMESTAMP null
)
    comment '日志版本表';

create table logan_log_detail
(
	id bigint(11) unsigned auto_increment comment '主键id'
		primary key,
	task_id bigint(11) unsigned not null comment '所属任务id',
	log_type varchar(40) not null comment '日志类型',
	content text not null comment '原始日志',
	log_time bigint unsigned not null comment '本条日志产生的具体时间戳',
	add_time timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '添加时间',
	update_time timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间'
)
comment '日志解析后的数据详情' collate=utf8mb4_unicode_ci;
create index idx_task_id
	on logan_log_detail (task_id);
create index idx_update_time
	on logan_log_detail (update_time);

create table logan_task
(
	id bigint(11) unsigned auto_increment comment '主键id'
		primary key,
	platform tinyint(11) unsigned not null comment '平台1android2iOS',
	amount varchar(64) default '' null comment '文件大小',
	app_id varchar(32) default '' null comment 'app标识',
	union_id varchar(256) default '' null comment '用户标识',
	device_id varchar(256) default '' null comment '设备标识',
	app_version varchar(64) default '' null comment 'app版本',
	build_version varchar(256) default '' null comment '构建版本',
	log_file_name varchar(512) charset utf8mb4 default '' null comment '日志文件所在路径',
	log_date bigint unsigned null comment '日志所属日期',
	add_time bigint unsigned not null comment '业务字段，日志上报时间',
	status tinyint(11) unsigned default 0 not null comment '0未分析过,1分析过',
	update_time timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间'
)
comment '上报日志任务表' collate=utf8mb4_unicode_ci;

create index idx_update_time
	on logan_task (update_time);


create table web_task
(
	id bigint(11) unsigned auto_increment comment '自增主键'
		primary key,
	device_id varchar(128) default '' not null comment '系统id',
	device_name varchar(128) default '' null comment '系统名称',
	environment varchar(2048) null comment '客户端自定义环境信息',
	page_num int not null comment '日志页码',
	content mediumtext not null comment '日志内容',
	add_time bigint not null comment '添加时间',
	log_date bigint not null comment '日志所属日期',
	status int not null comment '日志状态0未解析，1已解析',
	custom_report_info varchar(2048) null comment '自定义上报信息',
	update_time timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
	web_source varchar(128) null comment '来源',
	obj_type int default 1 null comment '1:系统；2:组件',
	record_year int null,
	record_month int null,
	record_day int null
)
comment 'H5上报任务表';

create index add_time_deviceid
	on web_task (add_time, device_id);

create index idx_update_time
	on web_task (update_time);

create index log_date_date
	on web_task (record_year, record_month, record_day);

create index log_date_deviceid
	on web_task (log_date, device_id);


create table web_detail
(
	id bigint(11) unsigned auto_increment comment '自增主键'
		primary key,
	task_id bigint not null comment '所属任务id',
	log_type varchar(40) not null comment '日志类型',
	content mediumtext not null comment '日志内容',
	log_time bigint not null comment '日志所属时间',
	log_level int null comment '日志等级',
	add_time bigint not null comment '添加时间',
	minute_offset int not null comment '距离当天0点的分钟数',
	environment varchar(2048) null comment '客户端自定义环境信息',
	custom_report_info varchar(2048) null comment '自定义上报信息',
	web_source varchar(128) null comment '来源',
	record_year int null,
	record_month int null,
	record_day int null
)
comment 'H5日志详情表';

create index log_date_date
	on web_detail (record_year, record_month, record_day);

create index taskid_logtype
	on web_detail (task_id, log_type);

-- dataway-schema
create table dataway_datasource
(
	id varchar(64) not null comment '唯一id',
	type varchar(64) null comment '数据类型',
	name varchar(255) null comment '数据库名称',
	ip_address varchar(255) null comment '数据库ip地址',
	username varchar(255) null,
	password varchar(255) null,
	alias varchar(255) null comment '数据库别名',
	remark varchar(255) null comment '备注',
	con_str varchar(255) null comment '连接字符串',
	is_use tinyint null comment '是否启用(0：启用，1、已禁用)',
	create_by varchar(36) null comment '创建人',
	update_by varchar(36) null comment '更新人',
	create_time datetime default CURRENT_TIMESTAMP null comment '创建时间',
	update_time datetime null comment '更新时间',
	del_flag tinyint default 0 null comment '删除状态(0-正常,1-已删除)'
);

create table dataway_module
(
	id varchar(36) not null comment '全局唯一ID',
	module_name varchar(255) null comment '模块名称',
	root_params_heard mediumtext null comment '请求头全局参数',
	root_params_request mediumtext null comment '全局请求参数',
	create_by varchar(36) null comment '创建人',
	update_by varchar(36) null comment '更新人',
	create_time datetime default CURRENT_TIMESTAMP null comment '创建时间',
	update_time datetime null comment '更新时间',
	del_flag tinyint default 0 null comment '删除状态(0-正常,1-已删除)'
);

create table interface_info
(
	api_id varchar(64) not null comment 'ID'
		primary key,
	api_method varchar(12) not null comment 'HttpMethod：GET、PUT、POST',
	api_path varchar(512) not null comment '拦截路径',
	api_status varchar(4) not null comment '状态：-1-删除, 0-草稿，1-发布，2-有变更，3-禁用',
	api_comment varchar(255) not null comment '注释',
	api_type varchar(24) not null comment '脚本类型：SQL、DataQL',
	api_script mediumtext not null comment '查询脚本：xxxxxxx',
	api_schema mediumtext not null comment '接口的请求/响应数据结构',
	api_sample mediumtext not null comment '请求/响应/请求头样本数据',
	api_option mediumtext not null comment '扩展配置信息',
	api_create_time varchar(32) not null comment '创建时间',
	api_gmt_time varchar(32) not null comment '修改时间',
	api_name varchar(255) null comment '扩展新增-接口名称'
)
comment 'Dataway 中的API' charset=utf8mb4;

create table interface_release
(
	pub_id varchar(64) not null comment 'Publish ID'
		primary key,
	pub_api_id varchar(64) not null comment '所属API ID',
	pub_method varchar(12) not null comment 'HttpMethod：GET、PUT、POST',
	pub_path varchar(512) not null comment '拦截路径',
	pub_status varchar(4) not null comment '状态：-1-删除, 0-草稿，1-发布，2-有变更，3-禁用',
	pub_type varchar(24) not null comment '脚本类型：SQL、DataQL',
	pub_script mediumtext not null comment '查询脚本：xxxxxxx',
	pub_script_ori mediumtext not null comment '原始查询脚本，仅当类型为SQL时不同',
	pub_schema mediumtext not null comment '接口的请求/响应数据结构',
	pub_sample mediumtext not null comment '请求/响应/请求头样本数据',
	pub_option mediumtext not null comment '扩展配置信息',
	pub_release_time varchar(32) not null comment '发布时间（下线不更新）',
	pub_comment varchar(255) null comment '注释'
)
comment 'Dataway API 发布记录' charset=utf8mb4;


-- logfv-data
INSERT INTO web_task
(id, device_id, device_name, environment, page_num, content, add_time, log_date, status, custom_report_info, update_time, web_source, obj_type, record_year, record_month, record_day)
VALUES (1, 'demo', 'demo系统', null, 1, '["{\\"t\\":\\"info\\",\\"c\\":\\"hello%20world\\",\\"d\\":\\"1635481539243\\",\\"e\\":\\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36\\",\\"i\\":\\"\\",\\"s\\":\\"browser\\"}","{\\"t\\":\\"page\\",\\"c\\":\\"hello%20world\\",\\"d\\":\\"1635481539245\\",\\"e\\":\\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36\\",\\"i\\":\\"\\",\\"s\\":\\"browser\\"}","{\\"t\\":\\"info\\",\\"c\\":\\"hello%20world\\",\\"d\\":\\"1635481539450\\",\\"e\\":\\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36\\",\\"i\\":\\"\\",\\"s\\":\\"browser\\"}","{\\"t\\":\\"page\\",\\"c\\":\\"hello%20world\\",\\"d\\":\\"1635481539451\\",\\"e\\":\\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36\\",\\"i\\":\\"\\",\\"s\\":\\"browser\\"}","{\\"t\\":\\"info\\",\\"c\\":\\"hello%20world\\",\\"d\\":\\"1635481539828\\",\\"e\\":\\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36\\",\\"i\\":\\"\\",\\"s\\":\\"browser\\"}","{\\"t\\":\\"page\\",\\"c\\":\\"hello%20world\\",\\"d\\":\\"1635481539829\\",\\"e\\":\\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36\\",\\"i\\":\\"\\",\\"s\\":\\"browser\\"}"]', REPLACE(unix_timestamp(NOW(3)),'.',''), unix_timestamp(NOW())*1000, 0, null, NOW(), null, 1, DATE_FORMAT(NOW(),'%Y'), DATE_FORMAT(NOW(),'%m'), DATE_FORMAT(NOW(),'%e'));
INSERT INTO web_detail (id, task_id, log_type, content, log_time, log_level, add_time, minute_offset, environment, custom_report_info, web_source,record_year, record_month, record_day) VALUES (1, 1, 'info', 'hello world', REPLACE(unix_timestamp(NOW(3)),'.',''), 0, REPLACE(unix_timestamp(NOW(3)),'.',''), 265, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36', '', 'browser',DATE_FORMAT(NOW(),'%Y'), DATE_FORMAT(NOW(),'%m'), DATE_FORMAT(NOW(),'%e'));
INSERT INTO web_detail (id, task_id, log_type, content, log_time, log_level, add_time, minute_offset, environment, custom_report_info, web_source,record_year, record_month, record_day) VALUES (2, 1, 'page', 'hello world', REPLACE(unix_timestamp(NOW(3)),'.',''), 0, REPLACE(unix_timestamp(NOW(3)),'.',''), 265, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36', '', 'browser',DATE_FORMAT(NOW(),'%Y'), DATE_FORMAT(NOW(),'%m'), DATE_FORMAT(NOW(),'%e'));
INSERT INTO web_detail (id, task_id, log_type, content, log_time, log_level, add_time, minute_offset, environment, custom_report_info, web_source,record_year, record_month, record_day) VALUES (3, 1, 'info', 'hello world', REPLACE(unix_timestamp(NOW(3)),'.',''), 0, REPLACE(unix_timestamp(NOW(3)),'.',''), 265, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36', '', 'browser',DATE_FORMAT(NOW(),'%Y'), DATE_FORMAT(NOW(),'%m'), DATE_FORMAT(NOW(),'%e'));
INSERT INTO web_detail (id, task_id, log_type, content, log_time, log_level, add_time, minute_offset, environment, custom_report_info, web_source,record_year, record_month, record_day) VALUES (4, 1, 'page', 'hello world', REPLACE(unix_timestamp(NOW(3)),'.',''), 0, REPLACE(unix_timestamp(NOW(3)),'.',''), 265, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36', '', 'browser',DATE_FORMAT(NOW(),'%Y'), DATE_FORMAT(NOW(),'%m'), DATE_FORMAT(NOW(),'%e'));
INSERT INTO web_detail (id, task_id, log_type, content, log_time, log_level, add_time, minute_offset, environment, custom_report_info, web_source,record_year, record_month, record_day) VALUES (5, 1, 'info', 'hello world', REPLACE(unix_timestamp(NOW(3)),'.',''), 0, REPLACE(unix_timestamp(NOW(3)),'.',''), 265, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36', '', 'browser',DATE_FORMAT(NOW(),'%Y'), DATE_FORMAT(NOW(),'%m'), DATE_FORMAT(NOW(),'%e'));
INSERT INTO web_detail (id, task_id, log_type, content, log_time, log_level, add_time, minute_offset, environment, custom_report_info, web_source,record_year, record_month, record_day) VALUES (6, 1, 'page', 'hello world', REPLACE(unix_timestamp(NOW(3)),'.',''), 0, REPLACE(unix_timestamp(NOW(3)),'.',''), 265, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36', '', 'browser',DATE_FORMAT(NOW(),'%Y'), DATE_FORMAT(NOW(),'%m'), DATE_FORMAT(NOW(),'%e'));
