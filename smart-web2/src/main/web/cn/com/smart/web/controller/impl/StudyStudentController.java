package cn.com.smart.web.controller.impl;

import cn.com.smart.bean.SmartResponse;
import cn.com.smart.web.bean.RequestPage;
import cn.com.smart.web.bean.entity.TGStudyCourse;
import cn.com.smart.web.bean.entity.TGStudyStudent;
import cn.com.smart.web.bean.entity.TGStudyStudentClassRel;
import cn.com.smart.web.bean.entity.TGStudyStudentCourseRel;
import cn.com.smart.web.bean.search.StudentSearch;
import cn.com.smart.web.constant.IActionConstant;
import cn.com.smart.web.constant.enums.BtnPropType;
import cn.com.smart.web.controller.base.BaseController;
import cn.com.smart.web.service.*;
import cn.com.smart.web.tag.bean.CustomBtn;
import com.mixsmart.utils.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.*;

@Controller
@RequestMapping("/studyStudent")
public class StudyStudentController extends BaseController {

    @Autowired
    private OPService opService;
    @Autowired
    private StudyStudentService studyStudentService;
    @Autowired
    private StudyClassService studyClassService;
    @Autowired
    private StudyStudentClassRelService studentClassRelService;

    public StudyStudentController() {
        super.setSubDir("/studyStudent/");
    }

    /**
     * @param searchParam
     * @param page
     * @return
     */
    @RequestMapping("/list")
    public ModelAndView list(StudentSearch searchParam, RequestPage page) {
        SmartResponse<Object> smartResp = opService.getDatas("select_study_student_list", searchParam, page.getStartNum(), page.getPageSize());
        ModelAndView modelAndView = this.packListModelView(searchParam, smartResp);

        // 增加自定义按钮
        this.addChooseClassBtn(modelAndView.getModelMap());
        return modelAndView;
    }

    /**
     * 增加报班按钮
     * @param modelMap
     */
    private void addChooseClassBtn(Map<String, Object> modelMap) {
        CustomBtn customBtn = new CustomBtn("chooseClass", "报班", "报班", this.getSubDir() + "chooseClass","glyphicon-list-alt", BtnPropType.SelectType.ONE.getValue());
        customBtn.setWidth("500");
        customBtns = new ArrayList<>(1);
        customBtns.add(customBtn);
        modelMap.put("customBtns", customBtns);
    }



    /**
     *
     * @return
     */
    @RequestMapping(value = "/add")
    public ModelAndView add() {
        ModelAndView modelView = new ModelAndView();
        modelView.setViewName(getURI() + "add");
        return modelView;
    }

    /**
     * 提交新增
     *
     * @return
     */
    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ResponseBody
    public SmartResponse<String> save(TGStudyStudent studyStudent) {
        studyStudent.setCreateTime(new Date());

        short parentType = studyStudent.getParentType();
        if(1 == parentType) {
            studyStudent.setParentName(studyStudent.getParentName() + "(父亲)");
        } else if(2 == parentType) {
            studyStudent.setParentName(studyStudent.getParentName() + "(母亲)");
        }

        studyStudent.setRemainCourse(studyStudent.getTotalCourse());

        SmartResponse<String> smartResp = studyStudentService.save(studyStudent);
        return smartResp;
    }

    @RequestMapping(value = "/edit")
    public ModelAndView update(String id) {
        ModelAndView modelView = new ModelAndView();
        if(StringUtils.isNotBlank(id)) {
            TGStudyStudent studyStudent = studyStudentService.find(id).getData();
            if(null != studyStudent) {
                modelView.getModelMap().put("objBean", studyStudent);
            }
        }
        modelView.setViewName(getURI() + "edit");
        return modelView;
    }

    /**
     * 提交编辑
     *
     * @param studyStudent
     * @return
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public SmartResponse<String> update(TGStudyStudent studyStudent) {
        TGStudyStudent studyStudentDb = this.studyStudentService.find(studyStudent.getId()).getData();
        studyStudent.setCreateTime(studyStudentDb.getCreateTime());
        studyStudent.setUpdateTime(new Date());
        SmartResponse<String> smartResp = studyStudentService.update(studyStudent);
        return smartResp;
    }


    /**
     *
     * @return
     */
    @RequestMapping(value = "/chooseClass")
    public ModelAndView chooseClass(String id) {
        ModelAndView modelView = new ModelAndView();

        TGStudyStudent studyStudent = studyStudentService.find(id).getData();
        modelView.getModelMap().put("student", studyStudent);

        Map<String, Object> params = new HashMap<>();
        params.put("status", "NORMAL");
        modelView.getModelMap().put("classes", studyClassService.findByParam(params).getDatas());

        modelView.setViewName(getURI() + "chooseClass");
        return modelView;
    }

    /**
     *
     * @return
     */
    @RequestMapping(value = "/submitChooseClass")
    @ResponseBody
    public SmartResponse<String> submitChooseClass(TGStudyStudentClassRel studentClassRel) {
        studentClassRel.setCreateTime(new Date());
        SmartResponse<String> smartResponse = studentClassRelService.save(studentClassRel);
        if(smartResponse.isSuccess()) {
            // 创建学生-班级-课程
            this.createStudentCourseRel(studentClassRel);
        }

        return smartResponse;
    }

    @Autowired
    private StudyStudentCourseRelService studentCourseRelService;
    @Autowired
    private StudyCourseService courseService;

    private void createStudentCourseRel(TGStudyStudentClassRel studentClassRel) {


        Map<String, Object> params = new HashMap<>();
        params.put("classId", studentClassRel.getClassId());
        List<TGStudyCourse> courseList = this.courseService.findByParam(params).getDatas();
        if(CollectionUtils.isNotEmpty(courseList)) {
            TGStudyStudentCourseRel rel = null;
            for(TGStudyCourse course : courseList) {
                rel = initStudentCourseRel(course, studentClassRel);
                studentCourseRelService.save(rel);
            }

        }
    }

    /**
     * 初始化学生的课程关系
     * @param course
     * @param studentClassRel
     * @return
     */
    private TGStudyStudentCourseRel initStudentCourseRel(TGStudyCourse course, TGStudyStudentClassRel studentClassRel) {
        TGStudyStudentCourseRel rel = new TGStudyStudentCourseRel();

        rel.setCourseId(course.getId());
        rel.setCourseWeekInfo(course.getWeekInfo());
        rel.setCourseTime(course.getCourseTime());

        rel.setClassId(studentClassRel.getClassId());
        rel.setClassName(studentClassRel.getClassName());

        rel.setClassroomId(course.getClassroomId());
        rel.setClassroomName(course.getClassroomName());

        rel.setTeacherId(course.getTeacherId());
        rel.setTeacherName(course.getTeacherName());

        rel.setStudentId(studentClassRel.getStudentId());
        rel.setStudentName(studentClassRel.getStudentName());

        rel.setCreateTime(new Date());
        return rel;
    }

}
