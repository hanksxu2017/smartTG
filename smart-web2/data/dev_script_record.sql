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
            FROM tg_study_student t
            ORDER BY t.create_time ASC;
            
SELECT t.id, t.course_date, t.course_time, t.class_name, t.classroom_name,
            t.teacher_name, sr.student_name,
            CASE sr.status WHEN "NORMAL" THEN '正常'
            ELSE '未定义' END ,
            sr.description, sr.update_time
            FROM tg_study_course_record t, tg_study_course_student_record sr
            WHERE t.id = sr.course_rec_id
            ORDER BY t.create_time ASC;

  SELECT t.id, t.name, t.week_info, t.course_time, t.classroom_name,
            CASE t.status WHEN "NORMAL" THEN '正常' ELSE '未定义' END,
            t.create_time, t.description
            FROM tg_study_course t 
            #where t.teacher_id = 
            ORDER BY t.create_time ASC;
            
            SELECT t.id, t.name, t.level, t.remain_course, DATE_FORMAT(t.create_time, '%Y-%c-%d')
            FROM tg_study_student t
            WHERE t.status = 'NORMAL'
            ORDER BY t.create_time ASC;
            
            
SELECT DISTINCT T.week_info
            FROM tg_study_course t
            WHERE t.teacher_id = 'U154234886659443576'
            ORDER BY t.create_time ASC;

SELECT t.id, t.course_date, t.course_time, t.class_name, t.classroom_name,
            t.teacher_name, t.student_quantity_plan, t.student_quantity_actual, t.student_personal_leave,
            t.student_other_absent,
            t.status, t.create_time, t.description
            FROM tg_study_course_record t
            ORDER BY t.create_time ASC;


SELECT t.id, t.course_date, t.course_time, t.course_name, t.teacher_name,
            CASE t.status WHEN "NORMAL" THEN '正常'
            ELSE '未定义' END
            FROM tg_study_course_record t
            #[where t.teacher_id =: teacherId]
            ORDER BY t.course_date ASC


SELECT t.id, t.name,
            CASE t.week_info WHEN "7" THEN '星期天'
            ELSE CONCAT('星期', t.week_info) END,
            t.course_time, t.classroom_name, t.teacher_name,
            CASE rel.status WHEN "NORMAL" THEN '正常'
            WHEN 'EXIT_COURSE' THEN '已退班'
            ELSE '未定义' END,
            t.create_time, t.description
            FROM tg_study_course t, tg_study_student_course_rel rel
            WHERE rel.student_id ='U154234936651434629' 
            AND rel.course_id = t.id
            AND rel.status ='NORMAL'
            #[and rel.student_name like '%:studentName%']
            ORDER BY t.create_time ASC;


UPDATE tg_study_course_record rec SET rec.course_name = (SELECT c.name FROM tg_study_course c WHERE c.id = rec.course_id);


SELECT * FROM tg_study_course WHERE id = 'U154234929855961102';



SELECT * FROM tg_study_system_message;


SELECT temp.id, temp.name, temp.week_info, temp.status, (SELECT COUNT(rel.id) AS studentCount FROM tg_study_student_course_rel rel) , temp.create_time, temp.description FROM (
            SELECT t.id, t.name,
            CASE t.week_info WHEN '7' THEN '星期天'
            WHEN '1' THEN '星期一'
            WHEN '2' THEN '星期二'
            WHEN '3' THEN '星期三'
            WHEN '4' THEN '星期四'
            WHEN '5' THEN '星期五'
            WHEN '6' THEN '星期六'
            ELSE '未设置' END AS week_info,
            t.course_time, t.classroom_name,
            CASE t.status WHEN "NORMAL" THEN '正常'
            ELSE '未定义' END AS STATUS,
            t.create_time,
            t.description
            FROM tg_study_course t
            WHERE t.teacher_id ='U154234886659443576' ) temp
            ORDER BY temp.create_time ASC;

SELECT * FROM tg_study_student_course_rel WHERE course_id = 'U154260888617713400';






































          
