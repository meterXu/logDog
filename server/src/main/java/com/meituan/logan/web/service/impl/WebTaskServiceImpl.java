package com.meituan.logan.web.service.impl;

import com.fasterxml.jackson.databind.ser.std.StdKeySerializers;
import com.meituan.logan.web.dto.TaskByDateDTO;
import com.meituan.logan.web.dto.WebLogTaskDTO;
import com.meituan.logan.web.dto.TaskIndexDTO;
import com.meituan.logan.web.enums.TaskStatusEnum;
import com.meituan.logan.web.mapper.WebLogTaskMapper;
import com.meituan.logan.web.model.WebLogTaskModel;
import com.meituan.logan.web.service.WebTaskService;
import org.apache.commons.collections.CollectionUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Collections;
import java.util.List;

/**
 * 功能描述:  <p>web上报处理服务</p>
 *
 * @version 1.0 2019-10-31
 * @since logan-admin-server 1.0
 */
@Service
public class WebTaskServiceImpl implements WebTaskService {
    private static final Logger LOGGER = Logger.getLogger(WebTaskServiceImpl.class);
    @Resource
    private WebLogTaskMapper webLogTaskMapper;

    @Override
    public Long saveTask(WebLogTaskModel taskModel) {
        try {
            WebLogTaskDTO taskDTO = taskModel.transformToDto();
            WebLogTaskDTO exist = webLogTaskMapper.exist(taskDTO.getLogDate(), taskDTO.getDeviceId(),
                    taskDTO.getPageNum());
            if (exist != null) {
                webLogTaskMapper.updateContent(exist.getTaskId(), taskDTO.getContent());
                return exist.getTaskId();
            } else {
                webLogTaskMapper.insert(taskDTO);
                return taskDTO.getTaskId();
            }

        } catch (Exception e) {
            LOGGER.error(e);
        }
        return null;
    }

    @Override
    public void deleteByAddTime(long addTime) {
        try {
            webLogTaskMapper.deleteByAddTime(addTime);
        } catch (Exception e) {
            LOGGER.error(e);
        }
    }

    @Override
    public List<WebLogTaskDTO> search(long beginTime, long endTime, String deviceId) {
        try {
            return webLogTaskMapper.search(beginTime, endTime, deviceId);
        } catch (Exception e) {
            LOGGER.error(e);
        }
        return Collections.emptyList();
    }

    @Override
    public List<WebLogTaskDTO> queryByTaskIds(List<Long> taskIds) {
        try {
            if (CollectionUtils.isEmpty(taskIds)) {
                return Collections.emptyList();
            }
            return webLogTaskMapper.queryByIds(taskIds);
        } catch (Exception e) {
            LOGGER.error(e);
        }
        return Collections.emptyList();
    }

    @Override
    public void updateStatus(long taskId, TaskStatusEnum status) {
        try {
            webLogTaskMapper.updateStatus(taskId, status.getStatus());
        } catch (Exception e) {
            LOGGER.error(e);
        }
    }

    @Override
    public List<WebLogTaskDTO> latest(int count) {
        try {
            long maxId = webLogTaskMapper.maxId();
            long minId = Math.max(0, maxId - count);
            return webLogTaskMapper.queryByRange(minId, maxId);
        } catch (Exception e) {
            LOGGER.error(e);
            return Collections.emptyList();
        }
    }

    @Override
    public List<TaskIndexDTO> query(int pageSize,int pageNum,String deviceName,String deviceId) {
        try {
            int offset = (pageSize-1)*pageNum;
            int limit = pageNum;
            return webLogTaskMapper.query(limit, offset,deviceName,deviceId);
        } catch (Exception e) {
            LOGGER.error(e);
            return Collections.emptyList();
        }
    }
    @Override
    public long total(String deviceName,String deviceId) {
        try {
            return webLogTaskMapper.total(deviceName,deviceId);
        } catch (Exception e) {
            LOGGER.error(e);
            return -1;
        }
    }
    @Override
    public List<TaskByDateDTO> queryTaskByDate(String deviceId) {
        try {
            return webLogTaskMapper.queryTaskByDate(deviceId);
        } catch (Exception e) {
            LOGGER.error(e);
            return Collections.emptyList();
        }
    }
}
