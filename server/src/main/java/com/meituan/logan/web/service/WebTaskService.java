package com.meituan.logan.web.service;

import com.fasterxml.jackson.databind.ser.std.StdKeySerializers;
import com.meituan.logan.web.dto.TaskByDateDTO;
import com.meituan.logan.web.dto.TaskIndexDTO;
import com.meituan.logan.web.dto.WebLogTaskDTO;
import com.meituan.logan.web.enums.TaskStatusEnum;
import com.meituan.logan.web.model.WebLogTaskModel;

import java.util.List;

/**
 * 功能描述:  <p></p>
 *
 *
 * @version 1.0 2019-10-30
 * @since logan-admin-server 1.0
 */
public interface WebTaskService {

    /**
     * 新增/更新一次上报
     *
     * @param webLogTaskModel
     */
    Long saveTask(WebLogTaskModel webLogTaskModel);

    /**
     * 删除addTime之前的记录，单位 ms
     *
     * @param addTime
     */
    void deleteByAddTime(long addTime);

    /**
     * 根据起始与截止时间进行搜索，3个参数必填，基于deviceId精确匹配
     *
     * @param beginTime
     * @param endTime
     * @param deviceId
     * @return
     */
    List<WebLogTaskDTO> search(long beginTime, long endTime, String deviceId);

    List<WebLogTaskDTO> queryByTaskIds(List<Long> taskIds);

    void updateStatus(long taskId, TaskStatusEnum status);

    List<WebLogTaskDTO> latest(int count);

    List<TaskIndexDTO> query(int pageSize, int pageNum, String deviceName,String deviceId);

    long total(String deviceName,String deviceId);

    List<TaskByDateDTO> queryTaskByDate(String deviceId);
}
