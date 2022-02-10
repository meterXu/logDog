package com.meituan.logan.web.controller;
import com.meituan.logan.web.model.TableModel;
import com.meituan.logan.web.service.BatchInsertService;
import com.meituan.logan.web.dto.WebLogDetailDTO;
import com.meituan.logan.web.model.WebLogTaskModel;
import com.meituan.logan.web.model.WebLogSaveModel;
import com.meituan.logan.web.model.response.LoganResponse;
import com.meituan.logan.web.parser.WebLogParser;
import com.meituan.logan.web.service.WebTaskService;
import com.mysql.cj.util.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * 功能描述:  <p>负责接受H5端上报的日志</p>
 *
 * @version 1.0 2019-10-31
 * @since logan-web 1.0
 */
@CrossOrigin(origins = "*", maxAge = 3600)
@Controller
@RequestMapping("/logfv/web")
public class WebLogUploadController {

    @Resource
    private WebTaskService webTaskService;
    @Resource(name = "webLogDetailServiceImpl")
    private BatchInsertService<WebLogDetailDTO> batchInsertService;
    /**
     * 接收并存储H5端上报的日志
     *
     * @param taskModel H5上报
     * @return LoganResponse<Boolean>
     */
    @PostMapping("/upload")
    @ResponseBody
    public LoganResponse<Boolean> receiveWebLog(@RequestBody WebLogTaskModel taskModel) {
        if (taskModel == null || !taskModel.isValid()) {
            return LoganResponse.badParam("无效的参数");
        }
        taskModel.setContent(WebLogParser.parse(taskModel.getLogArray()));
        Long taskId = webTaskService.saveTask(taskModel);
        if (taskId==null) {
            return LoganResponse.exception("日志任务为空！");
        }else if(taskId==0){
            return LoganResponse.exception("日志任务Id为0！");
        }else{
            List<WebLogDetailDTO> detailDTOS = WebLogParser.parseWebLogDetail(
                    taskModel.getContent(), taskId);
            batchInsertService.saveLogDetails(detailDTOS);
            return LoganResponse.success(true);

        }
    }

    @PostMapping("/save")
    @ResponseBody
    public LoganResponse<Boolean> saveWebLog(@RequestBody WebLogSaveModel saveModel) {
        if (saveModel == null || !saveModel.isValid()) {
            return LoganResponse.badParam("无效的参数");
        }
        WebLogSaveModel transformSaveModel = saveModel.transformToDto();
        WebLogTaskModel taskModel = new WebLogTaskModel();
        taskModel.setDeviceId(transformSaveModel.getAppId());
        taskModel.setAppName(transformSaveModel.getAppName());
        taskModel.setLogPageNo(0);
        taskModel.setLogDate(transformSaveModel.getLogDate());
        taskModel.setContent(transformSaveModel.getContent());
        Long taskId = webTaskService.saveTask(taskModel);
        if (taskId==null) {
            return LoganResponse.exception("日志任务为空！");
        }else if(taskId==0){
            return LoganResponse.exception("日志任务Id为0！");
        }else{
            List<WebLogDetailDTO> detailDTOS = WebLogParser.parseWebLogDetail(
                    transformSaveModel.getContent(), taskId);
            batchInsertService.saveLogDetails(detailDTOS);
            return LoganResponse.success(true);

        }
    }
}
