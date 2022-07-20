-- 表结构及初始化数据只执行一次

create table if not exists logdog_version
(
	id serial not null
		constraint logdog_version_pk
			primary key,
	version varchar(20) not null,
	time_stamp bigint,
	create_time timestamp default CURRENT_TIMESTAMP
);

alter table logdog_version owner to postgres;

create table if not exists web_task
(
	id serial not null
		constraint web_task_pk
			primary key,
	device_id varchar(128) not null,
	device_name varchar(128) not null,
	environment varchar(2048),
	page_num integer,
	content text not null,
	add_time bigint not null,
	log_date bigint not null,
	status integer not null,
	custom_report_info varchar(2048),
	update_time timestamp default CURRENT_TIMESTAMP not null,
	web_source varchar(128),
	obj_type integer default 1,
	record_year integer,
	record_month integer,
	record_day integer
);

alter table web_task owner to postgres;

create table if not exists web_detail
(
	id bigserial not null
		constraint web_detail_pk
			primary key,
	task_id bigint not null,
	log_type varchar(40) not null,
	content text not null,
	log_level integer,
	add_time bigint not null,
	minute_offset integer not null,
	environment varchar(2048),
	custom_report_info varchar(2048),
	web_source varchar(128),
	record_year varchar(20),
	record_month varchar(20),
	record_day varchar(20),
	log_time bigint
);

alter table web_detail owner to postgres;

create index if not exists web_detail_task_id_log_type_index
	on web_detail (task_id, log_type);

create index if not exists web_detail_record_year_record_month_record_day_index
	on web_detail (record_year, record_month, record_day);

create table if not exists dataway_datasource
(
	id varchar(64) not null
		constraint dataway_datasource_pk
			primary key,
	type varchar(64),
	name varchar(255),
	ip_address varchar(255),
	username varchar(255),
	password varchar(255),
	alias varchar(255),
	remark varchar(255),
	con_str varchar(255),
	is_use integer,
	create_by varchar(36),
	update_by varchar(36),
	create_time timestamp default CURRENT_TIMESTAMP,
	update_time timestamp,
	del_flag integer default 0
);

alter table dataway_datasource owner to postgres;

create table if not exists dataway_module
(
	id varchar(36) not null
		constraint dataway_module_pk
			primary key,
	module_name varchar(255),
	root_params_heard text,
	root_params_request text,
	create_by varchar(36),
	update_by varchar(36),
	create_time timestamp default CURRENT_TIMESTAMP,
	update_time timestamp,
	del_flag integer default 0
);

alter table dataway_module owner to postgres;

create table if not exists interface_info
(
	api_id varchar(64) not null
		constraint interface_info_pk
			primary key,
	api_method varchar(12) not null,
	api_path varchar(512) not null,
	api_status varchar(4) not null,
	api_comment varchar(255) not null,
	api_type varchar(24) not null,
	api_script text not null,
	api_schema text not null,
	api_sample text not null,
	api_option text not null,
	api_create_time varchar(32) not null,
	api_gmt_time varchar(32) not null,
	api_name varchar(255)
);

alter table interface_info owner to postgres;

create table if not exists interface_release
(
	pub_id varchar(64) not null
		constraint interface_release_pk
			primary key,
	pub_api_id varchar(64) not null,
	pub_method varchar(12) not null,
	pub_path varchar(512) not null,
	pub_status varchar(4) not null,
	pub_type varchar(24) not null,
	pub_script text not null,
	pub_script_ori text not null,
	pub_schema text not null,
	pub_sample text not null,
	pub_option text not null,
	pub_release_time varchar(32) not null,
	pub_comment varchar(255)
);

alter table interface_release owner to postgres;
