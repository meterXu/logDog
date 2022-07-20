-- 配置数据每次容器重启都执行
-- dataway-data
truncate table dataway_datasource;
truncate table dataway_module;
truncate table interface_info;
truncate table interface_release;

INSERT INTO dataway_datasource (id, type, name, ip_address, username, password, alias, remark, con_str, is_use, create_by, update_by, create_time, update_time, del_flag) VALUES ('998fec26568c00354e8fcc1c119ed89d', 'MySQL', 'DB_NAME', 'DB_HOST:DB_PORT', 'DB_USER', 'DB_PASSWD', 'logdog', null, 'jdbc:mysql://DB_HOST:DB_PORT/DB_NAME?characterEncoding=UTF8&allowMultiQueries=true&socketTimeout=60000&autoReconnect=true&useSSL=false&serverTimezone=Asia/Shanghai', 0, null, null, '2021-09-06 09:14:40', '2021-09-06 09:28:02', 0);



INSERT INTO interface_info (api_id, api_method, api_path, api_status, api_comment, api_type, api_script, api_schema, api_sample, api_option, api_create_time, api_gmt_time, api_name) VALUES ('i_eje29j14a-ag8', 'GET', '/api/logdog/web/queryLogCount', '1', '统计日志记录排行', 'DataQL', 'hint FRAGMENT_SQL_DATA_SOURCE = "logdog"
hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
var dataSet = @@sql()<%
select * from (
select b.device_id,b.device_name,count(a.id) as log_count from web_detail a
inner join web_task b on a.task_id = b.id where b.device_name <> ''''
group by b.device_id, b.device_name) a order by a.log_count desc limit 10;
%>
return dataSet(); ', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"array","items":{"type":"object","properties":{"device_name":{"type":"string"},"log_count":{"type":"number"},"device_id":{"type":"string"}}}}}}}', '{"requestHeader":"[]","requestBody":"{}","responseHeader":"{}","responseBody":"{\\n\\t\\"success\\":true,\\n\\t\\"message\\":\\"OK\\",\\n\\t\\"code\\":0,\\n\\t\\"lifeCycleTime\\":14,\\n\\t\\"executionTime\\":12,\\n\\t\\"value\\":[\\n\\t\\t{\\n\\t\\t\\t\\"device_id\\":\\"test1\\",\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"log_count\\":114\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_id\\":\\"test3\\",\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"log_count\\":112\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_id\\":\\"test2\\",\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"log_count\\":112\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_id\\":\\"test5\\",\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"log_count\\":112\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_id\\":\\"test8\\",\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"log_count\\":112\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_id\\":\\"test10\\",\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"log_count\\":112\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_id\\":\\"test6\\",\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"log_count\\":112\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_id\\":\\"test4\\",\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"log_count\\":112\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_id\\":\\"test9\\",\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"log_count\\":112\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_id\\":\\"test7\\",\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"log_count\\":112\\n\\t\\t}\\n\\t]\\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"024234752F01,0050569D4242,0242A8A12CFC","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\\n    \\"success\\"      : \\"@resultStatus\\",\\n    \\"message\\"      : \\"@resultMessage\\",\\n    \\"code\\"         : \\"@resultCode\\",\\n    \\"lifeCycleTime\\": \\"@timeLifeCycle\\",\\n    \\"executionTime\\": \\"@timeExecution\\",\\n    \\"value\\"        : \\"@resultData\\"\\n}","wrapParameterName":"root"}', '1630891971754', '1642404225376', null);
INSERT INTO interface_info (api_id, api_method, api_path, api_status, api_comment, api_type, api_script, api_schema, api_sample, api_option, api_create_time, api_gmt_time, api_name) VALUES ('i_eje2anaa294f4', 'GET', '/api/logdog/web/queryLogType', '1', '每天的日志类型数汇总', 'DataQL', '// a new Query.
// SQL 执行器切换为分页模式
hint FRAGMENT_SQL_DATA_SOURCE = "logdog"
hint FRAGMENT_SQL_QUERY_BY_PAGE = true
hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
//从 1 开始作为页码的启始编号
hint FRAGMENT_SQL_QUERY_BY_PAGE_NUMBER_OFFSET = 1
// 定义查询SQL

var dataSet = @@mybatis()<%
<select>
select date,log_type as logType,COUNT(log_type) as count from
(
select FROM_UNIXTIME(left(log_time,10),''%Y%m%d'') as date, log_type from web_detail a
where exists(select * from web_task b where a.task_id = b.id)
) b
group by date,log_type
 </select>
%>
// 创建分页查询对象
var pageQuery =  dataSet();
// 设置分页信息
run pageQuery.setPageInfo({
    "pageSize"    : ${pageSize}, // 页大小
    "currentPage" : ${pageNo}   // 第1页
});
// 执行分页查询
return {
    "pageInfo":pageQuery.pageInfo(),
    "pageData":pageQuery.data()
}', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"pageSize":{"type":"number"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"object","properties":{"pageInfo":{"type":"object","properties":{"recordPosition":{"type":"number"},"enable":{"type":"boolean"},"totalPage":{"type":"number"},"pageSize":{"type":"number"},"totalCount":{"type":"number"},"currentPage":{"type":"number"}}},"pageData":{"type":"array","items":{"type":"object","properties":{"date":{"type":"string"},"logType":{"type":"string"},"count":{"type":"number"}}}}}}}}}', '{"requestHeader":"[]","requestBody":"{\\"pageSize\\":1}","responseHeader":"{}","responseBody":"{\\n\\t\\"success\\":true,\\n\\t\\"message\\":\\"OK\\",\\n\\t\\"code\\":0,\\n\\t\\"lifeCycleTime\\":469,\\n\\t\\"executionTime\\":384,\\n\\t\\"value\\":{\\n\\t\\t\\"pageInfo\\":{\\n\\t\\t\\t\\"enable\\":true,\\n\\t\\t\\t\\"pageSize\\":1,\\n\\t\\t\\t\\"totalCount\\":7,\\n\\t\\t\\t\\"totalPage\\":7,\\n\\t\\t\\t\\"currentPage\\":1,\\n\\t\\t\\t\\"recordPosition\\":0\\n\\t\\t},\\n\\t\\t\\"pageData\\":[\\n\\t\\t\\t{\\n\\t\\t\\t\\t\\"date\\":\\"20211029\\",\\n\\t\\t\\t\\t\\"logType\\":\\"info\\",\\n\\t\\t\\t\\t\\"count\\":3\\n\\t\\t\\t}\\n\\t\\t]\\n\\t}\\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"024234752F01,0050569D4242,0242A8A12CFC","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\\n    \\"success\\"      : \\"@resultStatus\\",\\n    \\"message\\"      : \\"@resultMessage\\",\\n    \\"code\\"         : \\"@resultCode\\",\\n    \\"lifeCycleTime\\": \\"@timeLifeCycle\\",\\n    \\"executionTime\\": \\"@timeExecution\\",\\n    \\"value\\"        : \\"@resultData\\"\\n}","wrapParameterName":"root"}', '1630892364146', '1636609328400', null);
INSERT INTO interface_info (api_id, api_method, api_path, api_status, api_comment, api_type, api_script, api_schema, api_sample, api_option, api_create_time, api_gmt_time, api_name) VALUES ('i_eje2kj4bljclm', 'GET', '/api/logdog/web/queryTaskByDate', '1', '系统日志按天汇总查询', 'DataQL', 'hint FRAGMENT_SQL_DATA_SOURCE = "logdog"
hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
hint FRAGMENT_SQL_QUERY_BY_PAGE = true
hint FRAGMENT_SQL_QUERY_BY_PAGE_NUMBER_OFFSET = 1


var dataSet = @@mybatis(deviceId,startDate,endDate)<%
<select>
select b.device_id,b.log_date,count(a.id) log_count from web_detail a
inner join web_task b on a.task_id = b.id
where b.device_name != ''''
    <if test="deviceId != ''''">
        and  b.device_id = #{deviceId}
   </if>
   <if test="startDate != '''' and endDate != ''''">
        and  b.log_date between #{startDate} and #{endDate}
   </if>
group by b.device_id,b.log_date order by b.log_date desc
 </select>
%>

// 创建分页查询对象
var pageQuery =  dataSet(${deviceId},${startDate},${endDate});
// 设置分页信息
run pageQuery.setPageInfo({
    "pageSize"    : ${pageSize}, // 页大小
    "currentPage" : ${pageNo}   // 第1页
});
// 执行分页查询
return {
    "pageInfo":pageQuery.pageInfo(),
    "pageData":pageQuery.data()
}', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"deviceId":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"object","properties":{"pageInfo":{"type":"object","properties":{"recordPosition":{"type":"number"},"enable":{"type":"boolean"},"totalPage":{"type":"number"},"pageSize":{"type":"number"},"totalCount":{"type":"number"},"currentPage":{"type":"number"}}},"pageData":{"type":"array","items":{"type":["string","boolean","number","object","array","null"]}}}}}}}', '{"requestHeader":"[]","requestBody":"{\\"deviceId\\":\\"\\"}","responseHeader":"{}","responseBody":"{\\n\\t\\"success\\":true,\\n\\t\\"message\\":\\"OK\\",\\n\\t\\"code\\":0,\\n\\t\\"lifeCycleTime\\":17,\\n\\t\\"executionTime\\":8,\\n\\t\\"value\\":{\\n\\t\\t\\"pageInfo\\":{\\n\\t\\t\\t\\"enable\\":false,\\n\\t\\t\\t\\"pageSize\\":-1,\\n\\t\\t\\t\\"totalCount\\":0,\\n\\t\\t\\t\\"totalPage\\":1,\\n\\t\\t\\t\\"currentPage\\":1,\\n\\t\\t\\t\\"recordPosition\\":0\\n\\t\\t},\\n\\t\\t\\"pageData\\":[]\\n\\t}\\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"024234752F01,0050569D4242,0242A8A12CFC","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\\n    \\"success\\"      : \\"@resultStatus\\",\\n    \\"message\\"      : \\"@resultMessage\\",\\n    \\"code\\"         : \\"@resultCode\\",\\n    \\"lifeCycleTime\\": \\"@timeLifeCycle\\",\\n    \\"executionTime\\": \\"@timeExecution\\",\\n    \\"value\\"        : \\"@resultData\\"\\n}","wrapParameterName":"root"}', '1630895623197', '1642405667209', null);
INSERT INTO interface_info (api_id, api_method, api_path, api_status, api_comment, api_type, api_script, api_schema, api_sample, api_option, api_create_time, api_gmt_time, api_name) VALUES ('i_eje31jj424035', 'GET', '/api/logdog/web/query', '1', '系统日志列表查询', 'DataQL', '// a new Query.
// SQL 执行器切换为分页模式
hint FRAGMENT_SQL_DATA_SOURCE = "logdog"
hint FRAGMENT_SQL_QUERY_BY_PAGE = true
hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
//从 1 开始作为页码的启始编号
hint FRAGMENT_SQL_QUERY_BY_PAGE_NUMBER_OFFSET = 1
// 定义查询SQL

var dataSet = @@mybatis(deviceId,deviceName,objType,startDate,endDate)<%
<select>
select b.device_id,b.device_name,
       max(b.log_date) as last_log_date,
       max(b.obj_type) as obj_type,
       count(a.id) as log_count
from web_detail a
inner join web_task b on a.task_id = b.id
where b.device_name != ''''
    <if test="deviceId != ''''">
        and b.device_id = #{deviceId}
    </if>
    <if test="deviceName != ''''">
        and b.device_name  like concat(''%'', #{deviceName},''%'')
    </if>
    <if test="objType != ''''">
        and b.obj_type = #{objType}
    </if>
    <if test="startDate != '''' and endDate != ''''">
        and b.log_date between #{startDate} and #{endDate}
    </if>
group by b.device_id, b.device_name order by last_log_date desc,log_count desc
</select>
%>
// 创建分页查询对象
var pageQuery =  dataSet(${deviceId},${deviceName},${objType},${startDate},${endDate});
// 设置分页信息
run pageQuery.setPageInfo({
    "pageSize"    : ${pageSize}, // 页大小
    "currentPage" : ${pageNo}   // 第1页
});
// 执行分页查询
return {
    "pageInfo":pageQuery.pageInfo(),
    "pageData":pageQuery.data()
}', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"endDate":{"type":"string"},"pageNo":{"type":"number"},"pageSize":{"type":"number"},"deviceId":{"type":"string"},"deviceName":{"type":"string"},"objType":{"type":"string"},"startDate":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"object","properties":{"pageInfo":{"type":"object","properties":{"recordPosition":{"type":"number"},"enable":{"type":"boolean"},"totalPage":{"type":"number"},"pageSize":{"type":"number"},"totalCount":{"type":"number"},"currentPage":{"type":"number"}}},"pageData":{"type":"array","items":{"type":"object","properties":{"device_name":{"type":"string"},"log_count":{"type":"number"},"device_id":{"type":"string"},"obj_type":{"type":"number"},"last_log_date":{"type":"number"}}}}}}}}}', '{"requestHeader":"[]","requestBody":"{\\"deviceId\\":\\"\\",\\r\\n\\"deviceName\\":\\"\\",\\r\\n\\"startDate\\":\\"\\",\\r\\n\\"endDate\\":\\"\\",\\r\\n\\"objType\\":\\"\\",\\r\\n\\"pageNo\\":1,\\r\\n\\"pageSize\\":10}","responseHeader":"{}","responseBody":"{\\n\\t\\"success\\":true,\\n\\t\\"message\\":\\"OK\\",\\n\\t\\"code\\":0,\\n\\t\\"lifeCycleTime\\":29,\\n\\t\\"executionTime\\":26,\\n\\t\\"value\\":{\\n\\t\\t\\"pageInfo\\":{\\n\\t\\t\\t\\"enable\\":true,\\n\\t\\t\\t\\"pageSize\\":10,\\n\\t\\t\\t\\"totalCount\\":104,\\n\\t\\t\\t\\"totalPage\\":11,\\n\\t\\t\\t\\"currentPage\\":1,\\n\\t\\t\\t\\"recordPosition\\":0\\n\\t\\t},\\n\\t\\t\\"pageData\\":[\\n\\t\\t\\t{\\n\\t\\t\\t\\t\\"device_id\\":\\"test\\",\\n\\t\\t\\t\\t\\"device_name\\":\\"测试系统\\",\\n\\t\\t\\t\\t\\"last_log_date\\":1642003200000,\\n\\t\\t\\t\\t\\"obj_type\\":1,\\n\\t\\t\\t\\t\\"log_count\\":54\\n\\t\\t\\t},\\n\\t\\t\\t{\\n\\t\\t\\t\\t\\"device_id\\":\\"demo\\",\\n\\t\\t\\t\\t\\"device_name\\":\\"demo系统\\",\\n\\t\\t\\t\\t\\"last_log_date\\":1641539767000,\\n\\t\\t\\t\\t\\"obj_type\\":1,\\n\\t\\t\\t\\t\\"log_count\\":6\\n\\t\\t\\t},\\n\\t\\t\\t{\\n\\t\\t\\t\\t\\"device_id\\":\\"test1\\",\\n\\t\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\t\\"last_log_date\\":1641513600000,\\n\\t\\t\\t\\t\\"obj_type\\":1,\\n\\t\\t\\t\\t\\"log_count\\":114\\n\\t\\t\\t},\\n\\t\\t\\t{\\n\\t\\t\\t\\t\\"device_id\\":\\"test5\\",\\n\\t\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\t\\"last_log_date\\":1641513600000,\\n\\t\\t\\t\\t\\"obj_type\\":1,\\n\\t\\t\\t\\t\\"log_count\\":112\\n\\t\\t\\t},\\n\\t\\t\\t{\\n\\t\\t\\t\\t\\"device_id\\":\\"test8\\",\\n\\t\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\t\\"last_log_date\\":1641513600000,\\n\\t\\t\\t\\t\\"obj_type\\":1,\\n\\t\\t\\t\\t\\"log_count\\":112\\n\\t\\t\\t},\\n\\t\\t\\t{\\n\\t\\t\\t\\t\\"device_id\\":\\"test4\\",\\n\\t\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\t\\"last_log_date\\":1641513600000,\\n\\t\\t\\t\\t\\"obj_type\\":1,\\n\\t\\t\\t\\t\\"log_count\\":112\\n\\t\\t\\t},\\n\\t\\t\\t{\\n\\t\\t\\t\\t\\"device_id\\":\\"test7\\",\\n\\t\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\t\\"last_log_date\\":1641513600000,\\n\\t\\t\\t\\t\\"obj_type\\":1,\\n\\t\\t\\t\\t\\"log_count\\":112\\n\\t\\t\\t},\\n\\t\\t\\t{\\n\\t\\t\\t\\t\\"device_id\\":\\"test6\\",\\n\\t\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\t\\"last_log_date\\":1641513600000,\\n\\t\\t\\t\\t\\"obj_type\\":1,\\n\\t\\t\\t\\t\\"log_count\\":112\\n\\t\\t\\t},\\n\\t\\t\\t{\\n\\t\\t\\t\\t\\"device_id\\":\\"test3\\",\\n\\t\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\t\\"last_log_date\\":1641513600000,\\n\\t\\t\\t\\t\\"obj_type\\":1,\\n\\t\\t\\t\\t\\"log_count\\":112\\n\\t\\t\\t},\\n\\t\\t\\t{\\n\\t\\t\\t\\t\\"device_id\\":\\"test2\\",\\n\\t\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\t\\"last_log_date\\":1641513600000,\\n\\t\\t\\t\\t\\"obj_type\\":1,\\n\\t\\t\\t\\t\\"log_count\\":112\\n\\t\\t\\t}\\n\\t\\t]\\n\\t}\\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"024234752F01,0050569D4242,0242A8A12CFC","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\\n    \\"success\\"      : \\"@resultStatus\\",\\n    \\"message\\"      : \\"@resultMessage\\",\\n    \\"code\\"         : \\"@resultCode\\",\\n    \\"lifeCycleTime\\": \\"@timeLifeCycle\\",\\n    \\"executionTime\\": \\"@timeExecution\\",\\n    \\"value\\"        : \\"@resultData\\"\\n}","wrapParameterName":"root"}', '1630897290530', '1642406295553', null);
INSERT INTO interface_info (api_id, api_method, api_path, api_status, api_comment, api_type, api_script, api_schema, api_sample, api_option, api_create_time, api_gmt_time, api_name) VALUES ('i_eje447n2h-190', 'GET', '/api/logdog/web/querySystems', '1', '系统连接数', 'DataQL', 'hint FRAGMENT_SQL_DATA_SOURCE = "logdog"
var dataSet = @@sql()<%
    select   count(distinct device_id)    from web_task;
%>
return dataSet(); ', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"message":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"number"}}}}', '{"requestHeader":"[]","requestBody":"{\\"message\\":\\"Hello DataQL.\\"}","responseHeader":"{}","responseBody":"{\\n\\t\\"success\\":true,\\n\\t\\"message\\":\\"OK\\",\\n\\t\\"code\\":0,\\n\\t\\"lifeCycleTime\\":231,\\n\\t\\"executionTime\\":155,\\n\\t\\"value\\":202\\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"024234752F01,0050569D4242,0242A8A12CFC","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\\n    \\"success\\"      : \\"@resultStatus\\",\\n    \\"message\\"      : \\"@resultMessage\\",\\n    \\"code\\"         : \\"@resultCode\\",\\n    \\"lifeCycleTime\\": \\"@timeLifeCycle\\",\\n    \\"executionTime\\": \\"@timeExecution\\",\\n    \\"value\\"        : \\"@resultData\\"\\n}","wrapParameterName":"root"}', '1630906084865', '1636609469718', null);
INSERT INTO interface_info (api_id, api_method, api_path, api_status, api_comment, api_type, api_script, api_schema, api_sample, api_option, api_create_time, api_gmt_time, api_name) VALUES ('i_eje47e17d-4be', 'GET', '/api/logdog/web/runtime', '1', '运行时长', 'DataQL', 'hint FRAGMENT_SQL_DATA_SOURCE = "logdog"
var dataSet = @@sql()<%
  select ROUND( MAX(log_date)/1000/3600/24 - MIN(log_date)/1000/3600/24)+1 from web_task;
%>
return dataSet(); ', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"message":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"number"}}}}', '{"requestHeader":"[]","requestBody":"{\\"message\\":\\"Hello DataQL.\\"}","responseHeader":"{}","responseBody":"{\\n\\t\\"success\\":true,\\n\\t\\"message\\":\\"OK\\",\\n\\t\\"code\\":0,\\n\\t\\"lifeCycleTime\\":233,\\n\\t\\"executionTime\\":156,\\n\\t\\"value\\":5\\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"024234752F01,0050569D4242,0242A8A12CFC","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\\n    \\"success\\"      : \\"@resultStatus\\",\\n    \\"message\\"      : \\"@resultMessage\\",\\n    \\"code\\"         : \\"@resultCode\\",\\n    \\"lifeCycleTime\\": \\"@timeLifeCycle\\",\\n    \\"executionTime\\": \\"@timeExecution\\",\\n    \\"value\\"        : \\"@resultData\\"\\n}","wrapParameterName":"root"}', '1630907164405', '1636609526882', null);
INSERT INTO interface_info (api_id, api_method, api_path, api_status, api_comment, api_type, api_script, api_schema, api_sample, api_option, api_create_time, api_gmt_time, api_name) VALUES ('i_ejf0k4m547nb5', 'GET', '/api/logdog/web/queryTotalPage', '1', '日志总分片数', 'DataQL', 'hint FRAGMENT_SQL_DATA_SOURCE = "logdog"
var dataSet = @@sql()<%
select count(*) from web_detail;
%>
return dataSet(); ', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"message":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"number"}}}}', '{"requestHeader":"[]","requestBody":"{\\"message\\":\\"Hello DataQL.\\"}","responseHeader":"{}","responseBody":"{\\n\\t\\"success\\":true,\\n\\t\\"message\\":\\"OK\\",\\n\\t\\"code\\":0,\\n\\t\\"lifeCycleTime\\":31,\\n\\t\\"executionTime\\":29,\\n\\t\\"value\\":11252\\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"024234752F01,0050569D4242,0242A8A12CFC","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\\n    \\"success\\"      : \\"@resultStatus\\",\\n    \\"message\\"      : \\"@resultMessage\\",\\n    \\"code\\"         : \\"@resultCode\\",\\n    \\"lifeCycleTime\\": \\"@timeLifeCycle\\",\\n    \\"executionTime\\": \\"@timeExecution\\",\\n    \\"value\\"        : \\"@resultData\\"\\n}","wrapParameterName":"root"}', '1631070603772', '1642389387682', null);
INSERT INTO interface_info (api_id, api_method, api_path, api_status, api_comment, api_type, api_script, api_schema, api_sample, api_option, api_create_time, api_gmt_time, api_name) VALUES ('i_ekcijfdd53f1k', 'GET', '/api/logdog/web/dateLogIndex', '1', '一天日志的时间索引', 'DataQL', '// a new Query.
// SQL 执行器切换为分页模式
hint FRAGMENT_SQL_DATA_SOURCE = "logdog"
hint FRAGMENT_SQL_QUERY_BY_PAGE = true
hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
//从 1 开始作为页码的启始编号
hint FRAGMENT_SQL_QUERY_BY_PAGE_NUMBER_OFFSET = 1
// 定义查询SQL

var dataSet = @@mybatis(logDate,deviceId,content,logType,logOrder,startTime,endTime)<%
<select>

select b.* from web_task a left join web_detail  b on a.id = b.task_id where 1=1
 <if test="logDate != ''''">
        and a.log_date = #{logDate}
        </if>
 <if test="deviceId != ''''">
        and a.device_id = #{deviceId}
        </if>
    <if test="content != ''''">
        and b.content like concat(''%'', #{content},''%'')
        </if>
    <if test="logType != ''''">
     and b.log_type in
     <foreach collection="logType.split('','')" item="id" open="(" close=")" separator=",">
    #{id}
     </foreach>
    </if>
    <if test="content != ''''">
        and b.content like concat(''%'', #{content},''%'')
    </if>
    <if test="startTime != '''' and endTime != '''' ">
        and b.log_time between #{startTime} and #{endTime}
    </if>

    <if test="logOrder == ''''">
       order by b.log_time  asc
        </if>

     <if test="logOrder != ''''">
       order by b.log_time desc
    </if>
 </select>
%>
// 创建分页查询对象
var pageQuery =  dataSet(${logDate},${deviceId},${content},${logType},${logOrder},${startTime},${endTime});
// 设置分页信息
run pageQuery.setPageInfo({
    "pageSize"    : ${pageSize}, // 页大小
    "currentPage" : ${pageNo}   // 第1页
});
// 执行分页查询
return {
    "pageInfo":pageQuery.pageInfo(),
    "pageData":pageQuery.data()
}', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"logType":{"type":"string"},"logDate":{"type":"string"},"deviceId":{"type":"string"},"content":{"type":"string"},"logOrder":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"object","properties":{"pageInfo":{"type":"object","properties":{"recordPosition":{"type":"number"},"enable":{"type":"boolean"},"totalPage":{"type":"number"},"pageSize":{"type":"number"},"totalCount":{"type":"number"},"currentPage":{"type":"number"}}},"pageData":{"type":"array","items":{"type":["string","boolean","number","object","array","null"]}}}}}}}', '{"requestHeader":"[]","requestBody":"{\\"logDate\\":\\"\\",\\n\\"deviceId\\":\\"\\",\\n\\"content\\":\\"\\",\\n\\"logType\\":\\"\\", \\n\\"logOrder\\":\\"2\\"}","responseHeader":"{}","responseBody":"{\\n\\t\\"success\\":true,\\n\\t\\"message\\":\\"OK\\",\\n\\t\\"code\\":0,\\n\\t\\"lifeCycleTime\\":480,\\n\\t\\"executionTime\\":392,\\n\\t\\"value\\":{\\n\\t\\t\\"pageInfo\\":{\\n\\t\\t\\t\\"enable\\":false,\\n\\t\\t\\t\\"pageSize\\":-1,\\n\\t\\t\\t\\"totalCount\\":0,\\n\\t\\t\\t\\"totalPage\\":1,\\n\\t\\t\\t\\"currentPage\\":1,\\n\\t\\t\\t\\"recordPosition\\":0\\n\\t\\t},\\n\\t\\t\\"pageData\\":[]\\n\\t}\\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"0242AC140002","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\\n    \\"success\\"      : \\"@resultStatus\\",\\n    \\"message\\"      : \\"@resultMessage\\",\\n    \\"code\\"         : \\"@resultCode\\",\\n    \\"lifeCycleTime\\": \\"@timeLifeCycle\\",\\n    \\"executionTime\\": \\"@timeExecution\\",\\n    \\"value\\"        : \\"@resultData\\"\\n}","wrapParameterName":"root"}', '1635226908798', '1636609392818', null);
INSERT INTO interface_info (api_id, api_method, api_path, api_status, api_comment, api_type, api_script, api_schema, api_sample, api_option, api_create_time, api_gmt_time, api_name) VALUES ('i_ekcimn4fi77l7', 'GET', '/api/logdog/web/queryLogSize', '1', '日志大小', 'SQL', 'select concat(round(sum(data_length/1024/1024),2)) as data from information_schema.TABLES where table_schema=''logdog'' and (table_name = ''web_task''
or table_name = ''web_detail'')', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"message":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"string"}}}}', '{"requestHeader":"[]","requestBody":"{\\"message\\":\\"Hello DataQL.\\"}","responseHeader":"{}","responseBody":"{\\n\\t\\"success\\":true,\\n\\t\\"message\\":\\"OK\\",\\n\\t\\"code\\":0,\\n\\t\\"lifeCycleTime\\":156,\\n\\t\\"executionTime\\":75,\\n\\t\\"value\\":\\"153.08\\"\\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"0242AC150002","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\\n    \\"success\\"      : \\"@resultStatus\\",\\n    \\"message\\"      : \\"@resultMessage\\",\\n    \\"code\\"         : \\"@resultCode\\",\\n    \\"lifeCycleTime\\": \\"@timeLifeCycle\\",\\n    \\"executionTime\\": \\"@timeExecution\\",\\n    \\"value\\"        : \\"@resultData\\"\\n}","wrapParameterName":"root"}', '1635228009595', '1636609551642', null);
INSERT INTO interface_info (api_id, api_method, api_path, api_status, api_comment, api_type, api_script, api_schema, api_sample, api_option, api_create_time, api_gmt_time, api_name) VALUES ('i_ekk0b7j2h-58l', 'GET', '/api/logdog/web/getCountByGroupByLogType', '1', '按年，月，日志类型进行数量汇总', 'DataQL', '// a new Query.
hint FRAGMENT_SQL_DATA_SOURCE = "logdog"
hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
// 定义查询SQL
var dataSet = @@mybatis(year,month)<%
<select>
    <if test="year != '''' and month != ''''">
     select log_type,record_year,record_month,record_day,count(log_type) as num from web_detail
     where record_year = #{year} and record_month = #{month}
     group by log_type,record_year,record_month,record_day
     order by record_month,record_day,num desc
    </if>
    <if test="year != '''' and month == ''''">
     select log_type,record_year,record_month,count(log_type) as num from web_detail
     where record_year = #{year}
     group by log_type,record_year,record_month
     order by record_month, num desc
    </if>
 </select>
%>

return dataSet(${year},${month});
', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"month":{"type":"string"},"year":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"array","items":{"type":"object","properties":{"log_type":{"type":"string"},"record_year":{"type":"number"},"num":{"type":"number"},"record_month":{"type":"number"}}}}}}}', '{"requestHeader":"[]","requestBody":"{\\n  \\"year\\": \\"2021\\",\\n  \\"month\\":\\"\\"\\n}","responseHeader":"{}","responseBody":"{\\n\\t\\"success\\":true,\\n\\t\\"message\\":\\"OK\\",\\n\\t\\"code\\":0,\\n\\t\\"lifeCycleTime\\":7,\\n\\t\\"executionTime\\":5,\\n\\t\\"value\\":[\\n\\t\\t{\\n\\t\\t\\t\\"log_type\\":\\"info\\",\\n\\t\\t\\t\\"record_year\\":2021,\\n\\t\\t\\t\\"record_month\\":12,\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"log_type\\":\\"page\\",\\n\\t\\t\\t\\"record_year\\":2021,\\n\\t\\t\\t\\"record_month\\":12,\\n\\t\\t\\t\\"num\\":3\\n\\t\\t}\\n\\t]\\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"0242AC120002","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\\n    \\"success\\"      : \\"@resultStatus\\",\\n    \\"message\\"      : \\"@resultMessage\\",\\n    \\"code\\"         : \\"@resultCode\\",\\n    \\"lifeCycleTime\\": \\"@timeLifeCycle\\",\\n    \\"executionTime\\": \\"@timeExecution\\",\\n    \\"value\\"        : \\"@resultData\\"\\n}","wrapParameterName":"root"}', '1636609643777', '1638423431842', null);
INSERT INTO interface_info (api_id, api_method, api_path, api_status, api_comment, api_type, api_script, api_schema, api_sample, api_option, api_create_time, api_gmt_time, api_name) VALUES ('i_ekk0dh6f89d1n', 'GET', '/api/logdog/web/getCount', '1', '统计每天每个设备每个日志类型的个数', 'DataQL', '// a new Query.
hint FRAGMENT_SQL_DATA_SOURCE = "logdog"
hint FRAGMENT_SQL_QUERY_BY_PAGE = true
hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
//从 1 开始作为页码的启始编号
hint FRAGMENT_SQL_QUERY_BY_PAGE_NUMBER_OFFSET = 1
// 定义查询SQL
var dataSet = @@mybatis(year,month,day, logType)<%
<select>
    select t.device_name,t.device_id,t.obj_type,t.log_date, count(d.id) as num from web_detail d
    inner join web_task t on d.task_id = t.id
    where d.record_year = #{year} and d.record_month = #{month}
        and d.record_day = #{day} and d.log_type = #{logType} and  d.task_id != 0

    group by t.device_name,t.device_id,t.obj_type,log_date order by   num desc


 </select>
%>

// 创建分页查询对象
var pageQuery =  dataSet(${year},${month},${day},${logType});

// 设置分页信息
run pageQuery.setPageInfo({
    "pageSize"    : ${pageSize}, // 页大小
    "currentPage" : ${pageNo}   // 第1页
});

// 执行分页查询
return {
    "pageInfo":pageQuery.pageInfo(),
    "pageData":pageQuery.data()
}
', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"logType":{"type":"string"},"month":{"type":"string"},"year":{"type":"string"},"day":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"array","items":{"type":"object","properties":{"device_name":{"type":"string"},"num":{"type":"number"}}}}}}}', '{"requestHeader":"[]","requestBody":"{\\n  \\"year\\": \\"2021\\",\\n  \\"month\\":\\"11\\",\\n  \\"day\\":\\"2\\",\\n  \\"logType\\":\\"info\\"\\n}","responseHeader":"{}","responseBody":"{\\n\\t\\"success\\":true,\\n\\t\\"message\\":\\"OK\\",\\n\\t\\"code\\":0,\\n\\t\\"lifeCycleTime\\":233,\\n\\t\\"executionTime\\":159,\\n\\t\\"value\\":[\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":4\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":4\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":4\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":4\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":4\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":4\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":4\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":4\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":4\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":4\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":4\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":4\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":4\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":4\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":4\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":4\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":4\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":4\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":4\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":4\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":5\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":5\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":5\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":5\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":5\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":5\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":5\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":6\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":7\\n\\t\\t}\\n\\t]\\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"0242AC120002","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\\n    \\"success\\"      : \\"@resultStatus\\",\\n    \\"message\\"      : \\"@resultMessage\\",\\n    \\"code\\"         : \\"@resultCode\\",\\n    \\"lifeCycleTime\\": \\"@timeLifeCycle\\",\\n    \\"executionTime\\": \\"@timeExecution\\",\\n    \\"value\\"        : \\"@resultData\\"\\n}","wrapParameterName":"root"}', '1636610438384', '1636612169075', null);


INSERT INTO interface_release (pub_id, pub_api_id, pub_method, pub_path, pub_status, pub_type, pub_script, pub_script_ori, pub_schema, pub_sample, pub_option, pub_release_time, pub_comment) VALUES ('r_ekk0a8nh4-abe', 'i_eje2anaa294f4', 'GET', '/api/logdog/web/queryLogType', '1', 'DataQL', '// a new Query.
// SQL 执行器切换为分页模式
hint FRAGMENT_SQL_DATA_SOURCE = "logdog"
hint FRAGMENT_SQL_QUERY_BY_PAGE = true
hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
//从 1 开始作为页码的启始编号
hint FRAGMENT_SQL_QUERY_BY_PAGE_NUMBER_OFFSET = 1
// 定义查询SQL

var dataSet = @@mybatis()<%
<select>
select date,log_type as logType,COUNT(log_type) as count from
(
select FROM_UNIXTIME(left(log_time,10),''%Y%m%d'') as date, log_type from web_detail a
where exists(select * from web_task b where a.task_id = b.id)
) b
group by date,log_type
 </select>
%>
// 创建分页查询对象
var pageQuery =  dataSet();
// 设置分页信息
run pageQuery.setPageInfo({
    "pageSize"    : ${pageSize}, // 页大小
    "currentPage" : ${pageNo}   // 第1页
});
// 执行分页查询
return {
    "pageInfo":pageQuery.pageInfo(),
    "pageData":pageQuery.data()
}', '// a new Query.
// SQL 执行器切换为分页模式
hint FRAGMENT_SQL_DATA_SOURCE = "logdog"
hint FRAGMENT_SQL_QUERY_BY_PAGE = true
hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
//从 1 开始作为页码的启始编号
hint FRAGMENT_SQL_QUERY_BY_PAGE_NUMBER_OFFSET = 1
// 定义查询SQL

var dataSet = @@mybatis()<%
<select>
select date,log_type as logType,COUNT(log_type) as count from
(
select FROM_UNIXTIME(left(log_time,10),''%Y%m%d'') as date, log_type from web_detail a
where exists(select * from web_task b where a.task_id = b.id)
) b
group by date,log_type
 </select>
%>
// 创建分页查询对象
var pageQuery =  dataSet();
// 设置分页信息
run pageQuery.setPageInfo({
    "pageSize"    : ${pageSize}, // 页大小
    "currentPage" : ${pageNo}   // 第1页
});
// 执行分页查询
return {
    "pageInfo":pageQuery.pageInfo(),
    "pageData":pageQuery.data()
}', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"pageSize":{"type":"number"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"object","properties":{"pageInfo":{"type":"object","properties":{"recordPosition":{"type":"number"},"enable":{"type":"boolean"},"totalPage":{"type":"number"},"pageSize":{"type":"number"},"totalCount":{"type":"number"},"currentPage":{"type":"number"}}},"pageData":{"type":"array","items":{"type":"object","properties":{"date":{"type":"string"},"logType":{"type":"string"},"count":{"type":"number"}}}}}}}}}', '{"requestHeader":"[]","requestBody":"{\\"pageSize\\":1}","responseHeader":"{}","responseBody":"{\\n\\t\\"success\\":true,\\n\\t\\"message\\":\\"OK\\",\\n\\t\\"code\\":0,\\n\\t\\"lifeCycleTime\\":469,\\n\\t\\"executionTime\\":384,\\n\\t\\"value\\":{\\n\\t\\t\\"pageInfo\\":{\\n\\t\\t\\t\\"enable\\":true,\\n\\t\\t\\t\\"pageSize\\":1,\\n\\t\\t\\t\\"totalCount\\":7,\\n\\t\\t\\t\\"totalPage\\":7,\\n\\t\\t\\t\\"currentPage\\":1,\\n\\t\\t\\t\\"recordPosition\\":0\\n\\t\\t},\\n\\t\\t\\"pageData\\":[\\n\\t\\t\\t{\\n\\t\\t\\t\\t\\"date\\":\\"20211029\\",\\n\\t\\t\\t\\t\\"logType\\":\\"info\\",\\n\\t\\t\\t\\t\\"count\\":3\\n\\t\\t\\t}\\n\\t\\t]\\n\\t}\\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"024234752F01,0050569D4242,0242A8A12CFC","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\\n    \\"success\\"      : \\"@resultStatus\\",\\n    \\"message\\"      : \\"@resultMessage\\",\\n    \\"code\\"         : \\"@resultCode\\",\\n    \\"lifeCycleTime\\": \\"@timeLifeCycle\\",\\n    \\"executionTime\\": \\"@timeExecution\\",\\n    \\"value\\"        : \\"@resultData\\"\\n}","wrapParameterName":"root"}', '1636609328476', '每天的日志类型数汇总');

INSERT INTO interface_release (pub_id, pub_api_id, pub_method, pub_path, pub_status, pub_type, pub_script, pub_script_ori, pub_schema, pub_sample, pub_option, pub_release_time, pub_comment) VALUES ('r_en0n4me0d-4hk', 'i_ekcijfdd53f1k', 'GET', '/api/logdog/web/dateLogIndex', '1', 'DataQL', '// a new Query.
// SQL 执行器切换为分页模式
hint FRAGMENT_SQL_DATA_SOURCE = "logdog"
hint FRAGMENT_SQL_QUERY_BY_PAGE = true
hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
//从 1 开始作为页码的启始编号
hint FRAGMENT_SQL_QUERY_BY_PAGE_NUMBER_OFFSET = 1
// 定义查询SQL

var dataSet = @@mybatis(logDate,deviceId,content,logType,logOrder,startTime,endTime)<%
<select>

select b.* from web_task a left join web_detail  b on a.id = b.task_id where 1=1
    <if test="logDate != ''''">
        and a.log_date = #{logDate}
    </if>
    <if test="deviceId != ''''">
        and a.device_id = #{deviceId}
    </if>
    <if test="content != ''''">
        and b.content like concat(''%'', #{content},''%'')
    </if>
    <if test="logType != ''''">
     and b.log_type in
     <foreach collection="logType.split('','')" item="id" open="(" close=")" separator=",">
        #{id}
     </foreach>
    </if>
    <if test="content != ''''">
        and b.content like concat(''%'', #{content},''%'')
    </if>
    <if test="startTime != '''' and endTime != '''' ">
        and b.log_time between #{startTime} and #{endTime}
    </if>
    <if test="logOrder == ''''">
       order by b.log_time  asc
    </if>
     <if test="logOrder != ''''">
       order by b.log_time desc
    </if>
 </select>
%>
// 创建分页查询对象
var pageQuery =  dataSet(${logDate},${deviceId},${content},${logType},${logOrder},${startTime},${endTime});
// 设置分页信息
run pageQuery.setPageInfo({
    "pageSize"    : ${pageSize}, // 页大小
    "currentPage" : ${pageNo}   // 第1页
});
// 执行分页查询
return {
    "pageInfo":pageQuery.pageInfo(),
    "pageData":pageQuery.data()
}', '// a new Query.
// SQL 执行器切换为分页模式
hint FRAGMENT_SQL_DATA_SOURCE = "logdog"
hint FRAGMENT_SQL_QUERY_BY_PAGE = true
hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
//从 1 开始作为页码的启始编号
hint FRAGMENT_SQL_QUERY_BY_PAGE_NUMBER_OFFSET = 1
// 定义查询SQL

var dataSet = @@mybatis(logDate,deviceId,content,logType,logOrder,startTime,endTime)<%
<select>

select b.* from web_task a left join web_detail  b on a.id = b.task_id where 1=1
    <if test="logDate != ''''">
        and a.log_date = #{logDate}
    </if>
    <if test="deviceId != ''''">
        and a.device_id = #{deviceId}
    </if>
    <if test="content != ''''">
        and b.content like concat(''%'', #{content},''%'')
    </if>
    <if test="logType != ''''">
     and b.log_type in
     <foreach collection="logType.split('','')" item="id" open="(" close=")" separator=",">
        #{id}
     </foreach>
    </if>
    <if test="content != ''''">
        and b.content like concat(''%'', #{content},''%'')
    </if>
    <if test="startTime != '''' and endTime != '''' ">
        and b.log_time between #{startTime} and #{endTime}
    </if>
    <if test="logOrder == ''''">
       order by b.log_time  asc
    </if>
     <if test="logOrder != ''''">
       order by b.log_time desc
    </if>
 </select>
%>
// 创建分页查询对象
var pageQuery =  dataSet(${logDate},${deviceId},${content},${logType},${logOrder},${startTime},${endTime});
// 设置分页信息
run pageQuery.setPageInfo({
    "pageSize"    : ${pageSize}, // 页大小
    "currentPage" : ${pageNo}   // 第1页
});
// 执行分页查询
return {
    "pageInfo":pageQuery.pageInfo(),
    "pageData":pageQuery.data()
}', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"logType":{"type":"string"},"logDate":{"type":"string"},"pageNo":{"type":"number"},"pageSize":{"type":"number"},"startTime":{"type":"string"},"endTime":{"type":"string"},"deviceId":{"type":"string"},"content":{"type":"string"},"logOrder":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"object","properties":{"pageInfo":{"type":"object","properties":{"recordPosition":{"type":"number"},"enable":{"type":"boolean"},"totalPage":{"type":"number"},"pageSize":{"type":"number"},"totalCount":{"type":"number"},"currentPage":{"type":"number"}}},"pageData":{"type":"array","items":{"type":"object","properties":{"minute_offset":{"type":["string","boolean","number","object","array","null"]},"custom_report_info":{"type":["string","boolean","number","object","array","null"]},"record_year":{"type":["string","boolean","number","object","array","null"]},"log_level":{"type":["string","boolean","number","object","array","null"]},"task_id":{"type":["string","boolean","number","object","array","null"]},"content":{"type":["string","boolean","number","object","array","null"]},"log_time":{"type":["string","boolean","number","object","array","null"]},"web_source":{"type":["string","boolean","number","object","array","null"]},"log_type":{"type":["string","boolean","number","object","array","null"]},"environment":{"type":["string","boolean","number","object","array","null"]},"id":{"type":["string","boolean","number","object","array","null"]},"record_month":{"type":["string","boolean","number","object","array","null"]},"record_day":{"type":["string","boolean","number","object","array","null"]},"add_time":{"type":["string","boolean","number","object","array","null"]}}}}}}}}}', '{"requestHeader":"[]","requestBody":"{\\n\\"logDate\\":\\"\\",\\n\\"deviceId\\":\\"\\",\\n\\"content\\":\\"\\",\\n\\"logType\\":\\"\\", \\n\\"logOrder\\":\\"\\",\\n\\"startTime\\":\\"\\",\\n\\"endTime\\":\\"\\",\\n\\"pageNo\\": 1,\\n\\"pageSize\\": 1\\n}","responseHeader":"{}","responseBody":"{\\n\\t\\"success\\":true,\\n\\t\\"message\\":\\"OK\\",\\n\\t\\"code\\":0,\\n\\t\\"lifeCycleTime\\":2787,\\n\\t\\"executionTime\\":2778,\\n\\t\\"value\\":{\\n\\t\\t\\"pageInfo\\":{\\n\\t\\t\\t\\"enable\\":true,\\n\\t\\t\\t\\"pageSize\\":1,\\n\\t\\t\\t\\"totalCount\\":284759,\\n\\t\\t\\t\\"totalPage\\":284759,\\n\\t\\t\\t\\"currentPage\\":1,\\n\\t\\t\\t\\"recordPosition\\":0\\n\\t\\t},\\n\\t\\t\\"pageData\\":[\\n\\t\\t\\t{\\n\\t\\t\\t}\\n\\t\\t]\\n\\t}\\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"0242AC140002","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\\n    \\"success\\"      : \\"@resultStatus\\",\\n    \\"message\\"      : \\"@resultMessage\\",\\n    \\"code\\"         : \\"@resultCode\\",\\n    \\"lifeCycleTime\\": \\"@timeLifeCycle\\",\\n    \\"executionTime\\": \\"@timeExecution\\",\\n    \\"value\\"        : \\"@resultData\\"\\n}","wrapParameterName":"root"}', '1646728020877', '一天日志的时间索引');


INSERT INTO interface_release (pub_id, pub_api_id, pub_method, pub_path, pub_status, pub_type, pub_script, pub_script_ori, pub_schema, pub_sample, pub_option, pub_release_time, pub_comment) VALUES ('r_ekk0aj519-665', 'i_eje447n2h-190', 'GET', '/api/logdog/web/querySystems', '1', 'DataQL', 'hint FRAGMENT_SQL_DATA_SOURCE = "logdog"
var dataSet = @@sql()<%
    select   count(distinct device_id)    from web_task;
%>
return dataSet(); ', 'hint FRAGMENT_SQL_DATA_SOURCE = "logdog"
var dataSet = @@sql()<%
    select   count(distinct device_id)    from web_task;
%>
return dataSet(); ', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"message":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"number"}}}}', '{"requestHeader":"[]","requestBody":"{\\"message\\":\\"Hello DataQL.\\"}","responseHeader":"{}","responseBody":"{\\n\\t\\"success\\":true,\\n\\t\\"message\\":\\"OK\\",\\n\\t\\"code\\":0,\\n\\t\\"lifeCycleTime\\":231,\\n\\t\\"executionTime\\":155,\\n\\t\\"value\\":202\\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"024234752F01,0050569D4242,0242A8A12CFC","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\\n    \\"success\\"      : \\"@resultStatus\\",\\n    \\"message\\"      : \\"@resultMessage\\",\\n    \\"code\\"         : \\"@resultCode\\",\\n    \\"lifeCycleTime\\": \\"@timeLifeCycle\\",\\n    \\"executionTime\\": \\"@timeExecution\\",\\n    \\"value\\"        : \\"@resultData\\"\\n}","wrapParameterName":"root"}', '1636609469793', '系统连接数');
INSERT INTO interface_release (pub_id, pub_api_id, pub_method, pub_path, pub_status, pub_type, pub_script, pub_script_ori, pub_schema, pub_sample, pub_option, pub_release_time, pub_comment) VALUES ('r_ekk0an87875f1', 'i_eje47e17d-4be', 'GET', '/api/logdog/web/runtime', '1', 'DataQL', 'hint FRAGMENT_SQL_DATA_SOURCE = "logdog"
var dataSet = @@sql()<%
  select ROUND( MAX(log_date)/1000/3600/24 - MIN(log_date)/1000/3600/24)+1 from web_task;
%>
return dataSet(); ', 'hint FRAGMENT_SQL_DATA_SOURCE = "logdog"
var dataSet = @@sql()<%
  select ROUND( MAX(log_date)/1000/3600/24 - MIN(log_date)/1000/3600/24)+1 from web_task;
%>
return dataSet(); ', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"message":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"number"}}}}', '{"requestHeader":"[]","requestBody":"{\\"message\\":\\"Hello DataQL.\\"}","responseHeader":"{}","responseBody":"{\\n\\t\\"success\\":true,\\n\\t\\"message\\":\\"OK\\",\\n\\t\\"code\\":0,\\n\\t\\"lifeCycleTime\\":233,\\n\\t\\"executionTime\\":156,\\n\\t\\"value\\":5\\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"024234752F01,0050569D4242,0242A8A12CFC","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\\n    \\"success\\"      : \\"@resultStatus\\",\\n    \\"message\\"      : \\"@resultMessage\\",\\n    \\"code\\"         : \\"@resultCode\\",\\n    \\"lifeCycleTime\\": \\"@timeLifeCycle\\",\\n    \\"executionTime\\": \\"@timeExecution\\",\\n    \\"value\\"        : \\"@resultData\\"\\n}","wrapParameterName":"root"}', '1636609526961', '运行时长');
INSERT INTO interface_release (pub_id, pub_api_id, pub_method, pub_path, pub_status, pub_type, pub_script, pub_script_ori, pub_schema, pub_sample, pub_option, pub_release_time, pub_comment) VALUES ('r_ekk0b13752ieb', 'i_ekcimn4fi77l7', 'GET', '/api/logdog/web/queryLogSize', '1', 'SQL', 'var tempCall = @@sql(`message`)<%select concat(round(sum(data_length/1024/1024),2)) as data from information_schema.TABLES where table_schema=''logdog'' and (table_name = ''web_task''
or table_name = ''web_detail'')%>;
return tempCall(${message});', 'select concat(round(sum(data_length/1024/1024),2)) as data from information_schema.TABLES where table_schema=''logdog'' and (table_name = ''web_task''
or table_name = ''web_detail'')', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"message":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"string"}}}}', '{"requestHeader":"[]","requestBody":"{\\"message\\":\\"Hello DataQL.\\"}","responseHeader":"{}","responseBody":"{\\n\\t\\"success\\":true,\\n\\t\\"message\\":\\"OK\\",\\n\\t\\"code\\":0,\\n\\t\\"lifeCycleTime\\":156,\\n\\t\\"executionTime\\":75,\\n\\t\\"value\\":\\"153.08\\"\\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"0242AC150002","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\\n    \\"success\\"      : \\"@resultStatus\\",\\n    \\"message\\"      : \\"@resultMessage\\",\\n    \\"code\\"         : \\"@resultCode\\",\\n    \\"lifeCycleTime\\": \\"@timeLifeCycle\\",\\n    \\"executionTime\\": \\"@timeExecution\\",\\n    \\"value\\"        : \\"@resultData\\"\\n}","wrapParameterName":"root"}', '1636609551725', '日志大小');
INSERT INTO interface_release (pub_id, pub_api_id, pub_method, pub_path, pub_status, pub_type, pub_script, pub_script_ori, pub_schema, pub_sample, pub_option, pub_release_time, pub_comment) VALUES ('r_ekk0imbbl940i', 'i_ekk0dh6f89d1n', 'GET', '/api/logdog/web/getCount', '1', 'DataQL', '// a new Query.
hint FRAGMENT_SQL_DATA_SOURCE = "logdog"
hint FRAGMENT_SQL_QUERY_BY_PAGE = true
hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
//从 1 开始作为页码的启始编号
hint FRAGMENT_SQL_QUERY_BY_PAGE_NUMBER_OFFSET = 1
// 定义查询SQL
var dataSet = @@mybatis(year,month,day, logType)<%
<select>
    select t.device_name,t.device_id,t.obj_type,t.log_date, count(d.id) as num from web_detail d
    inner join web_task t on d.task_id = t.id
    where d.record_year = #{year} and d.record_month = #{month}
        and d.record_day = #{day} and d.log_type = #{logType} and  d.task_id != 0

    group by t.device_name,t.device_id,t.obj_type,log_date order by   num desc


 </select>
%>
// 创建分页查询对象
var pageQuery =  dataSet(${year},${month},${day},${logType});

// 设置分页信息
run pageQuery.setPageInfo({
    "pageSize"    : ${pageSize}, // 页大小
    "currentPage" : ${pageNo}   // 第1页
});

// 执行分页查询
return {
    "pageInfo":pageQuery.pageInfo(),
    "pageData":pageQuery.data()
}
', '// a new Query.
hint FRAGMENT_SQL_DATA_SOURCE = "logdog"
hint FRAGMENT_SQL_QUERY_BY_PAGE = true
hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
//从 1 开始作为页码的启始编号
hint FRAGMENT_SQL_QUERY_BY_PAGE_NUMBER_OFFSET = 1
// 定义查询SQL
var dataSet = @@mybatis(year,month,day, logType)<%
<select>
    select t.device_name,t.device_id,t.obj_type,t.log_date, count(d.id) as num from web_detail d
    inner join web_task t on d.task_id = t.id
    where d.record_year = #{year} and d.record_month = #{month}
        and d.record_day = #{day} and d.log_type = #{logType} and  d.task_id != 0

    group by t.device_name,t.device_id,t.obj_type,log_date order by   num desc


 </select>
%>
// 创建分页查询对象
var pageQuery =  dataSet(${year},${month},${day},${logType});

// 设置分页信息
run pageQuery.setPageInfo({
    "pageSize"    : ${pageSize}, // 页大小
    "currentPage" : ${pageNo}   // 第1页
});

// 执行分页查询
return {
    "pageInfo":pageQuery.pageInfo(),
    "pageData":pageQuery.data()
}
', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"logType":{"type":"string"},"month":{"type":"string"},"year":{"type":"string"},"day":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"array","items":{"type":"object","properties":{"device_name":{"type":"string"},"num":{"type":"number"}}}}}}}', '{"requestHeader":"[]","requestBody":"{\\n  \\"year\\": \\"2021\\",\\n  \\"month\\":\\"11\\",\\n  \\"day\\":\\"2\\",\\n  \\"logType\\":\\"info\\"\\n}","responseHeader":"{}","responseBody":"{\\n\\t\\"success\\":true,\\n\\t\\"message\\":\\"OK\\",\\n\\t\\"code\\":0,\\n\\t\\"lifeCycleTime\\":233,\\n\\t\\"executionTime\\":159,\\n\\t\\"value\\":[\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":1\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":2\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":4\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":4\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":4\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":4\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":4\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":4\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":4\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":4\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":4\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":4\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":4\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":4\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":4\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":4\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":4\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":4\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":4\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":4\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":4\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":4\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":5\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":5\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":5\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":5\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":5\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":5\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":5\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":6\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"num\\":7\\n\\t\\t}\\n\\t]\\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"0242AC120002","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\\n    \\"success\\"      : \\"@resultStatus\\",\\n    \\"message\\"      : \\"@resultMessage\\",\\n    \\"code\\"         : \\"@resultCode\\",\\n    \\"lifeCycleTime\\": \\"@timeLifeCycle\\",\\n    \\"executionTime\\": \\"@timeExecution\\",\\n    \\"value\\"        : \\"@resultData\\"\\n}","wrapParameterName":"root"}', '1636612169182', '统计每天每个设备每个日志类型的个数');
INSERT INTO interface_release (pub_id, pub_api_id, pub_method, pub_path, pub_status, pub_type, pub_script, pub_script_ori, pub_schema, pub_sample, pub_option, pub_release_time, pub_comment) VALUES ('r_el5c65chemb8h', 'i_ekk0b7j2h-58l', 'GET', '/api/logdog/web/getCountByGroupByLogType', '1', 'DataQL', '// a new Query.
hint FRAGMENT_SQL_DATA_SOURCE = "logdog"
hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
// 定义查询SQL
var dataSet = @@mybatis(year,month)<%
<select>
    <if test="year != '''' and month != ''''">
     select log_type,record_year,record_month,record_day,count(log_type) as num from web_detail
     where record_year = #{year} and record_month = #{month}
     group by log_type,record_year,record_month,record_day
     order by record_month,record_day,num desc
    </if>
    <if test="year != '''' and month == ''''">
     select log_type,record_year,record_month,count(log_type) as num from web_detail
     where record_year = #{year}
     group by log_type,record_year,record_month
     order by record_month, num desc
    </if>
 </select>
%>

return dataSet(${year},${month});
', '// a new Query.
hint FRAGMENT_SQL_DATA_SOURCE = "logdog"
hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
// 定义查询SQL
var dataSet = @@mybatis(year,month)<%
<select>
    <if test="year != '''' and month != ''''">
     select log_type,record_year,record_month,record_day,count(log_type) as num from web_detail
     where record_year = #{year} and record_month = #{month}
     group by log_type,record_year,record_month,record_day
     order by record_month,record_day,log_type
    </if>
    <if test="year != '''' and month == ''''">
     select log_type,record_year,record_month,count(log_type) as num from web_detail
     where record_year = #{year}
     group by log_type,record_year,record_month
     order by record_month, log_type
    </if>
 </select>
%>

return dataSet(${year},${month});
', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"month":{"type":"string"},"year":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"array","items":{"type":"object","properties":{"log_type":{"type":"string"},"record_year":{"type":"number"},"num":{"type":"number"},"record_month":{"type":"number"}}}}}}}', '{"requestHeader":"[]","requestBody":"{\\n  \\"year\\": \\"2021\\",\\n  \\"month\\":\\"\\"\\n}","responseHeader":"{}","responseBody":"{\\n\\t\\"success\\":true,\\n\\t\\"message\\":\\"OK\\",\\n\\t\\"code\\":0,\\n\\t\\"lifeCycleTime\\":7,\\n\\t\\"executionTime\\":5,\\n\\t\\"value\\":[\\n\\t\\t{\\n\\t\\t\\t\\"log_type\\":\\"info\\",\\n\\t\\t\\t\\"record_year\\":2021,\\n\\t\\t\\t\\"record_month\\":12,\\n\\t\\t\\t\\"num\\":3\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"log_type\\":\\"page\\",\\n\\t\\t\\t\\"record_year\\":2021,\\n\\t\\t\\t\\"record_month\\":12,\\n\\t\\t\\t\\"num\\":3\\n\\t\\t}\\n\\t]\\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"0242AC120002","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\\n    \\"success\\"      : \\"@resultStatus\\",\\n    \\"message\\"      : \\"@resultMessage\\",\\n    \\"code\\"         : \\"@resultCode\\",\\n    \\"lifeCycleTime\\": \\"@timeLifeCycle\\",\\n    \\"executionTime\\": \\"@timeExecution\\",\\n    \\"value\\"        : \\"@resultData\\"\\n}","wrapParameterName":"root"}', '1638423431846', '按年，月，日志类型进行数量汇总');
INSERT INTO interface_release (pub_id, pub_api_id, pub_method, pub_path, pub_status, pub_type, pub_script, pub_script_ori, pub_schema, pub_sample, pub_option, pub_release_time, pub_comment) VALUES ('r_em267mghd-nka', 'i_ejf0k4m547nb5', 'GET', '/api/logdog/web/queryTotalPage', '1', 'DataQL', 'hint FRAGMENT_SQL_DATA_SOURCE = "logdog"
var dataSet = @@sql()<%
select count(*) from web_detail;
%>
return dataSet(); ', 'hint FRAGMENT_SQL_DATA_SOURCE = "logdog"
var dataSet = @@sql()<%
select count(*) from web_detail;
%>
return dataSet(); ', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"message":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"number"}}}}', '{"requestHeader":"[]","requestBody":"{\\"message\\":\\"Hello DataQL.\\"}","responseHeader":"{}","responseBody":"{\\n\\t\\"success\\":true,\\n\\t\\"message\\":\\"OK\\",\\n\\t\\"code\\":0,\\n\\t\\"lifeCycleTime\\":31,\\n\\t\\"executionTime\\":29,\\n\\t\\"value\\":11252\\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"024234752F01,0050569D4242,0242A8A12CFC","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\\n    \\"success\\"      : \\"@resultStatus\\",\\n    \\"message\\"      : \\"@resultMessage\\",\\n    \\"code\\"         : \\"@resultCode\\",\\n    \\"lifeCycleTime\\": \\"@timeLifeCycle\\",\\n    \\"executionTime\\": \\"@timeExecution\\",\\n    \\"value\\"        : \\"@resultData\\"\\n}","wrapParameterName":"root"}', '1642389387685', '日志总分片数');
INSERT INTO interface_release (pub_id, pub_api_id, pub_method, pub_path, pub_status, pub_type, pub_script, pub_script_ori, pub_schema, pub_sample, pub_option, pub_release_time, pub_comment) VALUES ('r_em284g0em30im', 'i_eje29j14a-ag8', 'GET', '/api/logdog/web/queryLogCount', '1', 'DataQL', 'hint FRAGMENT_SQL_DATA_SOURCE = "logdog"
hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
var dataSet = @@sql()<%
select * from (
select b.device_id,b.device_name,count(a.id) as log_count from web_detail a
inner join web_task b on a.task_id = b.id where b.device_name <> ''''
group by b.device_id, b.device_name) a order by a.log_count desc limit 10;
%>
return dataSet(); ', 'hint FRAGMENT_SQL_DATA_SOURCE = "logdog"
hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
var dataSet = @@sql()<%
select * from (
select b.device_id,b.device_name,count(a.id) as log_count from web_detail a
inner join web_task b on a.task_id = b.id where b.device_name <> ''''
group by b.device_id, b.device_name) a order by a.log_count desc limit 10;
%>
return dataSet(); ', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"array","items":{"type":"object","properties":{"device_name":{"type":"string"},"log_count":{"type":"number"},"device_id":{"type":"string"}}}}}}}', '{"requestHeader":"[]","requestBody":"{}","responseHeader":"{}","responseBody":"{\\n\\t\\"success\\":true,\\n\\t\\"message\\":\\"OK\\",\\n\\t\\"code\\":0,\\n\\t\\"lifeCycleTime\\":14,\\n\\t\\"executionTime\\":12,\\n\\t\\"value\\":[\\n\\t\\t{\\n\\t\\t\\t\\"device_id\\":\\"test1\\",\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"log_count\\":114\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_id\\":\\"test3\\",\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"log_count\\":112\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_id\\":\\"test2\\",\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"log_count\\":112\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_id\\":\\"test5\\",\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"log_count\\":112\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_id\\":\\"test8\\",\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"log_count\\":112\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_id\\":\\"test10\\",\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"log_count\\":112\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_id\\":\\"test6\\",\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"log_count\\":112\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_id\\":\\"test4\\",\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"log_count\\":112\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_id\\":\\"test9\\",\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"log_count\\":112\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"device_id\\":\\"test7\\",\\n\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\"log_count\\":112\\n\\t\\t}\\n\\t]\\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"024234752F01,0050569D4242,0242A8A12CFC","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\\n    \\"success\\"      : \\"@resultStatus\\",\\n    \\"message\\"      : \\"@resultMessage\\",\\n    \\"code\\"         : \\"@resultCode\\",\\n    \\"lifeCycleTime\\": \\"@timeLifeCycle\\",\\n    \\"executionTime\\": \\"@timeExecution\\",\\n    \\"value\\"        : \\"@resultData\\"\\n}","wrapParameterName":"root"}', '1642404225382', '统计日志记录排行');
INSERT INTO interface_release (pub_id, pub_api_id, pub_method, pub_path, pub_status, pub_type, pub_script, pub_script_ori, pub_schema, pub_sample, pub_option, pub_release_time, pub_comment) VALUES ('r_em28907j4848f', 'i_eje2kj4bljclm', 'GET', '/api/logdog/web/queryTaskByDate', '1', 'DataQL', 'hint FRAGMENT_SQL_DATA_SOURCE = "logdog"
hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
hint FRAGMENT_SQL_QUERY_BY_PAGE = true
hint FRAGMENT_SQL_QUERY_BY_PAGE_NUMBER_OFFSET = 1


var dataSet = @@mybatis(deviceId,startDate,endDate)<%
<select>
select b.device_id,b.log_date,count(a.id) log_count from web_detail a
inner join web_task b on a.task_id = b.id
where b.device_name != ''''
    <if test="deviceId != ''''">
        and  b.device_id = #{deviceId}
   </if>
   <if test="startDate != '''' and endDate != ''''">
        and  b.log_date between #{startDate} and #{endDate}
   </if>
group by b.device_id,b.log_date order by b.log_date desc
 </select>
%>

// 创建分页查询对象
var pageQuery =  dataSet(${deviceId},${startDate},${endDate});
// 设置分页信息
run pageQuery.setPageInfo({
    "pageSize"    : ${pageSize}, // 页大小
    "currentPage" : ${pageNo}   // 第1页
});
// 执行分页查询
return {
    "pageInfo":pageQuery.pageInfo(),
    "pageData":pageQuery.data()
}', 'hint FRAGMENT_SQL_DATA_SOURCE = "logdog"
hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
hint FRAGMENT_SQL_QUERY_BY_PAGE = true
hint FRAGMENT_SQL_QUERY_BY_PAGE_NUMBER_OFFSET = 1


var dataSet = @@mybatis(deviceId,startDate,endDate)<%
<select>
select b.device_id,b.log_date,count(a.id) log_count from web_detail a
inner join web_task b on a.task_id = b.id
where b.device_name != ''''
    <if test="deviceId != ''''">
        and  b.device_id = #{deviceId}
   </if>
   <if test="startDate != '''' and endDate != ''''">
        and  b.log_date between #{startDate} and #{endDate}
   </if>
group by b.device_id,b.log_date order by b.log_date desc
 </select>
%>

// 创建分页查询对象
var pageQuery =  dataSet(${deviceId},${startDate},${endDate});
// 设置分页信息
run pageQuery.setPageInfo({
    "pageSize"    : ${pageSize}, // 页大小
    "currentPage" : ${pageNo}   // 第1页
});
// 执行分页查询
return {
    "pageInfo":pageQuery.pageInfo(),
    "pageData":pageQuery.data()
}', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"deviceId":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"object","properties":{"pageInfo":{"type":"object","properties":{"recordPosition":{"type":"number"},"enable":{"type":"boolean"},"totalPage":{"type":"number"},"pageSize":{"type":"number"},"totalCount":{"type":"number"},"currentPage":{"type":"number"}}},"pageData":{"type":"array","items":{"type":["string","boolean","number","object","array","null"]}}}}}}}', '{"requestHeader":"[]","requestBody":"{\\"deviceId\\":\\"\\"}","responseHeader":"{}","responseBody":"{\\n\\t\\"success\\":true,\\n\\t\\"message\\":\\"OK\\",\\n\\t\\"code\\":0,\\n\\t\\"lifeCycleTime\\":17,\\n\\t\\"executionTime\\":8,\\n\\t\\"value\\":{\\n\\t\\t\\"pageInfo\\":{\\n\\t\\t\\t\\"enable\\":false,\\n\\t\\t\\t\\"pageSize\\":-1,\\n\\t\\t\\t\\"totalCount\\":0,\\n\\t\\t\\t\\"totalPage\\":1,\\n\\t\\t\\t\\"currentPage\\":1,\\n\\t\\t\\t\\"recordPosition\\":0\\n\\t\\t},\\n\\t\\t\\"pageData\\":[]\\n\\t}\\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"024234752F01,0050569D4242,0242A8A12CFC","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\\n    \\"success\\"      : \\"@resultStatus\\",\\n    \\"message\\"      : \\"@resultMessage\\",\\n    \\"code\\"         : \\"@resultCode\\",\\n    \\"lifeCycleTime\\": \\"@timeLifeCycle\\",\\n    \\"executionTime\\": \\"@timeExecution\\",\\n    \\"value\\"        : \\"@resultData\\"\\n}","wrapParameterName":"root"}', '1642405667212', '系统日志按天汇总查询');
INSERT INTO interface_release (pub_id, pub_api_id, pub_method, pub_path, pub_status, pub_type, pub_script, pub_script_ori, pub_schema, pub_sample, pub_option, pub_release_time, pub_comment) VALUES ('r_em28alig4-94a', 'i_eje31jj424035', 'GET', '/api/logdog/web/query', '1', 'DataQL', '// a new Query.
// SQL 执行器切换为分页模式
hint FRAGMENT_SQL_DATA_SOURCE = "logdog"
hint FRAGMENT_SQL_QUERY_BY_PAGE = true
hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
//从 1 开始作为页码的启始编号
hint FRAGMENT_SQL_QUERY_BY_PAGE_NUMBER_OFFSET = 1
// 定义查询SQL

var dataSet = @@mybatis(deviceId,deviceName,objType,startDate,endDate)<%
<select>
select b.device_id,b.device_name,
       max(b.log_date) as last_log_date,
       max(b.obj_type) as obj_type,
       count(a.id) as log_count
from web_detail a
inner join web_task b on a.task_id = b.id
where b.device_name != ''''
    <if test="deviceId != ''''">
        and b.device_id = #{deviceId}
    </if>
    <if test="deviceName != ''''">
        and b.device_name  like concat(''%'', #{deviceName},''%'')
    </if>
    <if test="objType != ''''">
        and b.obj_type = #{objType}
    </if>
    <if test="startDate != '''' and endDate != ''''">
        and b.log_date between #{startDate} and #{endDate}
    </if>
group by b.device_id, b.device_name order by last_log_date desc,log_count desc
</select>
%>
// 创建分页查询对象
var pageQuery =  dataSet(${deviceId},${deviceName},${objType},${startDate},${endDate});
// 设置分页信息
run pageQuery.setPageInfo({
    "pageSize"    : ${pageSize}, // 页大小
    "currentPage" : ${pageNo}   // 第1页
});
// 执行分页查询
return {
    "pageInfo":pageQuery.pageInfo(),
    "pageData":pageQuery.data()
}', '// a new Query.
// SQL 执行器切换为分页模式
hint FRAGMENT_SQL_DATA_SOURCE = "logdog"
hint FRAGMENT_SQL_QUERY_BY_PAGE = true
hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
//从 1 开始作为页码的启始编号
hint FRAGMENT_SQL_QUERY_BY_PAGE_NUMBER_OFFSET = 1
// 定义查询SQL

var dataSet = @@mybatis(deviceId,deviceName,objType,startDate,endDate)<%
<select>
select b.device_id,b.device_name,
       max(b.log_date) as last_log_date,
       max(b.obj_type) as obj_type,
       count(a.id) as log_count
from web_detail a
inner join web_task b on a.task_id = b.id
where b.device_name != ''''
    <if test="deviceId != ''''">
        and b.device_id = #{deviceId}
    </if>
    <if test="deviceName != ''''">
        and b.device_name  like concat(''%'', #{deviceName},''%'')
    </if>
    <if test="objType != ''''">
        and b.obj_type = #{objType}
    </if>
    <if test="startDate != '''' and endDate != ''''">
        and b.log_date between #{startDate} and #{endDate}
    </if>
group by b.device_id, b.device_name order by last_log_date desc,log_count desc
</select>
%>
// 创建分页查询对象
var pageQuery =  dataSet(${deviceId},${deviceName},${objType},${startDate},${endDate});
// 设置分页信息
run pageQuery.setPageInfo({
    "pageSize"    : ${pageSize}, // 页大小
    "currentPage" : ${pageNo}   // 第1页
});
// 执行分页查询
return {
    "pageInfo":pageQuery.pageInfo(),
    "pageData":pageQuery.data()
}', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"endDate":{"type":"string"},"pageNo":{"type":"number"},"pageSize":{"type":"number"},"deviceId":{"type":"string"},"deviceName":{"type":"string"},"objType":{"type":"string"},"startDate":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"object","properties":{"pageInfo":{"type":"object","properties":{"recordPosition":{"type":"number"},"enable":{"type":"boolean"},"totalPage":{"type":"number"},"pageSize":{"type":"number"},"totalCount":{"type":"number"},"currentPage":{"type":"number"}}},"pageData":{"type":"array","items":{"type":"object","properties":{"device_name":{"type":"string"},"log_count":{"type":"number"},"device_id":{"type":"string"},"obj_type":{"type":"number"},"last_log_date":{"type":"number"}}}}}}}}}', '{"requestHeader":"[]","requestBody":"{\\"deviceId\\":\\"\\",\\r\\n\\"deviceName\\":\\"\\",\\r\\n\\"startDate\\":\\"\\",\\r\\n\\"endDate\\":\\"\\",\\r\\n\\"objType\\":\\"\\",\\r\\n\\"pageNo\\":1,\\r\\n\\"pageSize\\":10}","responseHeader":"{}","responseBody":"{\\n\\t\\"success\\":true,\\n\\t\\"message\\":\\"OK\\",\\n\\t\\"code\\":0,\\n\\t\\"lifeCycleTime\\":29,\\n\\t\\"executionTime\\":26,\\n\\t\\"value\\":{\\n\\t\\t\\"pageInfo\\":{\\n\\t\\t\\t\\"enable\\":true,\\n\\t\\t\\t\\"pageSize\\":10,\\n\\t\\t\\t\\"totalCount\\":104,\\n\\t\\t\\t\\"totalPage\\":11,\\n\\t\\t\\t\\"currentPage\\":1,\\n\\t\\t\\t\\"recordPosition\\":0\\n\\t\\t},\\n\\t\\t\\"pageData\\":[\\n\\t\\t\\t{\\n\\t\\t\\t\\t\\"device_id\\":\\"test\\",\\n\\t\\t\\t\\t\\"device_name\\":\\"测试系统\\",\\n\\t\\t\\t\\t\\"last_log_date\\":1642003200000,\\n\\t\\t\\t\\t\\"obj_type\\":1,\\n\\t\\t\\t\\t\\"log_count\\":54\\n\\t\\t\\t},\\n\\t\\t\\t{\\n\\t\\t\\t\\t\\"device_id\\":\\"demo\\",\\n\\t\\t\\t\\t\\"device_name\\":\\"demo系统\\",\\n\\t\\t\\t\\t\\"last_log_date\\":1641539767000,\\n\\t\\t\\t\\t\\"obj_type\\":1,\\n\\t\\t\\t\\t\\"log_count\\":6\\n\\t\\t\\t},\\n\\t\\t\\t{\\n\\t\\t\\t\\t\\"device_id\\":\\"test1\\",\\n\\t\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\t\\"last_log_date\\":1641513600000,\\n\\t\\t\\t\\t\\"obj_type\\":1,\\n\\t\\t\\t\\t\\"log_count\\":114\\n\\t\\t\\t},\\n\\t\\t\\t{\\n\\t\\t\\t\\t\\"device_id\\":\\"test5\\",\\n\\t\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\t\\"last_log_date\\":1641513600000,\\n\\t\\t\\t\\t\\"obj_type\\":1,\\n\\t\\t\\t\\t\\"log_count\\":112\\n\\t\\t\\t},\\n\\t\\t\\t{\\n\\t\\t\\t\\t\\"device_id\\":\\"test8\\",\\n\\t\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\t\\"last_log_date\\":1641513600000,\\n\\t\\t\\t\\t\\"obj_type\\":1,\\n\\t\\t\\t\\t\\"log_count\\":112\\n\\t\\t\\t},\\n\\t\\t\\t{\\n\\t\\t\\t\\t\\"device_id\\":\\"test4\\",\\n\\t\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\t\\"last_log_date\\":1641513600000,\\n\\t\\t\\t\\t\\"obj_type\\":1,\\n\\t\\t\\t\\t\\"log_count\\":112\\n\\t\\t\\t},\\n\\t\\t\\t{\\n\\t\\t\\t\\t\\"device_id\\":\\"test7\\",\\n\\t\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\t\\"last_log_date\\":1641513600000,\\n\\t\\t\\t\\t\\"obj_type\\":1,\\n\\t\\t\\t\\t\\"log_count\\":112\\n\\t\\t\\t},\\n\\t\\t\\t{\\n\\t\\t\\t\\t\\"device_id\\":\\"test6\\",\\n\\t\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\t\\"last_log_date\\":1641513600000,\\n\\t\\t\\t\\t\\"obj_type\\":1,\\n\\t\\t\\t\\t\\"log_count\\":112\\n\\t\\t\\t},\\n\\t\\t\\t{\\n\\t\\t\\t\\t\\"device_id\\":\\"test3\\",\\n\\t\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\t\\"last_log_date\\":1641513600000,\\n\\t\\t\\t\\t\\"obj_type\\":1,\\n\\t\\t\\t\\t\\"log_count\\":112\\n\\t\\t\\t},\\n\\t\\t\\t{\\n\\t\\t\\t\\t\\"device_id\\":\\"test2\\",\\n\\t\\t\\t\\t\\"device_name\\":\\"测试系统1\\",\\n\\t\\t\\t\\t\\"last_log_date\\":1641513600000,\\n\\t\\t\\t\\t\\"obj_type\\":1,\\n\\t\\t\\t\\t\\"log_count\\":112\\n\\t\\t\\t}\\n\\t\\t]\\n\\t}\\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"024234752F01,0050569D4242,0242A8A12CFC","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\\n    \\"success\\"      : \\"@resultStatus\\",\\n    \\"message\\"      : \\"@resultMessage\\",\\n    \\"code\\"         : \\"@resultCode\\",\\n    \\"lifeCycleTime\\": \\"@timeLifeCycle\\",\\n    \\"executionTime\\": \\"@timeExecution\\",\\n    \\"value\\"        : \\"@resultData\\"\\n}","wrapParameterName":"root"}', '1642406295556', '系统日志列表查询');


INSERT INTO interface_info (api_id, api_method, api_path, api_status, api_comment, api_type, api_script, api_schema, api_sample, api_option, api_create_time, api_gmt_time, api_name) VALUES ('i_em2jh8dle-abh', 'GET', '/api/logdog/web/getDayLogType', '1', '获取某天的日志类型汇总数据', 'DataQL', '// a new Query.
hint FRAGMENT_SQL_DATA_SOURCE = "logdog"
hint FRAGMENT_SQL_OPEN_PACKAGE = "off"

// 定义查询SQL
var dataSet = @@mybatis(year,month,day)<%
<select>
select d.log_type, count(d.id) as num from web_detail d
where
    d.record_year = #{year} and d.record_month = #{month} and
    d.record_day = #{day} and  d.task_id != 0
group by d.log_type order by num desc
 </select>
%>

return dataSet(${year},${month},${day});', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"month":{"type":"string"},"year":{"type":"string"},"day":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"array","items":{"type":"object","properties":{"log_type":{"type":"string"},"num":{"type":"number"}}}}}}}', '{"requestHeader":"[]","requestBody":"{\\r\\n    \\"year\\": \\"2021\\",\\r\\n    \\"month\\":\\"11\\",\\r\\n    \\"day\\":\\"2\\"\\r\\n}","responseHeader":"{}","responseBody":"{\\n\\t\\"success\\":true,\\n\\t\\"message\\":\\"OK\\",\\n\\t\\"code\\":0,\\n\\t\\"lifeCycleTime\\":8,\\n\\t\\"executionTime\\":6,\\n\\t\\"value\\":[\\n\\t\\t{\\n\\t\\t\\t\\"log_type\\":\\"network\\",\\n\\t\\t\\t\\"num\\":644\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"log_type\\":\\"page\\",\\n\\t\\t\\t\\"num\\":274\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"log_type\\":\\"info\\",\\n\\t\\t\\t\\"num\\":43\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"log_type\\":\\"exception\\",\\n\\t\\t\\t\\"num\\":41\\n\\t\\t}\\n\\t]\\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"0242C0A82002","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\\n    \\"success\\"      : \\"@resultStatus\\",\\n    \\"message\\"      : \\"@resultMessage\\",\\n    \\"code\\"         : \\"@resultCode\\",\\n    \\"lifeCycleTime\\": \\"@timeLifeCycle\\",\\n    \\"executionTime\\": \\"@timeExecution\\",\\n    \\"value\\"        : \\"@resultData\\"\\n}","wrapParameterName":"root"}', '1642496024390', '1642496593178', null);

INSERT INTO interface_release (pub_id, pub_api_id, pub_method, pub_path, pub_status, pub_type, pub_script, pub_script_ori, pub_schema, pub_sample, pub_option, pub_release_time, pub_comment) VALUES ('r_em2jj1h95-94k', 'i_em2jh8dle-abh', 'GET', '/api/logdog/web/getDayLogType', '1', 'DataQL', '// a new Query.
hint FRAGMENT_SQL_DATA_SOURCE = "logdog"
hint FRAGMENT_SQL_OPEN_PACKAGE = "off"

// 定义查询SQL
var dataSet = @@mybatis(year,month,day)<%
<select>
select d.log_type, count(d.id) as num from web_detail d
where
    d.record_year = #{year} and d.record_month = #{month} and
    d.record_day = #{day} and  d.task_id != 0
group by d.log_type order by num desc
 </select>
%>

return dataSet(${year},${month},${day});', '// a new Query.
hint FRAGMENT_SQL_DATA_SOURCE = "logdog"
hint FRAGMENT_SQL_OPEN_PACKAGE = "off"

// 定义查询SQL
var dataSet = @@mybatis(year,month,day)<%
<select>
select d.log_type, count(d.id) as num from web_detail d
where
    d.record_year = #{year} and d.record_month = #{month} and
    d.record_day = #{day} and  d.task_id != 0
group by d.log_type order by num desc
 </select>
%>

return dataSet(${year},${month},${day});', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"month":{"type":"string"},"year":{"type":"string"},"day":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"array","items":{"type":"object","properties":{"log_type":{"type":"string"},"num":{"type":"number"}}}}}}}', '{"requestHeader":"[]","requestBody":"{\\r\\n    \\"year\\": \\"2021\\",\\r\\n    \\"month\\":\\"11\\",\\r\\n    \\"day\\":\\"2\\"\\r\\n}","responseHeader":"{}","responseBody":"{\\n\\t\\"success\\":true,\\n\\t\\"message\\":\\"OK\\",\\n\\t\\"code\\":0,\\n\\t\\"lifeCycleTime\\":8,\\n\\t\\"executionTime\\":6,\\n\\t\\"value\\":[\\n\\t\\t{\\n\\t\\t\\t\\"log_type\\":\\"network\\",\\n\\t\\t\\t\\"num\\":644\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"log_type\\":\\"page\\",\\n\\t\\t\\t\\"num\\":274\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"log_type\\":\\"info\\",\\n\\t\\t\\t\\"num\\":43\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\"log_type\\":\\"exception\\",\\n\\t\\t\\t\\"num\\":41\\n\\t\\t}\\n\\t]\\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"0242C0A82002","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\\n    \\"success\\"      : \\"@resultStatus\\",\\n    \\"message\\"      : \\"@resultMessage\\",\\n    \\"code\\"         : \\"@resultCode\\",\\n    \\"lifeCycleTime\\": \\"@timeLifeCycle\\",\\n    \\"executionTime\\": \\"@timeExecution\\",\\n    \\"value\\"        : \\"@resultData\\"\\n}","wrapParameterName":"root"}', '1642496593181', '获取某天的日志类型汇总数据');
