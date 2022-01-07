package com.meituan.logan.web.mapper;

import com.fasterxml.jackson.databind.ser.std.StdKeySerializers;
import com.meituan.logan.web.dto.WebLogTaskDTO;
import com.meituan.logan.web.dto.TaskIndexDTO;
import com.meituan.logan.web.dto.TaskByDateDTO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface WebLogTaskMapper {

    void insert(@Param("task") WebLogTaskDTO taskDTO);

    void updateContent(@Param("taskId") long taskId, @Param("content") String content);

    WebLogTaskDTO exist(@Param("logDate") long logDate, @Param("deviceId") String deviceId,
            @Param("pageNum") int pageNum);

    List<WebLogTaskDTO> search(@Param("beginTime") long beginTime, @Param("endTime") long endTime,
            @Param("deviceId") String deviceId);

    void deleteByAddTime(@Param("addTime") long addTime);

    List<WebLogTaskDTO> queryByIds(@Param("tasks") List<Long> taskIds);

    void updateStatus(@Param("taskId") long taskId, @Param("status") int status);

    long maxId();

    List<WebLogTaskDTO> queryByRange(@Param("minId") long minId, @Param("maxId")long maxId);

    List<TaskIndexDTO> query(@Param("limit") int limit, @Param("offset")int offset,@Param("deviceName")String deviceName,@Param("deviceId")String deviceId);
    long total(@Param("deviceName")String deviceName,@Param("deviceId")String deviceId);

    List<TaskByDateDTO> queryTaskByDate(@Param("deviceId")String deviceId);
}
