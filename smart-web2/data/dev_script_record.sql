#-------清表
DELETE FROM tg_study_class;
DELETE FROM tg_study_classroom;
DELETE FROM tg_study_course;
DELETE FROM tg_study_school;
DELETE FROM tg_study_student;
DELETE FROM tg_study_student_class_rel;
DELETE FROM tg_study_student_course_rel;
DELETE FROM tg_study_teacher;


#
SELECT t.id, t.student_name, t.class_name, t.teacher_name, t.status, t.create_time
FROM tg_study_student_class_rel t
ORDER BY t.create_time ASC;




