package cn.com.smart.web.controller.impl;

import cn.com.smart.bean.SmartResponse;
import cn.com.smart.constant.IConstant;
import cn.com.smart.web.bean.RequestPage;
import cn.com.smart.web.bean.entity.TGStudyCourse;
import cn.com.smart.web.bean.search.ClassSearch;
import cn.com.smart.web.constant.enums.BtnPropType;
import cn.com.smart.web.controller.base.BaseController;
import cn.com.smart.web.service.*;
import cn.com.smart.web.tag.bean.CustomBtn;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/studyCourse/record")
public class StudyCourseRecordController extends BaseController {

    @Autowired
    private OPService opService;

    public StudyCourseRecordController() {
        super.setSubDir("/studyCourse/record");
    }

    /**
     * @param searchParam
     * @param page
     * @return
     */
    @RequestMapping("/list")
    public ModelAndView list(ClassSearch searchParam, RequestPage page) {
        SmartResponse<Object> smartResp = opService.getDatas("select_study_course_list", searchParam, page.getStartNum(), page.getPageSize());
        ModelAndView modelAndView = this.packListModelView(searchParam, smartResp);

        // 增加自定义按钮
        this.addChooseUnitBtn(modelAndView.getModelMap());
        return modelAndView;
    }

    /**
     * 增加报班按钮
     * @param modelMap
     */
    private void addChooseUnitBtn(Map<String, Object> modelMap) {
        CustomBtn customBtn = new CustomBtn("chooseUnit", "生成课程记录", "生成课程记录", null,"glyphicon-list-alt", BtnPropType.SelectType.NONE.getValue());
        customBtn.setWidth("500");
        customBtns = new ArrayList<>(1);
        customBtns.add(customBtn);
        modelMap.put("customBtns", customBtns);
    }


}
