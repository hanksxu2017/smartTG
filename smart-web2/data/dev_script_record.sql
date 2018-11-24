#-------清表
DELETE FROM tg_study_classroom;
DELETE FROM tg_study_school;
DELETE FROM tg_study_student;
DELETE FROM tg_study_teacher;

DELETE FROM tg_study_course;
DELETE FROM tg_study_course_record;
DELETE FROM tg_study_course_student_record;
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

  SELECT t.id, t.name, t.level, t.remain_course, t.create_time, record.status
            FROM tg_study_student t, tg_study_course_student_record record 
            WHERE t.id = record.student_id
            #and record.course_rec_id = :courseRecordId
            #[and t.name like '%:studentName%']
            ORDER BY t.remain_course


            SELECT t.id, t.message_type, t.message_content, t.level, t.is_process,
            t.create_time, t.process_time, t.process_desc
            FROM tg_study_system_message t
            ORDER BY t.level DESC, t.create_time DESC


            SELECT t.id,
            CASE t.message_type WHEN 'STUDENT_ABSENT_NOTE' THEN '连续缺课提醒'
            WHEN 'STUDENT_REMAIN_COURSE_NOTE' THEN '续费提醒'
            WHEN 'COURSE_UN_SIGNED_NOTE' THEN '课时未结课提醒'
            ELSE '未定义' END,
            t.message_content,
            CASE t.is_process WHEN 'NO' THEN '未处理'
            WHEN 'YES' THEN '已处理'
            ELSE '未定义' END,
            t.create_time, t.process_time, t.process_desc
            FROM tg_study_system_message t
            ORDER BY t.level DESC, t.create_time DESC;

SELECT * FROM t_user WHERE YEARWEEK(DATE_FORMAT(addedTime,'%Y-%m-%d')) = YEARWEEK(NOW());    


SELECT * FROM t_n_dict;






































          
