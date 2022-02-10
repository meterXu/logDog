package com.meituan.logan.web.model;
import com.alibaba.fastjson.JSON;
import com.meituan.logan.web.dto.WebLogDetailDTO;
import lombok.Data;
import org.apache.commons.lang3.StringUtils;
import java.net.URLEncoder;
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
    private transient String type;
    private transient String content;
    private transient String source;
    private transient String environment;
    private transient String info;
    private transient long logDate;

    public boolean isValid() {
        if (StringUtils.isEmpty(type) ||StringUtils.isEmpty(appName) ||StringUtils.isEmpty(appId) || StringUtils.isEmpty(content)||logDate==0) {
            return false;
        }
        return true;
    }

    public WebLogSaveModel transformToDto(){
        logObj log = new logObj();
        log.setT(type);
        log.setC(URLEncoder.encode(content));
        log.setD(logDate);
        log.setS(source);
        log.setE(environment);
        log.setI(info);
        List<logObj> logs = new LinkedList<logObj>();
        logs.add(log);
        this.content = JSON.toJSONString(logs);
        return this;
    }


}
