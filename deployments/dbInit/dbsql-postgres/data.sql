-- 配置数据每次容器重启都执行
INSERT INTO logfv.dataway_datasource (id, type, name, ip_address, username, password, alias, remark, con_str, is_use, create_by, update_by, create_time, update_time, del_flag) VALUES ('998fec26568c00354e8fcc1c119ed89d', 'Postgres', 'logfv', '192.168.253.128:5432', 'test_db', '123456', 'logfv', null, 'jdbc:postgresql://192.168.253.128:5432/test_db?useUnicode=true&characterEncoding=UTF8&serverTimezone=Asia/Shanghai&currentSchema=logfv', 0, null, null, '2021-09-06 09:14:40.000000', '2021-09-06 09:28:02.000000', 0);

INSERT INTO logfv.interface_info (api_id, api_method, api_path, api_status, api_comment, api_type, api_script, api_schema, api_sample, api_option, api_create_time, api_gmt_time, api_name) VALUES ('i_enf10073b-7f5', 'GET', '/api/logfv/web/runtime', '1', '', 'DataQL', 'var dataSet = @@sql()<%
  select ROUND( MAX(log_date)/1000/3600/24 - MIN(log_date)/1000/3600/24)+1 from web_task;
%>
return dataSet(); ', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"message":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":["string","boolean","number","object","array","null"]}}}}', '{"requestHeader":"[]","requestBody":"{\"message\":\"Hello DataQL.\"}","responseHeader":"{}","responseBody":"{\n\t\"success\":true,\n\t\"message\":\"OK\",\n\t\"code\":0,\n\t\"lifeCycleTime\":4,\n\t\"executionTime\":1\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"70B5E8293499,005056C00008,005056C00001,00E04C239987","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\n    \"success\"      : \"@resultStatus\",\n    \"message\"      : \"@resultMessage\",\n    \"code\"         : \"@resultCode\",\n    \"lifeCycleTime\": \"@timeLifeCycle\",\n    \"executionTime\": \"@timeExecution\",\n    \"value\"        : \"@resultData\"\n}","wrapParameterName":"root"}', '1649417752595', '1649417755167', null);
INSERT INTO logfv.interface_info (api_id, api_method, api_path, api_status, api_comment, api_type, api_script, api_schema, api_sample, api_option, api_create_time, api_gmt_time, api_name) VALUES ('i_enf0ni0jj2bh1', 'GET', '/api/logfv/web/query', '1', '', 'DataQL', '// a new Query.
// SQL ???????????????
hint FRAGMENT_SQL_QUERY_BY_PAGE = true
hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
//?? 1 ????????????????
hint FRAGMENT_SQL_QUERY_BY_PAGE_NUMBER_OFFSET = 1
// ??????SQL

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
// ??????????????
var pageQuery =  dataSet(${deviceId},${deviceName},${objType},${startDate},${endDate});
// ??????????
run pageQuery.setPageInfo({
    "pageSize"    : ${pageSize}, // ?????
    "currentPage" : ${pageNo}   // ??1?
});
// ?????????
return {
    "pageInfo":pageQuery.pageInfo(),
    "pageData":pageQuery.data()
}', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"endDate":{"type":"string"},"pageNo":{"type":"number"},"pageSize":{"type":"number"},"deviceId":{"type":"string"},"deviceName":{"type":"string"},"objType":{"type":"string"},"startDate":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"object","properties":{"pageInfo":{"type":"object","properties":{"recordPosition":{"type":"number"},"enable":{"type":"boolean"},"totalPage":{"type":"number"},"pageSize":{"type":"number"},"totalCount":{"type":"number"},"currentPage":{"type":"number"}}},"pageData":{"type":"array","items":{"type":["string","boolean","number","object","array","null"]}}}}}}}', '{"requestHeader":"[]","requestBody":"{\"deviceId\":\"\",\r\n\"deviceName\":\"\",\r\n\"startDate\":\"\",\r\n\"endDate\":\"\",\r\n\"objType\":\"\",\r\n\"pageNo\":1,\r\n\"pageSize\":10}","responseHeader":"{}","responseBody":"{\n\t\"success\":true,\n\t\"message\":\"OK\",\n\t\"code\":0,\n\t\"lifeCycleTime\":8,\n\t\"executionTime\":4,\n\t\"value\":{\n\t\t\"pageInfo\":{\n\t\t\t\"enable\":true,\n\t\t\t\"pageSize\":10,\n\t\t\t\"totalCount\":0,\n\t\t\t\"totalPage\":1,\n\t\t\t\"currentPage\":1,\n\t\t\t\"recordPosition\":0\n\t\t},\n\t\t\"pageData\":[]\n\t}\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"70B5E8293499,005056C00008,005056C00001,00E04C239987","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\n    \"success\"      : \"@resultStatus\",\n    \"message\"      : \"@resultMessage\",\n    \"code\"         : \"@resultCode\",\n    \"lifeCycleTime\": \"@timeLifeCycle\",\n    \"executionTime\": \"@timeExecution\",\n    \"value\"        : \"@resultData\"\n}","wrapParameterName":"root"}', '1649417666011', '1649417684503', null);
INSERT INTO logfv.interface_info (api_id, api_method, api_path, api_status, api_comment, api_type, api_script, api_schema, api_sample, api_option, api_create_time, api_gmt_time, api_name) VALUES ('i_enf0nl23h411h', 'GET', '/api/logfv/web/querySystems', '1', '', 'DataQL', 'var dataSet = @@sql()<%
    select   count(distinct device_id)    from web_task;
%>
return dataSet(); ', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"message":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"number"}}}}', '{"requestHeader":"[]","requestBody":"{\"message\":\"Hello DataQL.\"}","responseHeader":"{}","responseBody":"{\n\t\"success\":true,\n\t\"message\":\"OK\",\n\t\"code\":0,\n\t\"lifeCycleTime\":5,\n\t\"executionTime\":1,\n\t\"value\":0\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"70B5E8293499,005056C00008,005056C00001,00E04C239987","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\n    \"success\"      : \"@resultStatus\",\n    \"message\"      : \"@resultMessage\",\n    \"code\"         : \"@resultCode\",\n    \"lifeCycleTime\": \"@timeLifeCycle\",\n    \"executionTime\": \"@timeExecution\",\n    \"value\"        : \"@resultData\"\n}","wrapParameterName":"root"}', '1649417708249', '1649417717652', null);
INSERT INTO logfv.interface_info (api_id, api_method, api_path, api_status, api_comment, api_type, api_script, api_schema, api_sample, api_option, api_create_time, api_gmt_time, api_name) VALUES ('i_enf10f788-67a', 'GET', '/api/logfv/web/getDayLogType', '1', '', 'DataQL', '// a new Query.
hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
// �����ѯSQL
var dataSet = @@mybatis(year,month,day)<%
<select>
select d.log_type, count(d.id) as num from web_detail d
where
    d.record_year = #{year} and d.record_month = #{month} and
    d.record_day = #{day} and  d.task_id != 0
group by d.log_type order by num desc
 </select>
%>

return dataSet(${year},${month},${day});', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"month":{"type":"string"},"year":{"type":"string"},"day":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"array","items":{"type":["string","boolean","number","object","array","null"]}}}}}', '{"requestHeader":"[]","requestBody":"{\r\n    \"year\": \"2021\",\r\n    \"month\":\"11\",\r\n    \"day\":\"2\"\r\n}","responseHeader":"{}","responseBody":"{\n\t\"success\":true,\n\t\"message\":\"OK\",\n\t\"code\":0,\n\t\"lifeCycleTime\":4,\n\t\"executionTime\":2,\n\t\"value\":[]\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"70B5E8293499,005056C00008,005056C00001,00E04C239987","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\n    \"success\"      : \"@resultStatus\",\n    \"message\"      : \"@resultMessage\",\n    \"code\"         : \"@resultCode\",\n    \"lifeCycleTime\": \"@timeLifeCycle\",\n    \"executionTime\": \"@timeExecution\",\n    \"value\"        : \"@resultData\"\n}","wrapParameterName":"root"}', '1649417960072', '1649419603063', null);
INSERT INTO logfv.interface_info (api_id, api_method, api_path, api_status, api_comment, api_type, api_script, api_schema, api_sample, api_option, api_create_time, api_gmt_time, api_name) VALUES ('i_enf0n7b98-9he', 'GET', '/api/logfv/web/queryLogCount', '1', '', 'DataQL', 'hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
var dataSet = @@sql()<%
select * from (
select b.device_id,b.device_name,count(a.id) as log_count from web_detail a
inner join web_task b on a.task_id = b.id where b.device_name <> ''''
group by b.device_id, b.device_name) a order by a.log_count desc limit 10;
%>
return dataSet(); ', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"message":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"array","items":{"type":["string","boolean","number","object","array","null"]}}}}}', '{"requestHeader":"[]","requestBody":"{\"message\":\"Hello DataQL.\"}","responseHeader":"{}","responseBody":"{\n\t\"success\":true,\n\t\"message\":\"OK\",\n\t\"code\":0,\n\t\"lifeCycleTime\":2,\n\t\"executionTime\":1,\n\t\"value\":[]\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"70B5E8293499,005056C00008,005056C00001,00E04C239987","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\n    \"success\"      : \"@resultStatus\",\n    \"message\"      : \"@resultMessage\",\n    \"code\"         : \"@resultCode\",\n    \"lifeCycleTime\": \"@timeLifeCycle\",\n    \"executionTime\": \"@timeExecution\",\n    \"value\"        : \"@resultData\"\n}","wrapParameterName":"root"}', '1649417520032', '1649417638933', null);
INSERT INTO logfv.interface_info (api_id, api_method, api_path, api_status, api_comment, api_type, api_script, api_schema, api_sample, api_option, api_create_time, api_gmt_time, api_name) VALUES ('i_enf0negj4-62l', 'GET', '/api/logfv/web/queryTaskByDate', '1', '', 'DataQL', 'hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
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

// ??????????????
var pageQuery =  dataSet(${deviceId},${startDate},${endDate});
// ???��?????
run pageQuery.setPageInfo({
    "pageSize"    : ${pageSize}, // ???��
    "currentPage" : ${pageNo}   // ??1?
});
// ??��?????
return {
    "pageInfo":pageQuery.pageInfo(),
    "pageData":pageQuery.data()
}', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"message":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"object","properties":{"pageInfo":{"type":"object","properties":{"recordPosition":{"type":"number"},"enable":{"type":"boolean"},"totalPage":{"type":"number"},"pageSize":{"type":"number"},"totalCount":{"type":"number"},"currentPage":{"type":"number"}}},"pageData":{"type":"array","items":{"type":["string","boolean","number","object","array","null"]}}}}}}}', '{"requestHeader":"[]","requestBody":"{\"message\":\"Hello DataQL.\"}","responseHeader":"{}","responseBody":"{\n\t\"success\":true,\n\t\"message\":\"OK\",\n\t\"code\":0,\n\t\"lifeCycleTime\":11,\n\t\"executionTime\":7,\n\t\"value\":{\n\t\t\"pageInfo\":{\n\t\t\t\"enable\":false,\n\t\t\t\"pageSize\":-1,\n\t\t\t\"totalCount\":0,\n\t\t\t\"totalPage\":1,\n\t\t\t\"currentPage\":1,\n\t\t\t\"recordPosition\":0\n\t\t},\n\t\t\"pageData\":[]\n\t}\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"70B5E8293499,005056C00008,005056C00001,00E04C239987","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\n    \"success\"      : \"@resultStatus\",\n    \"message\"      : \"@resultMessage\",\n    \"code\"         : \"@resultCode\",\n    \"lifeCycleTime\": \"@timeLifeCycle\",\n    \"executionTime\": \"@timeExecution\",\n    \"value\"        : \"@resultData\"\n}","wrapParameterName":"root"}', '1649417619916', '1649417647080', null);
INSERT INTO logfv.interface_info (api_id, api_method, api_path, api_status, api_comment, api_type, api_script, api_schema, api_sample, api_option, api_create_time, api_gmt_time, api_name) VALUES ('i_enf10245e8ne2', 'GET', '/api/logfv/web/queryTotalPage', '1', '', 'DataQL', 'var dataSet = @@sql()<%
select count(*) from web_detail;
%>
return dataSet(); ', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"message":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"number"}}}}', '{"requestHeader":"[]","requestBody":"{\"message\":\"Hello DataQL.\"}","responseHeader":"{}","responseBody":"{\n\t\"success\":true,\n\t\"message\":\"OK\",\n\t\"code\":0,\n\t\"lifeCycleTime\":3,\n\t\"executionTime\":0,\n\t\"value\":0\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"70B5E8293499,005056C00008,005056C00001,00E04C239987","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\n    \"success\"      : \"@resultStatus\",\n    \"message\"      : \"@resultMessage\",\n    \"code\"         : \"@resultCode\",\n    \"lifeCycleTime\": \"@timeLifeCycle\",\n    \"executionTime\": \"@timeExecution\",\n    \"value\"        : \"@resultData\"\n}","wrapParameterName":"root"}', '1649417778566', '1649417780635', null);
INSERT INTO logfv.interface_info (api_id, api_method, api_path, api_status, api_comment, api_type, api_script, api_schema, api_sample, api_option, api_create_time, api_gmt_time, api_name) VALUES ('i_enf10418a3cjd', 'GET', '/api/logfv/web/dateLogIndex', '1', '', 'DataQL', '// a new Query.
// SQL ִ�����л�Ϊ��ҳģʽ
hint FRAGMENT_SQL_QUERY_BY_PAGE = true
hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
//�� 1 ��ʼ��Ϊҳ�����ʼ���
hint FRAGMENT_SQL_QUERY_BY_PAGE_NUMBER_OFFSET = 1
// �����ѯSQL

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
// ������ҳ��ѯ����
var pageQuery =  dataSet(${logDate},${deviceId},${content},${logType},${logOrder},${startTime},${endTime});
// ���÷�ҳ��Ϣ
run pageQuery.setPageInfo({
    "pageSize"    : ${pageSize}, // ҳ��С
    "currentPage" : ${pageNo}   // ��1ҳ
});
// ִ�з�ҳ��ѯ
return {
    "pageInfo":pageQuery.pageInfo(),
    "pageData":pageQuery.data()
}', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"logType":{"type":"string"},"logDate":{"type":"string"},"deviceId":{"type":"string"},"content":{"type":"string"},"logOrder":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"object","properties":{"pageInfo":{"type":"object","properties":{"recordPosition":{"type":"number"},"enable":{"type":"boolean"},"totalPage":{"type":"number"},"pageSize":{"type":"number"},"totalCount":{"type":"number"},"currentPage":{"type":"number"}}},"pageData":{"type":"array","items":{"type":["string","boolean","number","object","array","null"]}}}}}}}', '{"requestHeader":"[]","requestBody":"{\"logDate\":\"\",\r\n\"deviceId\":\"\",\r\n\"content\":\"\",\r\n\"logType\":\"\", \r\n\"logOrder\":\"2\"}","responseHeader":"{}","responseBody":"{\n\t\"success\":true,\n\t\"message\":\"OK\",\n\t\"code\":0,\n\t\"lifeCycleTime\":10,\n\t\"executionTime\":6,\n\t\"value\":{\n\t\t\"pageInfo\":{\n\t\t\t\"enable\":false,\n\t\t\t\"pageSize\":-1,\n\t\t\t\"totalCount\":0,\n\t\t\t\"totalPage\":1,\n\t\t\t\"currentPage\":1,\n\t\t\t\"recordPosition\":0\n\t\t},\n\t\t\"pageData\":[]\n\t}\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"70B5E8293499,005056C00008,005056C00001,00E04C239987","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\n    \"success\"      : \"@resultStatus\",\n    \"message\"      : \"@resultMessage\",\n    \"code\"         : \"@resultCode\",\n    \"lifeCycleTime\": \"@timeLifeCycle\",\n    \"executionTime\": \"@timeExecution\",\n    \"value\"        : \"@resultData\"\n}","wrapParameterName":"root"}', '1649417804554', '1649417817657', null);
INSERT INTO logfv.interface_info (api_id, api_method, api_path, api_status, api_comment, api_type, api_script, api_schema, api_sample, api_option, api_create_time, api_gmt_time, api_name) VALUES ('i_enf10bmdc-4in', 'GET', '/api/logfv/web/getCount', '1', '', 'DataQL', '// a new Query.
hint FRAGMENT_SQL_QUERY_BY_PAGE = true
hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
//�� 1 ��ʼ��Ϊҳ�����ʼ���
hint FRAGMENT_SQL_QUERY_BY_PAGE_NUMBER_OFFSET = 1
// �����ѯSQL
var dataSet = @@mybatis(year,month,day, logType)<%
<select>
    select t.device_name,t.device_id,t.obj_type,t.log_date, count(d.id) as num from web_detail d
    inner join web_task t on d.task_id = t.id
    where d.record_year = #{year} and d.record_month = #{month}
        and d.record_day = #{day} and d.log_type = #{logType} and  d.task_id != 0

    group by t.device_name,t.device_id,t.obj_type,log_date order by   num desc


 </select>
%>

// ������ҳ��ѯ����
var pageQuery =  dataSet(${year},${month},${day},${logType});

// ���÷�ҳ��Ϣ
run pageQuery.setPageInfo({
    "pageSize"    : ${pageSize}, // ҳ��С
    "currentPage" : ${pageNo}   // ��1ҳ
});

// ִ�з�ҳ��ѯ
return {
    "pageInfo":pageQuery.pageInfo(),
    "pageData":pageQuery.data()
}
', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"logType":{"type":"string"},"month":{"type":"string"},"year":{"type":"string"},"day":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"object","properties":{"pageInfo":{"type":"object","properties":{"recordPosition":{"type":"number"},"enable":{"type":"boolean"},"totalPage":{"type":"number"},"pageSize":{"type":"number"},"totalCount":{"type":"number"},"currentPage":{"type":"number"}}},"pageData":{"type":"array","items":{"type":["string","boolean","number","object","array","null"]}}}}}}}', '{"requestHeader":"[]","requestBody":"{\r\n  \"year\": \"2021\",\r\n  \"month\":\"11\",\r\n  \"day\":\"2\",\r\n  \"logType\":\"info\"\r\n}","responseHeader":"{}","responseBody":"{\n\t\"success\":true,\n\t\"message\":\"OK\",\n\t\"code\":0,\n\t\"lifeCycleTime\":8,\n\t\"executionTime\":4,\n\t\"value\":{\n\t\t\"pageInfo\":{\n\t\t\t\"enable\":false,\n\t\t\t\"pageSize\":-1,\n\t\t\t\"totalCount\":0,\n\t\t\t\"totalPage\":1,\n\t\t\t\"currentPage\":1,\n\t\t\t\"recordPosition\":0\n\t\t},\n\t\t\"pageData\":[]\n\t}\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"70B5E8293499,005056C00008,005056C00001,00E04C239987","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\n    \"success\"      : \"@resultStatus\",\n    \"message\"      : \"@resultMessage\",\n    \"code\"         : \"@resultCode\",\n    \"lifeCycleTime\": \"@timeLifeCycle\",\n    \"executionTime\": \"@timeExecution\",\n    \"value\"        : \"@resultData\"\n}","wrapParameterName":"root"}', '1649417913540', '1649419592259', null);
INSERT INTO logfv.interface_info (api_id, api_method, api_path, api_status, api_comment, api_type, api_script, api_schema, api_sample, api_option, api_create_time, api_gmt_time, api_name) VALUES ('i_enf10a77d8en1', 'GET', '/api/logfv/web/getCountByGroupByLogType', '1', '', 'DataQL', '// a new Query.
hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
// �����ѯSQL
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
', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"month":{"type":"string"},"year":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"array","items":{"type":["string","boolean","number","object","array","null"]}}}}}', '{"requestHeader":"[]","requestBody":"{\r\n  \"year\": \"2021\",\r\n  \"month\":\"\"\r\n}","responseHeader":"{}","responseBody":"{\n\t\"success\":true,\n\t\"message\":\"OK\",\n\t\"code\":0,\n\t\"lifeCycleTime\":8,\n\t\"executionTime\":4,\n\t\"value\":[]\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"70B5E8293499,005056C00008,005056C00001,00E04C239987","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\n    \"success\"      : \"@resultStatus\",\n    \"message\"      : \"@resultMessage\",\n    \"code\"         : \"@resultCode\",\n    \"lifeCycleTime\": \"@timeLifeCycle\",\n    \"executionTime\": \"@timeExecution\",\n    \"value\"        : \"@resultData\"\n}","wrapParameterName":"root"}', '1649417890933', '1649419581217', null);
INSERT INTO logfv.interface_info (api_id, api_method, api_path, api_status, api_comment, api_type, api_script, api_schema, api_sample, api_option, api_create_time, api_gmt_time, api_name) VALUES ('i_enf0n8l314829', 'GET', '/api/logfv/web/queryLogType', '1', '', 'DataQL', '// a new Query.
// SQL ???????????????
hint FRAGMENT_SQL_QUERY_BY_PAGE = true
hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
//?? 1 ????????????????
hint FRAGMENT_SQL_QUERY_BY_PAGE_NUMBER_OFFSET = 1
// ??????SQL

var dataSet = @@mybatis()<%
<select>
select date,log_type as "logType",COUNT(log_type) as count from
(
select TO_CHAR(TO_TIMESTAMP(log_time / 1000),''YYYYMMDD'') as date, log_type from web_detail a
where exists(select * from web_task b where a.task_id = b.id)
) b
group by date,log_type
 </select>
%>
// ??????????????
var pageQuery =  dataSet();
// ??????????
run pageQuery.setPageInfo({
    "pageSize"    : ${pageSize}, // ?????
    "currentPage" : ${pageNo}   // ??1?
});
// ?????????
return {
    "pageInfo":pageQuery.pageInfo(),
    "pageData":pageQuery.data()
}', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"message":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"object","properties":{"pageInfo":{"type":"object","properties":{"recordPosition":{"type":"number"},"enable":{"type":"boolean"},"totalPage":{"type":"number"},"pageSize":{"type":"number"},"totalCount":{"type":"number"},"currentPage":{"type":"number"}}},"pageData":{"type":"array","items":{"type":"object","properties":{"date":{"type":"string"},"logType":{"type":"string"},"count":{"type":"number"}}}}}}}}}', '{"requestHeader":"[]","requestBody":"{\"message\":\"Hello DataQL.\"}","responseHeader":"{}","responseBody":"{\n\t\"success\":true,\n\t\"message\":\"OK\",\n\t\"code\":0,\n\t\"lifeCycleTime\":4,\n\t\"executionTime\":2,\n\t\"value\":{\n\t\t\"pageInfo\":{\n\t\t\t\"enable\":false,\n\t\t\t\"pageSize\":-1,\n\t\t\t\"totalCount\":1,\n\t\t\t\"totalPage\":1,\n\t\t\t\"currentPage\":1,\n\t\t\t\"recordPosition\":0\n\t\t},\n\t\t\"pageData\":[\n\t\t\t{\n\t\t\t\t\"date\":\"20220408\",\n\t\t\t\t\"logType\":\"info\",\n\t\t\t\t\"count\":6\n\t\t\t}\n\t\t]\n\t}\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"70B5E8293499,005056C00008,005056C00001,00E04C239987","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\n    \"success\"      : \"@resultStatus\",\n    \"message\"      : \"@resultMessage\",\n    \"code\"         : \"@resultCode\",\n    \"lifeCycleTime\": \"@timeLifeCycle\",\n    \"executionTime\": \"@timeExecution\",\n    \"value\"        : \"@resultData\"\n}","wrapParameterName":"root"}', '1649417539465', '1649420947976', null);
INSERT INTO logfv.interface_info (api_id, api_method, api_path, api_status, api_comment, api_type, api_script, api_schema, api_sample, api_option, api_create_time, api_gmt_time, api_name) VALUES ('i_enf107718401a', 'GET', '/api/logfv/web/queryLogSize', '1', '', 'SQL', 'select round((pg_total_relation_size(''web_detail'')+pg_total_relation_size(''web_task''))::numeric/1024/1024,4) as data', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"message":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"number"}}}}', '{"requestHeader":"[]","requestBody":"{\"message\":\"Hello DataQL.\"}","responseHeader":"{}","responseBody":"{\n\t\"success\":true,\n\t\"message\":\"OK\",\n\t\"code\":0,\n\t\"lifeCycleTime\":3,\n\t\"executionTime\":1,\n\t\"value\":0.0938\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"70B5E8293499,005056C00008,005056C00001,00E04C239987","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\n    \"success\"      : \"@resultStatus\",\n    \"message\"      : \"@resultMessage\",\n    \"code\"         : \"@resultCode\",\n    \"lifeCycleTime\": \"@timeLifeCycle\",\n    \"executionTime\": \"@timeExecution\",\n    \"value\"        : \"@resultData\"\n}","wrapParameterName":"root"}', '1649417849312', '1649421364047', null);

INSERT INTO logfv.interface_release (pub_id, pub_api_id, pub_method, pub_path, pub_status, pub_type, pub_script, pub_script_ori, pub_schema, pub_sample, pub_option, pub_release_time, pub_comment) VALUES ('r_enf0ng1jf77b1', 'i_enf0n7b98-9he', 'GET', '/api/logfv/web/queryLogCount', '1', 'DataQL', 'hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
var dataSet = @@sql()<%
select * from (
select b.device_id,b.device_name,count(a.id) as log_count from web_detail a
inner join web_task b on a.task_id = b.id where b.device_name <> ''''
group by b.device_id, b.device_name) a order by a.log_count desc limit 10;
%>
return dataSet(); ', 'hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
var dataSet = @@sql()<%
select * from (
select b.device_id,b.device_name,count(a.id) as log_count from web_detail a
inner join web_task b on a.task_id = b.id where b.device_name <> ''''
group by b.device_id, b.device_name) a order by a.log_count desc limit 10;
%>
return dataSet(); ', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"message":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"array","items":{"type":["string","boolean","number","object","array","null"]}}}}}', '{"requestHeader":"[]","requestBody":"{\"message\":\"Hello DataQL.\"}","responseHeader":"{}","responseBody":"{\n\t\"success\":true,\n\t\"message\":\"OK\",\n\t\"code\":0,\n\t\"lifeCycleTime\":2,\n\t\"executionTime\":1,\n\t\"value\":[]\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"70B5E8293499,005056C00008,005056C00001,00E04C239987","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\n    \"success\"      : \"@resultStatus\",\n    \"message\"      : \"@resultMessage\",\n    \"code\"         : \"@resultCode\",\n    \"lifeCycleTime\": \"@timeLifeCycle\",\n    \"executionTime\": \"@timeExecution\",\n    \"value\"        : \"@resultData\"\n}","wrapParameterName":"root"}', '1649417638935', '');
INSERT INTO logfv.interface_release (pub_id, pub_api_id, pub_method, pub_path, pub_status, pub_type, pub_script, pub_script_ori, pub_schema, pub_sample, pub_option, pub_release_time, pub_comment) VALUES ('r_enf0n7gdk-80a', 'i_enf0n7b98-9he', 'POST', '/api/logfv/web/queryLogCount', '3', 'DataQL', 'hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
var dataSet = @@sql()<%
select * from (
select b.device_id,b.device_name,count(a.id) as log_count from web_detail a
inner join web_task b on a.task_id = b.id where b.device_name <> ''''
group by b.device_id, b.device_name) a order by a.log_count desc limit 10;
%>
return dataSet(); ', 'hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
var dataSet = @@sql()<%
select * from (
select b.device_id,b.device_name,count(a.id) as log_count from web_detail a
inner join web_task b on a.task_id = b.id where b.device_name <> ''''
group by b.device_id, b.device_name) a order by a.log_count desc limit 10;
%>
return dataSet(); ', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"message":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"array","items":{"type":["string","boolean","number","object","array","null"]}}}}}', '{"requestHeader":"[]","requestBody":"{\"message\":\"Hello DataQL.\"}","responseHeader":"{}","responseBody":"{\n\t\"success\":true,\n\t\"message\":\"OK\",\n\t\"code\":0,\n\t\"lifeCycleTime\":3,\n\t\"executionTime\":1,\n\t\"value\":[]\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"70B5E8293499,005056C00008,005056C00001,00E04C239987","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\n    \"success\"      : \"@resultStatus\",\n    \"message\"      : \"@resultMessage\",\n    \"code\"         : \"@resultCode\",\n    \"lifeCycleTime\": \"@timeLifeCycle\",\n    \"executionTime\": \"@timeExecution\",\n    \"value\"        : \"@resultData\"\n}","wrapParameterName":"root"}', '1649417523020', '');
INSERT INTO logfv.interface_release (pub_id, pub_api_id, pub_method, pub_path, pub_status, pub_type, pub_script, pub_script_ori, pub_schema, pub_sample, pub_option, pub_release_time, pub_comment) VALUES ('r_enf0nfba231l9', 'i_enf0negj4-62l', 'POST', '/api/logfv/web/queryTaskByDate', '3', 'DataQL', 'hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
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

// ������ҳ��ѯ����
var pageQuery =  dataSet(${deviceId},${startDate},${endDate});
// ���÷�ҳ��Ϣ
run pageQuery.setPageInfo({
    "pageSize"    : ${pageSize}, // ҳ��С
    "currentPage" : ${pageNo}   // ��1ҳ
});
// ִ�з�ҳ��ѯ
return {
    "pageInfo":pageQuery.pageInfo(),
    "pageData":pageQuery.data()
}', 'hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
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

// ������ҳ��ѯ����
var pageQuery =  dataSet(${deviceId},${startDate},${endDate});
// ���÷�ҳ��Ϣ
run pageQuery.setPageInfo({
    "pageSize"    : ${pageSize}, // ҳ��С
    "currentPage" : ${pageNo}   // ��1ҳ
});
// ִ�з�ҳ��ѯ
return {
    "pageInfo":pageQuery.pageInfo(),
    "pageData":pageQuery.data()
}', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"message":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"object","properties":{"pageInfo":{"type":"object","properties":{"recordPosition":{"type":"number"},"enable":{"type":"boolean"},"totalPage":{"type":"number"},"pageSize":{"type":"number"},"totalCount":{"type":"number"},"currentPage":{"type":"number"}}},"pageData":{"type":"array","items":{"type":["string","boolean","number","object","array","null"]}}}}}}}', '{"requestHeader":"[]","requestBody":"{\"message\":\"Hello DataQL.\"}","responseHeader":"{}","responseBody":"{\n\t\"success\":true,\n\t\"message\":\"OK\",\n\t\"code\":0,\n\t\"lifeCycleTime\":10,\n\t\"executionTime\":5,\n\t\"value\":{\n\t\t\"pageInfo\":{\n\t\t\t\"enable\":false,\n\t\t\t\"pageSize\":-1,\n\t\t\t\"totalCount\":0,\n\t\t\t\"totalPage\":1,\n\t\t\t\"currentPage\":1,\n\t\t\t\"recordPosition\":0\n\t\t},\n\t\t\"pageData\":[]\n\t}\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"70B5E8293499,005056C00008,005056C00001,00E04C239987","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\n    \"success\"      : \"@resultStatus\",\n    \"message\"      : \"@resultMessage\",\n    \"code\"         : \"@resultCode\",\n    \"lifeCycleTime\": \"@timeLifeCycle\",\n    \"executionTime\": \"@timeExecution\",\n    \"value\"        : \"@resultData\"\n}","wrapParameterName":"root"}', '1649417630642', '');
INSERT INTO logfv.interface_release (pub_id, pub_api_id, pub_method, pub_path, pub_status, pub_type, pub_script, pub_script_ori, pub_schema, pub_sample, pub_option, pub_release_time, pub_comment) VALUES ('r_enf0ngfn2-7ef', 'i_enf0negj4-62l', 'GET', '/api/logfv/web/queryTaskByDate', '1', 'DataQL', 'hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
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

// ??????????????
var pageQuery =  dataSet(${deviceId},${startDate},${endDate});
// ???��?????
run pageQuery.setPageInfo({
    "pageSize"    : ${pageSize}, // ???��
    "currentPage" : ${pageNo}   // ??1?
});
// ??��?????
return {
    "pageInfo":pageQuery.pageInfo(),
    "pageData":pageQuery.data()
}', 'hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
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

// ??????????????
var pageQuery =  dataSet(${deviceId},${startDate},${endDate});
// ???��?????
run pageQuery.setPageInfo({
    "pageSize"    : ${pageSize}, // ???��
    "currentPage" : ${pageNo}   // ??1?
});
// ??��?????
return {
    "pageInfo":pageQuery.pageInfo(),
    "pageData":pageQuery.data()
}', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"message":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"object","properties":{"pageInfo":{"type":"object","properties":{"recordPosition":{"type":"number"},"enable":{"type":"boolean"},"totalPage":{"type":"number"},"pageSize":{"type":"number"},"totalCount":{"type":"number"},"currentPage":{"type":"number"}}},"pageData":{"type":"array","items":{"type":["string","boolean","number","object","array","null"]}}}}}}}', '{"requestHeader":"[]","requestBody":"{\"message\":\"Hello DataQL.\"}","responseHeader":"{}","responseBody":"{\n\t\"success\":true,\n\t\"message\":\"OK\",\n\t\"code\":0,\n\t\"lifeCycleTime\":11,\n\t\"executionTime\":7,\n\t\"value\":{\n\t\t\"pageInfo\":{\n\t\t\t\"enable\":false,\n\t\t\t\"pageSize\":-1,\n\t\t\t\"totalCount\":0,\n\t\t\t\"totalPage\":1,\n\t\t\t\"currentPage\":1,\n\t\t\t\"recordPosition\":0\n\t\t},\n\t\t\"pageData\":[]\n\t}\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"70B5E8293499,005056C00008,005056C00001,00E04C239987","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\n    \"success\"      : \"@resultStatus\",\n    \"message\"      : \"@resultMessage\",\n    \"code\"         : \"@resultCode\",\n    \"lifeCycleTime\": \"@timeLifeCycle\",\n    \"executionTime\": \"@timeExecution\",\n    \"value\"        : \"@resultData\"\n}","wrapParameterName":"root"}', '1649417647082', '');
INSERT INTO logfv.interface_release (pub_id, pub_api_id, pub_method, pub_path, pub_status, pub_type, pub_script, pub_script_ori, pub_schema, pub_sample, pub_option, pub_release_time, pub_comment) VALUES ('r_enf0nj8m86967', 'i_enf0ni0jj2bh1', 'GET', '/api/logfv/web/query', '1', 'DataQL', '// a new Query.
// SQL ???????????????
hint FRAGMENT_SQL_QUERY_BY_PAGE = true
hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
//?? 1 ????????????????
hint FRAGMENT_SQL_QUERY_BY_PAGE_NUMBER_OFFSET = 1
// ??????SQL

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
// ??????????????
var pageQuery =  dataSet(${deviceId},${deviceName},${objType},${startDate},${endDate});
// ??????????
run pageQuery.setPageInfo({
    "pageSize"    : ${pageSize}, // ?????
    "currentPage" : ${pageNo}   // ??1?
});
// ?????????
return {
    "pageInfo":pageQuery.pageInfo(),
    "pageData":pageQuery.data()
}', '// a new Query.
// SQL ???????????????
hint FRAGMENT_SQL_QUERY_BY_PAGE = true
hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
//?? 1 ????????????????
hint FRAGMENT_SQL_QUERY_BY_PAGE_NUMBER_OFFSET = 1
// ??????SQL

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
// ??????????????
var pageQuery =  dataSet(${deviceId},${deviceName},${objType},${startDate},${endDate});
// ??????????
run pageQuery.setPageInfo({
    "pageSize"    : ${pageSize}, // ?????
    "currentPage" : ${pageNo}   // ??1?
});
// ?????????
return {
    "pageInfo":pageQuery.pageInfo(),
    "pageData":pageQuery.data()
}', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"endDate":{"type":"string"},"pageNo":{"type":"number"},"pageSize":{"type":"number"},"deviceId":{"type":"string"},"deviceName":{"type":"string"},"objType":{"type":"string"},"startDate":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"object","properties":{"pageInfo":{"type":"object","properties":{"recordPosition":{"type":"number"},"enable":{"type":"boolean"},"totalPage":{"type":"number"},"pageSize":{"type":"number"},"totalCount":{"type":"number"},"currentPage":{"type":"number"}}},"pageData":{"type":"array","items":{"type":["string","boolean","number","object","array","null"]}}}}}}}', '{"requestHeader":"[]","requestBody":"{\"deviceId\":\"\",\r\n\"deviceName\":\"\",\r\n\"startDate\":\"\",\r\n\"endDate\":\"\",\r\n\"objType\":\"\",\r\n\"pageNo\":1,\r\n\"pageSize\":10}","responseHeader":"{}","responseBody":"{\n\t\"success\":true,\n\t\"message\":\"OK\",\n\t\"code\":0,\n\t\"lifeCycleTime\":8,\n\t\"executionTime\":4,\n\t\"value\":{\n\t\t\"pageInfo\":{\n\t\t\t\"enable\":true,\n\t\t\t\"pageSize\":10,\n\t\t\t\"totalCount\":0,\n\t\t\t\"totalPage\":1,\n\t\t\t\"currentPage\":1,\n\t\t\t\"recordPosition\":0\n\t\t},\n\t\t\"pageData\":[]\n\t}\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"70B5E8293499,005056C00008,005056C00001,00E04C239987","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\n    \"success\"      : \"@resultStatus\",\n    \"message\"      : \"@resultMessage\",\n    \"code\"         : \"@resultCode\",\n    \"lifeCycleTime\": \"@timeLifeCycle\",\n    \"executionTime\": \"@timeExecution\",\n    \"value\"        : \"@resultData\"\n}","wrapParameterName":"root"}', '1649417684504', '');
INSERT INTO logfv.interface_release (pub_id, pub_api_id, pub_method, pub_path, pub_status, pub_type, pub_script, pub_script_ori, pub_schema, pub_sample, pub_option, pub_release_time, pub_comment) VALUES ('r_enf0nic6i38ih', 'i_enf0ni0jj2bh1', 'POST', '/api/logfv/web/query', '3', 'DataQL', '// a new Query.
// SQL ִ�����л�Ϊ��ҳģʽ
hint FRAGMENT_SQL_QUERY_BY_PAGE = true
hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
//�� 1 ��ʼ��Ϊҳ�����ʼ���
hint FRAGMENT_SQL_QUERY_BY_PAGE_NUMBER_OFFSET = 1
// �����ѯSQL

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
// ������ҳ��ѯ����
var pageQuery =  dataSet(${deviceId},${deviceName},${objType},${startDate},${endDate});
// ���÷�ҳ��Ϣ
run pageQuery.setPageInfo({
    "pageSize"    : ${pageSize}, // ҳ��С
    "currentPage" : ${pageNo}   // ��1ҳ
});
// ִ�з�ҳ��ѯ
return {
    "pageInfo":pageQuery.pageInfo(),
    "pageData":pageQuery.data()
}', '// a new Query.
// SQL ִ�����л�Ϊ��ҳģʽ
hint FRAGMENT_SQL_QUERY_BY_PAGE = true
hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
//�� 1 ��ʼ��Ϊҳ�����ʼ���
hint FRAGMENT_SQL_QUERY_BY_PAGE_NUMBER_OFFSET = 1
// �����ѯSQL

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
// ������ҳ��ѯ����
var pageQuery =  dataSet(${deviceId},${deviceName},${objType},${startDate},${endDate});
// ���÷�ҳ��Ϣ
run pageQuery.setPageInfo({
    "pageSize"    : ${pageSize}, // ҳ��С
    "currentPage" : ${pageNo}   // ��1ҳ
});
// ִ�з�ҳ��ѯ
return {
    "pageInfo":pageQuery.pageInfo(),
    "pageData":pageQuery.data()
}', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"endDate":{"type":"string"},"pageNo":{"type":"number"},"pageSize":{"type":"number"},"deviceId":{"type":"string"},"deviceName":{"type":"string"},"objType":{"type":"string"},"startDate":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"object","properties":{"pageInfo":{"type":"object","properties":{"recordPosition":{"type":"number"},"enable":{"type":"boolean"},"totalPage":{"type":"number"},"pageSize":{"type":"number"},"totalCount":{"type":"number"},"currentPage":{"type":"number"}}},"pageData":{"type":"array","items":{"type":["string","boolean","number","object","array","null"]}}}}}}}', '{"requestHeader":"[]","requestBody":"{\"deviceId\":\"\",\r\n\"deviceName\":\"\",\r\n\"startDate\":\"\",\r\n\"endDate\":\"\",\r\n\"objType\":\"\",\r\n\"pageNo\":1,\r\n\"pageSize\":10}","responseHeader":"{}","responseBody":"{\n\t\"success\":true,\n\t\"message\":\"OK\",\n\t\"code\":0,\n\t\"lifeCycleTime\":10,\n\t\"executionTime\":5,\n\t\"value\":{\n\t\t\"pageInfo\":{\n\t\t\t\"enable\":true,\n\t\t\t\"pageSize\":10,\n\t\t\t\"totalCount\":0,\n\t\t\t\"totalPage\":1,\n\t\t\t\"currentPage\":1,\n\t\t\t\"recordPosition\":0\n\t\t},\n\t\t\"pageData\":[]\n\t}\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"70B5E8293499,005056C00008,005056C00001,00E04C239987","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\n    \"success\"      : \"@resultStatus\",\n    \"message\"      : \"@resultMessage\",\n    \"code\"         : \"@resultCode\",\n    \"lifeCycleTime\": \"@timeLifeCycle\",\n    \"executionTime\": \"@timeExecution\",\n    \"value\"        : \"@resultData\"\n}","wrapParameterName":"root"}', '1649417672610', '');
INSERT INTO logfv.interface_release (pub_id, pub_api_id, pub_method, pub_path, pub_status, pub_type, pub_script, pub_script_ori, pub_schema, pub_sample, pub_option, pub_release_time, pub_comment) VALUES ('r_enf10502a4f9b', 'i_enf10418a3cjd', 'GET', '/api/logfv/web/dateLogIndex', '1', 'DataQL', '// a new Query.
// SQL ִ�����л�Ϊ��ҳģʽ
hint FRAGMENT_SQL_QUERY_BY_PAGE = true
hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
//�� 1 ��ʼ��Ϊҳ�����ʼ���
hint FRAGMENT_SQL_QUERY_BY_PAGE_NUMBER_OFFSET = 1
// �����ѯSQL

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
// ������ҳ��ѯ����
var pageQuery =  dataSet(${logDate},${deviceId},${content},${logType},${logOrder},${startTime},${endTime});
// ���÷�ҳ��Ϣ
run pageQuery.setPageInfo({
    "pageSize"    : ${pageSize}, // ҳ��С
    "currentPage" : ${pageNo}   // ��1ҳ
});
// ִ�з�ҳ��ѯ
return {
    "pageInfo":pageQuery.pageInfo(),
    "pageData":pageQuery.data()
}', '// a new Query.
// SQL ִ�����л�Ϊ��ҳģʽ
hint FRAGMENT_SQL_QUERY_BY_PAGE = true
hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
//�� 1 ��ʼ��Ϊҳ�����ʼ���
hint FRAGMENT_SQL_QUERY_BY_PAGE_NUMBER_OFFSET = 1
// �����ѯSQL

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
// ������ҳ��ѯ����
var pageQuery =  dataSet(${logDate},${deviceId},${content},${logType},${logOrder},${startTime},${endTime});
// ���÷�ҳ��Ϣ
run pageQuery.setPageInfo({
    "pageSize"    : ${pageSize}, // ҳ��С
    "currentPage" : ${pageNo}   // ��1ҳ
});
// ִ�з�ҳ��ѯ
return {
    "pageInfo":pageQuery.pageInfo(),
    "pageData":pageQuery.data()
}', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"logType":{"type":"string"},"logDate":{"type":"string"},"deviceId":{"type":"string"},"content":{"type":"string"},"logOrder":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"object","properties":{"pageInfo":{"type":"object","properties":{"recordPosition":{"type":"number"},"enable":{"type":"boolean"},"totalPage":{"type":"number"},"pageSize":{"type":"number"},"totalCount":{"type":"number"},"currentPage":{"type":"number"}}},"pageData":{"type":"array","items":{"type":["string","boolean","number","object","array","null"]}}}}}}}', '{"requestHeader":"[]","requestBody":"{\"logDate\":\"\",\r\n\"deviceId\":\"\",\r\n\"content\":\"\",\r\n\"logType\":\"\", \r\n\"logOrder\":\"2\"}","responseHeader":"{}","responseBody":"{\n\t\"success\":true,\n\t\"message\":\"OK\",\n\t\"code\":0,\n\t\"lifeCycleTime\":10,\n\t\"executionTime\":6,\n\t\"value\":{\n\t\t\"pageInfo\":{\n\t\t\t\"enable\":false,\n\t\t\t\"pageSize\":-1,\n\t\t\t\"totalCount\":0,\n\t\t\t\"totalPage\":1,\n\t\t\t\"currentPage\":1,\n\t\t\t\"recordPosition\":0\n\t\t},\n\t\t\"pageData\":[]\n\t}\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"70B5E8293499,005056C00008,005056C00001,00E04C239987","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\n    \"success\"      : \"@resultStatus\",\n    \"message\"      : \"@resultMessage\",\n    \"code\"         : \"@resultCode\",\n    \"lifeCycleTime\": \"@timeLifeCycle\",\n    \"executionTime\": \"@timeExecution\",\n    \"value\"        : \"@resultData\"\n}","wrapParameterName":"root"}', '1649417817658', '');
INSERT INTO logfv.interface_release (pub_id, pub_api_id, pub_method, pub_path, pub_status, pub_type, pub_script, pub_script_ori, pub_schema, pub_sample, pub_option, pub_release_time, pub_comment) VALUES ('r_enf1046km-51f', 'i_enf10418a3cjd', 'POST', '/api/logfv/web/dateLogIndex', '3', 'DataQL', '// a new Query.
// SQL 执行器切换为分页模式
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
}', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"logType":{"type":"string"},"logDate":{"type":"string"},"deviceId":{"type":"string"},"content":{"type":"string"},"logOrder":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"object","properties":{"pageInfo":{"type":"object","properties":{"recordPosition":{"type":"number"},"enable":{"type":"boolean"},"totalPage":{"type":"number"},"pageSize":{"type":"number"},"totalCount":{"type":"number"},"currentPage":{"type":"number"}}},"pageData":{"type":"array","items":{"type":["string","boolean","number","object","array","null"]}}}}}}}', '{"requestHeader":"[]","requestBody":"{\"logDate\":\"\",\r\n\"deviceId\":\"\",\r\n\"content\":\"\",\r\n\"logType\":\"\", \r\n\"logOrder\":\"2\"}","responseHeader":"{}","responseBody":"{\n\t\"success\":true,\n\t\"message\":\"OK\",\n\t\"code\":0,\n\t\"lifeCycleTime\":10,\n\t\"executionTime\":5,\n\t\"value\":{\n\t\t\"pageInfo\":{\n\t\t\t\"enable\":false,\n\t\t\t\"pageSize\":-1,\n\t\t\t\"totalCount\":0,\n\t\t\t\"totalPage\":1,\n\t\t\t\"currentPage\":1,\n\t\t\t\"recordPosition\":0\n\t\t},\n\t\t\"pageData\":[]\n\t}\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"70B5E8293499,005056C00008,005056C00001,00E04C239987","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\n    \"success\"      : \"@resultStatus\",\n    \"message\"      : \"@resultMessage\",\n    \"code\"         : \"@resultCode\",\n    \"lifeCycleTime\": \"@timeLifeCycle\",\n    \"executionTime\": \"@timeExecution\",\n    \"value\"        : \"@resultData\"\n}","wrapParameterName":"root"}', '1649417807734', '');
INSERT INTO logfv.interface_release (pub_id, pub_api_id, pub_method, pub_path, pub_status, pub_type, pub_script, pub_script_ori, pub_schema, pub_sample, pub_option, pub_release_time, pub_comment) VALUES ('r_enf0nlibe2jdj', 'i_enf0nl23h411h', 'GET', '/api/logfv/web/querySystems', '1', 'DataQL', 'var dataSet = @@sql()<%
    select   count(distinct device_id)    from web_task;
%>
return dataSet(); ', 'var dataSet = @@sql()<%
    select   count(distinct device_id)    from web_task;
%>
return dataSet(); ', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"message":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"number"}}}}', '{"requestHeader":"[]","requestBody":"{\"message\":\"Hello DataQL.\"}","responseHeader":"{}","responseBody":"{\n\t\"success\":true,\n\t\"message\":\"OK\",\n\t\"code\":0,\n\t\"lifeCycleTime\":5,\n\t\"executionTime\":1,\n\t\"value\":0\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"70B5E8293499,005056C00008,005056C00001,00E04C239987","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\n    \"success\"      : \"@resultStatus\",\n    \"message\"      : \"@resultMessage\",\n    \"code\"         : \"@resultCode\",\n    \"lifeCycleTime\": \"@timeLifeCycle\",\n    \"executionTime\": \"@timeExecution\",\n    \"value\"        : \"@resultData\"\n}","wrapParameterName":"root"}', '1649417717654', '');
INSERT INTO logfv.interface_release (pub_id, pub_api_id, pub_method, pub_path, pub_status, pub_type, pub_script, pub_script_ori, pub_schema, pub_sample, pub_option, pub_release_time, pub_comment) VALUES ('r_enf100beg-4f9', 'i_enf10073b-7f5', 'GET', '/api/logfv/web/runtime', '1', 'DataQL', 'var dataSet = @@sql()<%
  select ROUND( MAX(log_date)/1000/3600/24 - MIN(log_date)/1000/3600/24)+1 from web_task;
%>
return dataSet(); ', 'var dataSet = @@sql()<%
  select ROUND( MAX(log_date)/1000/3600/24 - MIN(log_date)/1000/3600/24)+1 from web_task;
%>
return dataSet(); ', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"message":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":["string","boolean","number","object","array","null"]}}}}', '{"requestHeader":"[]","requestBody":"{\"message\":\"Hello DataQL.\"}","responseHeader":"{}","responseBody":"{\n\t\"success\":true,\n\t\"message\":\"OK\",\n\t\"code\":0,\n\t\"lifeCycleTime\":4,\n\t\"executionTime\":1\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"70B5E8293499,005056C00008,005056C00001,00E04C239987","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\n    \"success\"      : \"@resultStatus\",\n    \"message\"      : \"@resultMessage\",\n    \"code\"         : \"@resultCode\",\n    \"lifeCycleTime\": \"@timeLifeCycle\",\n    \"executionTime\": \"@timeExecution\",\n    \"value\"        : \"@resultData\"\n}","wrapParameterName":"root"}', '1649417755168', '');
INSERT INTO logfv.interface_release (pub_id, pub_api_id, pub_method, pub_path, pub_status, pub_type, pub_script, pub_script_ori, pub_schema, pub_sample, pub_option, pub_release_time, pub_comment) VALUES ('r_enf1027jl-98e', 'i_enf10245e8ne2', 'GET', '/api/logfv/web/queryTotalPage', '1', 'DataQL', 'var dataSet = @@sql()<%
select count(*) from web_detail;
%>
return dataSet(); ', 'var dataSet = @@sql()<%
select count(*) from web_detail;
%>
return dataSet(); ', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"message":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"number"}}}}', '{"requestHeader":"[]","requestBody":"{\"message\":\"Hello DataQL.\"}","responseHeader":"{}","responseBody":"{\n\t\"success\":true,\n\t\"message\":\"OK\",\n\t\"code\":0,\n\t\"lifeCycleTime\":3,\n\t\"executionTime\":0,\n\t\"value\":0\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"70B5E8293499,005056C00008,005056C00001,00E04C239987","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\n    \"success\"      : \"@resultStatus\",\n    \"message\"      : \"@resultMessage\",\n    \"code\"         : \"@resultCode\",\n    \"lifeCycleTime\": \"@timeLifeCycle\",\n    \"executionTime\": \"@timeExecution\",\n    \"value\"        : \"@resultData\"\n}","wrapParameterName":"root"}', '1649417780637', '');
INSERT INTO logfv.interface_release (pub_id, pub_api_id, pub_method, pub_path, pub_status, pub_type, pub_script, pub_script_ori, pub_schema, pub_sample, pub_option, pub_release_time, pub_comment) VALUES ('r_enf107bd472b8', 'i_enf107718401a', 'GET', '/api/logfv/web/queryLogSize', '3', 'DataQL', 'select concat(round(sum(data_length/1024/1024),2)) as data from information_schema.TABLES where table_schema=''logfv'' and (table_name = ''web_task''
or table_name = ''web_detail'')', 'select concat(round(sum(data_length/1024/1024),2)) as data from information_schema.TABLES where table_schema=''logfv'' and (table_name = ''web_task''
or table_name = ''web_detail'')', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"message":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"string"}}}}', '{"requestHeader":"[]","requestBody":"{\"message\":\"Hello DataQL.\"}","responseHeader":"{}","responseBody":"{\n\t\"success\":false,\n\t\"message\":\"line 1:0 mismatched input ''select'' expecting {''if'', ''return'', ''throw'', ''exit'', ''var'', ''run'', ''hint'', ''import'', ''{''}\",\n\t\"code\":500,\n\t\"lifeCycleTime\":5,\n\t\"executionTime\":-1,\n\t\"value\":\"line 1:0 mismatched input ''select'' expecting {''if'', ''return'', ''throw'', ''exit'', ''var'', ''run'', ''hint'', ''import'', ''{''}\"\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"70B5E8293499,005056C00008,005056C00001,00E04C239987","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\n    \"success\"      : \"@resultStatus\",\n    \"message\"      : \"@resultMessage\",\n    \"code\"         : \"@resultCode\",\n    \"lifeCycleTime\": \"@timeLifeCycle\",\n    \"executionTime\": \"@timeExecution\",\n    \"value\"        : \"@resultData\"\n}","wrapParameterName":"root"}', '1649417851900', '');
INSERT INTO logfv.interface_release (pub_id, pub_api_id, pub_method, pub_path, pub_status, pub_type, pub_script, pub_script_ori, pub_schema, pub_sample, pub_option, pub_release_time, pub_comment) VALUES ('r_enf14jjhe4j02', 'i_enf107718401a', 'GET', '/api/logfv/web/queryLogSize', '3', 'SQL', 'var tempCall = @@sql(`message`)<%select pg_database_size(''test_db'') as data%>;
return tempCall(${message});', 'select pg_database_size(''test_db'') as data', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"message":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"number"}}}}', '{"requestHeader":"[]","requestBody":"{\"message\":\"Hello DataQL.\"}","responseHeader":"{}","responseBody":"{\n\t\"success\":true,\n\t\"message\":\"OK\",\n\t\"code\":0,\n\t\"lifeCycleTime\":2,\n\t\"executionTime\":1,\n\t\"value\":9364259\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"70B5E8293499,005056C00008,005056C00001,00E04C239987","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\n    \"success\"      : \"@resultStatus\",\n    \"message\"      : \"@resultMessage\",\n    \"code\"         : \"@resultCode\",\n    \"lifeCycleTime\": \"@timeLifeCycle\",\n    \"executionTime\": \"@timeExecution\",\n    \"value\"        : \"@resultData\"\n}","wrapParameterName":"root"}', '1649419349606', '');
INSERT INTO logfv.interface_release (pub_id, pub_api_id, pub_method, pub_path, pub_status, pub_type, pub_script, pub_script_ori, pub_schema, pub_sample, pub_option, pub_release_time, pub_comment) VALUES ('r_enf15cdk2-5i7', 'i_enf10a77d8en1', 'GET', '/api/logfv/web/getCountByGroupByLogType', '1', 'DataQL', '// a new Query.
hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
// �����ѯSQL
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
hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
// �����ѯSQL
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
', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"month":{"type":"string"},"year":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"array","items":{"type":["string","boolean","number","object","array","null"]}}}}}', '{"requestHeader":"[]","requestBody":"{\r\n  \"year\": \"2021\",\r\n  \"month\":\"\"\r\n}","responseHeader":"{}","responseBody":"{\n\t\"success\":true,\n\t\"message\":\"OK\",\n\t\"code\":0,\n\t\"lifeCycleTime\":8,\n\t\"executionTime\":4,\n\t\"value\":[]\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"70B5E8293499,005056C00008,005056C00001,00E04C239987","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\n    \"success\"      : \"@resultStatus\",\n    \"message\"      : \"@resultMessage\",\n    \"code\"         : \"@resultCode\",\n    \"lifeCycleTime\": \"@timeLifeCycle\",\n    \"executionTime\": \"@timeExecution\",\n    \"value\"        : \"@resultData\"\n}","wrapParameterName":"root"}', '1649419581218', '');
INSERT INTO logfv.interface_release (pub_id, pub_api_id, pub_method, pub_path, pub_status, pub_type, pub_script, pub_script_ori, pub_schema, pub_sample, pub_option, pub_release_time, pub_comment) VALUES ('r_enf15c6mb8j59', 'i_enf10a77d8en1', 'GET', '/api/logfv/web/getCountByGroupByLogType', '3', 'DataQL', '// a new Query.
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
', '{"requestHeader":null,"requestBody":null,"responseHeader":null,"responseBody":null}', '{"requestHeader":"[]","requestBody":"{\r\n  \"year\": \"2021\",\r\n  \"month\":\"\"\r\n}","responseHeader":"[]","responseBody":"{}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"70B5E8293499,005056C00008,005056C00001,00E04C239987","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\n    \"success\"      : \"@resultStatus\",\n    \"message\"      : \"@resultMessage\",\n    \"code\"         : \"@resultCode\",\n    \"lifeCycleTime\": \"@timeLifeCycle\",\n    \"executionTime\": \"@timeExecution\",\n    \"value\"        : \"@resultData\"\n}","wrapParameterName":"root"}', '1649419577243', '');
INSERT INTO logfv.interface_release (pub_id, pub_api_id, pub_method, pub_path, pub_status, pub_type, pub_script, pub_script_ori, pub_schema, pub_sample, pub_option, pub_release_time, pub_comment) VALUES ('r_enf15d904-dk6', 'i_enf10bmdc-4in', 'GET', '/api/logfv/web/getCount', '1', 'DataQL', '// a new Query.
hint FRAGMENT_SQL_QUERY_BY_PAGE = true
hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
//�� 1 ��ʼ��Ϊҳ�����ʼ���
hint FRAGMENT_SQL_QUERY_BY_PAGE_NUMBER_OFFSET = 1
// �����ѯSQL
var dataSet = @@mybatis(year,month,day, logType)<%
<select>
    select t.device_name,t.device_id,t.obj_type,t.log_date, count(d.id) as num from web_detail d
    inner join web_task t on d.task_id = t.id
    where d.record_year = #{year} and d.record_month = #{month}
        and d.record_day = #{day} and d.log_type = #{logType} and  d.task_id != 0

    group by t.device_name,t.device_id,t.obj_type,log_date order by   num desc


 </select>
%>

// ������ҳ��ѯ����
var pageQuery =  dataSet(${year},${month},${day},${logType});

// ���÷�ҳ��Ϣ
run pageQuery.setPageInfo({
    "pageSize"    : ${pageSize}, // ҳ��С
    "currentPage" : ${pageNo}   // ��1ҳ
});

// ִ�з�ҳ��ѯ
return {
    "pageInfo":pageQuery.pageInfo(),
    "pageData":pageQuery.data()
}
', '// a new Query.
hint FRAGMENT_SQL_QUERY_BY_PAGE = true
hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
//�� 1 ��ʼ��Ϊҳ�����ʼ���
hint FRAGMENT_SQL_QUERY_BY_PAGE_NUMBER_OFFSET = 1
// �����ѯSQL
var dataSet = @@mybatis(year,month,day, logType)<%
<select>
    select t.device_name,t.device_id,t.obj_type,t.log_date, count(d.id) as num from web_detail d
    inner join web_task t on d.task_id = t.id
    where d.record_year = #{year} and d.record_month = #{month}
        and d.record_day = #{day} and d.log_type = #{logType} and  d.task_id != 0

    group by t.device_name,t.device_id,t.obj_type,log_date order by   num desc


 </select>
%>

// ������ҳ��ѯ����
var pageQuery =  dataSet(${year},${month},${day},${logType});

// ���÷�ҳ��Ϣ
run pageQuery.setPageInfo({
    "pageSize"    : ${pageSize}, // ҳ��С
    "currentPage" : ${pageNo}   // ��1ҳ
});

// ִ�з�ҳ��ѯ
return {
    "pageInfo":pageQuery.pageInfo(),
    "pageData":pageQuery.data()
}
', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"logType":{"type":"string"},"month":{"type":"string"},"year":{"type":"string"},"day":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"object","properties":{"pageInfo":{"type":"object","properties":{"recordPosition":{"type":"number"},"enable":{"type":"boolean"},"totalPage":{"type":"number"},"pageSize":{"type":"number"},"totalCount":{"type":"number"},"currentPage":{"type":"number"}}},"pageData":{"type":"array","items":{"type":["string","boolean","number","object","array","null"]}}}}}}}', '{"requestHeader":"[]","requestBody":"{\r\n  \"year\": \"2021\",\r\n  \"month\":\"11\",\r\n  \"day\":\"2\",\r\n  \"logType\":\"info\"\r\n}","responseHeader":"{}","responseBody":"{\n\t\"success\":true,\n\t\"message\":\"OK\",\n\t\"code\":0,\n\t\"lifeCycleTime\":8,\n\t\"executionTime\":4,\n\t\"value\":{\n\t\t\"pageInfo\":{\n\t\t\t\"enable\":false,\n\t\t\t\"pageSize\":-1,\n\t\t\t\"totalCount\":0,\n\t\t\t\"totalPage\":1,\n\t\t\t\"currentPage\":1,\n\t\t\t\"recordPosition\":0\n\t\t},\n\t\t\"pageData\":[]\n\t}\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"70B5E8293499,005056C00008,005056C00001,00E04C239987","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\n    \"success\"      : \"@resultStatus\",\n    \"message\"      : \"@resultMessage\",\n    \"code\"         : \"@resultCode\",\n    \"lifeCycleTime\": \"@timeLifeCycle\",\n    \"executionTime\": \"@timeExecution\",\n    \"value\"        : \"@resultData\"\n}","wrapParameterName":"root"}', '1649419592260', '');
INSERT INTO logfv.interface_release (pub_id, pub_api_id, pub_method, pub_path, pub_status, pub_type, pub_script, pub_script_ori, pub_schema, pub_sample, pub_option, pub_release_time, pub_comment) VALUES ('r_enf15e3i88an4', 'i_enf10f788-67a', 'GET', '/api/logfv/web/getDayLogType', '1', 'DataQL', '// a new Query.
hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
// �����ѯSQL
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
hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
// �����ѯSQL
var dataSet = @@mybatis(year,month,day)<%
<select>
select d.log_type, count(d.id) as num from web_detail d
where
    d.record_year = #{year} and d.record_month = #{month} and
    d.record_day = #{day} and  d.task_id != 0
group by d.log_type order by num desc
 </select>
%>

return dataSet(${year},${month},${day});', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"month":{"type":"string"},"year":{"type":"string"},"day":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"array","items":{"type":["string","boolean","number","object","array","null"]}}}}}', '{"requestHeader":"[]","requestBody":"{\r\n    \"year\": \"2021\",\r\n    \"month\":\"11\",\r\n    \"day\":\"2\"\r\n}","responseHeader":"{}","responseBody":"{\n\t\"success\":true,\n\t\"message\":\"OK\",\n\t\"code\":0,\n\t\"lifeCycleTime\":4,\n\t\"executionTime\":2,\n\t\"value\":[]\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"70B5E8293499,005056C00008,005056C00001,00E04C239987","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\n    \"success\"      : \"@resultStatus\",\n    \"message\"      : \"@resultMessage\",\n    \"code\"         : \"@resultCode\",\n    \"lifeCycleTime\": \"@timeLifeCycle\",\n    \"executionTime\": \"@timeExecution\",\n    \"value\"        : \"@resultData\"\n}","wrapParameterName":"root"}', '1649419603064', '');
INSERT INTO logfv.interface_release (pub_id, pub_api_id, pub_method, pub_path, pub_status, pub_type, pub_script, pub_script_ori, pub_schema, pub_sample, pub_option, pub_release_time, pub_comment) VALUES ('r_enf13mc9h-7c9', 'i_enf0n8l314829', 'GET', '/api/logfv/web/queryLogType', '3', 'DataQL', '// a new Query.
// SQL ???????????????
hint FRAGMENT_SQL_QUERY_BY_PAGE = true
hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
//?? 1 ????????????????
hint FRAGMENT_SQL_QUERY_BY_PAGE_NUMBER_OFFSET = 1
// ??????SQL

var dataSet = @@mybatis()<%
<select>
select date,log_type as logType,COUNT(log_type) as count from
(
select left(cast (log_time as varchar),10) as date, log_type from web_detail a
where exists(select * from web_task b where a.task_id = b.id)
) b
group by date,log_type
 </select>
%>
// ??????????????
var pageQuery =  dataSet();
// ??????????
run pageQuery.setPageInfo({
    "pageSize"    : ${pageSize}, // ?????
    "currentPage" : ${pageNo}   // ??1?
});
// ?????????
return {
    "pageInfo":pageQuery.pageInfo(),
    "pageData":pageQuery.data()
}', '// a new Query.
// SQL ???????????????
hint FRAGMENT_SQL_QUERY_BY_PAGE = true
hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
//?? 1 ????????????????
hint FRAGMENT_SQL_QUERY_BY_PAGE_NUMBER_OFFSET = 1
// ??????SQL

var dataSet = @@mybatis()<%
<select>
select date,log_type as logType,COUNT(log_type) as count from
(
select left(cast (log_time as varchar),10) as date, log_type from web_detail a
where exists(select * from web_task b where a.task_id = b.id)
) b
group by date,log_type
 </select>
%>
// ??????????????
var pageQuery =  dataSet();
// ??????????
run pageQuery.setPageInfo({
    "pageSize"    : ${pageSize}, // ?????
    "currentPage" : ${pageNo}   // ??1?
});
// ?????????
return {
    "pageInfo":pageQuery.pageInfo(),
    "pageData":pageQuery.data()
}', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"message":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"object","properties":{"pageInfo":{"type":"object","properties":{"recordPosition":{"type":"number"},"enable":{"type":"boolean"},"totalPage":{"type":"number"},"pageSize":{"type":"number"},"totalCount":{"type":"number"},"currentPage":{"type":"number"}}},"pageData":{"type":"array","items":{"type":"object","properties":{"date":{"type":"string"},"logtype":{"type":"string"},"count":{"type":"number"}}}}}}}}}', '{"requestHeader":"[]","requestBody":"{\"message\":\"Hello DataQL.\"}","responseHeader":"{}","responseBody":"{\n\t\"success\":true,\n\t\"message\":\"OK\",\n\t\"code\":0,\n\t\"lifeCycleTime\":7,\n\t\"executionTime\":4,\n\t\"value\":{\n\t\t\"pageInfo\":{\n\t\t\t\"enable\":false,\n\t\t\t\"pageSize\":-1,\n\t\t\t\"totalCount\":4,\n\t\t\t\"totalPage\":1,\n\t\t\t\"currentPage\":1,\n\t\t\t\"recordPosition\":0\n\t\t},\n\t\t\"pageData\":[\n\t\t\t{\n\t\t\t\t\"date\":\"1649418061\",\n\t\t\t\t\"logtype\":\"page\",\n\t\t\t\t\"count\":1\n\t\t\t},\n\t\t\t{\n\t\t\t\t\"date\":\"1649418570\",\n\t\t\t\t\"logtype\":\"info\",\n\t\t\t\t\"count\":1\n\t\t\t},\n\t\t\t{\n\t\t\t\t\"date\":\"1649418063\",\n\t\t\t\t\"logtype\":\"info\",\n\t\t\t\t\"count\":4\n\t\t\t},\n\t\t\t{\n\t\t\t\t\"date\":\"1649418570\",\n\t\t\t\t\"logtype\":\"warn\",\n\t\t\t\t\"count\":1\n\t\t\t}\n\t\t]\n\t}\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"70B5E8293499,005056C00008,005056C00001,00E04C239987","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\n    \"success\"      : \"@resultStatus\",\n    \"message\"      : \"@resultMessage\",\n    \"code\"         : \"@resultCode\",\n    \"lifeCycleTime\": \"@timeLifeCycle\",\n    \"executionTime\": \"@timeExecution\",\n    \"value\"        : \"@resultData\"\n}","wrapParameterName":"root"}', '1649419055081', '');
INSERT INTO logfv.interface_release (pub_id, pub_api_id, pub_method, pub_path, pub_status, pub_type, pub_script, pub_script_ori, pub_schema, pub_sample, pub_option, pub_release_time, pub_comment) VALUES ('r_enf19fag931nj', 'i_enf0n8l314829', 'GET', '/api/logfv/web/queryLogType', '1', 'DataQL', '// a new Query.
// SQL ???????????????
hint FRAGMENT_SQL_QUERY_BY_PAGE = true
hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
//?? 1 ????????????????
hint FRAGMENT_SQL_QUERY_BY_PAGE_NUMBER_OFFSET = 1
// ??????SQL

var dataSet = @@mybatis()<%
<select>
select date,log_type as "logType",COUNT(log_type) as count from
(
select TO_CHAR(TO_TIMESTAMP(log_time / 1000),''YYYYMMDD'') as date, log_type from web_detail a
where exists(select * from web_task b where a.task_id = b.id)
) b
group by date,log_type
 </select>
%>
// ??????????????
var pageQuery =  dataSet();
// ??????????
run pageQuery.setPageInfo({
    "pageSize"    : ${pageSize}, // ?????
    "currentPage" : ${pageNo}   // ??1?
});
// ?????????
return {
    "pageInfo":pageQuery.pageInfo(),
    "pageData":pageQuery.data()
}', '// a new Query.
// SQL ???????????????
hint FRAGMENT_SQL_QUERY_BY_PAGE = true
hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
//?? 1 ????????????????
hint FRAGMENT_SQL_QUERY_BY_PAGE_NUMBER_OFFSET = 1
// ??????SQL

var dataSet = @@mybatis()<%
<select>
select date,log_type as "logType",COUNT(log_type) as count from
(
select TO_CHAR(TO_TIMESTAMP(log_time / 1000),''YYYYMMDD'') as date, log_type from web_detail a
where exists(select * from web_task b where a.task_id = b.id)
) b
group by date,log_type
 </select>
%>
// ??????????????
var pageQuery =  dataSet();
// ??????????
run pageQuery.setPageInfo({
    "pageSize"    : ${pageSize}, // ?????
    "currentPage" : ${pageNo}   // ??1?
});
// ?????????
return {
    "pageInfo":pageQuery.pageInfo(),
    "pageData":pageQuery.data()
}', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"message":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"object","properties":{"pageInfo":{"type":"object","properties":{"recordPosition":{"type":"number"},"enable":{"type":"boolean"},"totalPage":{"type":"number"},"pageSize":{"type":"number"},"totalCount":{"type":"number"},"currentPage":{"type":"number"}}},"pageData":{"type":"array","items":{"type":"object","properties":{"date":{"type":"string"},"logType":{"type":"string"},"count":{"type":"number"}}}}}}}}}', '{"requestHeader":"[]","requestBody":"{\"message\":\"Hello DataQL.\"}","responseHeader":"{}","responseBody":"{\n\t\"success\":true,\n\t\"message\":\"OK\",\n\t\"code\":0,\n\t\"lifeCycleTime\":4,\n\t\"executionTime\":2,\n\t\"value\":{\n\t\t\"pageInfo\":{\n\t\t\t\"enable\":false,\n\t\t\t\"pageSize\":-1,\n\t\t\t\"totalCount\":1,\n\t\t\t\"totalPage\":1,\n\t\t\t\"currentPage\":1,\n\t\t\t\"recordPosition\":0\n\t\t},\n\t\t\"pageData\":[\n\t\t\t{\n\t\t\t\t\"date\":\"20220408\",\n\t\t\t\t\"logType\":\"info\",\n\t\t\t\t\"count\":6\n\t\t\t}\n\t\t]\n\t}\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"70B5E8293499,005056C00008,005056C00001,00E04C239987","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\n    \"success\"      : \"@resultStatus\",\n    \"message\"      : \"@resultMessage\",\n    \"code\"         : \"@resultCode\",\n    \"lifeCycleTime\": \"@timeLifeCycle\",\n    \"executionTime\": \"@timeExecution\",\n    \"value\"        : \"@resultData\"\n}","wrapParameterName":"root"}', '1649420947977', '');
INSERT INTO logfv.interface_release (pub_id, pub_api_id, pub_method, pub_path, pub_status, pub_type, pub_script, pub_script_ori, pub_schema, pub_sample, pub_option, pub_release_time, pub_comment) VALUES ('r_enf18gh4i-3h9', 'i_enf0n8l314829', 'GET', '/api/logfv/web/queryLogType', '3', 'DataQL', '// a new Query.
// SQL ???????????????
hint FRAGMENT_SQL_QUERY_BY_PAGE = true
hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
//?? 1 ????????????????
hint FRAGMENT_SQL_QUERY_BY_PAGE_NUMBER_OFFSET = 1
// ??????SQL

var dataSet = @@mybatis()<%
<select>
select date,log_type as logType,COUNT(log_type) as count from
(
select TO_CHAR(TO_TIMESTAMP(log_time / 1000),''YYYYMMDD'') as date, log_type from web_detail a
where exists(select * from web_task b where a.task_id = b.id)
) b
group by date,log_type
 </select>
%>
// ??????????????
var pageQuery =  dataSet();
// ??????????
run pageQuery.setPageInfo({
    "pageSize"    : ${pageSize}, // ?????
    "currentPage" : ${pageNo}   // ??1?
});
// ?????????
return {
    "pageInfo":pageQuery.pageInfo(),
    "pageData":pageQuery.data()
}', '// a new Query.
// SQL ???????????????
hint FRAGMENT_SQL_QUERY_BY_PAGE = true
hint FRAGMENT_SQL_OPEN_PACKAGE = "off"
//?? 1 ????????????????
hint FRAGMENT_SQL_QUERY_BY_PAGE_NUMBER_OFFSET = 1
// ??????SQL

var dataSet = @@mybatis()<%
<select>
select date,log_type as logType,COUNT(log_type) as count from
(
select TO_CHAR(TO_TIMESTAMP(log_time / 1000),''YYYYMMDD'') as date, log_type from web_detail a
where exists(select * from web_task b where a.task_id = b.id)
) b
group by date,log_type
 </select>
%>
// ??????????????
var pageQuery =  dataSet();
// ??????????
run pageQuery.setPageInfo({
    "pageSize"    : ${pageSize}, // ?????
    "currentPage" : ${pageNo}   // ??1?
});
// ?????????
return {
    "pageInfo":pageQuery.pageInfo(),
    "pageData":pageQuery.data()
}', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"message":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"object","properties":{"pageInfo":{"type":"object","properties":{"recordPosition":{"type":"number"},"enable":{"type":"boolean"},"totalPage":{"type":"number"},"pageSize":{"type":"number"},"totalCount":{"type":"number"},"currentPage":{"type":"number"}}},"pageData":{"type":"array","items":{"type":"object","properties":{"date":{"type":"string"},"logtype":{"type":"string"},"count":{"type":"number"}}}}}}}}}', '{"requestHeader":"[]","requestBody":"{\"message\":\"Hello DataQL.\"}","responseHeader":"{}","responseBody":"{\n\t\"success\":true,\n\t\"message\":\"OK\",\n\t\"code\":0,\n\t\"lifeCycleTime\":5,\n\t\"executionTime\":3,\n\t\"value\":{\n\t\t\"pageInfo\":{\n\t\t\t\"enable\":false,\n\t\t\t\"pageSize\":-1,\n\t\t\t\"totalCount\":1,\n\t\t\t\"totalPage\":1,\n\t\t\t\"currentPage\":1,\n\t\t\t\"recordPosition\":0\n\t\t},\n\t\t\"pageData\":[\n\t\t\t{\n\t\t\t\t\"date\":\"20220408\",\n\t\t\t\t\"logtype\":\"info\",\n\t\t\t\t\"count\":5\n\t\t\t}\n\t\t]\n\t}\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"70B5E8293499,005056C00008,005056C00001,00E04C239987","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\n    \"success\"      : \"@resultStatus\",\n    \"message\"      : \"@resultMessage\",\n    \"code\"         : \"@resultCode\",\n    \"lifeCycleTime\": \"@timeLifeCycle\",\n    \"executionTime\": \"@timeExecution\",\n    \"value\"        : \"@resultData\"\n}","wrapParameterName":"root"}', '1649420633778', '');
INSERT INTO logfv.interface_release (pub_id, pub_api_id, pub_method, pub_path, pub_status, pub_type, pub_script, pub_script_ori, pub_schema, pub_sample, pub_option, pub_release_time, pub_comment) VALUES ('r_enf1ald0h1a5l', 'i_enf107718401a', 'GET', '/api/logfv/web/queryLogSize', '1', 'SQL', 'var tempCall = @@sql(`message`)<%select round((pg_total_relation_size(''web_detail'')+pg_total_relation_size(''web_task''))::numeric/1024/1024,4) as data%>;
return tempCall(${message});', 'select round((pg_total_relation_size(''web_detail'')+pg_total_relation_size(''web_task''))::numeric/1024/1024,4) as data', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"message":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"number"}}}}', '{"requestHeader":"[]","requestBody":"{\"message\":\"Hello DataQL.\"}","responseHeader":"{}","responseBody":"{\n\t\"success\":true,\n\t\"message\":\"OK\",\n\t\"code\":0,\n\t\"lifeCycleTime\":3,\n\t\"executionTime\":1,\n\t\"value\":0.0938\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"70B5E8293499,005056C00008,005056C00001,00E04C239987","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\n    \"success\"      : \"@resultStatus\",\n    \"message\"      : \"@resultMessage\",\n    \"code\"         : \"@resultCode\",\n    \"lifeCycleTime\": \"@timeLifeCycle\",\n    \"executionTime\": \"@timeExecution\",\n    \"value\"        : \"@resultData\"\n}","wrapParameterName":"root"}', '1649421364049', '');
INSERT INTO logfv.interface_release (pub_id, pub_api_id, pub_method, pub_path, pub_status, pub_type, pub_script, pub_script_ori, pub_schema, pub_sample, pub_option, pub_release_time, pub_comment) VALUES ('r_enf1a7gd4-6kh', 'i_enf107718401a', 'GET', '/api/logfv/web/queryLogSize', '3', 'SQL', 'var tempCall = @@sql(`message`)<%select (pg_total_relation_size(''web_detail'')+pg_total_relation_size(''web_task''))/1024/1024 as data%>;
return tempCall(${message});', 'select (pg_total_relation_size(''web_detail'')+pg_total_relation_size(''web_task''))/1024/1024 as data', '{"requestHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"requestBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"message":{"type":"string"}}},"responseHeader":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{}},"responseBody":{"$schema":"http://json-schema.org/draft-04/schema#","type":"object","properties":{"executionTime":{"type":"number"},"code":{"type":"number"},"success":{"type":"boolean"},"lifeCycleTime":{"type":"number"},"message":{"type":"string"},"value":{"type":"number"}}}}', '{"requestHeader":"[]","requestBody":"{\"message\":\"Hello DataQL.\"}","responseHeader":"{}","responseBody":"{\n\t\"success\":true,\n\t\"message\":\"OK\",\n\t\"code\":0,\n\t\"lifeCycleTime\":2,\n\t\"executionTime\":0,\n\t\"value\":0\n}"}', '{"wrapAllParameters":false,"enableCrossDomain":true,"API_BASE_URL":"/api/","ALL_MAC":"70B5E8293499,005056C00008,005056C00001,00E04C239987","resultStructure":true,"showGitButton":false,"DATAWAY_VERSION":"4.2.2.RELEASE","checkDatawayVersion":true,"CONTEXT_PATH":"/dataway-api","responseFormat":"{\n    \"success\"      : \"@resultStatus\",\n    \"message\"      : \"@resultMessage\",\n    \"code\"         : \"@resultCode\",\n    \"lifeCycleTime\": \"@timeLifeCycle\",\n    \"executionTime\": \"@timeExecution\",\n    \"value\"        : \"@resultData\"\n}","wrapParameterName":"root"}', '1649421172540', '');
