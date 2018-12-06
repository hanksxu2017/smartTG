package cn.com.smart.web.controller.impl;

import cn.com.smart.bean.SmartResponse;
import cn.com.smart.constant.IConstant;
import cn.com.smart.constant.enumEntity.ClassroomRentalStatusEnum;
import cn.com.smart.web.bean.RequestPage;
import cn.com.smart.web.bean.entity.*;
import cn.com.smart.web.bean.search.ClassroomSearch;
import cn.com.smart.web.controller.base.BaseController;
import cn.com.smart.web.service.*;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.util.StringUtil;
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

        if(CollectionUtils.isNotEmpty(dictList)) {
            for(TNDict tnDict : dictList) {
                if(this.isIdleForNewCourse(classroomId,
                        Short.valueOf(weekInfo), Short.valueOf(tnDict.getBusiValue()), null)) {
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

    private boolean isIdleForNewCourse(String classroomId, short weekInfo, short courseTimeIndex, String excludeId) {
        Map<String, Object> params = new HashMap<>();
        params.put("classroomId", classroomId);
        params.put("weekInfo", Short.valueOf(weekInfo));
        params.put("courseTimeIndex", courseTimeIndex);
        List<TGStudyCourse> courseList = this.courseService.findByParam(params).getDatas();
        if(CollectionUtils.isNotEmpty(courseList)) {
            return false;
        }

        List<TGStudyClassroomRental> classroomRentalList = this.classroomRentalService.findByParam(params).getDatas();
        if(CollectionUtils.isEmpty(classroomRentalList)) {
            return true;
        }

        if(StringUtils.isNotBlank(excludeId) && classroomRentalList.size() == 1 &&
                StringUtils.equals(classroomRentalList.get(0).getId(), excludeId)) {
            return true;
        }

        return false;
    }

	/**
	 * 提交新增
	 *
	 * @return
	 */
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	@ResponseBody
	public SmartResponse<String> save(TGStudyClassroomRental classroomRental) {
        SmartResponse<String> smartResponse = new SmartResponse<>();
	    if(null == classroomRental || StringUtils.isBlank(classroomRental.getClassroomId())) {
            smartResponse.setMsg("请求无效");
            return smartResponse;
        }

        if(!this.isIdleForNewCourse(classroomRental.getClassroomId(), classroomRental.getWeekInfo(),
                classroomRental.getCourseTimeIndex(), null)) {
            smartResponse.setMsg("课时冲突,无法进行租赁");
            return smartResponse;
        }

		classroomRental.setCreateTime(new Date());
		classroomRental.setName("[租]" + classroomRental.getTenantName());
        smartResponse = classroomRentalService.save(classroomRental);
        return smartResponse;
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
        SmartResponse<String> smartResponse = new SmartResponse<>();
	    if(null == classroomRental || StringUtils.isBlank(classroomRental.getId()) ||
                StringUtils.isBlank(classroomRental.getClassroomId())) {
            smartResponse.setMsg("请求无效");
            return smartResponse;
        }

        if(!this.isIdleForNewCourse(classroomRental.getClassroomId(), classroomRental.getWeekInfo(),
                classroomRental.getCourseTimeIndex(), classroomRental.getId())) {
            smartResponse.setMsg("课时冲突,无法进行租赁修改");
            return smartResponse;
        }

		TGStudyClassroomRental classroomRentalDb = this.classroomRentalService.find(classroomRental.getId()).getData();
	    if(null != classroomRentalDb) {
            this.copyClassroomRental(classroomRentalDb, classroomRental);
            classroomRentalDb.setUpdateTime(new Date());
            smartResponse = classroomRentalService.update(classroomRentalDb);
        }

        return smartResponse;
	}

    /**
     * 信息拷贝
     * @param classroomRentalDb 数据库中的租赁信息
     * @param classroomRental   页面提交的租赁信息
     */
	private void copyClassroomRental(TGStudyClassroomRental classroomRentalDb, TGStudyClassroomRental classroomRental) {
        // 修改配置信息
        classroomRentalDb.setTenantName(classroomRental.getTenantName());
        classroomRentalDb.setTenantPhone(classroomRental.getTenantPhone());

        classroomRentalDb.setClassroomId(classroomRental.getClassroomId());
        classroomRentalDb.setClassroomName(classroomRental.getClassroomName());

        classroomRentalDb.setWeekInfo(classroomRental.getWeekInfo());

        classroomRentalDb.setCourseTimeIndex(classroomRental.getCourseTimeIndex());
        classroomRentalDb.setCourseTime(classroomRental.getCourseTime());

        classroomRentalDb.setEndDate(classroomRental.getEndDate());
        classroomRentalDb.setDescription(classroomRental.getDescription());

        classroomRentalDb.setUpdateTime(new Date());
        classroomRentalDb.setName("[租]" + classroomRental.getTenantName());
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public SmartResponse<String> delete(String id) {
        SmartResponse<String> smartResponse = new SmartResponse<>();
        TGStudyClassroomRental classroomRentalDb = this.classroomRentalService.find(id).getData();
        if(null != classroomRentalDb &&
                !StringUtils.equals(IConstant.STATUS_DELETE, classroomRentalDb.getStatus())) {
            classroomRentalDb.setStatus(ClassroomRentalStatusEnum.CANCEL.name());
            classroomRentalDb.setUpdateTime(new Date());
            smartResponse = classroomRentalService.update(classroomRentalDb);
        }

        return smartResponse;
    }

}
