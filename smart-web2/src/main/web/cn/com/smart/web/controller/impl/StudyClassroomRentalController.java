package cn.com.smart.web.controller.impl;

import cn.com.smart.bean.SmartResponse;
import cn.com.smart.constant.IConstant;
import cn.com.smart.web.bean.RequestPage;
import cn.com.smart.web.bean.entity.*;
import cn.com.smart.web.bean.search.ClassroomSearch;
import cn.com.smart.web.controller.base.BaseController;
import cn.com.smart.web.service.*;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.*;

@Controller
@RequestMapping("/studyClassroom/rental")
public class StudyClassroomRentalController extends BaseController {

    @Autowired
    private OPService opService;

    @Autowired
    private StudyClassroomService classroomService;

    @Autowired
    private StudyClassroomRentalService classroomRentalService;

    public StudyClassroomRentalController() {
        super.setSubDir("/studyClassroom/rental/");
    }

    /**
     * @param searchParam
     * @param page
     * @return
     */
    @RequestMapping("/list")
    public ModelAndView list(ClassroomSearch searchParam, RequestPage page) {
        SmartResponse<Object> smartResp = opService.getDatas("classroom_rental_list", searchParam, page.getStartNum(), page.getPageSize());
        return this.packListModelView(searchParam, smartResp);
    }

	@Autowired
	private DictService dictService;

    /**
     *
     * @return
     */
    @RequestMapping(value = "/add")
    public ModelAndView add() {
        ModelAndView modelView = new ModelAndView();

        modelView.getModelMap().put("classrooms", classroomService.findNormal().getDatas());

	    modelView.getModelMap().put("weekInfoList", dictService.getItems("WEEK_INFO_LIST").getDatas());

        modelView.setViewName(getPageDir() + "add");
        return modelView;
    }

    @Autowired
    private StudyCourseService courseService;

    @RequestMapping(value = "/getIdleCourseTime", method = RequestMethod.GET)
    @ResponseBody
    public SmartResponse<TNDict> getIdleCourseTime(String classroomId, String weekInfo) {

        List<TNDict> dictList = dictService.getItems("COURSE_TIMES").getDatas();
        List<TNDict> idleList = new ArrayList<>();

        Map<String, Object> params;
        List<TGStudyCourse> courseList;

        if(CollectionUtils.isNotEmpty(dictList)) {
            for(TNDict tnDict : dictList) {
                params = new HashMap<>();
                params.put("classroomId", classroomId);
                params.put("weekInfo", Short.valueOf(weekInfo));
                params.put("courseTimeIndex", Short.valueOf(tnDict.getBusiValue()));
	            courseList = this.courseService.findByParam(params).getDatas();
                if(CollectionUtils.isEmpty(courseList)) {
                    idleList.add(tnDict);
                }
            }
        }

        SmartResponse<TNDict> smartResponse = new SmartResponse<>();
        smartResponse.setResult(IConstant.OP_SUCCESS);
        smartResponse.setMsg(IConstant.OP_SUCCESS_MSG);
        smartResponse.setDatas(idleList);
	    return smartResponse;
    }

	/**
	 * 提交新增
	 *
	 * @return
	 */
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	@ResponseBody
	public SmartResponse<String> save(TGStudyClassroomRental classroomRental) {
		classroomRental.setCreateTime(new Date());
		classroomRental.setName("[租]" + classroomRental.getTenantName());
		return classroomRentalService.save(classroomRental);
	}

	/**
	 *
	 * @return
	 */
	@RequestMapping(value = "/edit")
	public ModelAndView edit(String id) {
		ModelAndView modelView = new ModelAndView();

		modelView.getModelMap().put("classroomRental", this.classroomRentalService.find(id).getData());

		modelView.getModelMap().put("classrooms", classroomService.findNormal().getDatas());

		modelView.getModelMap().put("weekInfoList", dictService.getItems("WEEK_INFO_LIST").getDatas());

		modelView.setViewName(getPageDir() + "edit");
		return modelView;
	}

	@RequestMapping(value = "/subEdit", method = RequestMethod.POST)
	@ResponseBody
	public SmartResponse<String> subEdit(TGStudyClassroomRental classroomRental) {
		TGStudyClassroomRental classroomRentalDb = this.classroomRentalService.find(classroomRental.getId()).getData();
		// 修改配置信息

		classroomRentalDb.setUpdateTime(new Date());
		classroomRentalDb.setName("[租]" + classroomRental.getTenantName());
		return classroomRentalService.update(classroomRentalDb);
	}

}
