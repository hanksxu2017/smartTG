/*
SQLyog Ultimate v12.08 (64 bit)
MySQL - 5.7.23-log : Database - smart_web_v2.0.0
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`smart_web_v2.0.0` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `smart_web_v2.0.0`;

/*Table structure for table `t_n_dict` */

DROP TABLE IF EXISTS `t_n_dict`;

CREATE TABLE `t_n_dict` (
  `id` varchar(32) NOT NULL,
  `busi_level` int(5) DEFAULT NULL,
  `busi_name` varchar(255) NOT NULL,
  `busi_value` varchar(255) NOT NULL,
  `parent_id` varchar(32) NOT NULL,
  `sort_order` int(5) DEFAULT NULL,
  `state` int(2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_n_dict` */

insert  into `t_n_dict`(`id`,`busi_level`,`busi_name`,`busi_value`,`parent_id`,`sort_order`,`state`) values ('D_4832651141870',1,'数据状态','DATA_STATE','0',46,1),('D_4841918379297',2,'有效','1','D_4832651141870',1,1),('D_4853866505824',2,'无效','0','D_4832651141870',47,1),('D_U154285367204894559',1,'授课时间','COURSE_TIMES','0',34,1),('D_U154285369346927236',2,'7:30-9:00','1','D_U154285367204894559',1,1),('D_U154285373665568607',2,'9:00-10:30','2','D_U154285367204894559',35,1),('D_U154285375273891463',2,'13:30-15:00','3','D_U154285367204894559',36,1),('D_U154285379350790577',2,'15:30-17:00','4','D_U154285367204894559',37,1),('D_U154285380737356991',2,'18:30-20:00','5','D_U154285367204894559',38,1),('D_U154285636538465892',1,'星期列表','WEEK_INFO_LIST','0',39,1),('D_U154285637786274337',2,'星期一','1','D_U154285636538465892',1,1),('D_U154285639065552152',2,'星期二','2','D_U154285636538465892',40,1),('D_U154285640354285094',2,'星期三','3','D_U154285636538465892',41,1),('D_U154285641632094598',2,'星期四','4','D_U154285636538465892',42,1),('D_U154285642590342963',2,'星期五','5','D_U154285636538465892',43,1),('D_U154285643697439432',2,'星期六','6','D_U154285636538465892',44,1),('D_U154285645487136281',2,'星期天','7','D_U154285636538465892',45,1);

/*Table structure for table `t_n_menu` */

DROP TABLE IF EXISTS `t_n_menu`;

CREATE TABLE `t_n_menu` (
  `id` varchar(32) NOT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `parent_id` varchar(32) NOT NULL,
  `resource_id` varchar(32) DEFAULT NULL,
  `sort_order` int(11) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_n_menu` */

insert  into `t_n_menu`(`id`,`icon`,`name`,`parent_id`,`resource_id`,`sort_order`,`state`) values ('M-UU142493393340566190','','系统管理','0','',10,1),('M-UU142493393345840632','','菜单管理','M-UU142502912450567699','UU142493393303513551',2,1),('M-UU142493393345982202','','资源管理','M-UU142502912450567699','UU142493393323156274',1,1),('M-UU142502856650696782','','数据字典管理','M-UU142502912450567699','UU142494155606818866',3,1),('M-UU142502912450567699','','基础信息管理','M-UU142493393340566190','',4,1),('M-UU142508562386146072','','角色管理','M-UU142508565901356613','UU142494261976460581',5,1),('M-UU142508565901356613','','系统权限管理','M-UU142493393340566190','',6,1),('M-UU142508575818005410','','操作权限管理','M-UU142502912450567699','UU142494269829079292',6,1),('M-UU142508577364831096','','用户管理','M-UU142502912450567699','UU142494266546995694',7,1),('M-UU142508579506696266','','权限管理','M-UU142508565901356613','UU142494288694979665',6,1),('M_875688083764','','统计管理','','',31,1),('M_U154225004073616144','','校务管理','','',20,1),('M_U154225007149324418','','校区管理','M_U154237158480128046','U154225067366985402',1,1),('M_U154226493530106359','','教师信息','M_U154237158480128046','U154226490927926250',21,1),('M_U154226856686813620','','教室信息','M_U154237158480128046','U154226854575116662',22,1),('M_U154227254133036595','','班级信息','M_U154237158480128046','U154227251858798941',24,1),('M_U154228787322754855','','学生信息','M_U154237158480128046','U154228785560711973',23,1),('M_U154233259511310918','','课程表管理','M_U154225004073616144','U154233255974582635',25,1),('M_U154237158480128046','','信息管理','','',28,1),('M_U154237249973265102','','课时管理','M_U154225004073616144','U154237151730283760',29,1),('M_U154272178887659993','','消息通知','M_U154225004073616144','U154272176054572296',30,1);

/*Table structure for table `t_n_op_auth` */

DROP TABLE IF EXISTS `t_n_op_auth`;

CREATE TABLE `t_n_op_auth` (
  `id` varchar(32) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `value` varchar(50) NOT NULL,
  `sort_order` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_4567cw4oed5ce96lbqjo3spyt` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_n_op_auth` */

insert  into `t_n_op_auth`(`id`,`create_time`,`name`,`value`,`sort_order`) values ('A-U143591450834502927','2015-07-03 17:08:28','审核','audit',1),('A-UU142534841115229345','2015-03-03 10:06:51','修改密码','changepwd',5),('A-UU142865511755998939','2015-04-10 16:38:38','修改','edit_designer',1),('A_U143936255049193524','2015-08-12 14:55:50','任意跳转','jump_task',1),('A_U147446697154526617','2016-09-21 22:09:32','流程表单编辑','flow_form_edit',6),('A_U150885497581940413','2017-10-24 22:22:56','导出','export',7),('A_U154234125919595129','2018-11-16 12:07:39','报班','chooseClass',8),('A_U154237155119607752','2018-11-16 20:32:31','生成课时','generateCourseRecord',9),('A_U154241990665741071','2018-11-17 09:58:27','查看学生列表','queryStudent',10),('A_U154242701412479483','2018-11-17 11:56:54','学生签到','studentSignIn',11),('A_U154278335218843096','2018-11-21 14:55:52','课时续费','increaseRemainCourse',12),('B-UU141804293977346637','2014-12-08 20:48:59','添加','add',1),('B-UU141804295101229675','2014-12-08 20:49:11','编辑','edit',2),('B-UU141804296218585442','2014-12-08 20:49:22','删除','del',3),('B-UU141804297299702298','2014-12-08 20:49:32','刷新','refresh',4);

/*Table structure for table `t_n_resource` */

DROP TABLE IF EXISTS `t_n_resource`;

CREATE TABLE `t_n_resource` (
  `id` varchar(32) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `op_auths` varchar(255) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_n_resource` */

insert  into `t_n_resource`(`id`,`create_time`,`name`,`uri`,`state`,`op_auths`,`type`) values ('U143386875037004503','2015-06-10 00:52:30','待办资源','process/todo',1,NULL,'other_resource'),('U143437621125952385','2015-06-15 21:50:11','流程实例管理','process/mgr/orderList',1,'jump_task,flow_form_edit,del,refresh,','other_resource'),('U143437623207722734','2015-06-15 21:50:32','流程历史实例管理','process/mgr/histOrderList',1,'flow_form_edit,del,refresh,','other_resource'),('U143437634716263470','2015-06-15 21:52:27','流程实例管理页面','showPage/flow_process_mgr_list',1,NULL,'other_resource'),('U143617398234893404','2015-07-06 17:13:02','表单对应的数据库表管理','form/table/list',1,'add,edit,del,refresh,','other_resource'),('U143891863167559700','2015-08-07 11:37:12','已办','process/hasTodo',1,NULL,'other_resource'),('U146772885528409688','2016-07-05 22:27:35','测试流程1','process/form?processName=test_01',1,NULL,'flow_resource'),('U147417439880357008','2016-09-18 12:53:19','测试jquery方法','test/jqueryMethod',1,NULL,'other_resource'),('U147522762933583369','2016-09-30 17:27:09','测试表单1','test/inputSelect',1,NULL,'other_resource'),('U147563795975505594','2016-10-05 11:26:00','版本管理','version/list',1,'add,edit,del,refresh,','other_resource'),('U147686532906967243','2016-10-19 16:22:09','表单帮助信息管理列表','form/helper/list',1,'add,edit,del,refresh,','other_resource'),('U148248001874056364','2016-12-23 16:00:19','子系统管理列表','subSystem/list',1,'edit_designer,add,edit,del,refresh,','other_resource'),('U148765647626620413','2017-02-21 13:54:36','测试自定义列列表','test/cellList',1,'changepwd,edit_designer,add,edit,refresh,','other_resource'),('U148774376819175947','2017-02-22 14:09:28','测试异步列表树','test/tableAsyncTree',1,'add,edit,del,refresh,','other_resource'),('U149542927908493158','2017-05-22 13:01:19','请假判断测试1','process/form?processName=leave_ judge_test',1,NULL,'flow_resource'),('U150107939436631363','2017-07-26 22:29:54','表单资源管理','form/resource/list',1,'add,edit,del,refresh,','other_resource'),('U150108134134573562','2017-07-26 23:02:21','测试普通表单','form/instance/create?formId=U150108080025383738',1,NULL,'form_resource'),('U150419023701932892','2017-08-31 22:37:17','表单实例管理','form/instance/list',1,'edit,del,refresh,','other_resource'),('U150505741534899631','2017-09-10 23:30:15','简单报表设计','report/designer',1,NULL,'other_resource'),('U150523150955702051','2017-09-12 23:51:50','表单测试2','form/instance/create?formId=U150523148906512260',1,NULL,'form_resource'),('U150609785810770279','2017-09-23 00:30:58','报表管理列表','report/list',1,'edit_designer,del,refresh,','other_resource'),('U150773698819847933','2017-10-11 23:49:48','报表资源管理','report/resource/list',1,'add,edit,del,refresh,','other_resource'),('U150773721860798909','2017-10-11 23:53:39','测试报表1','report/instance/list?reportId=R_U150600830877642873',1,'export,','report_resource'),('U150894686421341181','2017-10-25 23:54:24','SQL资源管理列表','sql/resource/list',1,'add,edit,del,refresh,','other_resource'),('U154225067366985402','2018-11-15 10:57:54','校区信息','studySchool/list',1,'edit_designer,add,edit,','other_resource'),('U154226490927926250','2018-11-15 14:55:09','教师','studyTeacher/list',1,'add,edit,del,refresh,','other_resource'),('U154226854575116662','2018-11-15 15:55:46','教室信息','studyClassroom/list',1,'add,edit,del,refresh,','other_resource'),('U154227251858798941','2018-11-15 17:01:59','班级信息','studyCourse/index',1,NULL,'other_resource'),('U154228785560711973','2018-11-15 21:17:35','学生信息','studyStudent/list',1,'increaseRemainCourse,add,edit,del,refresh,','other_resource'),('U154233255974582635','2018-11-16 09:42:40','课程表','studyCourse/list',1,'add,edit,del,refresh,','other_resource'),('U154234951077617402','2018-11-16 14:25:11','学生分班信息','studyStudent/class/list',1,'refresh,','other_resource'),('U154235825869638603','2018-11-16 16:50:59','学生课时信息','studyStudent/course/list',1,'del,refresh,','other_resource'),('U154237151730283760','2018-11-16 20:31:57','课时记录','studyCourse/record/index',1,NULL,'other_resource'),('U154242430730400390','2018-11-17 11:11:47','每日课时_学生','studyCourse/studentRecord/list',1,'studentSignIn,edit,refresh,','other_resource'),('U154272176054572296','2018-11-20 21:49:20','系统提醒','studySystemMessage/list',1,'edit,refresh,','other_resource'),('UU142493393303513551','2015-02-27 15:35:45','菜单管理','menu/list',1,'add,edit,del,refresh,',NULL),('UU142493393323156274','2015-02-26 14:58:53','资源管理','resource/list',1,'add,edit,del,refresh,','other_resource'),('UU142494155606818866','2015-02-26 17:05:56','数据字典管理','dict/list',1,'add,edit,del,refresh,',NULL),('UU142494261976460581','2015-02-26 17:23:39','角色管理','role/list',1,'add,edit,del,refresh,',NULL),('UU142494266546995694','2015-02-26 17:24:25','用户管理','user/list',1,'changepwd,add,edit,del,refresh,','other_resource'),('UU142494269829079292','2015-02-26 17:24:58','操作权限管理','opauth/list',1,'add,edit,del,refresh,',NULL),('UU142494281162643857','2015-02-26 17:26:51','组织机构管理','org/list',1,'add,edit,del,refresh,',NULL),('UU142494285272420160','2015-02-26 17:27:32','职位管理','showPage/base_position_org',1,NULL,'other_resource'),('UU142494288694979665','2015-02-26 17:28:06','权限管理','auth/index',1,NULL,NULL),('UU142494292374313391','2015-02-26 17:28:43','个人设置管理','user/setting/list',1,'add,edit,del,refresh,',NULL),('UU142508630396009472','2015-02-28 09:18:23','表单测试页面','test/test',1,NULL,NULL),('UU142536339652188513','2015-03-03 14:16:36','角色下的用户列表','role/userlist',1,'add,del,refresh,',NULL),('UU142536367109082749','2015-03-03 14:21:11','角色下的组织机构列表','role/orglist',1,'add,del,refresh,',NULL),('UU142536370298266280','2015-03-03 14:21:42','角色下的岗位列表','role/positionlist',1,'add,del,refresh,',NULL),('UU142536376280597829','2015-03-03 14:22:42','组织机构拥有的角色列表','org/rolelist',1,'add,del,refresh,',NULL),('UU142536417802440972','2015-03-03 14:29:38','岗位拥有的角色列表','position/rolelist',1,'add,del,refresh,',NULL),('UU142536421178574716','2015-03-03 14:30:11','用户拥有的角色列表','user/rolelist',1,'add,del,refresh,',NULL),('UU142536483130282094','2015-03-03 14:40:31','职位管理列表','position/list',1,'add,edit,del,refresh,','other_resource'),('UU142536804561674717','2015-03-03 15:34:05','测试权限按钮页面','test/auth',1,'add,edit,del,refresh,changepwd,',NULL),('UU142537018725515068','2015-03-03 16:09:47','jqGrid插件测试','test/jqGrid',1,'add,edit,del,refresh,',NULL),('UU142623880634351320','2015-03-13 17:26:46','小窗口管理','minwin/list',1,'add,edit,del,refresh,',NULL),('UU142648904341707233','2015-03-16 14:57:23','上传文件测试','test/upload',1,NULL,NULL),('UU142674912100115069','2015-03-19 15:12:01','流程设计器','flow/designer',1,NULL,NULL),('UU142725947101781158','2015-03-25 12:57:51','流程页面模版','flow/page/model/list',1,'add,edit,del,refresh,',NULL),('UU142726304175200513','2015-03-25 13:57:21','表单设计','form/designer',1,NULL,NULL),('UU142865507367695503','2015-04-10 16:37:54','流程列表','flow/list',1,'del,refresh,edit_designer,','other_resource'),('UU142891052568659983','2015-04-13 15:35:26','流程菜单资源','flow/resource/list',1,'add,edit,del,refresh,','other_resource'),('UU143065539369030702','2015-05-03 20:16:34','表单列表','form/list',1,'null,null,del,refresh,null,edit_designer,','other_resource');

/*Table structure for table `t_n_role` */

DROP TABLE IF EXISTS `t_n_role`;

CREATE TABLE `t_n_role` (
  `id` varchar(32) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `descr` varchar(255) DEFAULT NULL,
  `name` varchar(127) DEFAULT NULL,
  `flag` varchar(127) DEFAULT NULL,
  `user_id` varchar(32) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_n_role` */

insert  into `t_n_role`(`id`,`create_time`,`descr`,`name`,`flag`,`user_id`,`state`) values ('R-UU141994583098704113','2014-12-30 21:23:50','普通管理员角色','普通管理员',NULL,'U141770099155103287',1),('R-UU142509589602782910','2015-02-28 11:58:16','测试','教师',NULL,'U141770099155103287',1),('R141770099156750308','2014-12-04 21:49:51','系统超级管理员角色','超级管理员角色','super_admin','U141770099155103287',1);

/*Table structure for table `t_n_role_menu` */

DROP TABLE IF EXISTS `t_n_role_menu`;

CREATE TABLE `t_n_role_menu` (
  `id` varchar(32) NOT NULL,
  `menu_id` varchar(32) NOT NULL,
  `role_id` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_n_role_menu` */

insert  into `t_n_role_menu`(`id`,`menu_id`,`role_id`) values ('RM-4357413049265','M-UU142508575818005410','R141770099156750308'),('RM-5242748943457','M-UU142493393345982202','R141770099156750308'),('RM-875741764767','M_875688083764','R141770099156750308'),('RM-U154242006298225293','M-UU142508577364831096','R141770099156750308'),('RM-U154242006298267260','M_U154237158480128046','R141770099156750308'),('RM-U154242006298274608','M-UU142508565901356613','R141770099156750308'),('RM-U154242006298284205','M_U154226856686813620','R141770099156750308'),('RM-U154242006298286919','M-UU142502912450567699','R141770099156750308'),('RM-U154242006298416870','M-UU142508579506696266','R141770099156750308'),('RM-U154242006298421994','M-UU142508562386146072','R141770099156750308'),('RM-U154242006298439479','M_U154225007149324418','R141770099156750308'),('RM-U154242006298485956','M_U154233259511310918','R141770099156750308'),('RM-U154242006298511744','M_U154226493530106359','R141770099156750308'),('RM-U154242006298537261','M_U154228787322754855','R141770099156750308'),('RM-U154242006298557111','M_U154227254133036595','R141770099156750308'),('RM-U154242006298575604','M_U154225004073616144','R141770099156750308'),('RM-U154242006298635617','M-UU142502856650696782','R141770099156750308'),('RM-U154242006298635995','M-UU142493393340566190','R141770099156750308'),('RM-U154242006298665586','M-UU142493393345840632','R141770099156750308'),('RM-U154268080352207260','M_U154237249973265102','R141770099156750308'),('RM-U154272178890313818','M_U154272178887659993','R141770099156750308'),('RM-U154276255292806698','M_U154228787322754855','R-UU141994583098704113'),('RM-U154276255292834146','M_U154225004073616144','R-UU141994583098704113'),('RM-U154276255292849120','M_U154237249973265102','R-UU141994583098704113'),('RM-U154276255292865687','M_U154225007149324418','R-UU141994583098704113'),('RM-U154276255292897551','M_U154226493530106359','R-UU141994583098704113'),('RM-U154276255292922259','M_U154227254133036595','R-UU141994583098704113'),('RM-U154276255292942249','M_U154233259511310918','R-UU141994583098704113'),('RM-U154276255292943793','M_U154226856686813620','R-UU141994583098704113'),('RM-U154276255292961173','M_U154272178887659993','R-UU141994583098704113'),('RM-U154276255292982808','M_U154237158480128046','R-UU141994583098704113'),('RM-U154276265010168065','M_U154225004073616144','R-UU142509589602782910'),('RM-U154276265010251257','M_U154237249973265102','R-UU142509589602782910'),('RM-U154276265010260639','M_U154228787322754855','R-UU142509589602782910'),('RM-U154276265010304416','M_U154227254133036595','R-UU142509589602782910'),('RM-U154276265010317889','M_U154237158480128046','R-UU142509589602782910');

/*Table structure for table `t_n_role_resource` */

DROP TABLE IF EXISTS `t_n_role_resource`;

CREATE TABLE `t_n_role_resource` (
  `id` varchar(32) NOT NULL,
  `op_auths` varchar(255) DEFAULT NULL,
  `resource_id` varchar(32) NOT NULL,
  `role_id` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_n_role_resource` */

insert  into `t_n_role_resource`(`id`,`op_auths`,`resource_id`,`role_id`) values ('U154242006299214901','add,edit,del,refresh,','UU142494261976460581','R141770099156750308'),('U154242006299215696','add,edit,del,refresh,','UU142494155606818866','R141770099156750308'),('U154242006299228417','add,edit,del,refresh,changepwd,','UU142494266546995694','R141770099156750308'),('U154242006299242722','add,edit,del,refresh,','UU142494281162643857','R141770099156750308'),('U154242006299246066','add,edit,del,refresh,','UU142493393323156274','R141770099156750308'),('U154242006299250270','','UU142494285272420160','R141770099156750308'),('U154242006299262977','add,edit,del,refresh,','UU142494269829079292','R141770099156750308'),('U154242006299305155','add,edit,del,refresh,','UU142493393303513551','R141770099156750308'),('U154242006299309588','','UU142494288694979665','R141770099156750308'),('U154242006299347208','add,del,refresh,','UU142536339652188513','R141770099156750308'),('U154242006299360022','add,del,refresh,','UU142536367109082749','R141770099156750308'),('U154242006299362780','add,edit,del,refresh,','UU142494292374313391','R141770099156750308'),('U154242006299367049','add,del,refresh,','UU142536417802440972','R141770099156750308'),('U154242006299367068','add,del,refresh,','UU142536376280597829','R141770099156750308'),('U154242006299386508','','UU142508630396009472','R141770099156750308'),('U154242006299394069','add,del,refresh,','UU142536370298266280','R141770099156750308'),('U154242006299420851','','UU142648904341707233','R141770099156750308'),('U154242006299420951','edit_designer,del,refresh,','UU142865507367695503','R141770099156750308'),('U154242006299421101','add,edit,del,refresh,','UU142891052568659983','R141770099156750308'),('U154242006299423032','','U143386875037004503','R141770099156750308'),('U154242006299430205','add,edit,del,refresh,changepwd,','UU142536804561674717','R141770099156750308'),('U154242006299439507','add,edit,del,refresh,','UU142623880634351320','R141770099156750308'),('U154242006299446214','edit_designer,del,refresh,','UU143065539369030702','R141770099156750308'),('U154242006299464627','add,edit,del,refresh,','UU142725947101781158','R141770099156750308'),('U154242006299466517','','UU142674912100115069','R141770099156750308'),('U154242006299472329','jump_task,del,refresh,flow_form_edit,','U143437621125952385','R141770099156750308'),('U154242006299475386','add,del,refresh,','UU142536421178574716','R141770099156750308'),('U154242006299480341','','UU142726304175200513','R141770099156750308'),('U154242006299481478','add,edit,del,refresh,','UU142536483130282094','R141770099156750308'),('U154242006299485510','add,edit,del,refresh,','UU142537018725515068','R141770099156750308'),('U154242006299502120','add,edit,del,refresh,','U148774376819175947','R141770099156750308'),('U154242006299508149','','U147417439880357008','R141770099156750308'),('U154242006299513779','edit,del,refresh,','U150419023701932892','R141770099156750308'),('U154242006299514337','add,edit,del,refresh,','U147686532906967243','R141770099156750308'),('U154242006299521714','','U150108134134573562','R141770099156750308'),('U154242006299522903','del,refresh,flow_form_edit,','U143437623207722734','R141770099156750308'),('U154242006299543162','','U147522762933583369','R141770099156750308'),('U154242006299543526','','U143891863167559700','R141770099156750308'),('U154242006299543942','add,edit,del,refresh,','U143617398234893404','R141770099156750308'),('U154242006299543973','edit_designer,add,edit,refresh,changepwd,','U148765647626620413','R141770099156750308'),('U154242006299556004','','U149542927908493158','R141770099156750308'),('U154242006299558894','','U150505741534899631','R141770099156750308'),('U154242006299562233','add,edit,del,refresh,','U147563795975505594','R141770099156750308'),('U154242006299567616','','U146772885528409688','R141770099156750308'),('U154242006299569886','','U143437634716263470','R141770099156750308'),('U154242006299581202','add,edit,del,refresh,','U150107939436631363','R141770099156750308'),('U154242006299584632','edit_designer,add,edit,del,refresh,','U148248001874056364','R141770099156750308'),('U154242006299616401','','U154227251858798941','R141770099156750308'),('U154242006299617088','','U150523150955702051','R141770099156750308'),('U154242006299618762','add,edit,del,refresh,','U150894686421341181','R141770099156750308'),('U154242006299631411','refresh,','U154234951077617402','R141770099156750308'),('U154242006299637136','','U154237151730283760','R141770099156750308'),('U154242006299638647','add,edit,del,refresh,','U154226490927926250','R141770099156750308'),('U154242006299652486','edit_designer,add,edit,','U154225067366985402','R141770099156750308'),('U154242006299663141','add,edit,del,refresh,','U150773698819847933','R141770099156750308'),('U154242006299667255','edit_designer,del,refresh,','U150609785810770279','R141770099156750308'),('U154242006299667743','del,refresh,','U154235825869638603','R141770099156750308'),('U154242006299671112','add,edit,del,refresh,','U154226854575116662','R141770099156750308'),('U154242006299677468','export,','U150773721860798909','R141770099156750308'),('U154242006299684380','increaseRemainCourse,add,edit,del,refresh,','U154228785560711973','R141770099156750308'),('U154242006299691269','add,edit,del,refresh,','U154233255974582635','R141770099156750308'),('U154242430733493370','studentSignIn,edit,refresh,','U154242430730400390','R141770099156750308'),('U154272176061389596','edit,refresh,','U154272176054572296','R141770099156750308'),('U154276255293867843','edit_designer,add,edit,','U154225067366985402','R-UU141994583098704113'),('U154276255293907670','del,refresh,','U154235825869638603','R-UU141994583098704113'),('U154276255293932334','add,edit,del,refresh,','U154226854575116662','R-UU141994583098704113'),('U154276255293933887','refresh,','U154234951077617402','R-UU141994583098704113'),('U154276255293953354','','U154237151730283760','R-UU141994583098704113'),('U154276255293965975','edit,refresh,studentSignIn,','U154242430730400390','R-UU141994583098704113'),('U154276255293969941','','U154227251858798941','R-UU141994583098704113'),('U154276255293976867','add,edit,del,refresh,','U154226490927926250','R-UU141994583098704113'),('U154276255293984354','add,edit,del,refresh,chooseClass,','U154228785560711973','R-UU141994583098704113'),('U154276255293998709','add,edit,del,refresh,','U154233255974582635','R-UU141994583098704113'),('U154276265010829089','','UU142508630396009472','R-UU142509589602782910');

/*Table structure for table `t_n_role_user` */

DROP TABLE IF EXISTS `t_n_role_user`;

CREATE TABLE `t_n_role_user` (
  `ID` varchar(32) NOT NULL,
  `ROLE_ID` varchar(32) DEFAULT NULL,
  `USER_ID` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_n_role_user` */

insert  into `t_n_role_user`(`ID`,`ROLE_ID`,`USER_ID`) values ('141770099157657188','R141770099156750308','U141770099155103287'),('U143462141469509690','R-UU141994583098704113','U-UU142406936416863226'),('U150485509319491457','R-UU141994583098704113','U_U146720855065737398'),('U154237232717738607','R-UU141994583098704113','U_U154237223000479222'),('U154276270973930261','R-UU142509589602782910','U_U154276269082998004'),('UU142407651985936553','R-UU141994583098704113','U-UU142062143880838422');

/*Table structure for table `t_n_user` */

DROP TABLE IF EXISTS `t_n_user`;

CREATE TABLE `t_n_user` (
  `id` varchar(32) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `full_name` varchar(32) DEFAULT NULL,
  `mobile_no` varchar(32) DEFAULT NULL,
  `org_id` varchar(64) DEFAULT NULL,
  `password` varchar(32) DEFAULT NULL,
  `qq` varchar(20) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `username` varchar(50) NOT NULL,
  `position_id` varchar(32) DEFAULT NULL,
  `sort_order` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_n_user` */

insert  into `t_n_user`(`id`,`create_time`,`email`,`full_name`,`mobile_no`,`org_id`,`password`,`qq`,`remark`,`state`,`username`,`position_id`,`sort_order`) values ('U141770099155103287','2014-12-04 21:49:51','','超级管理员','','0','c51b9fba77df5f9195d7730163e176fc','','',1,'admin','',NULL),('U_U154237223000479222','2018-11-16 20:43:50','','协会管理员','','ORG_U154237217148182457','e10adc3949ba59abbe56e057f20f883e','','',1,'tg-admin','',NULL),('U_U154276269082998004','2018-11-21 09:11:31','','老师01','','ORG_U154237217148182457','e10adc3949ba59abbe56e057f20f883e','','',1,'teacher01','',NULL);

/*Table structure for table `tg_study_classroom` */

DROP TABLE IF EXISTS `tg_study_classroom`;

CREATE TABLE `tg_study_classroom` (
  `id` varchar(64) NOT NULL,
  `school_id` varchar(64) DEFAULT NULL,
  `school_name` varchar(64) DEFAULT NULL,
  `name` varchar(64) DEFAULT NULL,
  `status` varchar(16) DEFAULT NULL,
  `description` varchar(128) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `sort_order` int(4) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `sort_order` (`sort_order`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

/*Data for the table `tg_study_classroom` */

insert  into `tg_study_classroom`(`id`,`school_id`,`school_name`,`name`,`status`,`description`,`create_time`,`update_time`,`sort_order`) values ('U154278944159689965','U154278937639961731','灵秀','灵秀一','NORMAL','灵秀一','2018-11-21 16:37:22',NULL,1),('U154278945143928838','U154278937639961731','灵秀','灵秀二','NORMAL','灵秀二','2018-11-21 16:37:31',NULL,2),('U154278946335725256','U154278938594715590','碧海','碧海一','NORMAL','碧海一','2018-11-21 16:37:43',NULL,3),('U154278947254004755','U154278938594715590','碧海','碧海二','NORMAL','碧海二','2018-11-21 16:37:53',NULL,4),('U154278948205280404','U154278938594715590','碧海','碧海三','NORMAL','碧海三','2018-11-21 16:38:02',NULL,5),('U154278949320644493','U154278938594715590','碧海','碧海四','NORMAL','碧海四','2018-11-21 16:38:13',NULL,6),('U154278950797478300','U154278940555972710','沈家门','沈家门','NORMAL','沈家门','2018-11-21 16:38:28',NULL,7),('U154278952002996339','U154278942492545956','城建','城建','NORMAL','城建','2018-11-21 16:38:40',NULL,9),('U154279020003980659','U154278941642911961','一小','一小','NORMAL','一小','2018-11-21 16:50:00',NULL,8);

/*Table structure for table `tg_study_course` */

DROP TABLE IF EXISTS `tg_study_course`;

CREATE TABLE `tg_study_course` (
  `id` varchar(64) NOT NULL,
  `name` varchar(64) DEFAULT NULL,
  `week_info` tinyint(2) DEFAULT NULL,
  `course_time_index` tinyint(2) DEFAULT NULL,
  `course_time` varchar(32) DEFAULT NULL,
  `school_id` varchar(64) DEFAULT NULL,
  `school_name` varchar(64) DEFAULT NULL,
  `classroom_id` varchar(64) DEFAULT NULL,
  `classroom_name` varchar(64) DEFAULT NULL,
  `teacher_id` varchar(64) DEFAULT NULL,
  `teacher_name` varchar(64) DEFAULT NULL,
  `status` varchar(16) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tg_study_course` */

insert  into `tg_study_course`(`id`,`name`,`week_info`,`course_time_index`,`course_time`,`school_id`,`school_name`,`classroom_id`,`classroom_name`,`teacher_id`,`teacher_name`,`status`,`description`,`create_time`,`update_time`) values ('30065359752847','周宏斌星期六1',6,1,'7:30-9:00','U154278941642911961','一小','U154279020003980659','一小','U154278954605976028','周宏斌','NORMAL','','2018-11-28 17:04:32',NULL),('30075026200083','周宏斌星期六2',6,2,'9:00-10:30','U154278941642911961','一小','U154279020003980659','一小','U154278954605976028','周宏斌','NORMAL','','2018-11-28 17:04:42',NULL),('30127164511418','周宏斌星期六4',6,4,'15:30-17:00','U154278937639961731','灵秀','U154278944159689965','灵秀一','U154278954605976028','周宏斌','NORMAL','','2018-11-28 17:05:34',NULL),('30135070565241','周宏斌星期六5',6,5,'18:30-20:00','U154278937639961731','灵秀','U154278944159689965','灵秀一','U154278954605976028','周宏斌','NORMAL','','2018-11-28 17:05:42',NULL),('U154287287751332438','周宏斌星期二5',2,5,'18:30-20:00','U154278937639961731','灵秀','U154278944159689965','灵秀一','U154278954605976028','周宏斌','NORMAL','','2018-11-22 15:47:58',NULL),('U154287288842867264','周宏斌星期三5',3,5,'18:30-20:00','U154278937639961731','灵秀','U154278944159689965','灵秀一','U154278954605976028','周宏斌','NORMAL','','2018-11-22 15:48:08',NULL),('U154287292108462387','周宏斌星期六3',6,3,'13:30-15:00','U154278937639961731','灵秀','U154278944159689965','灵秀一','U154278954605976028','周宏斌','NORMAL','','2018-11-22 15:48:41',NULL);

/*Table structure for table `tg_study_course_record` */

DROP TABLE IF EXISTS `tg_study_course_record`;

CREATE TABLE `tg_study_course_record` (
  `id` varchar(64) NOT NULL,
  `course_id` varchar(64) DEFAULT NULL,
  `course_name` varchar(64) DEFAULT NULL,
  `course_date` varchar(32) DEFAULT NULL,
  `course_time` varchar(32) DEFAULT NULL,
  `classroom_id` varchar(64) DEFAULT NULL,
  `classroom_name` varchar(64) DEFAULT NULL,
  `teacher_id` varchar(64) DEFAULT NULL,
  `teacher_name` varchar(64) DEFAULT NULL,
  `student_quantity_plan` int(11) DEFAULT NULL,
  `student_quantity_actual` int(11) DEFAULT NULL,
  `student_personal_leave` int(11) DEFAULT NULL,
  `student_play_truant` int(11) DEFAULT NULL,
  `student_other_absent` int(11) DEFAULT NULL,
  `status` varchar(16) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `description` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tg_study_course_record` */

insert  into `tg_study_course_record`(`id`,`course_id`,`course_name`,`course_date`,`course_time`,`classroom_id`,`classroom_name`,`teacher_id`,`teacher_name`,`student_quantity_plan`,`student_quantity_actual`,`student_personal_leave`,`student_play_truant`,`student_other_absent`,`status`,`create_time`,`update_time`,`description`) values ('30065449290480','30065359752847','周宏斌星期六1','2018-12-01','7:30-9:00','U154279020003980659','一小','U154278954605976028','周宏斌',0,0,0,0,0,'NORMAL','2018-11-28 17:04:32',NULL,NULL),('30075036191640','30075026200083','周宏斌星期六2','2018-12-01','9:00-10:30','U154279020003980659','一小','U154278954605976028','周宏斌',0,0,0,0,0,'NORMAL','2018-11-28 17:04:42',NULL,NULL),('30127174071826','30127164511418','周宏斌星期六4','2018-12-01','15:30-17:00','U154278944159689965','灵秀一','U154278954605976028','周宏斌',0,0,0,0,0,'NORMAL','2018-11-28 17:05:34',NULL,NULL),('30135078985731','30135070565241','周宏斌星期六5','2018-12-01','18:30-20:00','U154278944159689965','灵秀一','U154278954605976028','周宏斌',0,0,0,0,0,'NORMAL','2018-11-28 17:05:42',NULL,NULL),('31001071228728','U154287287751332438','周宏斌星期二5','2018-12-04','18:30-20:00','U154278944159689965','灵秀一','U154278954605976028','周宏斌',0,0,0,0,0,'NORMAL','2018-11-27 17:17:37',NULL,NULL),('31001099518976','U154287288842867264','周宏斌星期三5','2018-12-05','18:30-20:00','U154278944159689965','灵秀一','U154278954605976028','周宏斌',0,0,0,0,0,'NORMAL','2018-11-27 17:17:37',NULL,NULL),('31001108780405','U154287292108462387','周宏斌星期六3','2018-12-08','13:30-15:00','U154278944159689965','灵秀一','U154278954605976028','周宏斌',0,0,0,0,0,'NORMAL','2018-11-27 17:17:37',NULL,NULL),('3607100967457','U154287287751332438','周宏斌星期二5','2018-11-27','18:30-20:00','U154278944159689965','灵秀一','U154278954605976028','周宏斌',1,1,0,0,0,'NORMAL_END','2018-11-21 09:43:32','2018-11-28 09:44:02',NULL),('3607314243565','U154287288842867264','周宏斌星期三5','2018-11-28','18:30-20:00','U154278944159689965','灵秀一','U154278954605976028','周宏斌',1,0,0,0,1,'NORMAL_END','2018-11-21 09:43:33','2018-11-29 17:28:11',NULL),('3607444214931','U154287292108462387','周宏斌星期六3','2018-12-01','13:30-15:00','U154278944159689965','灵秀一','U154278954605976028','周宏斌',0,0,0,0,0,'NORMAL','2018-11-21 09:43:33',NULL,NULL),('U154287292110995660','U154287292108462387','周宏斌星期六3','2018-11-24','13:30-15:00','U154278944159689965','灵秀一','U154278954605976028','周宏斌',0,0,0,0,0,'NORMAL','2018-11-22 15:48:41',NULL,NULL);

/*Table structure for table `tg_study_course_student_record` */

DROP TABLE IF EXISTS `tg_study_course_student_record`;

CREATE TABLE `tg_study_course_student_record` (
  `id` varchar(64) NOT NULL,
  `course_record_id` varchar(64) DEFAULT NULL,
  `course_id` varchar(64) DEFAULT NULL,
  `student_id` varchar(64) DEFAULT NULL,
  `student_name` varchar(64) DEFAULT NULL,
  `status` varchar(32) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `description` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tg_study_course_student_record` */

insert  into `tg_study_course_student_record`(`id`,`course_record_id`,`course_id`,`student_id`,`student_name`,`status`,`create_time`,`update_time`,`description`) values ('3607185600199','3607314243565','U154287288842867264','U154294589485489135','余昊泽','OTHER_ABSENT','2018-11-21 09:43:33','2018-11-29 17:28:11',NULL);

/*Table structure for table `tg_study_renew_record` */

DROP TABLE IF EXISTS `tg_study_renew_record`;

CREATE TABLE `tg_study_renew_record` (
  `id` varchar(64) NOT NULL,
  `student_id` varchar(64) DEFAULT NULL,
  `student_name` varchar(64) DEFAULT NULL,
  `amount` bigint(16) DEFAULT NULL COMMENT '额度,单位元',
  `course_count` int(8) DEFAULT NULL,
  `description` varchar(128) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `operator_id` varchar(64) DEFAULT NULL,
  `operator_full_name` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tg_study_renew_record` */

insert  into `tg_study_renew_record`(`id`,`student_id`,`student_name`,`amount`,`course_count`,`description`,`create_time`,`operator_id`,`operator_full_name`) values ('24094254999819','22384029931917','测试学生02',1000,20,'续费，增加课时','2018-11-27 15:22:29','U141770099155103287','超级管理员'),('24115494258965','22384029931917','测试学生02',1000,20,'继续增加课时','2018-11-27 15:22:51','U141770099155103287',NULL),('3769339870384','U154294589485489135','余昊泽',1000,20,'','2018-11-28 09:46:15','U141770099155103287','超级管理员'),('3790513966848','U154294589485489135','余昊泽',1000,20,'','2018-11-28 09:46:36','U141770099155103287','超级管理员'),('3852411034729','22384029931917','测试学生02',1000,20,'','2018-11-28 09:47:38','U141770099155103287','超级管理员');

/*Table structure for table `tg_study_school` */

DROP TABLE IF EXISTS `tg_study_school`;

CREATE TABLE `tg_study_school` (
  `id` varchar(255) NOT NULL,
  `name` varchar(64) DEFAULT NULL,
  `address` varchar(128) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `status` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tg_study_school` */

insert  into `tg_study_school`(`id`,`name`,`address`,`create_time`,`status`) values ('U154278937639961731','灵秀','灵秀街','2018-11-21 16:36:16','NORMAL'),('U154278938594715590','碧海','碧海莲缘','2018-11-21 16:36:26','NORMAL'),('U154278940555972710','沈家门','沈家门','2018-11-21 16:36:46','NORMAL'),('U154278941642911961','一小','一小','2018-11-21 16:36:56','NORMAL'),('U154278942492545956','城建','城建','2018-11-21 16:37:05','NORMAL');

/*Table structure for table `tg_study_student` */

DROP TABLE IF EXISTS `tg_study_student`;

CREATE TABLE `tg_study_student` (
  `id` varchar(64) NOT NULL,
  `name` varchar(64) DEFAULT NULL,
  `age` int(2) DEFAULT NULL,
  `sex` smallint(1) DEFAULT NULL,
  `birthday` varchar(32) DEFAULT NULL,
  `school_name` varchar(128) DEFAULT NULL,
  `level` varchar(8) DEFAULT NULL,
  `parent_phone` varchar(16) DEFAULT NULL,
  `parent_name` varchar(64) DEFAULT NULL,
  `parent_type` smallint(1) DEFAULT NULL,
  `status` varchar(16) DEFAULT NULL,
  `total_course` int(11) DEFAULT NULL,
  `remain_course` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `course_series_un_signed` int(3) DEFAULT '0',
  `is_register` varchar(8) DEFAULT NULL COMMENT 'YES,NO',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tg_study_student` */

insert  into `tg_study_student`(`id`,`name`,`age`,`sex`,`birthday`,`school_name`,`level`,`parent_phone`,`parent_name`,`parent_type`,`status`,`total_course`,`remain_course`,`create_time`,`update_time`,`course_series_un_signed`,`is_register`) values ('21458917372428','测试学生01',0,1,'2018-11-06','东港小学','2段','13565654212',NULL,0,'NORMAL',20,-1,'2018-11-27 14:38:34','2018-11-27 17:10:57',0,'NO'),('22384029931917','测试学生02',0,1,'2018-11-10','东港小学','5级','13521215868',NULL,0,'NORMAL',100,19,'2018-11-27 14:53:59','2018-11-28 09:47:38',0,'YES'),('U154284988174387916','汪云浩',0,1,'2008-10-01','城北','17级','18768074874',NULL,0,'NORMAL',20,0,'2018-11-22 09:24:42','2018-11-27 14:34:38',0,'NO'),('U154287115737626131','宁振皓',0,1,'2012-02-28','城北','1段','13750721901',NULL,0,'NORMAL',20,0,'2018-11-22 15:19:17','2018-11-27 14:34:45',0,'NO'),('U154294499776100947','陈昱帆',0,1,'2012-11-02','东港','0','13567696388',NULL,0,'NORMAL',0,0,'2018-11-23 11:49:58',NULL,0,'NO'),('U154294499777208620','朱奕臻',0,1,'2014-01-07','东港','0','13506809405',NULL,0,'NORMAL',0,0,'2018-11-23 11:49:58',NULL,0,'NO'),('U154294499778085165','陆妍心',0,2,'2011-08-25','小天地','0','13957234971',NULL,0,'NORMAL',0,0,'2018-11-23 11:49:58',NULL,0,'NO'),('U154294499779522229','李京晓',0,2,'2012-08-22','熊猫','0','18768068262',NULL,0,'NORMAL',0,0,'2018-11-23 11:49:58',NULL,0,'NO'),('U154294499780700347','陈冠羽',0,1,'2013-01-14','东港','0','13706800431',NULL,0,'NORMAL',0,0,'2018-11-23 11:49:58',NULL,0,'NO'),('U154294499782021537','吴彦诺',0,1,'2012-12-30','熊猫','0','13967203170',NULL,0,'NORMAL',0,0,'2018-11-23 11:49:58',NULL,0,'NO'),('U154294572271042531','沈辰旭',0,1,'2010-11-01','一小','22','13735017673',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572272185818','程昱甄',0,2,'2011-11-06','普陀小学','0','18058028653',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572272870346','许正洋',0,1,'2010-08-01','沈小','0','18268703246',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572273959472','贺昱玮',0,1,'2013-02-03','熊猫','25','15957057352',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572274773837','丁麒谕',0,1,'2013-06-01','熊猫','11级','13967205718',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03','2018-11-27 14:34:32',0,'NO'),('U154294572275489969','林睿泽',0,1,'2013-11-03','东港','0','13868248467',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572276363772','翁子画',0,1,'2011-12-08','熊猫','23','13967219630',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572277022045','庄子涵',0,1,'2012-08-09','熊猫','24','15157980909',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572278111582','郑皓仁',0,1,'2013-05-03','和润','0','13868213553',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572280221735','翁熙哲',0,1,'2012-10-11','蓝盾','0','15958078208',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572281120339','贝晨晰',0,2,'2013-03-30','蓝盾','0','15958095561',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572281725702','杨浚溢',0,1,'2011-08-25','城北','0','13506801361',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572282741846','张宸硕',0,1,'2013-08-31','熊猫','0','13587071618',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572283437627','盛张睿',0,1,'2013-03-01','普陀小学','0','13758006682',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572284166197','李雨轩',0,1,'2013-07-11','东港','0','13666703299',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572284890715','李函臻',0,1,'2012-09-20','沈家门','0','13666585833',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572285707302','乐禹含',0,1,'2012-08-23','熊猫','0','13967217161',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572286478459','屠骁腾',0,1,'2014-02-08','','0','13758004946',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572287119616','袁佳玮',0,2,'2014-06-20','熊猫','0','13396805858',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572287818698','孙颢淳',0,1,'2013-04-01','颐景园','0','13587094040',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572289132557','韩宗博',0,1,'2011-07-25','一小','0','13758032766',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572289946616','孙浩航',0,1,'2014-05-27','','0','15305808779',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572291233447','王麒皓',0,1,'2012-12-05','北安','0','13665810440',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572292168429','陈乙霆',0,1,'2012-08-13','沈家门','0','13616806368',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572293134130','王博然',0,1,'2014-10-15','沈家门','0','663272',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572294688973','程玺璇',0,2,'2008-03-28','沈小','0','13587066203',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572296178891','郑欣睿',0,1,'2009-03-01','勾山小学','0','15957087078',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572297371249','王一早',0,1,'2010-01-15','一小','22','13059888081',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572298687840','陈禹桦',0,1,'2012-07-17','熊猫','19','13867213552',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572299776813','苗凯杰',0,1,'2011-12-30','青苹果','0','13665818945',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572300410719','谢其桓',0,1,'2010-07-13','蓝盾','22','18005808588',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572301357879','许誉耀',0,1,'2010-11-16','沈小','23','13655806486',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572302063824','李佳澔',0,1,'2009-10-24','勾山','17','15958078515',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572303153866','林哲毅',0,1,'2010-04-08','沈小','18','13575604884',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572304359360','曹佑嘉',0,1,'2010-04-14','普陀小学','0','13732530195',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572305223139','徐博厚',0,1,'2010-10-17','城建','19','15305808660',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572306014711','邬知逸',0,1,'2010-11-19','和润','23','13567675500',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572306058487','虞钧涵',0,1,'2012-05-23','熊猫','22','13957232107',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572306058774','邵匀佐',0,1,'2012-08-03','熊猫','22','13735035708',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572309250552','胡哲喻',0,1,'2010-10-24','普陀小学','21','15958068812',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572312328474','张晋瑜',0,1,'2013-01-15','实验','20','13735013587',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572313861707','刘书岑',0,2,'2010-10-28','','24','13867232522',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572316563396','蒋卓航',0,1,'2011-11-22','新城幼儿园','0','13967201544',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572318678993','刘  辰',0,1,'2010-12-03','普小','0','13758016309',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572319935282','韩雨臻',0,1,'2010-04-03','颐景园','22','15068007101',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572320869870','翁齐辰',0,1,'2012-02-07','熊猫','23','13665804357',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572321687403','翁晨越',0,1,'2012-04-23','东港','0','13750711467',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572322319786','沃渲博',0,1,'2012-09-12','沈家门','0','13567698277',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572323157126','丁嘉鸿',0,1,'2012-09-16','东港','0','13666591905',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572323924436','李昕瀚',0,1,'2012-09-21','东港','23','15924005307',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572324854349','周子翔',0,1,'2012-11-01','普陀','0','13967213777',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572325883196','徐靖昕',0,1,'2012-12-10','沈家门','0','13857207742',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572326530362','马瑜辰',0,1,'2013-03-24','碧海','0','18058021772',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572327263757','刘讴睿',0,1,'2012-03-26','熊猫','0','15858089696',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572328033669','周柏臻',0,1,'2011-05-07','颐景园','24','18058095670',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572328997724','王艺瑾',0,2,'2012-10-17','中心','0','13567670608',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572329813983','张译涵',0,1,'2012-06-01','南海','0','13957235991',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572330712305','乐凯文',0,1,'2009-07-16','一小','0','13868237741',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572331663377','王浚羽',0,1,'2009-05-04','','0','13868224057',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572332477969','郭泽楠',0,1,'2011-01-13','和润','16','13868238308',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572333932768','殷又嘉',0,1,'2010-06-17','颐景园','0','18069293617',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572335188124','钟昊轩',0,1,'2012-09-02','熊猫','0','13867213122',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572336322087','俞博文',0,1,'2009-09-07','和润','17','13587081166',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572337370334','汪淇涵',0,1,'2010-06-01','和润','19','18605808885',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572338478539','俞俊烨',0,1,'2010-12-14','一小','0','13587065522',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572339221329','李思竟',0,2,'2011-02-11','和润','21','13587047227',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572340358766','王浚棋',0,1,'2010-10-26','普陀小学','10','13575611610',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572341266092','张子涵',0,1,'2007-12-02','沈四小','23','18605807508',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572341993151','李若水',0,2,'2006-05-05','一小','0','13905800185',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572342813715','刘梓源',0,1,'2009-02-02','普小','7','13705807782',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572343526686','焦俊宁',0,1,'2011-12-18','普小','0','13868236317',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572344373716','童煜希',0,1,'2011-09-25','沈小','0','13758007115',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572344479863','马誉宸',0,1,'2008-10-07','沈小','13','13735029991',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572346461672','邵润觉',0,1,'2010-10-11','普陀小学','17','13587077978',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572347324767','胡闵皓',0,1,'2011-01-06','沈一小','6','13732528368',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572348092843','徐嘉豪',0,1,'2010-02-19','沈一小','7','13867226338',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572348942976','严晟珈',0,1,'2009-10-10','沈四小','9','13868223516',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572349970368','黄子洋',0,1,'2010-01-10','普小','0','13868247446',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:03',NULL,0,'NO'),('U154294572350732210','蒋泽宇',0,1,'2008-06-01','','0','13567661028',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572351770708','包烜豪',0,1,'2011-11-01','','0','13857206218',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572352879514','张宸豪',0,1,'2012-10-16','碧海园','0','13666717662',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572353519214','颜琳烨',0,2,'2013-04-12','熊猫','0','13566005441',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572354630681','李谨旭',0,2,'2013-08-12','熊猫','0','13957222412',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572355449483','张力匀',0,1,'2012-10-24','熊猫','0','13857204977',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572356395454','余嘉硕',0,1,'2012-12-29','熊猫','0','15088893967',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572357036827','严晨慧',0,2,'2013-04-15','熊猫','0','13758014780',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572358088444','孙博艺',0,1,'2013-06-10','普陀','0','13735018835',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572358982489','孔彦淇',0,1,'2012-06-01','实验','0','13666703142',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572359936546','刘辰昕',0,1,'2012-12-01','东港','0','18658005303',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572360753222','虞健仰',0,1,'2012-06-16','熊猫','0','18058028217',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572361542188','李柏霖',0,1,'2013-01-10','熊猫','0','13305800827',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572362135219','翁浩瀚',0,1,'2012-08-28','熊猫','0','13967206186',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572362903445','虞子萱',0,1,'2014-03-01','熊猫','0','13665807742',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572363574169','陈衍桦',0,1,'2012-11-29','熊猫','0','15924021540',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572366028698','方颢霖',0,1,'2013-11-01','熊猫','0','13665816156',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572366660840','张沐晨',0,1,'2014-05-24','熊猫','0','13967219367',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572367168733','缪卓谕',0,1,'2014-03-24','熊猫','0','15957085006',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572367782199','彭煜轩',0,1,'2014-01-20','熊猫','0','13868231077',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572368230952','徐启然',0,1,'2013-04-02','东港','0','13857235895',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572368795451','王  政',0,1,'2012-09-08','熊猫','0','15159320092',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572369548989','陈泓睿',0,1,'2012-03-27','碧海园','0','13967235426',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572370211224','刘骐恺',0,1,'2012-12-18','碧海园','0','13388449009爸',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572371309234','王思然',0,1,'2013-12-26','熊猫','0','15657097537',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572371941368','许淇皓',0,1,'2012-09-19','东港','0','13656820536',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572372686722','柳彦朵',0,1,'2014-03-17','熊猫','0','13868236233',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572373529346','李承桦',0,1,'2010-04-11','普陀小学','0','13587091383',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572373569760','孙译辰',0,1,'2011-04-07','新城','8','13666705660',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572375004769','李政翰',0,1,'2010-03-06','沈小','0','13567697796',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572375052002','胡潇楠',0,1,'2011-10-01','颐景园','22','18627117833',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572376656628','蒋易睿',0,1,'2011-03-26','城建','0','18857058878',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572376681392','陆柏男',0,1,'2010-07-10','中旭','0','18273125312',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572378103473','小李雨泽',0,1,'2011-04-26','蓝盾','21','13567684942',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572378182041','陈希骏',0,1,'2011-04-25','颐景园','24','15858055821',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572379721462','杨骐泽',0,1,'2011-12-19','沈家门','20','13967203181',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572379791170','洪睿阳',0,1,'2011-07-06','熊猫','20','15168082891',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572381302568','李奕涵',0,1,'2012-05-16','颐景园','23','13867208229',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572381337501','魏辰旭',0,1,'2012-03-06','沈家门','16','13857237083',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572383186187','胡智勋',0,1,'2011-12-21','一小','0','13666705163',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572383713641','张桓豪',0,1,'2010-01-05','沈家门','0','15957072431',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572384205916','沈子洋',0,1,'2011-05-10','熊猫','23','15268029518',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572384834125','叶子煜',0,1,'2012-01-01','蓝盾','0','13967224552',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572385633933','周彦江',0,2,'2011-05-11','蓝盾','24','18768006639',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572386496781','范丰毅',0,1,'2009-02-02','颐景园','14','13567693493',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572387001882','刘焘毓',0,1,'2007-03-26','勾山','18','13967221543',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572387583858','丁乐捷',0,1,'2009-08-26','南海','23','13758018125',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572388059819','孙薪淯',0,2,'2009-01-29','一小','0','13868238654',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572388756782','张翔宾',0,1,'2006-11-21','芦花','15','13575624282',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572389380092','腾斌源',0,1,'2009-03-02','洞洞','12','13567679565',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572389885198','鲍鼎维',0,1,'2008-11-11','舟山小学','10','15924014680',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572390565744','冯茂庭',0,1,'2011-01-01','熊猫','17','13967201337',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572391324643','方彬鉴',0,1,'2009-08-20','熊猫','0','13645804014',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572391942445','周子恩',0,1,'2009-01-14','沈小','0','13735028757',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572392890888','吴昊东',0,1,'2010-08-22','一小','19','13615809628',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572393431519','魏子谦',0,1,'2008-04-14','南海','2','13868202256',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572394018920','刘政男',0,1,'2007-09-24','沈小','2','13735022412',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572394061852','庄天乐',0,1,'2007-01-23','沈小','2','13758046321',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572395600314','陈芊含',0,2,'2009-11-26','一小','22','13735029815',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572395630735','潘冠翰',0,1,'2010-05-26','舟山一小','22','13587067852',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572397125440','麻秦子轩',0,1,'2011-04-01','北禅','0','15858087871',NULL,0,'NORMAL',20,20,'2018-11-23 12:02:04','2018-11-23 13:35:50',0,'NO'),('U154294572397162991','陈  澄',0,1,'2007-07-09','沈小','0','13868245577',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572398778403','庄浚朗',0,1,'2010-02-27','颐景园','13','13758028605',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572400458556','刘绍涵',0,1,'2012-03-30','熊猫','0','15168078701',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572401454491','黄于哲',0,1,'2010-07-24','沈小','0','15957091588',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572402108609','李佳臻',0,1,'2009-02-07','沈小','0','13967231912',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572402905022','余禹翰',0,1,'2010-10-23','熊猫','20','13957234793',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572403568138','贺铭依',0,2,'2011-01-02','沈小','0','13705803205',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572403931076','王齐成',0,1,'2012-03-14','普陀','13','13867211582',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572403994913','徐晨皓',0,1,'2010-03-10','颐景园','4','13095809823',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572405419157','大李雨泽',0,1,'2010-10-09','颐景园幼儿','0','13567690703',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572405448913','童禹豪',0,1,'2010-09-22','和润','18','13575631524',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572405475616','蒋林璇',0,1,'2010-03-14','颐景园','16','13857236580',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572407031329','戴子尧',0,1,'2011-03-02','颐景园','0','13587079931',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572407092041','顾沅镳',0,1,'2011-06-12','城建','22','13905803805',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572408792015','刘俊彦',0,1,'2013-01-12','熊猫','0','13587070810',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572409289948','金若言',0,1,'2013-11-12','城北','0','13587081002',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572409327930','谢松廷',0,1,'2010-11-19','城北','0','15957066526',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572409358652','孙悦翔',0,1,'2013-12-13','颐景园','0','13575614121',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572410904425','周羿辰',0,1,'2011-12-26','熊猫','0','15924003332',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572410919072','杨承谕',0,1,'2014-01-25','沈家门','0','13567658273',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572410957975','傅韬谕',0,1,'2013-01-19','个人','0','13750714141',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572412511667','王林禄',0,1,'2013-08-23','颐景园','0','13967214975',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572412577872','丁宇菲',0,2,'2013-03-22','颐景园','0','15858072866',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572412580097','俞博涵',0,1,'2010-10-15','一小','0','13867223101',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572414036055','胡轩豪',0,1,'2011-11-06','沈小','0','13967233084',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572414058427','丁宇航',0,1,'2013-03-22','颐景园','0','15858072866',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572414091850','刘珈妤',0,2,'2011-12-18','城北','0','13567665575',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572415664869','施兴海',0,1,'2012-09-05','荷叶湾','0','18368092586',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572417134818','周庄挺',0,1,'2010-11-06','沈家门','23','13957207385',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572417150708','沈子皓',0,1,'2012-04-16','北安','24','15857076512',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572417192129','朱芷萱',0,2,'2010-01-01','四小','0','15168068859',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572419560802','张哲瀚',0,2,'2012-03-30','三盛','0','13867214752',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572420255116','陈沛泽',0,1,'2012-01-04','颐景园','24','18967200386',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572420735322','史祝嘉',0,1,'2012-01-23','熊猫','21','13587076832',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572420869083','倪睿婕',0,2,'2012-05-19','东港','23','15958065966',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572422410000','林  诚',0,1,'2008-11-06','城建','16','13587078393',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572422434277','许博淳',0,1,'2011-11-11','三盛','20','13758005215',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572422457022','胡真闻',0,1,'2012-05-15','','18','13867211231',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572423920685','王舸瑜',0,1,'2005-03-31','沈小','1','13587044200',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572423975574','汪展拓',0,1,'2006-01-16','熊猫','1','13868240925',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572423993761','余佳润',0,1,'2007-04-28','熊猫','1','18957218285',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572425506987','郑鉴原',0,1,'2006-12-05','蓝盾','4','13857209083',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572425522192','高浩力',0,1,'2008-07-22','城建','2','13515805819',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572425587549','娄峻帆',0,1,'2006-03-29','熊猫','1','13868213668',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572427019983','陈玫羽',0,2,'2007-08-31','沈小','4','13857202252',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572427033632','李柏璋',0,1,'2009-03-18','洞洞','7','18606807770',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572427089929','郑文哲',0,1,'2007-06-07','一小','1','13705806835',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572428804339','施翔耀',0,1,'2009-01-26','城建','2','15957059366',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572428836946','洪子然',0,1,'2007-07-30','熊猫','1','13506801869',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572428878277','李晨灏',0,1,'2010-06-29','熊猫','4','13967209004',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572430441673','倪彬哲',0,1,'2008-10-20','沈小','1','13967236398',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572430455863','陆沾锦',0,1,'2005-10-12','一小','0','13675806078',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572430488763','李奕娴',0,2,'2009-11-08','实验','1','13867231209',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572431938294','王羿皓',0,1,'2011-09-20','新城六','18','13575616633',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572431949036','张真豪',0,1,'2010-08-04','沈小','20','18042298650',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572431966403','刘炎松',0,1,'2011-07-24','沈小','20','13515809246',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572433542453','戎柏臻',0,1,'2010-03-01','蓝盾','16','13867233340',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572433581245','刘津源',0,1,'2011-04-15','沈小','9','13082866959',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572433597819','泮政宇',0,1,'2011-03-27','沈小','10','13750711265',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572435017145','何政磊',0,1,'2011-03-01','育华','13','13706808607',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572435041281','虞铮楠',0,1,'2007-07-23','四小','24','13615802673',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294572435075094','周冠辰',0,1,'2011-03-29','普陀小学','20','13656826154',NULL,0,'NORMAL',0,0,'2018-11-23 12:02:04',NULL,0,'NO'),('U154294589386418580','刘骐恺',0,1,'2012-12-18','碧海园','0','13388449009',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:54',NULL,0,'NO'),('U154294589425468145','陈奕天',0,1,'2009-03-30','沈一小','12','13967228143',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:54',NULL,0,'NO'),('U154294589426903902','方柏昊',0,1,'2010-05-01','沈小','20','13567658229',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:54',NULL,0,'NO'),('U154294589426967822','王瑞泽',0,1,'2010-09-09','沈一小','14','13750718384',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:54',NULL,0,'NO'),('U154294589426983919','冯子渝',0,1,'2010-10-24','鲁家','21','15336848517',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:54',NULL,0,'NO'),('U154294589428526099','施博觉',0,1,'2012-02-07','荷叶湾','19','13665818766',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:54',NULL,0,'NO'),('U154294589430032571','刘子立',0,1,'2012-05-03','熊猫','20','13735029706',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:54',NULL,0,'NO'),('U154294589431851292','虞轶涵',0,2,'2012-05-31','熊猫','0','13645805580',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:54',NULL,0,'NO'),('U154294589433429886','沈彥佐',0,1,'2011-03-21','颐景园','23','15958086991',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:54',NULL,0,'NO'),('U154294589433466180','丁韦涵',0,1,'2011-01-02','北安','23','13906802353',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:54',NULL,0,'NO'),('U154294589434957960','吴冠辰',0,1,'2009-09-23','沈小','0','13567685094',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:54',NULL,0,'NO'),('U154294589434974016','刘芮汐',0,1,'2012-07-07','北安','0','18058046700',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:54',NULL,0,'NO'),('U154294589436559081','周煜皓',0,1,'2007-10-22','沈四小','9','13136420905',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:54',NULL,0,'NO'),('U154294589436580859','李涵宸',0,1,'2010-05-03','普陀小学','24','13868208820',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:54',NULL,0,'NO'),('U154294589438040958','张炎凌',0,1,'2010-07-24','蓝盾','17','13867205032',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:54',NULL,0,'NO'),('U154294589438053686','杨雯喧',0,1,'2009-05-27','沈小','23','13705806560',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:54',NULL,0,'NO'),('U154294589439635212','沈柏宇',0,1,'2008-02-02','一小','0','13306803322',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:54',NULL,0,'NO'),('U154294589441213427','牟咨臻',0,2,'2008-01-16','沈小','10','13857215892',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:54',NULL,0,'NO'),('U154294589441266273','张淳皓',0,2,'2012-05-07','三盛','0','13967206906',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:54',NULL,0,'NO'),('U154294589442759771','李林桓',0,1,'2008-06-21','沈小','18','13587051626',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:54',NULL,0,'NO'),('U154294589442764490','杜铭杰',0,1,'2011-08-29','沈小','22','13758029755',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:54',NULL,0,'NO'),('U154294589444320682','朱雨墨',0,1,'2011-05-16','普陀小学','22','13957226563',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:54',NULL,0,'NO'),('U154294589444343933','叶祖延',0,1,'2009-08-05','一小','19','13666705035',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:54',NULL,0,'NO'),('U154294589444370194','徐一然',0,1,'2009-01-01','熊猫','19','13967209974',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:54',NULL,0,'NO'),('U154294589446470995','江晨烁',0,1,'2012-06-28','东港','0','13656803988',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:54',NULL,0,'NO'),('U154294589448020635','林尚轩',0,1,'2012-09-10','和润','0','13750717574',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:54',NULL,0,'NO'),('U154294589448710236','吴谦睿',0,1,'2012-11-20','熊猫','0','13884318290',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:54',NULL,0,'NO'),('U154294589449541957','施童捷',0,1,'2012-03-30','熊猫','23','13857215815',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:54',NULL,0,'NO'),('U154294589450174746','方彦栋',0,1,'2012-01-26','熊猫','0','13655803080',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:55',NULL,0,'NO'),('U154294589452888213','竺帅辰',0,1,'2012-03-06','熊猫','24','13506801383',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:55',NULL,0,'NO'),('U154294589454355598','吴陈熙',0,1,'2012-06-28','熊猫','22','13967214349',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:55',NULL,0,'NO'),('U154294589455915130','杜少璞',0,1,'2012-09-11','熊猫','0','13967206336',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:55',NULL,0,'NO'),('U154294589457522672','潘相予',0,1,'2008-08-31','沈小','9','18058026630',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:55',NULL,0,'NO'),('U154294589459065715','王俊寓',0,1,'2009-12-20','沈小','20','13735018756',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:55',NULL,0,'NO'),('U154294589462350409','徐铭浩',0,2,'2009-10-30','沈小','22','15924039538',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:55',NULL,0,'NO'),('U154294589463512636','徐浩杰',0,1,'2009-10-10','普陀小学','22','13454095956',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:55',NULL,0,'NO'),('U154294589464307378','林宸豪',0,1,'2011-07-02','普陀小学','9','13884303156',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:55',NULL,0,'NO'),('U154294589464480392','黄宣瑜',0,1,'2011-12-31','和津苑','22','18969233098',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:55',NULL,0,'NO'),('U154294589464496329','马语蔚',0,1,'2011-02-20','普小','14','13967206465',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:55',NULL,0,'NO'),('U154294589466004134','郑博予',0,1,'2011-08-29','蓝盾','0','13967216872',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:55',NULL,0,'NO'),('U154294589466069077','顾晨左',0,1,'2012-04-23','实验','0','13857228966',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:55',NULL,0,'NO'),('U154294589467640109','蒋佳辰',0,1,'2012-05-18','实验','0','13506800991',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:55',NULL,0,'NO'),('U154294589467647526','高毓泽',0,1,'2012-05-02','实验','0','13967205990',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:55',NULL,0,'NO'),('U154294589467648552','虞卓骏',0,1,'2012-08-08','实验','0','13867208400',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:55',NULL,0,'NO'),('U154294589469102580','朱珉磊',0,1,'2013-03-11','城建','0','18967238048',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:55',NULL,0,'NO'),('U154294589469159390','张哲毓',0,1,'2012-11-09','北安','0','13857217136',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:55',NULL,0,'NO'),('U154294589470701532','陈舟煜',0,1,'2013-01-24','北安','0','13675806112',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:55',NULL,0,'NO'),('U154294589472229469','陈凯鑫',0,1,'2013-05-09','颐景园','0','13857232488',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:55',NULL,0,'NO'),('U154294589473671050','姜柏丞',0,1,'2010-11-26','沈一小','0','15068007077',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:55',NULL,0,'NO'),('U154294589474330687','虞思贤',0,1,'2012-08-06','城建','0','13857207412',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:55',NULL,0,'NO'),('U154294589475164118','王千亦',0,1,'2012-01-01','城建','0','13306807088',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:55',NULL,0,'NO'),('U154294589475721373','周奕轩',0,1,'2013-03-21','','0','13867221789',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:55',NULL,0,'NO'),('U154294589476836201','张昊聘',0,1,'2013-05-14','沈家门','0','13567655557',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:55',NULL,0,'NO'),('U154294589477328314','卢嘉晨',0,1,'2012-09-20','物资','0','13140849139',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:55',NULL,0,'NO'),('U154294589477372736','虞铠瑄',0,1,'2011-04-01','城建','23','13362805153',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:55',NULL,0,'NO'),('U154294589478963561','吴秉泽',0,1,'2012-06-10','城建','0','13867238881',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:55',NULL,0,'NO'),('U154294589480526118','金彦含',0,1,'2008-07-08','蓝盾','0','13857226558',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:55',NULL,0,'NO'),('U154294589482054801','黄禹哲',0,1,'2008-10-09','沈小','3','13587077711',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:55',NULL,0,'NO'),('U154294589482067841','翁铭泽',0,1,NULL,'','0','',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:55',NULL,0,'NO'),('U154294589484053633','姚沛宜',0,1,NULL,'','0','',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:55',NULL,0,'NO'),('U154294589484860602','',0,2,NULL,'','0','',NULL,0,'NORMAL',0,0,'2018-11-23 12:04:55',NULL,0,'NO'),('U154294589485489135','余昊泽',0,1,NULL,'','0','13506605986',NULL,0,'NORMAL',60,58,'2018-11-23 12:04:55','2018-11-29 17:28:11',1,'NO');

/*Table structure for table `tg_study_student_course_rel` */

DROP TABLE IF EXISTS `tg_study_student_course_rel`;

CREATE TABLE `tg_study_student_course_rel` (
  `id` varchar(64) NOT NULL,
  `course_id` varchar(64) DEFAULT NULL,
  `course_name` varchar(64) DEFAULT NULL,
  `student_id` varchar(64) DEFAULT NULL,
  `student_name` varchar(64) DEFAULT NULL,
  `status` varchar(16) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `classroom_id` varchar(64) DEFAULT NULL,
  `classroom_name` varchar(64) DEFAULT NULL,
  `course_time` varchar(32) DEFAULT NULL,
  `course_week_info` tinyint(2) DEFAULT NULL,
  `teacher_id` varchar(64) DEFAULT NULL,
  `teacher_name` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tg_study_student_course_rel` */

insert  into `tg_study_student_course_rel`(`id`,`course_id`,`course_name`,`student_id`,`student_name`,`status`,`create_time`,`update_time`,`classroom_id`,`classroom_name`,`course_time`,`course_week_info`,`teacher_id`,`teacher_name`) values ('2980383049956','U154287287751332438','周宏斌星期二5','U154294589485489135','余昊泽','NORMAL','2018-11-28 09:33:06',NULL,'U154278944159689965','灵秀一','18:30-20:00',2,'U154278954605976028','周宏斌');

/*Table structure for table `tg_study_system_message` */

DROP TABLE IF EXISTS `tg_study_system_message`;

CREATE TABLE `tg_study_system_message` (
  `id` varchar(64) NOT NULL,
  `message_type` varchar(64) DEFAULT NULL,
  `message_content` varchar(64) DEFAULT NULL,
  `level` int(2) DEFAULT NULL COMMENT '紧急度',
  `is_process` varchar(16) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `process_time` datetime DEFAULT NULL,
  `process_desc` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tg_study_system_message` */

insert  into `tg_study_system_message`(`id`,`message_type`,`message_content`,`level`,`is_process`,`create_time`,`process_time`,`process_desc`) values ('3636829318482','STUDENT_REMAIN_COURSE_NOTE','学生[余昊泽]仅剩余 -1课时!',10,'NO','2018-11-28 09:44:02',NULL,NULL);

/*Table structure for table `tg_study_teacher` */

DROP TABLE IF EXISTS `tg_study_teacher`;

CREATE TABLE `tg_study_teacher` (
  `id` varchar(32) NOT NULL,
  `name` varchar(32) DEFAULT NULL,
  `phone` varchar(64) DEFAULT NULL,
  `level` varchar(16) DEFAULT NULL,
  `status` varchar(16) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tg_study_teacher` */

insert  into `tg_study_teacher`(`id`,`name`,`phone`,`level`,`status`,`create_time`,`update_time`) values ('U154278954605976028','周宏斌','13212345678','业余四段','NORMAL','2018-11-21 16:39:06','2018-11-21 16:39:28'),('U154278956053217488','孙为民','11','业余四段','NORMAL','2018-11-21 16:39:21',NULL),('U154278962301569613','蒋杰','11','业余四段','NORMAL','2018-11-21 16:40:23',NULL),('U154278963512684555','叶开良','11','业余四段','NORMAL','2018-11-21 16:40:35',NULL),('U154278965230025110','张国忠','11','业务四段','NORMAL','2018-11-21 16:40:52',NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
