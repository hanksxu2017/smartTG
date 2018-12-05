package cn.com.smart.web.service;

import cn.com.smart.constant.enumEntity.SystemMessageEnum;
import cn.com.smart.service.impl.MgrServiceImpl;
import cn.com.smart.web.bean.entity.TGStudyClassroom;
import cn.com.smart.web.bean.entity.TGStudySystemMessage;
import cn.com.smart.web.dao.impl.StudyClassroomDao;
import cn.com.smart.web.dao.impl.StudySystemMessageDao;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 版本服务类
 * @author XUWENYI <br />
 * 2018年11月15日
 * @version 1.0
 * @since 1.0
 */
@Service
public class StudySystemMessageService extends MgrServiceImpl<TGStudySystemMessage> {

	@Override
	public StudySystemMessageDao getDao() {
		return (StudySystemMessageDao)super.getDao();
	}

	public void broadSystemMessage(SystemMessageEnum systemMessageEnum, String content, String studentId) {
		TGStudySystemMessage systemMessage = new TGStudySystemMessage();
		systemMessage.setMessageType(systemMessageEnum.name());
		systemMessage.setMessageContent(content);
		systemMessage.setLevel(systemMessageEnum.getLevel());
		systemMessage.setCreateTime(new Date());
		systemMessage.setStudentId(studentId);
		this.save(systemMessage);
	}

	public void processSystemMessageBySystem(SystemMessageEnum systemMessageEnum, String studentId) {

        Map<String, Object> params = new HashMap<>();
        params.put("studentId", studentId);
        params.put("messageType", systemMessageEnum.name());
        params.put("isProcess", IS_PROCESS_NO);
        List<TGStudySystemMessage> systemMessageList = this.findByParam(params).getDatas();
        if(CollectionUtils.isNotEmpty(systemMessageList)) {
            for(TGStudySystemMessage systemMessage : systemMessageList) {
                systemMessage.setIsProcess(IS_PROCESS_YES);
                systemMessage.setProcessDesc("processed by system.");
                systemMessage.setProcessTime(new Date());
            }
            this.update(systemMessageList);
        }

	}

}
