package com.meituan.logan.web.model;
import com.alibaba.fastjson.JSON;
import com.meituan.logan.web.dto.WebLogDetailDTO;
import com.meituan.logan.web.util.DateTimeUtil;
import com.meituan.logan.web.util.TrimFieldEnum;
import lombok.Data;
import org.apache.commons.lang3.StringUtils;
import java.net.URLEncoder;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

@Data
class logObj {
    private String t;
    private String c;
    private long d;
    private String e;
    private String i;
    private String s;
}

@Data
public class WebLogSaveModel {

    private String appName;
    private String appId;
    private String type;
    private String content;
    private String source;
    private String environment;
    private String info;
    private long logTime;
    private long logDate;

    public boolean isValid() {
        if (StringUtils.isEmpty(type) ||StringUtils.isEmpty(appName) ||StringUtils.isEmpty(appId) || StringUtils.isEmpty(content)|| logTime==0) {
            return false;
        }
        Timestamp ts=new Timestamp(logTime);
        Date date=new Date(ts.getTime());
        if (date == null) {
            return false;
        } else {
            logDate = DateTimeUtil.trimAfter(TrimFieldEnum.HOUR, date).getTime();
        }
        return true;
    }

    public WebLogSaveModel transformToDto(){
        logObj log = new logObj();
        log.setT(type);
        log.setC(URLEncoder.encode(content));
        log.setD(logTime);
        log.setS(source);
        log.setE(environment);
        log.setI(info);
        List<logObj> logs = new LinkedList<logObj>();
        logs.add(log);
        this.content = JSON.toJSONString(logs);
        return this;
    }


}
