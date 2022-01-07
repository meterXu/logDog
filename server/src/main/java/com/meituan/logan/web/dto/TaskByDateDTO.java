package com.meituan.logan.web.dto;

import lombok.Data;

import java.util.Date;

/**
 * 功能描述:  <p></p>
 *
 * @version 1.0 2019-10-30
 * @since logan-web 1.0
 */
@Data
public class TaskByDateDTO {
    private String deviceId;
    private long logDate;
    private long logPageNum;

}
