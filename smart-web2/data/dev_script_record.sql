#-------清表
DELETE FROM tg_study_classroom;
DELETE FROM tg_study_school;
DELETE FROM tg_study_student;
DELETE FROM tg_study_teacher;
DELETE FROM tg_study_course;
DELETE FROM tg_study_student_course_rel;



#
SELECT t.id, t.student_name, t.class_name, t.teacher_name, t.status, t.create_time
FROM tg_study_student_class_rel t
ORDER BY t.create_time ASC;

#
SELECT t.id, t.course_week_info, t.course_time, t.student_name,t.class_name, t.classroom_name, t.teacher_name, t.status, t.create_time
            FROM tg_study_student_course_rel t
            ORDER BY t.create_time ASC;

            SELECT t.id, t.name, IF(t.sex = 1, "男生", "女生"), t.birthday, t.school_name, t.parent_name, t.parent_phone,
            t.level,
            CASE t.status WHEN "NORMAL" THEN '正常'
            WHEN "DROP_OUT" THEN '退学'
            WHEN "TEMP_LEAVE" THEN "休学"
            ELSE '未定义' END ,
            t.remain_course, t.create_time
            from tg_study_student t
            order by t.create_time asc;
            
select t.id, t.course_date, t.course_time, t.class_name, t.classroom_name,
            t.teacher_name, sr.student_name,
            CASE sr.status WHEN "NORMAL" THEN '正常'
            ELSE '未定义' END ,
            sr.description, sr.update_time
            from tg_study_course_record t, tg_study_course_student_record sr
            where t.id = sr.course_rec_id
            order by t.create_time asc;

  select t.id, t.name, t.week_info, t.course_time, t.classroom_name,
            CASE t.status WHEN "NORMAL" THEN '正常' ELSE '未定义' END,
            t.create_time, t.description
            from tg_study_course t 
            #where t.teacher_id = 
            order by t.create_time asc;
            
            select t.id, t.name, t.level, t.remain_course, date_format(t.create_time, '%Y-%c-%d')
            from tg_study_student t
            where t.status = 'NORMAL'
            order by t.create_time asc;
            
            
select DISTINCT T.week_info
            from tg_study_course t
            where t.teacher_id = 'U154234886659443576'
            order by t.create_time asc;

select t.id, t.course_date, t.course_time, t.class_name, t.classroom_name,
            t.teacher_name, t.student_quantity_plan, t.student_quantity_actual, t.student_personal_leave,
            t.student_other_absent,
            t.status, t.create_time, t.description
            from tg_study_course_record t
            order by t.create_time asc;


select t.id, t.course_date, t.course_time, t.course_name, t.teacher_name,
            CASE t.status WHEN "NORMAL" THEN '正常'
            ELSE '未定义' END
            from tg_study_course_record t
            #[where t.teacher_id =: teacherId]
            order by t.course_date asc




















































          
