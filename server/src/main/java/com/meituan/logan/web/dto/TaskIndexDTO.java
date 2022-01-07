package com.meituan.logan.web.dto;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;

import java.util.Date;

/**
 * 功能描述:  <p></p>
 *
 * @version 1.0 2019-10-30
 * @since logan-web 1.0
 */
@Data
public class TaskIndexDTO {
    private String deviceId;
    private String deviceName;
    private Long lastLogDate;
    private Long logPageNum;

}
