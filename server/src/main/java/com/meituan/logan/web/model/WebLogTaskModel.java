package com.meituan.logan.web.model;

import com.meituan.logan.web.dto.WebLogTaskDTO;
import com.meituan.logan.web.util.DateTimeUtil;
import com.meituan.logan.web.util.TrimFieldEnum;
import lombok.Data;
import org.apache.commons.lang3.StringUtils;

import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Date;

/**
 * 功能描述:  <p></p>
 *
 *
 * @version 1.0 2019-10-30
 * @since logan-web 1.0
 */
@Data
public class WebLogTaskModel {

    private String deviceId;

    private String appName;

    private int logPageNo;
    private int objType;
    private String webSource;

    private String environment;

    private String logArray;

    private transient String content;

    private transient long logDate;

    private String fileDate;

    private String client;

    private String customInfo;

    public boolean isValid() {
        if (StringUtils.isEmpty(deviceId) || StringUtils.isEmpty(appName) || logPageNo <= 0 || StringUtils.isEmpty(logArray)
                || StringUtils.isEmpty(fileDate)) {
            return false;
        }
        Date date = DateTimeUtil.parseDate(fileDate);
        if (date == null) {
            return false;
        } else {
            logDate = DateTimeUtil.trimAfter(TrimFieldEnum.HOUR, date).getTime();
        }
        return true;
    }
    public WebLogTaskDTO transformToDto() {
        WebLogTaskDTO taskDTO = new WebLogTaskDTO();
        taskDTO.setDeviceId(deviceId);
        taskDTO.setAppName(appName);
        taskDTO.setWebSource(webSource);
        taskDTO.setEnvironment(environment);
        taskDTO.setPageNum(logPageNo);
        taskDTO.setContent(content);
        taskDTO.setLogDate(logDate);
        taskDTO.setCustomReportInfo(customInfo);
        if(objType==0){
            objType=1;
        }
        taskDTO.setObjType(objType);
        Timestamp ts=new Timestamp(logDate);
        Date date=new Date(ts.getTime());
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        taskDTO.setRecordYear(cal.get(Calendar.YEAR));
        taskDTO.setRecordMonth(cal.get(Calendar.MONTH) + 1);
        taskDTO.setRecordDay(cal.get(Calendar.DAY_OF_MONTH));
        return taskDTO;
    }
}
