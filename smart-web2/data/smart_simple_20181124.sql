/*
SQLyog Enterprise v12.08 (64 bit)
MySQL - 5.5.56 : Database - smart_web
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`smart_web` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `smart_web`;

/*Table structure for table `t_c3p0_test` */

DROP TABLE IF EXISTS `t_c3p0_test`;

CREATE TABLE `t_c3p0_test` (
  `a` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_c3p0_test` */

/*Table structure for table `t_create_table` */

DROP TABLE IF EXISTS `t_create_table`;

CREATE TABLE `t_create_table` (
  `id` varchar(50) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `remark` varchar(500) DEFAULT NULL,
  `table_name` varchar(127) NOT NULL,
  `user_id` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_create_table` */

/*Table structure for table `t_create_table_field` */

DROP TABLE IF EXISTS `t_create_table_field`;

CREATE TABLE `t_create_table_field` (
  `id` varchar(50) NOT NULL,
  `data_format` varchar(50) DEFAULT NULL,
  `field_name` varchar(127) NOT NULL,
  `field_remark` varchar(500) DEFAULT NULL,
  `length` varchar(10) DEFAULT NULL,
  `sort_order` int(11) DEFAULT NULL,
  `table_id` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_create_table_field` */

/*Table structure for table `t_flow_attachment` */

DROP TABLE IF EXISTS `t_flow_attachment`;

CREATE TABLE `t_flow_attachment` (
  `id` varchar(50) NOT NULL,
  `att_type` varchar(127) DEFAULT NULL,
  `attachment_id` varchar(50) NOT NULL,
  `form_id` varchar(50) DEFAULT NULL,
  `order_id` varchar(50) DEFAULT NULL,
  `process_id` varchar(50) NOT NULL,
  `task_id` varchar(50) DEFAULT NULL,
  `task_key` varchar(50) DEFAULT NULL,
  `user_id` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_flow_attachment` */

/*Table structure for table `t_flow_form` */

DROP TABLE IF EXISTS `t_flow_form`;

CREATE TABLE `t_flow_form` (
  `id` varchar(50) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `execute_node_num` int(11) NOT NULL,
  `form_data_id` varchar(50) NOT NULL,
  `form_id` varchar(50) NOT NULL,
  `order_id` varchar(50) NOT NULL,
  `org_id` varchar(50) DEFAULT NULL,
  `process_id` varchar(50) NOT NULL,
  `process_name` varchar(255) DEFAULT NULL,
  `progress` float DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `total_node_num` int(11) NOT NULL,
  `user_id` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_flow_form` */

/*Table structure for table `t_flow_page_model` */

DROP TABLE IF EXISTS `t_flow_page_model`;

CREATE TABLE `t_flow_page_model` (
  `id` varchar(50) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `name` varchar(127) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `uri` varchar(127) DEFAULT NULL,
  `user_id` varchar(50) DEFAULT NULL,
  `view_uri` varchar(127) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_flow_page_model` */

/*Table structure for table `t_flow_process` */

DROP TABLE IF EXISTS `t_flow_process`;

CREATE TABLE `t_flow_process` (
  `id` varchar(50) NOT NULL,
  `attachment` varchar(2) DEFAULT NULL,
  `flow_type` varchar(127) DEFAULT NULL,
  `form_id` varchar(50) DEFAULT NULL,
  `node_name_collection` varchar(4000) DEFAULT NULL,
  `org_id` varchar(50) DEFAULT NULL,
  `process_id` varchar(50) DEFAULT NULL,
  `total_node_num` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_flow_process` */

/*Table structure for table `t_form` */

DROP TABLE IF EXISTS `t_form`;

CREATE TABLE `t_form` (
  `id` varchar(50) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `creator` varchar(50) NOT NULL,
  `field_num` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `original_html` longtext,
  `parse_html` longtext,
  `type` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_form` */

/*Table structure for table `t_form_attachment` */

DROP TABLE IF EXISTS `t_form_attachment`;

CREATE TABLE `t_form_attachment` (
  `id` varchar(50) NOT NULL,
  `attachment_id` varchar(50) NOT NULL,
  `create_timestamp` bigint(20) DEFAULT NULL,
  `form_data_id` varchar(50) NOT NULL,
  `form_id` varchar(50) NOT NULL,
  `user_id` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_form_attachment` */

/*Table structure for table `t_form_field` */

DROP TABLE IF EXISTS `t_form_field`;

CREATE TABLE `t_form_field` (
  `id` varchar(50) NOT NULL,
  `flow` varchar(50) DEFAULT NULL,
  `form_id` varchar(50) NOT NULL,
  `is_institle` varchar(10) DEFAULT NULL,
  `is_log` int(11) DEFAULT NULL,
  `plugins` varchar(50) DEFAULT NULL,
  `table_field_id` varchar(50) NOT NULL,
  `table_id` varchar(50) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `type` varchar(126) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_form_field` */

/*Table structure for table `t_form_field_change_log` */

DROP TABLE IF EXISTS `t_form_field_change_log`;

CREATE TABLE `t_form_field_change_log` (
  `id` varchar(50) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `flag` varchar(50) DEFAULT NULL,
  `form_data_id` varchar(50) NOT NULL,
  `form_id` varchar(50) NOT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `source_value` varchar(255) DEFAULT NULL,
  `table_field_id` varchar(50) NOT NULL,
  `user_id` varchar(50) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_form_field_change_log` */

/*Table structure for table `t_form_helper` */

DROP TABLE IF EXISTS `t_form_helper`;

CREATE TABLE `t_form_helper` (
  `id` varchar(50) NOT NULL,
  `content` text,
  `create_time` datetime DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `user_id` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_form_helper` */

/*Table structure for table `t_form_import` */

DROP TABLE IF EXISTS `t_form_import`;

CREATE TABLE `t_form_import` (
  `id` varchar(50) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `field_separator` varchar(50) DEFAULT NULL,
  `form_id` varchar(50) NOT NULL,
  `import_type` varchar(127) NOT NULL,
  `last_update_time` datetime DEFAULT NULL,
  `last_user_id` varchar(50) DEFAULT NULL,
  `start_row` int(11) DEFAULT NULL,
  `table_id` varchar(50) NOT NULL,
  `user_id` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_form_import` */

/*Table structure for table `t_form_import_field` */

DROP TABLE IF EXISTS `t_form_import_field`;

CREATE TABLE `t_form_import_field` (
  `id` varchar(50) NOT NULL,
  `column_index` int(11) DEFAULT NULL,
  `form_import_id` varchar(50) NOT NULL,
  `table_field_id` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_form_import_field` */

/*Table structure for table `t_form_instance` */

DROP TABLE IF EXISTS `t_form_instance`;

CREATE TABLE `t_form_instance` (
  `id` varchar(50) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `form_data_id` varchar(50) NOT NULL,
  `form_id` varchar(50) NOT NULL,
  `org_id` varchar(50) NOT NULL,
  `title` varchar(255) NOT NULL,
  `user_id` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_form_instance` */

/*Table structure for table `t_n_access_log` */

DROP TABLE IF EXISTS `t_n_access_log`;

CREATE TABLE `t_n_access_log` (
  `id` varchar(50) NOT NULL,
  `browser` varchar(127) DEFAULT NULL,
  `browser_version` varchar(127) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `device_type` varchar(127) DEFAULT NULL,
  `ip` varchar(127) DEFAULT NULL,
  `login_id` varchar(50) DEFAULT NULL,
  `os` varchar(127) DEFAULT NULL,
  `param` varchar(500) DEFAULT NULL,
  `request_method` varchar(100) DEFAULT NULL,
  `response_time` datetime DEFAULT NULL,
  `uri` varchar(127) NOT NULL,
  `url` varchar(500) NOT NULL,
  `use_time` bigint(20) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `user_id` varchar(50) DEFAULT NULL,
  `username` varchar(127) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_n_access_log` */

/*Table structure for table `t_n_attachment` */

DROP TABLE IF EXISTS `t_n_attachment`;

CREATE TABLE `t_n_attachment` (
  `id` varchar(50) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `file_size` bigint(20) DEFAULT NULL,
  `file_suffix` varchar(50) DEFAULT NULL,
  `file_type` varchar(1024) DEFAULT NULL,
  `user_id` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_n_attachment` */

/*Table structure for table `t_n_cus_index_min_win` */

DROP TABLE IF EXISTS `t_n_cus_index_min_win`;

CREATE TABLE `t_n_cus_index_min_win` (
  `id` varchar(50) NOT NULL,
  `cus_index_id` varchar(50) NOT NULL,
  `min_win_id` varchar(50) NOT NULL,
  `sort_order` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_n_cus_index_min_win` */

/*Table structure for table `t_n_custom_index` */

DROP TABLE IF EXISTS `t_n_custom_index`;

CREATE TABLE `t_n_custom_index` (
  `id` varchar(50) NOT NULL,
  `cols` int(11) DEFAULT NULL,
  `layout` varchar(255) NOT NULL,
  `rows` int(11) DEFAULT NULL,
  `user_id` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_n_custom_index` */

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

insert  into `t_n_dict`(`id`,`busi_level`,`busi_name`,`busi_value`,`parent_id`,`sort_order`,`state`) values ('D-U143528452115354128',1,'表字段数据类型','TABLE_FIELD_DATA_FORMAT','0',11,1),('D-U143528456250084987',2,'字符串','varchar','D-U143528452115354128',1,1),('D-U143528460847918719',2,'整型','int','D-U143528452115354128',2,1),('D-U143528465248556356',2,'小数','numeric','D-U143528452115354128',3,1),('D-U143528469421736768',2,'日期时间','datetime','D-U143528452115354128',4,1),('D-UU141994787908554209',1,'组织机构类型','ORG_TYPE','0',5,1),('D-UU141994799754738879',2,'公司','company','D-UU141994787908554209',1,1),('D-UU141994802829255042',2,'部门','department','D-UU141994787908554209',2,1),('D-UU142649131272879431',1,'显示状态','VISIBLE_STATE','0',6,1),('D-UU142649132119031154',2,'显示','1','D-UU142649131272879431',1,1),('D-UU142649133056067830',2,'隐藏','0','D-UU142649131272879431',2,1),('D-UU142890921453238272',1,'资源类型','RESOURCE_TYPE','0',7,1),('D-UU142890925241329179',2,'流程菜单资源','flow_resource','D-UU142890921453238272',3,1),('D-UU142890927338225836',2,'表单资源','form_resource','D-UU142890921453238272',2,1),('D-UU142890931093087556',2,'其他资源','other_resource','D-UU142890921453238272',1,1),('D-UU142899881750676264',1,'表单类型','FORM_TYPE','0',8,1),('D-UU142899884488544351',2,'流程表单','flow_form','D-UU142899881750676264',1,1),('D-UU142899901902659586',2,'普通表单','normal_form','D-UU142899881750676264',2,1),('D-UU143066280538891847',1,'是否','YES_OR_NO','0',9,1),('D-UU143066282421563437',2,'是','1','D-UU143066280538891847',1,1),('D-UU143066283457564141',2,'否','0','D-UU143066280538891847',3,1),('D-UU143066288276869806',1,'流程类型','FLOW_TYPE','0',10,1),('D-UU143066293000095099',2,'普通流程','normal_flow','D-UU143066288276869806',1,1),('D-UU143066294971397701',2,'公文流程','office_flow','D-UU143066288276869806',2,1),('D141770362251230637',1,'数据状态','DATA_STATE','0',1,1),('D141770363532239881',2,'有效','1','D141770362251230637',1,1),('D141770364923252290',2,'无效','0','D141770362251230637',2,1),('D141787854035683659',1,'首页布局模板','INDEX_LAYOUT_TEMP','0',3,1),('D141787860820885393',2,'一行一列','l-1-1','D141787854035683659',1,1),('D141787863777042921',2,'一行两列','l-1-2','D141787854035683659',2,1),('D141787866943105931',2,'两行一列','l-2-1','D141787854035683659',3,1),('D141787869379953801',2,'两行两列','l-2-2','D141787854035683659',4,1),('D_U143668337727078367',1,'流程线类型','FLOW_LINE_TYPE','0',12,1),('D_U143668343657740283',2,'正常','normal','D_U143668337727078367',1,1),('D_U143668344965664408',2,'驳回','back','D_U143668337727078367',2,1),('D_U143935698601463174',1,'选择方式','SELECT_STYLE','0',30,1),('D_U143935702783733446',2,'单选','radio','D_U143935698601463174',1,1),('D_U143935703947681541',2,'多选','checkbox','D_U143935698601463174',2,1),('D_U147684954020967859',2,'文本','text','D-U143528452115354128',5,1),('D_U147798209987529948',2,'大文本','longtext','D-U143528452115354128',6,1),('D_U150072105118891605',1,'系统类型','SYS_TYPE','0',31,1),('D_U150072108430946258',2,'内部系统','internal_sys','D_U150072105118891605',1,1),('D_U150072111745594994',2,'外部系统','external_sys','D_U150072105118891605',2,1),('D_U150505689147319379',1,'报表类型','REPORT_TYPE','0',32,1),('D_U150505691852150657',2,'流程报表','flow_report','D_U150505689147319379',1,0),('D_U150505693536168279',2,'普通表单报表','form_report','D_U150505689147319379',2,0),('D_U150505697480974042',2,'其他报表','other_report','D_U150505689147319379',3,0),('D_U150514196143918923',2,'自定义SQL报表','custom_sql_report','D_U150505689147319379',0,1),('D_U150582974016514097',1,'页面打开类型','OPEN_URL_TYPE','0',33,1),('D_U150582986026620497',2,'弹出窗口','popup_win','D_U150582974016514097',1,1),('D_U150582998167066023',2,'新选项卡中打开','cnoj-open-tabs','D_U150582974016514097',2,1),('D_U150583000755452709',2,'当前选项卡中打开','cnoj-open-self','D_U150582974016514097',3,1),('D_U150583013803315345',2,'打开新窗口','_blank','D_U150582974016514097',4,1),('D_U150771101965610026',2,'报表资源','report_resource','D-UU142890921453238272',4,1),('D_U154285367204894559',1,'授课时间','COURSE_TIMES','0',34,1),('D_U154285369346927236',2,'7:30-9:00','1','D_U154285367204894559',1,1),('D_U154285373665568607',2,'9:00-10:30','2','D_U154285367204894559',35,1),('D_U154285375273891463',2,'13:30-15:00','3','D_U154285367204894559',36,1),('D_U154285379350790577',2,'15:30-17:00','4','D_U154285367204894559',37,1),('D_U154285380737356991',2,'18:30-20:00','5','D_U154285367204894559',38,1),('D_U154285636538465892',1,'星期列表','WEEK_INFO_LIST','0',39,1),('D_U154285637786274337',2,'星期一','1','D_U154285636538465892',1,1),('D_U154285639065552152',2,'星期二','2','D_U154285636538465892',40,1),('D_U154285640354285094',2,'星期三','3','D_U154285636538465892',41,1),('D_U154285641632094598',2,'星期四','4','D_U154285636538465892',42,1),('D_U154285642590342963',2,'星期五','5','D_U154285636538465892',43,1),('D_U154285643697439432',2,'星期六','6','D_U154285636538465892',44,1),('D_U154285645487136281',2,'星期天','7','D_U154285636538465892',45,1);

/*Table structure for table `t_n_login_log` */

DROP TABLE IF EXISTS `t_n_login_log`;

CREATE TABLE `t_n_login_log` (
  `id` varchar(50) NOT NULL,
  `browser` varchar(127) DEFAULT NULL,
  `browser_version` varchar(127) DEFAULT NULL,
  `client_screen_height` float DEFAULT NULL,
  `client_screen_width` float DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `device_type` varchar(127) DEFAULT NULL,
  `ip` varchar(50) DEFAULT NULL,
  `login_type` varchar(100) NOT NULL,
  `msg` varchar(255) DEFAULT NULL,
  `os` varchar(127) DEFAULT NULL,
  `resolution` varchar(127) DEFAULT NULL,
  `state` tinyint(1) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `user_id` varchar(50) DEFAULT NULL,
  `username` varchar(127) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_n_login_log` */

insert  into `t_n_login_log`(`id`,`browser`,`browser_version`,`client_screen_height`,`client_screen_width`,`create_time`,`device_type`,`ip`,`login_type`,`msg`,`os`,`resolution`,`state`,`user_agent`,`user_id`,`username`) values ('L_U154224989676913727','Chrome','71.0.3554.0',1080,1920,'2018-11-15 10:44:57','Computer','0:0:0:0:0:0:0:1','normal','验证码输入错误','Windows 7','1920x1080',0,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36',NULL,NULL),('L_U154224990160716310','Chrome','71.0.3554.0',1080,1920,'2018-11-15 10:45:02','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154225042956000702','Chrome','71.0.3554.0',1080,1920,'2018-11-15 10:53:50','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154225048079478546','Chrome','71.0.3554.0',1080,1920,'2018-11-15 10:54:41','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154225202373627850','Chrome','71.0.3554.0',1080,1920,'2018-11-15 11:20:24','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154225216757224790','Chrome','71.0.3554.0',1080,1920,'2018-11-15 11:22:48','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154225234581870079','Chrome','71.0.3554.0',1080,1920,'2018-11-15 11:25:46','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154225248969907387','Chrome','71.0.3554.0',1080,1920,'2018-11-15 11:28:10','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154225251086236977','Chrome','71.0.3554.0',1080,1920,'2018-11-15 11:28:31','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154225268839391525','Chrome','71.0.3554.0',1080,1920,'2018-11-15 11:31:28','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154225440739007118','Chrome','71.0.3554.0',1080,1920,'2018-11-15 12:00:07','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154225456194621108','Chrome','71.0.3554.0',1080,1920,'2018-11-15 12:02:42','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154225885665929088','Chrome','71.0.3554.0',1080,1920,'2018-11-15 13:14:17','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154225943342391150','Chrome','71.0.3554.0',1080,1920,'2018-11-15 13:23:53','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154225948052945330','Chrome','71.0.3554.0',1080,1920,'2018-11-15 13:24:41','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154225962418656795','Chrome','71.0.3554.0',1080,1920,'2018-11-15 13:27:04','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154225995580025063','Chrome','71.0.3554.0',1080,1920,'2018-11-15 13:32:36','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154226025964096412','Chrome','71.0.3554.0',1080,1920,'2018-11-15 13:37:40','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154226141362096314','Chrome','71.0.3554.0',1080,1920,'2018-11-15 13:56:54','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154226149390996823','Chrome','71.0.3554.0',1080,1920,'2018-11-15 13:58:14','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154226164579078299','Chrome','71.0.3554.0',1080,1920,'2018-11-15 14:00:46','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154226211076595515','Chrome','71.0.3554.0',1080,1920,'2018-11-15 14:08:31','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154226258089817504','Chrome','71.0.3554.0',1080,1920,'2018-11-15 14:16:21','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154226297681124490','Chrome','71.0.3554.0',1080,1920,'2018-11-15 14:22:57','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154226340120013588','Chrome','71.0.3554.0',1080,1920,'2018-11-15 14:30:01','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154226374458042980','Chrome','71.0.3554.0',1080,1920,'2018-11-15 14:35:45','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154226393280876043','Chrome','71.0.3554.0',1080,1920,'2018-11-15 14:38:53','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154226509393697088','Chrome','71.0.3554.0',1080,1920,'2018-11-15 14:58:14','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154226528473021208','Chrome','71.0.3554.0',1080,1920,'2018-11-15 15:01:25','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154226535410523722','Chrome','71.0.3554.0',1080,1920,'2018-11-15 15:02:34','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154226657513223956','Chrome','71.0.3554.0',1080,1920,'2018-11-15 15:22:55','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154226699210494413','Chrome','71.0.3554.0',1080,1920,'2018-11-15 15:29:52','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154226865839548882','Chrome','71.0.3554.0',1080,1920,'2018-11-15 15:57:38','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154226897638852050','Chrome','71.0.3554.0',1080,1920,'2018-11-15 16:02:56','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154226963173467937','Chrome','71.0.3554.0',1080,1920,'2018-11-15 16:13:52','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154227071260476297','Chrome','71.0.3554.0',1080,1920,'2018-11-15 16:31:53','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154227247600813988','Chrome','71.0.3554.0',1080,1920,'2018-11-15 17:01:16','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154227261205289040','Chrome','71.0.3554.0',1080,1920,'2018-11-15 17:03:32','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154227266898880441','Chrome','71.0.3554.0',1080,1920,'2018-11-15 17:04:29','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154227275394775164','Chrome','71.0.3554.0',1080,1920,'2018-11-15 17:05:54','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154227411233926196','Chrome','71.0.3554.0',1080,1920,'2018-11-15 17:28:32','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154227467927452930','Chrome','71.0.3554.0',1080,1920,'2018-11-15 17:37:59','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154228634015651526','Chrome','70.0.3538.102',768,1366,'2018-11-15 20:52:20','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U141770099155103287','admin'),('L_U154228782645235075','Chrome','70.0.3538.102',768,1366,'2018-11-15 21:17:06','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U141770099155103287','admin'),('L_U154228797362844960','Chrome','70.0.3538.102',768,1366,'2018-11-15 21:19:33','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U141770099155103287','admin'),('L_U154228978569285383','Chrome','70.0.3538.102',768,1366,'2018-11-15 21:49:45','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U141770099155103287','admin'),('L_U154229071758859480','Chrome','70.0.3538.102',768,1366,'2018-11-15 22:05:17','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U141770099155103287','admin'),('L_U154229166304587632','Chrome','70.0.3538.102',768,1366,'2018-11-15 22:21:03','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U141770099155103287','admin'),('L_U154233146870941762','Chrome','71.0.3554.0',1080,1920,'2018-11-16 09:24:29','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154233251080140262','Chrome','71.0.3554.0',1080,1920,'2018-11-16 09:41:51','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154233445318565605','Chrome','71.0.3554.0',1080,1920,'2018-11-16 10:14:13','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154233472410961728','Chrome','71.0.3554.0',1080,1920,'2018-11-16 10:18:44','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154233500827798504','Chrome','71.0.3554.0',1080,1920,'2018-11-16 10:23:28','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154233681020962843','Chrome','71.0.3554.0',1080,1920,'2018-11-16 10:53:30','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154233786764541813','Chrome','71.0.3554.0',1080,1920,'2018-11-16 11:11:08','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154233843491158458','Chrome','71.0.3554.0',1080,1920,'2018-11-16 11:20:35','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154233945085239490','Chrome','71.0.3554.0',1080,1920,'2018-11-16 11:37:31','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154233963979947076','Chrome','71.0.3554.0',1080,1920,'2018-11-16 11:40:40','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154234007181063930','Chrome','71.0.3554.0',1080,1920,'2018-11-16 11:47:52','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154234085628702065','Chrome','71.0.3554.0',1080,1920,'2018-11-16 12:00:56','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154234130664993849','Chrome','71.0.3554.0',1080,1920,'2018-11-16 12:08:27','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154234133826936427','Chrome','71.0.3554.0',1080,1920,'2018-11-16 12:08:58','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154234468292172373','Chrome','71.0.3554.0',1080,1920,'2018-11-16 13:04:43','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154234523224789639','Chrome','71.0.3554.0',1080,1920,'2018-11-16 13:13:52','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154234576478896508','Chrome','71.0.3554.0',1080,1920,'2018-11-16 13:22:45','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154234614374922186','Chrome','71.0.3554.0',1080,1920,'2018-11-16 13:29:04','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154234863442280565','Chrome','71.0.3554.0',1080,1920,'2018-11-16 14:10:34','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154234883657461221','Chrome','71.0.3554.0',1080,1920,'2018-11-16 14:13:57','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154234984015079013','Chrome','71.0.3554.0',1080,1920,'2018-11-16 14:30:40','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154235418835451253','Chrome','71.0.3554.0',1080,1920,'2018-11-16 15:43:08','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154235480912460651','Chrome','71.0.3554.0',1080,1920,'2018-11-16 15:53:29','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154235568336251798','Chrome','71.0.3554.0',1080,1920,'2018-11-16 16:08:03','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154235574947287801','Chrome','71.0.3554.0',1080,1920,'2018-11-16 16:09:09','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154235650623805965','Chrome','71.0.3554.0',1080,1920,'2018-11-16 16:21:46','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154235661205432904','Chrome','71.0.3554.0',1080,1920,'2018-11-16 16:23:32','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154235731081171309','Chrome','71.0.3554.0',1080,1920,'2018-11-16 16:35:11','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154235820563745119','Chrome','71.0.3554.0',1080,1920,'2018-11-16 16:50:06','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154235890420539876','Chrome','71.0.3554.0',1080,1920,'2018-11-16 17:01:44','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154236256535411705','Chrome','71.0.3554.0',1080,1920,'2018-11-16 18:02:45','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154236286177410085','Chrome','71.0.3554.0',1080,1920,'2018-11-16 18:07:42','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154236304208756489','Chrome','71.0.3554.0',1080,1920,'2018-11-16 18:10:42','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154236448308657988','Chrome','71.0.3554.0',1080,1920,'2018-11-16 18:34:43','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154237145696411245','Chrome','70.0.3538.102',768,1366,'2018-11-16 20:30:56','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U141770099155103287','admin'),('L_U154237192750063803','Chrome','70.0.3538.102',768,1366,'2018-11-16 20:38:47','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U146720855065737398','tg-admin'),('L_U154237195799416806','Chrome','70.0.3538.102',768,1366,'2018-11-16 20:39:17','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U141770099155103287','admin'),('L_U154237233525252788','Chrome','70.0.3538.102',768,1366,'2018-11-16 20:45:35','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154237234667683841','Chrome','70.0.3538.102',768,1366,'2018-11-16 20:45:46','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U141770099155103287','admin'),('L_U154237239464444049','Chrome','70.0.3538.102',768,1366,'2018-11-16 20:46:34','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154237246265216327','Chrome','70.0.3538.102',768,1366,'2018-11-16 20:47:42','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U141770099155103287','admin'),('L_U154237253864043524','Chrome','70.0.3538.102',768,1366,'2018-11-16 20:48:58','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154237272259170140','Chrome','70.0.3538.102',768,1366,'2018-11-16 20:52:02','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154237285106431573','Chrome','70.0.3538.102',768,1366,'2018-11-16 20:54:11','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U141770099155103287','admin'),('L_U154237289857280494','Chrome','70.0.3538.102',768,1366,'2018-11-16 20:54:58','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154237365779938562','Chrome','70.0.3538.102',768,1366,'2018-11-16 21:07:37','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154237384535726186','Chrome','70.0.3538.102',768,1366,'2018-11-16 21:10:45','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154237660575507195','Chrome','70.0.3538.102',768,1366,'2018-11-16 21:56:45','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154238256389433567','Chrome','70.0.3538.102',768,1366,'2018-11-16 23:36:03','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154241872827158065','Chrome','71.0.3554.0',1080,1920,'2018-11-17 09:38:48','Computer','127.0.0.1','normal','用户名或密码输入错误','Windows 7','1920x1080',0,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36',NULL,NULL),('L_U154241873520232662','Chrome','71.0.3554.0',1080,1920,'2018-11-17 09:38:55','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154241930239784756','Chrome','71.0.3554.0',1080,1920,'2018-11-17 09:48:22','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154241985089905844','Chrome','71.0.3554.0',1080,1920,'2018-11-17 09:57:31','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154241998043817909','Chrome','71.0.3554.0',1080,1920,'2018-11-17 09:59:40','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154241998879005571','Chrome','71.0.3554.0',1080,1920,'2018-11-17 09:59:49','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154242022776770449','Chrome','71.0.3554.0',1080,1920,'2018-11-17 10:03:48','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154242074722264178','Chrome','71.0.3554.0',1080,1920,'2018-11-17 10:12:27','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154242375077464874','Chrome','71.0.3554.0',1080,1920,'2018-11-17 11:02:31','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154242485241206243','Chrome','71.0.3554.0',1080,1920,'2018-11-17 11:20:52','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154242505183258688','Chrome','71.0.3554.0',1080,1920,'2018-11-17 11:24:12','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154242596858419962','Chrome','71.0.3554.0',1080,1920,'2018-11-17 11:39:29','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154242610449599738','Chrome','71.0.3554.0',1080,1920,'2018-11-17 11:41:44','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154242635444143627','Chrome','71.0.3554.0',1080,1920,'2018-11-17 11:45:54','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154242706036687502','Chrome','71.0.3554.0',1080,1920,'2018-11-17 11:57:40','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154242707316773618','Chrome','71.0.3554.0',1080,1920,'2018-11-17 11:57:53','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154242727955357381','Chrome','71.0.3554.0',1080,1920,'2018-11-17 12:01:20','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154242730671347051','Chrome','71.0.3554.0',1080,1920,'2018-11-17 12:01:47','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154243871893954412','Chrome','71.0.3554.0',1080,1920,'2018-11-17 15:11:59','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154243918828690961','Chrome','71.0.3554.0',1080,1920,'2018-11-17 15:19:48','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154243919342970442','Chrome','71.0.3554.0',1080,1920,'2018-11-17 15:19:53','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154244107940049537','Chrome','71.0.3554.0',1080,1920,'2018-11-17 15:51:19','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154244165817370817','Chrome','71.0.3554.0',1080,1920,'2018-11-17 16:00:58','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154244234351670980','Chrome','71.0.3554.0',1080,1920,'2018-11-17 16:12:24','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154244484318449078','Chrome','71.0.3554.0',1080,1920,'2018-11-17 16:54:03','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154244594055979540','Chrome','71.0.3554.0',1080,1920,'2018-11-17 17:12:21','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154244609610945258','Chrome','71.0.3554.0',1080,1920,'2018-11-17 17:14:56','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154244664465187263','Chrome','71.0.3554.0',1080,1920,'2018-11-17 17:24:05','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154244795843037780','Chrome','71.0.3554.0',1080,1920,'2018-11-17 17:45:58','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154244822575922081','Chrome','71.0.3554.0',1080,1920,'2018-11-17 17:50:26','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154244931309458581','Chrome','71.0.3554.0',1080,1920,'2018-11-17 18:08:33','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154245094473960889','Chrome','70.0.3538.102',768,1366,'2018-11-17 18:35:44','Computer','0:0:0:0:0:0:0:1','normal','用户名或密码输入错误','Windows 7','1366x768',0,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36',NULL,NULL),('L_U154245094963889450','Chrome','70.0.3538.102',768,1366,'2018-11-17 18:35:49','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154245280212786420','Chrome','70.0.3538.102',768,1366,'2018-11-17 19:06:42','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154245292421575863','Chrome','70.0.3538.102',768,1366,'2018-11-17 19:08:44','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U141770099155103287','admin'),('L_U154245767691490885','Chrome','70.0.3538.102',768,1366,'2018-11-17 20:27:56','Computer','0:0:0:0:0:0:0:1','normal','用户名或密码输入错误','Windows 7','1366x768',0,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36',NULL,NULL),('L_U154245768854360625','Chrome','70.0.3538.102',768,1366,'2018-11-17 20:28:08','Computer','0:0:0:0:0:0:0:1','normal','用户名或密码输入错误','Windows 7','1366x768',0,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36',NULL,NULL),('L_U154245769272009135','Chrome','70.0.3538.102',768,1366,'2018-11-17 20:28:12','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154245938215375646','Chrome','70.0.3538.102',768,1366,'2018-11-17 20:56:22','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154245951360818877','Chrome','70.0.3538.102',768,1366,'2018-11-17 20:58:33','Computer','0:0:0:0:0:0:0:1','normal','用户名或密码输入错误','Windows 7','1366x768',0,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36',NULL,NULL),('L_U154245951902705487','Chrome','70.0.3538.102',768,1366,'2018-11-17 20:58:39','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U141770099155103287','admin'),('L_U154246211132327985','Chrome','70.0.3538.102',768,1366,'2018-11-17 21:41:51','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U141770099155103287','admin'),('L_U154246264308835711','Chrome','70.0.3538.102',768,1366,'2018-11-17 21:50:43','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U141770099155103287','admin'),('L_U154246502655669365','Chrome','70.0.3538.102',768,1366,'2018-11-17 22:30:26','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U141770099155103287','admin'),('L_U154246563429315435','Chrome','70.0.3538.102',768,1366,'2018-11-17 22:40:34','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U141770099155103287','admin'),('L_U154246619615347009','Chrome','70.0.3538.102',768,1366,'2018-11-17 22:49:56','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U141770099155103287','admin'),('L_U154246666022838708','Chrome','70.0.3538.102',768,1366,'2018-11-17 22:57:40','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U141770099155103287','admin'),('L_U154246910110957585','Chrome','70.0.3538.102',768,1366,'2018-11-17 23:38:21','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U141770099155103287','admin'),('L_U154246936208367141','Chrome','70.0.3538.102',768,1366,'2018-11-17 23:42:42','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U141770099155103287','admin'),('L_U154258866098271141','Chrome','71.0.3554.0',1080,1920,'2018-11-19 08:51:01','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154259338659909638','Chrome','71.0.3554.0',1080,1920,'2018-11-19 10:09:47','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154259478569145138','Chrome','71.0.3554.0',1080,1920,'2018-11-19 10:33:06','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154259820985734441','Chrome','71.0.3554.0',1080,1920,'2018-11-19 11:30:10','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154259865727095163','Chrome','71.0.3554.0',1080,1920,'2018-11-19 11:37:37','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154259969000176564','Chrome','71.0.3554.0',1080,1920,'2018-11-19 11:54:50','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154260528047338827','Chrome','71.0.3554.0',1080,1920,'2018-11-19 13:28:00','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154260648158414259','Chrome','71.0.3554.0',1080,1920,'2018-11-19 13:48:02','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154260780863873160','Chrome','71.0.3554.0',1080,1920,'2018-11-19 14:10:09','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154260885363288146','Chrome','71.0.3554.0',1080,1920,'2018-11-19 14:27:34','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154260972321437550','Chrome','71.0.3554.0',1080,1920,'2018-11-19 14:42:03','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154261055128484297','Chrome','71.0.3554.0',1080,1920,'2018-11-19 14:55:51','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154261248067924747','Chrome','71.0.3554.0',1080,1920,'2018-11-19 15:28:01','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154261322388234624','Chrome','71.0.3554.0',1080,1920,'2018-11-19 15:40:24','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154261677618882698','Chrome','71.0.3554.0',1080,1920,'2018-11-19 16:39:36','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154267602360886087','Chrome','71.0.3554.0',1080,1920,'2018-11-20 09:07:04','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154267794209279369','Chrome','71.0.3554.0',1080,1920,'2018-11-20 09:39:02','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154268017117715352','Chrome','71.0.3554.0',1080,1920,'2018-11-20 10:16:11','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154268037916794769','Chrome','71.0.3554.0',1080,1920,'2018-11-20 10:19:39','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154268051805720784','Chrome','71.0.3554.0',1080,1920,'2018-11-20 10:21:58','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154268161266057243','Chrome','71.0.3554.0',1080,1920,'2018-11-20 10:40:13','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154268184585587690','Chrome','71.0.3554.0',1080,1920,'2018-11-20 10:44:06','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154268196544426256','Chrome','71.0.3554.0',1080,1920,'2018-11-20 10:46:05','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154268219720643283','Chrome','71.0.3554.0',1080,1920,'2018-11-20 10:49:57','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154268324185109424','Chrome','71.0.3554.0',1080,1920,'2018-11-20 11:07:22','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154268531374447256','Chrome','71.0.3554.0',1080,1920,'2018-11-20 11:41:54','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154268575813523146','Chrome','71.0.3554.0',1080,1920,'2018-11-20 11:49:18','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154270047334117891','Chrome','71.0.3554.0',1080,1920,'2018-11-20 15:54:33','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154270446433672732','Chrome','71.0.3554.0',1080,1920,'2018-11-20 17:01:04','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154270511679306707','Chrome','71.0.3554.0',1080,1920,'2018-11-20 17:11:57','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154270651082285661','Chrome','71.0.3554.0',1080,1920,'2018-11-20 17:35:11','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154270676839716226','Chrome','71.0.3554.0',1080,1920,'2018-11-20 17:39:28','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154270758301209916','Chrome','71.0.3554.0',1080,1920,'2018-11-20 17:53:03','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154270767759599019','Chrome','71.0.3554.0',1080,1920,'2018-11-20 17:54:38','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154271425884392040','Chrome','70.0.3538.102',768,1366,'2018-11-20 19:44:18','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U141770099155103287','admin'),('L_U154271998244333081','Chrome','70.0.3538.102',768,1366,'2018-11-20 21:19:42','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U141770099155103287','admin'),('L_U154272053904637054','Chrome','70.0.3538.102',768,1366,'2018-11-20 21:28:59','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U141770099155103287','admin'),('L_U154272188178534883','Chrome','70.0.3538.102',768,1366,'2018-11-20 21:51:21','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U141770099155103287','admin'),('L_U154272248058985411','Chrome','70.0.3538.102',768,1366,'2018-11-20 22:01:20','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U141770099155103287','admin'),('L_U154272347260501682','Chrome','70.0.3538.102',768,1366,'2018-11-20 22:17:52','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U141770099155103287','admin'),('L_U154276181597275753','Chrome','71.0.3554.0',1080,1920,'2018-11-21 08:56:56','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154276273682758455','Chrome','71.0.3554.0',1080,1920,'2018-11-21 09:12:17','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154276632649508726','Chrome','71.0.3554.0',1080,1920,'2018-11-21 10:12:06','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154276713085162900','Chrome','71.0.3554.0',1080,1920,'2018-11-21 10:25:31','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154276846510142833','Chrome','71.0.3554.0',1080,1920,'2018-11-21 10:47:45','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154276999625865724','Chrome','71.0.3554.0',1080,1920,'2018-11-21 11:13:16','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154277111481203992','Chrome','71.0.3554.0',1080,1920,'2018-11-21 11:31:55','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154277131042063673','Chrome','71.0.3554.0',1080,1920,'2018-11-21 11:35:10','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154277151495566690','Chrome','71.0.3554.0',1080,1920,'2018-11-21 11:38:35','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154277976843609744','Chrome','71.0.3554.0',1080,1920,'2018-11-21 13:56:08','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154277984707464122','Chrome','71.0.3554.0',1080,1920,'2018-11-21 13:57:27','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154278058311881582','Chrome','71.0.3554.0',1080,1920,'2018-11-21 14:09:43','Computer','127.0.0.1','normal','用户名或密码输入错误','Windows 7','1920x1080',0,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36',NULL,NULL),('L_U154278058870153520','Chrome','71.0.3554.0',1080,1920,'2018-11-21 14:09:49','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154278069071405050','Chrome','71.0.3554.0',1080,1920,'2018-11-21 14:11:31','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154278199371092092','Chrome','71.0.3554.0',1080,1920,'2018-11-21 14:33:14','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154278251575956592','Chrome','71.0.3554.0',1080,1920,'2018-11-21 14:41:56','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154278260882006514','Chrome','71.0.3554.0',1080,1920,'2018-11-21 14:43:29','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154278289107884892','Chrome','71.0.3554.0',1080,1920,'2018-11-21 14:48:11','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154278296585377076','Chrome','71.0.3554.0',1080,1920,'2018-11-21 14:49:26','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154278318561575554','Chrome','71.0.3554.0',1080,1920,'2018-11-21 14:53:06','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154278320341095067','Chrome','71.0.3554.0',1080,1920,'2018-11-21 14:53:23','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154278327761587054','Chrome','71.0.3554.0',1080,1920,'2018-11-21 14:54:38','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154278351931749814','Chrome','71.0.3554.0',1080,1920,'2018-11-21 14:58:39','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154278470795876050','Chrome','71.0.3554.0',1080,1920,'2018-11-21 15:18:28','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154278476380338680','Chrome','71.0.3554.0',1080,1920,'2018-11-21 15:19:24','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154278502378683681','Chrome','71.0.3554.0',1080,1920,'2018-11-21 15:23:44','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154278800900711884','Chrome','71.0.3554.0',1080,1920,'2018-11-21 16:13:29','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154278826427144750','Chrome','71.0.3554.0',1080,1920,'2018-11-21 16:17:44','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154278839670346228','Chrome','71.0.3554.0',1080,1920,'2018-11-21 16:19:57','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154278921149879882','Chrome','71.0.3554.0',1080,1920,'2018-11-21 16:33:31','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154279038268801509','Chrome','71.0.3554.0',1080,1920,'2018-11-21 16:53:03','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154285289042029406','Chrome','71.0.3554.0',1080,1920,'2018-11-22 10:14:50','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154285502239870128','Chrome','71.0.3554.0',1080,1920,'2018-11-22 10:50:22','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154285547404150075','Chrome','71.0.3554.0',1080,1920,'2018-11-22 10:57:54','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154285563838420989','Chrome','71.0.3554.0',1080,1920,'2018-11-22 11:00:38','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154285634068177801','Chrome','71.0.3554.0',1080,1920,'2018-11-22 11:12:21','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154285827698008066','Chrome','71.0.3554.0',1080,1920,'2018-11-22 11:44:37','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154285828221744947','Chrome','71.0.3554.0',1080,1920,'2018-11-22 11:44:42','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154285849830268470','Chrome','71.0.3554.0',1080,1920,'2018-11-22 11:48:18','Computer','127.0.0.1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154286243576470837','Chrome','70.0.3538.102',768,1366,'2018-11-22 12:53:55','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154286362887594004','Chrome','70.0.3538.102',768,1366,'2018-11-22 13:13:48','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154296737433400625','Chrome','70.0.3538.102',768,1366,'2018-11-23 18:02:54','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154297055782681494','Chrome','70.0.3538.102',768,1366,'2018-11-23 18:55:57','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154297347140156955','Chrome','70.0.3538.102',768,1366,'2018-11-23 19:44:31','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154297598739300343','Chrome','70.0.3538.102',768,1366,'2018-11-23 20:26:27','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154298161459442197','Chrome','70.0.3538.102',768,1366,'2018-11-23 22:00:14','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154298268363719704','Chrome','70.0.3538.102',768,1366,'2018-11-23 22:18:03','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154304834540301240','Chrome','70.0.3538.102',768,1366,'2018-11-24 16:32:25','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154305366571218405','Chrome','70.0.3538.102',768,1366,'2018-11-24 18:01:05','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U_U154237223000479222','tg-admin'),('L_U154305453486102631','Chrome','70.0.3538.102',768,1366,'2018-11-24 18:15:34','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U_U154237223000479222','tg-admin');

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

insert  into `t_n_menu`(`id`,`icon`,`name`,`parent_id`,`resource_id`,`sort_order`,`state`) values ('M-U143386498490644858','','我的办公','','',15,1),('M-U143386499780007244','','我的待办','M-U143386498490644858','U143386875037004503',1,1),('M-U143386502139997938','','我的已办','M-U143386498490644858','U143891863167559700',2,1),('M-U143437637668627416','','流程实例管理','M-UU142674907787008431','U143437634716263470',5,1),('M-UU142493393340566190','','系统管理','0','',10,1),('M-UU142493393345840632','','菜单管理','M-UU142502912450567699','UU142493393303513551',2,1),('M-UU142493393345982202','','资源管理','M-UU142502912450567699','UU142493393323156274',1,1),('M-UU142502856650696782','','数据字典管理','M-UU142502912450567699','UU142494155606818866',3,1),('M-UU142502912450567699','','基础信息管理','M-UU142493393340566190','',4,1),('M-UU142508562386146072','','角色管理','M-UU142508565901356613','UU142494261976460581',5,1),('M-UU142508565901356613','','系统权限管理','M-UU142493393340566190','',6,1),('M-UU142508575818005410','','操作权限管理','M-UU142502912450567699','UU142494269829079292',6,1),('M-UU142508577364831096','','用户管理','M-UU142502912450567699','UU142494266546995694',7,1),('M-UU142508579506696266','','权限管理','M-UU142508565901356613','UU142494288694979665',6,1),('M-UU142508581582421400','','组织机构管理','M-UU142502912450567699','UU142494281162643857',8,1),('M-UU142508582672975095','','职位管理','M-UU142502912450567699','UU142494285272420160',9,1),('M-UU142508584581052708','','个人设置管理','M-UU142502912450567699','UU142494292374313391',10,0),('M-UU142508632307077913','','测试菜单','0','',11,1),('M-UU142509266596498359','','表单测试页面','M-UU142508632307077913','UU142508630396009472',1,1),('M-UU142536825033474422','','权限测试页面','M-UU142508632307077913','UU142536804561674717',2,1),('M-UU142537020883891213','','jqGrid测试页面','M-UU142508632307077913','UU142537018725515068',3,1),('M-UU142614435382531564','glyphicon-film','测试菜单1238','M-UU142508632307077913','UU142536483130282094',4,1),('M-UU142623915330541216','','小窗口管理','M-UU142502912450567699','UU142623880634351320',11,0),('M-UU142648905947706614','','上传文件','M-UU142508632307077913','UU142648904341707233',5,1),('M-UU142674907787008431','','流程管理','','',12,1),('M-UU142674914090993592','','流程设计器','M-UU142674907787008431','UU142674912100115069',1,1),('M-UU142725965216133778','','流程页面模版','M-UU142674907787008431','UU142725947101781158',2,1),('M-UU142726297434397142','','表单管理','','',13,1),('M-UU142726773386586759','','表单设计器','M-UU142726297434397142','UU142726304175200513',1,1),('M-UU142865516785678977','','流程列表','M-UU142674907787008431','UU142865507367695503',3,1),('M-UU142891059112535159','','流程菜单资源管理','M-UU142674907787008431','UU142891052568659983',4,1),('M-UU143065549041483387','','表单列表','M-UU142726297434397142','UU143065539369030702',2,1),('M-UU143148104616493973','','测试流程','','',14,1),('M_U143617405773277013','','表管理','M-UU142726297434397142','U143617398234893404',3,1),('M_U146772887866360899','','测试流程1','M-UU143148104616493973','U146772885528409688',5,1),('M_U147417441609808442','','测试jquery方法','M-UU142508632307077913','U147417439880357008',7,1),('M_U147522765545394886','','测试表单1','M-UU142508632307077913','U147522762933583369',8,1),('M_U147563798223468130','','版本管理','M-UU142493393340566190','U147563795975505594',7,1),('M_U147686536145550268','','表单帮助信息管理','M-UU142726297434397142','U147686532906967243',4,1),('M_U148248006315688612','','子系统管理','M-UU142493393340566190','U148248001874056364',8,1),('M_U148765649968126029','','自定义列列表','M-UU142508632307077913','U148765647626620413',9,1),('M_U148774379154981169','','测试异步列表树','M-UU142508632307077913','U148774376819175947',10,1),('M_U149542930364019298','','请假条件判断测试','M-UU143148104616493973','U149542927908493158',6,1),('M_U150107942410202851','','表单资源管理','M-UU142726297434397142','U150107939436631363',5,1),('M_U150271305138806638','','测试表单','','',16,1),('M_U150271311055026835','','测试单独表单1','M_U150271305138806638','U150108134134573562',1,1),('M_U150419026910267250','','表单实例','M-UU142726297434397142','U150419023701932892',6,1),('M_U150505743154581563','','报表管理','','',17,1),('M_U150505744589936513','','简单报表设计','M_U150505743154581563','U150505741534899631',1,1),('M_U150523152985112535','','测试单独表单2','M_U150271305138806638','U150523150955702051',2,1),('M_U150609787532592249','','报表管理列表','M_U150505743154581563','U150609785810770279',2,1),('M_U150773702650901782','','报表资源管理','M_U150505743154581563','U150773698819847933',3,1),('M_U150773725051970620','','测试简单报表','','',18,1),('M_U150773726492879051','','测试简单报表1','M_U150773725051970620','U150773721860798909',1,1),('M_U150894689375830371','','SQL资源管理','','',19,1),('M_U150894690539658983','','SQL资源管理列表','M_U150894689375830371','U150894686421341181',1,1),('M_U154225004073616144','','校务管理','','',20,1),('M_U154225007149324418','','校区管理','M_U154237158480128046','U154225067366985402',1,1),('M_U154226493530106359','','教师信息','M_U154237158480128046','U154226490927926250',21,1),('M_U154226856686813620','','教室信息','M_U154237158480128046','U154226854575116662',22,1),('M_U154227254133036595','','班级信息','M_U154237158480128046','U154227251858798941',24,1),('M_U154228787322754855','','学生信息','M_U154237158480128046','U154228785560711973',23,1),('M_U154233259511310918','','课程表管理','M_U154225004073616144','U154233255974582635',25,1),('M_U154237158480128046','','信息管理','','',28,1),('M_U154237249973265102','','课时管理','M_U154225004073616144','U154237151730283760',29,1),('M_U154272178887659993','','消息通知','M_U154225004073616144','U154272176054572296',30,1);

/*Table structure for table `t_n_min_window` */

DROP TABLE IF EXISTS `t_n_min_window`;

CREATE TABLE `t_n_min_window` (
  `id` varchar(50) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `height` varchar(10) DEFAULT NULL,
  `is_show_title` int(11) DEFAULT NULL,
  `more_uri` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `sort_order` double DEFAULT NULL,
  `state` varchar(2) DEFAULT NULL,
  `uri` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_n_min_window` */

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

/*Table structure for table `t_n_org` */

DROP TABLE IF EXISTS `t_n_org`;

CREATE TABLE `t_n_org` (
  `id` varchar(32) NOT NULL,
  `code` varchar(32) DEFAULT NULL,
  `name` varchar(64) DEFAULT NULL,
  `parent_id` varchar(32) NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `contact_number` varchar(50) DEFAULT NULL,
  `contacts` varchar(50) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `seq_names` varchar(1000) DEFAULT NULL,
  `seq_parent_ids` varchar(1000) DEFAULT NULL,
  `sort_order` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_n_org` */

insert  into `t_n_org`(`id`,`code`,`name`,`parent_id`,`type`,`contact_number`,`contacts`,`create_time`,`seq_names`,`seq_parent_ids`,`sort_order`) values ('ORG_U143919519043844770','zs_go_001','舟山围棋协会','0','company','','','2015-08-10 16:26:30','舟山围棋协会','null.ORG_U143919516611919370.',1),('ORG_U154237217148182457','tg_go_001_01','灵秀街分部','ORG_U143919519043844770','department','','','2018-11-16 20:42:51','舟山围棋协会>灵秀街分部','null.ORG_U143919516611919370.ORG_U143919519043844770.',1);

/*Table structure for table `t_n_position` */

DROP TABLE IF EXISTS `t_n_position`;

CREATE TABLE `t_n_position` (
  `id` varchar(50) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `org_id` varchar(50) NOT NULL,
  `seq_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_n_position` */

/*Table structure for table `t_n_push_msg_log` */

DROP TABLE IF EXISTS `t_n_push_msg_log`;

CREATE TABLE `t_n_push_msg_log` (
  `id` varchar(50) NOT NULL,
  `content` varchar(1024) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `msg_type` varchar(100) NOT NULL,
  `sender` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_n_push_msg_log` */

/*Table structure for table `t_n_push_msg_read_log` */

DROP TABLE IF EXISTS `t_n_push_msg_read_log`;

CREATE TABLE `t_n_push_msg_read_log` (
  `id` varchar(50) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `msg_id` varchar(50) NOT NULL,
  `msg_receive_id` varchar(50) NOT NULL,
  `user_id` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_n_push_msg_read_log` */

/*Table structure for table `t_n_push_msg_receiver` */

DROP TABLE IF EXISTS `t_n_push_msg_receiver`;

CREATE TABLE `t_n_push_msg_receiver` (
  `id` varchar(50) NOT NULL,
  `is_all` tinyint(1) DEFAULT NULL,
  `msg_id` varchar(50) NOT NULL,
  `receiver` varchar(50) DEFAULT NULL,
  `receiver_type` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_n_push_msg_receiver` */

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

insert  into `t_n_role_menu`(`id`,`menu_id`,`role_id`) values ('RM-U154242006298129054','M-UU142648905947706614','R141770099156750308'),('RM-U154242006298200268','M-UU142725965216133778','R141770099156750308'),('RM-U154242006298219513','M_U150609787532592249','R141770099156750308'),('RM-U154242006298225238','M-UU143065549041483387','R141770099156750308'),('RM-U154242006298225293','M-UU142508577364831096','R141770099156750308'),('RM-U154242006298267008','M-U143386499780007244','R141770099156750308'),('RM-U154242006298267260','M_U154237158480128046','R141770099156750308'),('RM-U154242006298274608','M-UU142508565901356613','R141770099156750308'),('RM-U154242006298283100','M_U147417441609808442','R141770099156750308'),('RM-U154242006298284205','M_U154226856686813620','R141770099156750308'),('RM-U154242006298286919','M-UU142502912450567699','R141770099156750308'),('RM-U154242006298288531','M_U148774379154981169','R141770099156750308'),('RM-U154242006298294139','M_U143617405773277013','R141770099156750308'),('RM-U154242006298294517','M-UU142674907787008431','R141770099156750308'),('RM-U154242006298299263','M_U150271311055026835','R141770099156750308'),('RM-U154242006298324337','M-UU142674914090993592','R141770099156750308'),('RM-U154242006298407327','M_U149542930364019298','R141770099156750308'),('RM-U154242006298412942','M-UU143148104616493973','R141770099156750308'),('RM-U154242006298413534','M_U147563798223468130','R141770099156750308'),('RM-U154242006298414260','M_U150505744589936513','R141770099156750308'),('RM-U154242006298416870','M-UU142508579506696266','R141770099156750308'),('RM-U154242006298421994','M-UU142508562386146072','R141770099156750308'),('RM-U154242006298436004','M-UU142537020883891213','R141770099156750308'),('RM-U154242006298439479','M_U154225007149324418','R141770099156750308'),('RM-U154242006298461953','M_U150419026910267250','R141770099156750308'),('RM-U154242006298465779','M_U150107942410202851','R141770099156750308'),('RM-U154242006298477056','M_U150894689375830371','R141770099156750308'),('RM-U154242006298485956','M_U154233259511310918','R141770099156750308'),('RM-U154242006298499004','M-UU142614435382531564','R141770099156750308'),('RM-U154242006298499213','M-UU142493393345982202','R141770099156750308'),('RM-U154242006298501129','M_U150505743154581563','R141770099156750308'),('RM-U154242006298506062','M_U146772887866360899','R141770099156750308'),('RM-U154242006298510013','M-U143437637668627416','R141770099156750308'),('RM-U154242006298511744','M_U154226493530106359','R141770099156750308'),('RM-U154242006298512045','M-UU142726297434397142','R141770099156750308'),('RM-U154242006298513873','M-UU142536825033474422','R141770099156750308'),('RM-U154242006298537261','M_U154228787322754855','R141770099156750308'),('RM-U154242006298541028','M_U150523152985112535','R141770099156750308'),('RM-U154242006298548857','M_U148765649968126029','R141770099156750308'),('RM-U154242006298549427','M-UU142726773386586759','R141770099156750308'),('RM-U154242006298550658','M-UU142508575818005410','R141770099156750308'),('RM-U154242006298557111','M_U154227254133036595','R141770099156750308'),('RM-U154242006298567024','M-UU142509266596498359','R141770099156750308'),('RM-U154242006298575604','M_U154225004073616144','R141770099156750308'),('RM-U154242006298590993','M-U143386498490644858','R141770099156750308'),('RM-U154242006298592998','M-UU142623915330541216','R141770099156750308'),('RM-U154242006298594249','M_U150773702650901782','R141770099156750308'),('RM-U154242006298595926','M-UU142508584581052708','R141770099156750308'),('RM-U154242006298599946','M_U150271305138806638','R141770099156750308'),('RM-U154242006298600651','M_U150773726492879051','R141770099156750308'),('RM-U154242006298606253','M_U150894690539658983','R141770099156750308'),('RM-U154242006298617008','M-UU142891059112535159','R141770099156750308'),('RM-U154242006298627446','M_U147686536145550268','R141770099156750308'),('RM-U154242006298629822','M_U150773725051970620','R141770099156750308'),('RM-U154242006298635617','M-UU142502856650696782','R141770099156750308'),('RM-U154242006298635995','M-UU142493393340566190','R141770099156750308'),('RM-U154242006298638069','M_U148248006315688612','R141770099156750308'),('RM-U154242006298653049','M-UU142508632307077913','R141770099156750308'),('RM-U154242006298654389','M-UU142865516785678977','R141770099156750308'),('RM-U154242006298656150','M-UU142508582672975095','R141770099156750308'),('RM-U154242006298665586','M-UU142493393345840632','R141770099156750308'),('RM-U154242006298681128','M-U143386502139997938','R141770099156750308'),('RM-U154242006298690891','M_U147522765545394886','R141770099156750308'),('RM-U154242006298692929','M-UU142508581582421400','R141770099156750308'),('RM-U154268080352207260','M_U154237249973265102','R141770099156750308'),('RM-U154272178890313818','M_U154272178887659993','R141770099156750308'),('RM-U154276255292806698','M_U154228787322754855','R-UU141994583098704113'),('RM-U154276255292834146','M_U154225004073616144','R-UU141994583098704113'),('RM-U154276255292849120','M_U154237249973265102','R-UU141994583098704113'),('RM-U154276255292865687','M_U154225007149324418','R-UU141994583098704113'),('RM-U154276255292897551','M_U154226493530106359','R-UU141994583098704113'),('RM-U154276255292922259','M_U154227254133036595','R-UU141994583098704113'),('RM-U154276255292942249','M_U154233259511310918','R-UU141994583098704113'),('RM-U154276255292943793','M_U154226856686813620','R-UU141994583098704113'),('RM-U154276255292961173','M_U154272178887659993','R-UU141994583098704113'),('RM-U154276255292982808','M_U154237158480128046','R-UU141994583098704113'),('RM-U154276265010168065','M_U154225004073616144','R-UU142509589602782910'),('RM-U154276265010185420','M-U143386498490644858','R-UU142509589602782910'),('RM-U154276265010215387','M-U143386502139997938','R-UU142509589602782910'),('RM-U154276265010251257','M_U154237249973265102','R-UU142509589602782910'),('RM-U154276265010260639','M_U154228787322754855','R-UU142509589602782910'),('RM-U154276265010277300','M-UU142508632307077913','R-UU142509589602782910'),('RM-U154276265010304416','M_U154227254133036595','R-UU142509589602782910'),('RM-U154276265010316832','M_U146772887866360899','R-UU142509589602782910'),('RM-U154276265010317889','M_U154237158480128046','R-UU142509589602782910'),('RM-U154276265010355753','M-UU143148104616493973','R-UU142509589602782910'),('RM-U154276265010386656','M-U143386499780007244','R-UU142509589602782910'),('RM-U154276265010399414','M-UU142509266596498359','R-UU142509589602782910');

/*Table structure for table `t_n_role_org` */

DROP TABLE IF EXISTS `t_n_role_org`;

CREATE TABLE `t_n_role_org` (
  `id` varchar(32) NOT NULL,
  `org_id` varchar(32) NOT NULL,
  `role_id` varchar(32) NOT NULL,
  `flag` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_n_role_org` */

insert  into `t_n_role_org`(`id`,`org_id`,`role_id`,`flag`) values ('141770099158434195','ORG141770098906478558','R141770099156750308','role'),('U143807026267420415','ORG_U143781444238608701','R141770099156750308','role'),('U143807026267503592','ORG_U143781429264856739','R141770099156750308','role'),('U143807026267508815','ORG_U143781424491515835','R141770099156750308','role'),('U143807026267587371','ORG_U143781427094033322','R141770099156750308','role'),('U143807026267622959','ORG_U143781436872880188','R141770099156750308','role'),('U143807026267653121','ORG_U143781439299536938','R141770099156750308','role'),('U143807026267661115','ORG_U143781418633095546','R141770099156750308','role'),('U143807026267673388','ORG_U143781434542612938','R141770099156750308','role'),('U143807026267755919','ORG_U143781376781766946','R141770099156750308','role'),('U143807026267812879','ORG_U143806590727689343','R141770099156750308','role'),('U143807026267826310','ORG_U143781441944628562','R141770099156750308','role'),('U143807026267848318','ORG_U143806582943509071','R141770099156750308','role'),('U143807026267856307','ORG_U143781379596867277','R141770099156750308','role'),('U143807026267910395','ORG_U143806592742875610','R141770099156750308','role'),('U143807026267912181','ORG_U143806588133596408','R141770099156750308','role'),('U143807026267949995','ORG_U143781372488726933','R141770099156750308','role'),('U143807026267984116','ORG_U143781370113972594','R141770099156750308','role'),('U143807026268001090','ORG_U143806595541436748','R141770099156750308','role'),('U143807026268033019','ORG_U143806599978100313','R141770099156750308','role'),('U143807026268054695','ORG_U143806597929193485','R141770099156750308','role'),('U146720873624562288','ORG_U143919516611919370','R141770099156750308','role'),('U146720873624670988','ORG_U143919519043844770','R141770099156750308','role'),('U146720873624688867','ORG_U143919525899571244','R141770099156750308','role'),('U146773102521073480','ORG_U146773102513694776','R141770099156750308','role'),('U146773105683480241','ORG_U146773105679787136','R141770099156750308','role'),('U146773108457347567','ORG_U146773108453453069','R141770099156750308','role'),('U146773154286827766','ORG_U146773105679787136','R-UU142509589602782910','role'),('U146773154286839356','ORG_U146773108453453069','R-UU142509589602782910','role'),('U146773154286990654','ORG_U143919525899571244','R-UU142509589602782910','role'),('U146773224504704114','ORG_U143919525899571244','R-UU142509589602782910','org'),('U146773225459064319','ORG_U146773105679787136','R-UU142509589602782910','org'),('U146773225953631565','ORG_U146773108453453069','R-UU142509589602782910','org'),('U148932427595869398','ORG_U143919516611919370','R-UU141994583098704113','role'),('U150485511090150548','ORG_U143919516611919370','R-UU142509589602782910','role'),('U154237217162567371','ORG_U154237217148182457','R141770099156750308','role'),('UU142485560013316363','ORG-UU142070879569950627','R141770099156750308','role'),('UU142485560013370812','ORG-UU142001300832233005','R141770099156750308','role'),('UU142485560013449781','ORG-UU142070100547125784','R141770099156750308','role'),('UU142485560013460108','ORG-UU142001326526339899','R141770099156750308','role'),('UU142485560013463120','ORG-UU142001293948308437','R141770099156750308','role'),('UU142485560013490658','ORG-UU142001312205127213','R141770099156750308','role'),('UU142485560013508213','ORG-UU142001319768851387','R141770099156750308','role'),('UU142485560013523221','ORG-UU142001331342114761','R141770099156750308','role'),('UU142485560013646608','ORG-UU142001333744500857','R141770099156750308','role');

/*Table structure for table `t_n_role_position` */

DROP TABLE IF EXISTS `t_n_role_position`;

CREATE TABLE `t_n_role_position` (
  `id` varchar(50) NOT NULL,
  `position_id` varchar(50) NOT NULL,
  `role_id` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_n_role_position` */

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

/*Table structure for table `t_n_sql_resource` */

DROP TABLE IF EXISTS `t_n_sql_resource`;

CREATE TABLE `t_n_sql_resource` (
  `id` varchar(50) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `descr` varchar(255) NOT NULL,
  `is_filter` tinyint(1) NOT NULL,
  `last_modify_time` datetime DEFAULT NULL,
  `last_user_id` varchar(50) DEFAULT NULL,
  `res_name` varchar(127) NOT NULL,
  `sql_` varchar(1024) NOT NULL,
  `user_id` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_n_sql_resource` */

/*Table structure for table `t_n_sub_system` */

DROP TABLE IF EXISTS `t_n_sub_system`;

CREATE TABLE `t_n_sub_system` (
  `id` varchar(50) NOT NULL,
  `create_time` datetime NOT NULL,
  `icon` varchar(100) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `sort_order` int(11) NOT NULL,
  `state` varchar(2) NOT NULL,
  `sys_type` varchar(127) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `user_id` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_n_sub_system` */

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

/*Table structure for table `t_n_user_set_menu` */

DROP TABLE IF EXISTS `t_n_user_set_menu`;

CREATE TABLE `t_n_user_set_menu` (
  `id` varchar(50) NOT NULL,
  `name` varchar(255) NOT NULL,
  `sort_order` double DEFAULT NULL,
  `state` varchar(2) DEFAULT NULL,
  `uri` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_n_user_set_menu` */

/*Table structure for table `t_n_version` */

DROP TABLE IF EXISTS `t_n_version`;

CREATE TABLE `t_n_version` (
  `id` varchar(50) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `descr` varchar(4000) DEFAULT NULL,
  `num_version` bigint(20) DEFAULT NULL,
  `type_` varchar(50) NOT NULL,
  `update_date` varchar(20) DEFAULT NULL,
  `user_id` varchar(50) NOT NULL,
  `version_` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_n_version` */

/*Table structure for table `t_report` */

DROP TABLE IF EXISTS `t_report`;

CREATE TABLE `t_report` (
  `id` varchar(50) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `type` varchar(127) NOT NULL,
  `user_id` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_report` */

/*Table structure for table `t_report_field` */

DROP TABLE IF EXISTS `t_report_field`;

CREATE TABLE `t_report_field` (
  `id` varchar(50) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `custom_class` varchar(255) DEFAULT NULL,
  `open_url_type` varchar(127) DEFAULT NULL,
  `param_name` varchar(255) DEFAULT NULL,
  `param_value` varchar(127) DEFAULT NULL,
  `report_id` varchar(50) NOT NULL,
  `search_name` varchar(127) DEFAULT NULL,
  `sort_order` int(11) DEFAULT NULL,
  `title` varchar(127) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `width` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_report_field` */

/*Table structure for table `t_report_properties` */

DROP TABLE IF EXISTS `t_report_properties`;

CREATE TABLE `t_report_properties` (
  `id` varchar(50) NOT NULL,
  `is_checkbox` int(11) DEFAULT NULL,
  `is_fixed_header` int(11) DEFAULT NULL,
  `is_has_id` int(11) DEFAULT NULL,
  `is_import` int(11) DEFAULT NULL,
  `is_show_id` int(11) DEFAULT NULL,
  `report_id` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_report_properties` */

/*Table structure for table `t_report_sql_resource` */

DROP TABLE IF EXISTS `t_report_sql_resource`;

CREATE TABLE `t_report_sql_resource` (
  `id` varchar(50) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `is_filter` int(11) DEFAULT NULL,
  `name` varchar(127) NOT NULL,
  `report_id` varchar(50) NOT NULL,
  `sql_` varchar(4000) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_8fco6q6cytflnss8nf0u6ob1l` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_report_sql_resource` */

/*Table structure for table `t_wf_cc_order` */

DROP TABLE IF EXISTS `t_wf_cc_order`;

CREATE TABLE `t_wf_cc_order` (
  `order_id` varchar(32) NOT NULL,
  `actor_id` varchar(32) NOT NULL,
  `creator` varchar(50) DEFAULT NULL,
  `create_time` varchar(50) DEFAULT NULL,
  `finish_time` varchar(50) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`order_id`,`actor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_wf_cc_order` */

/*Table structure for table `t_wf_hist_order` */

DROP TABLE IF EXISTS `t_wf_hist_order`;

CREATE TABLE `t_wf_hist_order` (
  `id` varchar(32) NOT NULL,
  `process_id` varchar(32) DEFAULT NULL,
  `order_state` int(11) DEFAULT NULL,
  `creator` varchar(50) DEFAULT NULL,
  `create_time` varchar(50) DEFAULT NULL,
  `end_time` varchar(50) DEFAULT NULL,
  `expire_time` varchar(50) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `parent_id` varchar(32) DEFAULT NULL,
  `order_no` varchar(50) DEFAULT NULL,
  `variable` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_wf_hist_order` */

/*Table structure for table `t_wf_hist_task` */

DROP TABLE IF EXISTS `t_wf_hist_task`;

CREATE TABLE `t_wf_hist_task` (
  `id` varchar(32) NOT NULL,
  `order_id` varchar(32) DEFAULT NULL,
  `task_name` varchar(100) DEFAULT NULL,
  `display_name` varchar(200) DEFAULT NULL,
  `operator` varchar(50) DEFAULT NULL,
  `create_time` varchar(50) DEFAULT NULL,
  `take_time` varchar(50) DEFAULT NULL,
  `finish_time` varchar(50) DEFAULT NULL,
  `expire_time` varchar(50) DEFAULT NULL,
  `action_url` varchar(200) DEFAULT NULL,
  `task_type` int(11) DEFAULT NULL,
  `task_state` int(11) DEFAULT NULL,
  `perform_type` int(11) DEFAULT NULL,
  `parent_task_id` varchar(32) DEFAULT NULL,
  `variable` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_wf_hist_task` */

/*Table structure for table `t_wf_hist_task_actor` */

DROP TABLE IF EXISTS `t_wf_hist_task_actor`;

CREATE TABLE `t_wf_hist_task_actor` (
  `task_id` varchar(32) NOT NULL,
  `actor_id` varchar(50) NOT NULL,
  PRIMARY KEY (`task_id`,`actor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_wf_hist_task_actor` */

/*Table structure for table `t_wf_order` */

DROP TABLE IF EXISTS `t_wf_order`;

CREATE TABLE `t_wf_order` (
  `id` varchar(32) NOT NULL,
  `version` int(11) NOT NULL,
  `process_id` varchar(32) DEFAULT NULL,
  `creator` varchar(50) DEFAULT NULL,
  `create_time` varchar(50) DEFAULT NULL,
  `expire_time` varchar(50) DEFAULT NULL,
  `last_update_Time` varchar(50) DEFAULT NULL,
  `last_updator` varchar(50) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `parent_id` varchar(32) DEFAULT NULL,
  `parent_node_name` varchar(50) DEFAULT NULL,
  `order_no` varchar(50) DEFAULT NULL,
  `variable` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_wf_order` */

/*Table structure for table `t_wf_process` */

DROP TABLE IF EXISTS `t_wf_process`;

CREATE TABLE `t_wf_process` (
  `id` varchar(32) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `display_name` varchar(200) DEFAULT NULL,
  `instance_url` varchar(200) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `content` longblob,
  `version` int(11) DEFAULT NULL,
  `create_time` varchar(50) DEFAULT NULL,
  `creator` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_wf_process` */

/*Table structure for table `t_wf_surrogate` */

DROP TABLE IF EXISTS `t_wf_surrogate`;

CREATE TABLE `t_wf_surrogate` (
  `id` varchar(32) NOT NULL,
  `process_name` varchar(100) DEFAULT NULL,
  `operator` varchar(50) DEFAULT NULL,
  `surrogate` varchar(50) DEFAULT NULL,
  `odate` varchar(50) DEFAULT NULL,
  `sdate` varchar(50) DEFAULT NULL,
  `edate` varchar(50) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_wf_surrogate` */

/*Table structure for table `t_wf_task` */

DROP TABLE IF EXISTS `t_wf_task`;

CREATE TABLE `t_wf_task` (
  `id` varchar(32) NOT NULL,
  `version` int(11) NOT NULL,
  `order_id` varchar(32) DEFAULT NULL,
  `task_name` varchar(100) DEFAULT NULL,
  `display_name` varchar(200) DEFAULT NULL,
  `operator` varchar(50) DEFAULT NULL,
  `create_time` varchar(50) DEFAULT NULL,
  `finish_time` varchar(50) DEFAULT NULL,
  `take_time` varchar(50) DEFAULT NULL,
  `expire_time` varchar(50) DEFAULT NULL,
  `action_url` varchar(200) DEFAULT NULL,
  `task_type` int(11) DEFAULT NULL,
  `perform_type` int(11) DEFAULT NULL,
  `parent_task_id` varchar(32) DEFAULT NULL,
  `variable` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_wf_task` */

/*Table structure for table `t_wf_task_actor` */

DROP TABLE IF EXISTS `t_wf_task_actor`;

CREATE TABLE `t_wf_task_actor` (
  `task_id` varchar(32) NOT NULL,
  `actor_id` varchar(50) NOT NULL,
  PRIMARY KEY (`task_id`,`actor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_wf_task_actor` */

/*Table structure for table `t_wf_workitem` */

DROP TABLE IF EXISTS `t_wf_workitem`;

CREATE TABLE `t_wf_workitem` (
  `task_Id` varchar(255) NOT NULL,
  `process_id` varchar(255) DEFAULT NULL,
  `order_id` varchar(255) DEFAULT NULL,
  `order_no` varchar(255) DEFAULT NULL,
  `process_name` varchar(255) DEFAULT NULL,
  `order_title` varchar(255) DEFAULT NULL,
  `instance_url` varchar(255) DEFAULT NULL,
  `parent_id` varchar(255) DEFAULT NULL,
  `creator` varchar(255) DEFAULT NULL,
  `order_create_time` varchar(255) DEFAULT NULL,
  `order_expire_time` varchar(255) DEFAULT NULL,
  `order_variable` varchar(255) DEFAULT NULL,
  `task_name` varchar(255) DEFAULT NULL,
  `task_key` varchar(255) DEFAULT NULL,
  `operator` varchar(255) DEFAULT NULL,
  `task_create_time` varchar(255) DEFAULT NULL,
  `task_take_time` varchar(255) DEFAULT NULL,
  `task_end_time` varchar(255) DEFAULT NULL,
  `task_expire_time` varchar(255) DEFAULT NULL,
  `action_url` varchar(255) DEFAULT NULL,
  `task_type` int(11) DEFAULT NULL,
  `perform_type` int(11) DEFAULT NULL,
  `task_variable` varchar(255) DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `org_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`task_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_wf_workitem` */

/*Table structure for table `tg_study_class` */

DROP TABLE IF EXISTS `tg_study_class`;

CREATE TABLE `tg_study_class` (
  `id` varchar(64) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `description` varchar(64) DEFAULT NULL,
  `level` varchar(128) DEFAULT NULL,
  `name` varchar(128) DEFAULT NULL,
  `status` varchar(16) NOT NULL,
  `teacher_id` varchar(128) DEFAULT NULL,
  `teacher_name` varchar(128) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tg_study_class` */

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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tg_study_classroom` */

insert  into `tg_study_classroom`(`id`,`school_id`,`school_name`,`name`,`status`,`description`,`create_time`,`update_time`) values ('U154278944159689965','U154278937639961731','灵秀','灵秀一','NORMAL','灵秀一','2018-11-21 16:37:22',NULL),('U154278945143928838','U154278937639961731','灵秀','灵秀二','NORMAL','灵秀二','2018-11-21 16:37:31',NULL),('U154278946335725256','U154278938594715590','碧海','碧海一','NORMAL','碧海一','2018-11-21 16:37:43',NULL),('U154278947254004755','U154278938594715590','碧海','碧海二','NORMAL','碧海二','2018-11-21 16:37:53',NULL),('U154278948205280404','U154278938594715590','碧海','碧海三','NORMAL','碧海三','2018-11-21 16:38:02',NULL),('U154278949320644493','U154278938594715590','碧海','碧海四','NORMAL','碧海四','2018-11-21 16:38:13',NULL),('U154278950797478300','U154278940555972710','沈家门','沈家门','NORMAL','沈家门','2018-11-21 16:38:28',NULL),('U154278952002996339','U154278942492545956','城建','城建','NORMAL','城建','2018-11-21 16:38:40',NULL),('U154279020003980659','U154278941642911961','一小','一小','NORMAL','一小','2018-11-21 16:50:00',NULL);

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

insert  into `tg_study_course`(`id`,`name`,`week_info`,`course_time_index`,`course_time`,`school_id`,`school_name`,`classroom_id`,`classroom_name`,`teacher_id`,`teacher_name`,`status`,`description`,`create_time`,`update_time`) values ('U154285565174266606','周宏斌星期二5',2,5,'18:30-20:00','U154278937639961731','','U154278944159689965','灵秀一','U154278954605976028',NULL,'NORMAL','',NULL,'2018-11-22 11:47:45'),('U154285648373308696','周宏斌星期三5',3,5,'18:30-20:00','U154278937639961731','灵秀','U154278944159689965','灵秀一','U154278954605976028','周宏斌','NORMAL','','2018-11-22 11:14:44',NULL),('U154285651121458136','周宏斌星期五5',5,5,'18:30-20:00','U154278937639961731','灵秀','U154278944159689965','灵秀一','U154278954605976028','周宏斌','NORMAL','','2018-11-22 11:15:11',NULL),('U154285654102487561','周宏斌星期四5',4,5,'18:30-20:00','U154278938594715590','碧海','U154278949320644493','碧海四','U154278954605976028','周宏斌','NORMAL','','2018-11-22 11:15:41',NULL),('U154285664693668265','周宏斌星期六1',6,1,'7:30-9:00','U154278941642911961','一小','U154279020003980659','一小','U154278954605976028','周宏斌','NORMAL','','2018-11-22 11:17:27',NULL),('U154285666029388397','周宏斌星期六2',6,2,'9:00-10:30','U154278941642911961','一小','U154279020003980659','一小','U154278954605976028','周宏斌','NORMAL','','2018-11-22 11:17:40',NULL),('U154285667675426054','周宏斌星期六3',6,3,'13:30-15:00','U154278937639961731','灵秀','U154278944159689965','灵秀一','U154278954605976028','周宏斌','NORMAL','','2018-11-22 11:17:57',NULL),('U154285668918106780','周宏斌星期六4',6,4,'15:30-17:00','U154278937639961731','灵秀','U154278944159689965','灵秀一','U154278954605976028','周宏斌','NORMAL','','2018-11-22 11:18:09',NULL),('U154285669967069011','周宏斌星期六5',6,5,'18:30-20:00','U154278937639961731','灵秀','U154278944159689965','灵秀一','U154278954605976028','周宏斌','NORMAL','','2018-11-22 11:18:20',NULL),('U154285671686326617','周宏斌星期天2',7,2,'9:00-10:30','U154278938594715590','碧海','U154278948205280404','碧海三','U154278954605976028','周宏斌','NORMAL','','2018-11-22 11:18:37',NULL),('U154285673148545401','周宏斌星期天4',7,4,'15:30-17:00','U154278938594715590','碧海','U154278948205280404','碧海三','U154278954605976028','周宏斌','NORMAL','','2018-11-22 11:18:51',NULL),('U154285674483362792','周宏斌星期天5',7,5,'18:30-20:00','U154278938594715590','碧海','U154278948205280404','碧海三','U154278954605976028','周宏斌','NORMAL','','2018-11-22 11:19:05',NULL),('U154285853614541899','孙为民星期二5',2,5,'18:30-20:00','U154278937639961731','灵秀','U154278945143928838','灵秀二','U154278956053217488','孙为民','NORMAL','','2018-11-22 11:48:56',NULL),('U154286250823733462','孙为民星期三5',3,5,'18:30-20:00','U154278937639961731','灵秀','U154278945143928838','灵秀二','U154278956053217488','孙为民','NORMAL','','2018-11-22 12:55:08',NULL),('U154286253275412196','孙为民星期天2',7,2,'9:00-10:30','U154278937639961731','灵秀','U154278945143928838','灵秀二','U154278956053217488','孙为民','NORMAL','','2018-11-22 12:55:32',NULL);

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
  `level` int(11) DEFAULT NULL,
  `parent_phone` varchar(16) DEFAULT NULL,
  `parent_name` varchar(64) DEFAULT NULL,
  `parent_type` smallint(1) DEFAULT NULL,
  `status` varchar(16) DEFAULT NULL,
  `total_course` int(11) DEFAULT NULL,
  `remain_course` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `course_series_un_signed` int(3) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tg_study_student` */

insert  into `tg_study_student`(`id`,`name`,`age`,`sex`,`birthday`,`school_name`,`level`,`parent_phone`,`parent_name`,`parent_type`,`status`,`total_course`,`remain_course`,`create_time`,`update_time`,`course_series_un_signed`) values ('U154297612702219574','汪云浩',0,1,'2008-10-01','城北',0,'18768074874',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612703173126','宁振皓',0,1,'2012-02-28','城北',0,'13750721901',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612703926668','陈昱帆',0,1,'2012-11-02','东港',0,'13567696388',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612704860994','朱奕臻',0,1,'2014-01-07','东港',0,'13506809405',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612705699032','陆妍心',0,2,'2011-08-25','小天地',0,'13957234971',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612706828267','李京晓',0,2,'2012-08-22','熊猫',0,'18768068262',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612707535096','陈冠羽',0,1,'2013-01-14','东港',0,'13706800431',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612708254391','吴彦诺',0,1,'2012-12-30','熊猫',0,'13967203170',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612708955934','沈辰旭',0,1,'2010-11-01','一小',22,'13735017673',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612709624967','程昱甄',0,2,'2011-11-06','普陀小学',0,'18058028653',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612710491593','许正洋',0,1,'2010-08-01','沈小',0,'18268703246',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612711239747','贺昱玮',0,1,'2013-02-03','熊猫',25,'15957057352',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612712009727','丁麒谕',0,1,'2013-06-01','熊猫',0,'13967205718',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612713392609','林睿泽',0,1,'2013-11-03','东港',0,'13868248467',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612714108904','翁子画',0,1,'2011-12-08','熊猫',23,'13967219630',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612714949247','庄子涵',0,1,'2012-08-09','熊猫',24,'15157980909',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612715772448','郑皓仁',0,1,'2013-05-03','和润',0,'13868213553',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612716558800','翁熙哲',0,1,'2012-10-11','蓝盾',0,'15958078208',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612717256853','贝晨晰',0,2,'2013-03-30','蓝盾',0,'15958095561',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612718082891','杨浚溢',0,1,'2011-08-25','城北',0,'13506801361',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612718818038','张宸硕',0,1,'2013-08-31','熊猫',0,'13587071618',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612719656688','盛张睿',0,1,'2013-03-01','普陀小学',0,'13758006682',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612720431479','李雨轩',0,1,'2013-07-11','东港',0,'13666703299',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612721291691','李函臻',0,1,'2012-09-20','沈家门',0,'13666585833',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612722275907','乐禹含',0,1,'2012-08-23','熊猫',0,'13967217161',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612723232792','屠骁腾',0,1,'2014-02-08','',0,'13758004946',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612724855046','袁佳玮',0,2,'2014-06-20','熊猫',0,'13396805858',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612726043247','孙颢淳',0,1,'2013-04-01','颐景园',0,'13587094040',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612727084505','韩宗博',0,1,'2011-07-25','一小',0,'13758032766',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612728989508','孙浩航',0,1,'2014-05-27','',0,'15305808779',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612730104835','王麒皓',0,1,'2012-12-05','北安',0,'13665810440',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612731219610','陈乙霆',0,1,'2012-08-13','沈家门',0,'13616806368',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612732467828','王博然',0,1,'2014-10-15','沈家门',0,'663272',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612733623559','程玺璇',0,2,'2008-03-28','沈小',0,'13587066203',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612734787140','郑欣睿',0,1,'2009-03-01','勾山小学',0,'15957087078',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612735725185','王一早',0,1,'2010-01-15','一小',22,'13059888081',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612736704825','陈禹桦',0,1,'2012-07-17','熊猫',19,'13867213552',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612737592247','苗凯杰',0,1,'2011-12-30','青苹果',0,'13665818945',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612738279011','谢其桓',0,1,'2010-07-13','蓝盾',22,'18005808588',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612739079382','许誉耀',0,1,'2010-11-16','沈小',23,'13655806486',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612739897181','李佳澔',0,1,'2009-10-24','勾山',17,'15958078515',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612740671256','林哲毅',0,1,'2010-04-08','沈小',18,'13575604884',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612741348072','曹佑嘉',0,1,'2010-04-14','普陀小学',0,'13732530195',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612742428283','徐博厚',0,1,'2010-10-17','城建',19,'15305808660',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612743563426','邬知逸',0,1,'2010-11-19','和润',23,'13567675500',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612745348604','虞钧涵',0,1,'2012-05-23','熊猫',22,'13957232107',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612746449373','邵匀佐',0,1,'2012-08-03','熊猫',22,'13735035708',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612747327879','胡哲喻',0,1,'2010-10-24','普陀小学',21,'15958068812',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612748263593','张晋瑜',0,1,'2013-01-15','实验',20,'13735013587',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612749068699','刘书岑',0,2,'2010-10-28','',24,'13867232522',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612750086239','蒋卓航',0,1,'2011-11-22','新城幼儿园',0,'13967201544',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612751130378','刘辰',0,1,'2010-12-03','普小',0,'13758016309',NULL,0,'NORMAL',20,20,'2018-11-23 20:28:47','2018-11-24 16:35:38',0),('U154297612752369897','韩雨臻',0,1,'2010-04-03','颐景园',22,'15068007101',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612753489017','翁齐辰',0,1,'2012-02-07','熊猫',23,'13665804357',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612754647454','翁晨越',0,1,'2012-04-23','东港',0,'13750711467',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612755519070','沃渲博',0,1,'2012-09-12','沈家门',0,'13567698277',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612756613471','丁嘉鸿',0,1,'2012-09-16','东港',0,'13666591905',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612757739928','李昕瀚',0,1,'2012-09-21','东港',23,'15924005307',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612758870654','周子翔',0,1,'2012-11-01','普陀',0,'13967213777',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612759983563','徐靖昕',0,1,'2012-12-10','沈家门',0,'13857207742',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612760965276','马瑜辰',0,1,'2013-03-24','碧海',0,'18058021772',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612762195968','刘讴睿',0,1,'2012-03-26','熊猫',0,'15858089696',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612763136891','周柏臻',0,1,'2011-05-07','颐景园',24,'18058095670',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612764298014','王艺瑾',0,2,'2012-10-17','中心',0,'13567670608',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612765390497','张译涵',0,1,'2012-06-01','南海',0,'13957235991',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612766448598','乐凯文',0,1,'2009-07-16','一小',0,'13868237741',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612767499290','王浚羽',0,1,'2009-05-04','',0,'13868224057',NULL,0,'NORMAL',20,20,'2018-11-23 20:28:47','2018-11-24 16:35:31',0),('U154297612768251872','郭泽楠',0,1,'2011-01-13','和润',16,'13868238308',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612769058093','殷又嘉',0,1,'2010-06-17','颐景园',0,'18069293617',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612769887175','钟昊轩',0,1,'2012-09-02','熊猫',0,'13867213122',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612774110103','俞博文',0,1,'2009-09-07','和润',17,'13587081166',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612774948275','汪淇涵',0,1,'2010-06-01','和润',19,'18605808885',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612775630112','俞俊烨',0,1,'2010-12-14','一小',0,'13587065522',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612776323967','李思竟',0,2,'2011-02-11','和润',21,'13587047227',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612777015971','王浚棋',0,1,'2010-10-26','普陀小学',10,'13575611610',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612777870247','张子涵',0,1,'2007-12-02','沈四小',23,'18605807508',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612778619832','李若水',0,2,'2006-05-05','一小',0,'13905800185',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612779618657','刘梓源',0,1,'2009-02-02','普小',7,'13705807782',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612780590662','焦俊宁',0,1,'2011-12-18','普小',0,'13868236317',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612781373264','童煜希',0,1,'2011-09-25','沈小',0,'13758007115',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612782157325','马誉宸',0,1,'2008-10-07','沈小',13,'13735029991',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612783189848','邵润觉',0,1,'2010-10-11','普陀小学',17,'13587077978',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612783839872','胡闵皓',0,1,'2011-01-06','沈一小',6,'13732528368',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612784622641','徐嘉豪',0,1,'2010-02-19','沈一小',7,'13867226338',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612785444912','严晟珈',0,1,'2009-10-10','沈四小',9,'13868223516',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612786334162','黄子洋',0,1,'2010-01-10','普小',0,'13868247446',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612787075664','蒋泽宇',0,1,'2008-06-01','',0,'13567661028',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612787989534','包烜豪',0,1,'2011-11-01','',0,'13857206218',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612788753381','张宸豪',0,1,'2012-10-16','碧海园',0,'13666717662',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612789515003','颜琳烨',0,2,'2013-04-12','熊猫',0,'13566005441',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612790565230','李谨旭',0,2,'2013-08-12','熊猫',0,'13957222412',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612791448277','张力匀',0,1,'2012-10-24','熊猫',0,'13857204977',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612792559183','余嘉硕',0,1,'2012-12-29','熊猫',0,'15088893967',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612793606065','严晨慧',0,2,'2013-04-15','熊猫',0,'13758014780',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612794500539','孙博艺',0,1,'2013-06-10','普陀',0,'13735018835',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612795348477','孔彦淇',0,1,'2012-06-01','实验',0,'13666703142',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612796093668','刘辰昕',0,1,'2012-12-01','东港',0,'18658005303',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612796702445','虞健仰',0,1,'2012-06-16','熊猫',0,'18058028217',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612797451167','李柏霖',0,1,'2013-01-10','熊猫',0,'13305800827',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612798184937','翁浩瀚',0,1,'2012-08-28','熊猫',0,'13967206186',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612799096408','虞子萱',0,1,'2014-03-01','熊猫',0,'13665807742',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612799865762','陈衍桦',0,1,'2012-11-29','熊猫',0,'15924021540',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:47',NULL,0),('U154297612800699489','方颢霖',0,1,'2013-11-01','熊猫',0,'13665816156',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612801524787','张沐晨',0,1,'2014-05-24','熊猫',0,'13967219367',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612802385449','缪卓谕',0,1,'2014-03-24','熊猫',0,'15957085006',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612803154209','彭煜轩',0,1,'2014-01-20','熊猫',0,'13868231077',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612803821260','徐启然',0,1,'2013-04-02','东港',0,'13857235895',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612804791869','王  政',0,1,'2012-09-08','熊猫',0,'15159320092',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612805592752','陈泓睿',0,1,'2012-03-27','碧海园',0,'13967235426',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612806756379','刘骐恺',0,1,'2012-12-18','碧海园',0,'13388449009',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612807552844','王思然',0,1,'2013-12-26','熊猫',0,'15657097537',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612819712067','许淇皓',0,1,'2012-09-19','东港',0,'13656820536',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612821149842','柳彦朵',0,1,'2014-03-17','熊猫',0,'13868236233',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612822637630','孙译辰',0,1,'2011-04-07','新城',8,'13666705660',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612823611392','李承桦',0,1,'2010-04-11','普陀小学',0,'13587091383',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612824340731','李政翰',0,1,'2010-03-06','沈小',0,'13567697796',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612825156705','胡潇楠',0,1,'2011-10-01','颐景园',22,'18627117833',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612826036586','陆柏男',0,1,'2010-07-10','中旭',0,'18273125312',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612826964744','蒋易睿',0,1,'2011-03-26','城建',0,'18857058878',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612827920010','陈希骏',0,1,'2011-04-25','颐景园',24,'15858055821',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612828992821','小李雨泽',0,1,'2011-04-26','蓝盾',21,'13567684942',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612829986951','洪睿阳',0,1,'2011-07-06','熊猫',20,'15168082891',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612830857488','杨骐泽',0,1,'2011-12-19','沈家门',20,'13967203181',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612832165647','魏辰旭',0,1,'2012-03-06','沈家门',16,'13857237083',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612833158322','李奕涵',0,1,'2012-05-16','颐景园',23,'13867208229',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612834211904','胡智勋',0,1,'2011-12-21','一小',0,'13666705163',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612835228846','张桓豪',0,1,'2010-01-05','沈家门',0,'15957072431',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612839420435','沈子洋',0,1,'2011-05-10','熊猫',23,'15268029518',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612840428598','叶子煜',0,1,'2012-01-01','蓝盾',0,'13967224552',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612841551220','周彦江',0,2,'2011-05-11','蓝盾',24,'18768006639',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612842778511','范丰毅',0,1,'2009-02-02','颐景园',14,'13567693493',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612843722051','刘焘毓',0,1,'2007-03-26','勾山',18,'13967221543',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612844786716','丁乐捷',0,1,'2009-08-26','南海',23,'13758018125',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612845747404','孙薪淯',0,2,'2009-01-29','一小',0,'13868238654',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612846721048','张翔宾',0,1,'2006-11-21','芦花',15,'13575624282',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612847963303','腾斌源',0,1,'2009-03-02','洞洞',12,'13567679565',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612848891192','鲍鼎维',0,1,'2008-11-11','舟山小学',10,'15924014680',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612849809006','冯茂庭',0,1,'2011-01-01','熊猫',17,'13967201337',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612850824973','方彬鉴',0,1,'2009-08-20','熊猫',0,'13645804014',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612851917828','周子恩',0,1,'2009-01-14','沈小',0,'13735028757',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612853040062','吴昊东',0,1,'2010-08-22','一小',19,'13615809628',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612853903749','魏子谦',0,1,'2008-04-14','南海',2,'13868202256',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612855014458','庄天乐',0,1,'2007-01-23','沈小',2,'13758046321',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612856206437','刘政男',0,1,'2007-09-24','沈小',2,'13735022412',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612857490824','潘冠翰',0,1,'2010-05-26','舟山一小',22,'13587067852',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612858454653','陈芊含',0,2,'2009-11-26','一小',22,'13735029815',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612859311916','陈  澄',0,1,'2007-07-09','沈小',0,'13868245577',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612860334396','麻秦子轩',0,1,'2011-04-01','北禅',0,'15858087871',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612861360828','庄浚朗',0,1,'2010-02-27','颐景园',13,'13758028605',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612862408274','刘绍涵',0,1,'2012-03-30','熊猫',0,'15168078701',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612863471509','黄于哲',0,1,'2010-07-24','沈小',0,'15957091588',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612864379129','李佳臻',0,1,'2009-02-07','沈小',0,'13967231912',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612865329965','余禹翰',0,1,'2010-10-23','熊猫',20,'13957234793',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612866243414','贺铭依',0,2,'2011-01-02','沈小',0,'13705803205',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612867295078','王齐成',0,1,'2012-03-14','普陀',13,'13867211582',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612868338643','徐晨皓',0,1,'2010-03-10','颐景园',4,'13095809823',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612869368567','蒋林璇',0,1,'2010-03-14','颐景园',16,'13857236580',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612870339906','童禹豪',0,1,'2010-09-22','和润',18,'13575631524',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612871230443','大李雨泽',0,1,'2010-10-09','颐景园幼儿',0,'13567690703',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612872320241','戴子尧',0,1,'2011-03-02','颐景园',0,'13587079931',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612873274322','顾沅镳',0,1,'2011-06-12','城建',22,'13905803805',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612873962204','刘俊彦',0,1,'2013-01-12','熊猫',0,'13587070810',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612874728642','金若言',0,1,'2013-11-12','城北',0,'13587081002',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612875517530','孙悦翔',0,1,'2013-12-13','颐景园',0,'13575614121',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612876577095','谢松廷',0,1,'2010-11-19','城北',0,'15957066526',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612877442659','周羿辰',0,1,'2011-12-26','熊猫',0,'15924003332',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612878236871','杨承谕',0,1,'2014-01-25','沈家门',0,'13567658273',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612879148919','傅韬谕',0,1,'2013-01-19','个人',0,'13750714141',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612880160461','俞博涵',0,1,'2010-10-15','一小',0,'13867223101',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612881025629','王林禄',0,1,'2013-08-23','颐景园',0,'13967214975',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612882222391','丁宇菲',0,2,'2013-03-22','颐景园',0,'15858072866',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612883308498','丁宇航',0,1,'2013-03-22','颐景园',0,'15858072866',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612884246493','刘珈妤',0,2,'2011-12-18','城北',0,'13567665575',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612885190350','胡轩豪',0,1,'2011-11-06','沈小',0,'13967233084',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612886151108','施兴海',0,1,'2012-09-05','荷叶湾',0,'18368092586',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612887216218','朱芷萱',0,2,'2010-01-01','四小',0,'15168068859',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612888285256','周庄挺',0,1,'2010-11-06','沈家门',23,'13957207385',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612889368756','沈子皓',0,1,'2012-04-16','北安',24,'15857076512',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612890382946','张哲瀚',0,2,'2012-03-30','三盛',0,'13867214752',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612891121829','陈沛泽',0,1,'2012-01-04','颐景园',24,'18967200386',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612892436531','史祝嘉',0,1,'2012-01-23','熊猫',21,'13587076832',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612893515499','倪睿婕',0,2,'2012-05-19','东港',23,'15958065966',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612894764275','胡真闻',0,1,'2012-05-15','',18,'13867211231',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612895806430','许博淳',0,1,'2011-11-11','三盛',20,'13758005215',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612896969963','林  诚',0,1,'2008-11-06','城建',16,'13587078393',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612897786149','汪展拓',0,1,'2006-01-16','熊猫',1,'13868240925',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612898798194','余佳润',0,1,'2007-04-28','熊猫',1,'18957218285',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:48',NULL,0),('U154297612900522764','王舸瑜',0,1,'2005-03-31','沈小',1,'13587044200',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612901622996','娄峻帆',0,1,'2006-03-29','熊猫',1,'13868213668',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612902890344','高浩力',0,1,'2008-07-22','城建',2,'13515805819',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612903692999','郑鉴原',0,1,'2006-12-05','蓝盾',4,'13857209083',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612904682772','陈玫羽',0,2,'2007-08-31','沈小',4,'13857202252',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612905536900','李柏璋',0,1,'2009-03-18','洞洞',7,'18606807770',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612906505385','郑文哲',0,1,'2007-06-07','一小',1,'13705806835',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612907692155','李晨灏',0,1,'2010-06-29','熊猫',4,'13967209004',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612908598724','洪子然',0,1,'2007-07-30','熊猫',1,'13506801869',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612909446490','施翔耀',0,1,'2009-01-26','城建',2,'15957059366',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612910065211','陆沾锦',0,1,'2005-10-12','一小',0,'13675806078',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612910858831','李奕娴',0,2,'2009-11-08','实验',1,'13867231209',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612911608433','倪彬哲',0,1,'2008-10-20','沈小',1,'13967236398',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612912422085','张真豪',0,1,'2010-08-04','沈小',20,'18042298650',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612913377745','刘炎松',0,1,'2011-07-24','沈小',20,'13515809246',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612914099932','王羿皓',0,1,'2011-09-20','新城六',18,'13575616633',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612914875144','刘津源',0,1,'2011-04-15','沈小',9,'13082866959',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612915510282','泮政宇',0,1,'2011-03-27','沈小',10,'13750711265',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612916408356','戎柏臻',0,1,'2010-03-01','蓝盾',16,'13867233340',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612917466735','虞铮楠',0,1,'2007-07-23','四小',24,'13615802673',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612918424818','何政磊',0,1,'2011-03-01','育华',13,'13706808607',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612919548205','周冠辰',0,1,'2011-03-29','普陀小学',20,'13656826154',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612920533864','陈奕天',0,1,'2009-03-30','沈一小',12,'13967228143',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612921416024','王瑞泽',0,1,'2010-09-09','沈一小',14,'13750718384',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612922283726','冯子渝',0,1,'2010-10-24','鲁家',21,'15336848517',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612923317346','方柏昊',0,1,'2010-05-01','沈小',20,'13567658229',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612924509197','施博觉',0,1,'2012-02-07','荷叶湾',19,'13665818766',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612925675048','刘子立',0,1,'2012-05-03','熊猫',20,'13735029706',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612926634179','虞轶涵',0,2,'2012-05-31','熊猫',0,'13645805580',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612927642713','丁韦涵',0,1,'2011-01-02','北安',23,'13906802353',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612928887309','沈彥佐',0,1,'2011-03-21','颐景园',23,'15958086991',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612929697524','刘芮汐',0,1,'2012-07-07','北安',0,'18058046700',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612930573927','吴冠辰',0,1,'2009-09-23','沈小',0,'13567685094',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612931421635','李涵宸',0,1,'2010-05-03','普陀小学',24,'13868208820',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612932474369','周煜皓',0,1,'2007-10-22','沈四小',9,'13136420905',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612933334748','张炎凌',0,1,'2010-07-24','蓝盾',17,'13867205032',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612934099434','杨雯喧',0,1,'2009-05-27','沈小',23,'13705806560',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612934706634','沈柏宇',0,1,'2008-02-02','一小',0,'13306803322',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612935407598','牟咨臻',0,2,'2008-01-16','沈小',10,'13857215892',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612936257141','张淳皓',0,2,'2012-05-07','三盛',0,'13967206906',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612936924260','杜铭杰',0,1,'2011-08-29','沈小',22,'13758029755',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612937686202','李林桓',0,1,'2008-06-21','沈小',18,'13587051626',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612939250796','徐一然',0,1,'2009-01-01','熊猫',19,'13967209974',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612940156690','叶祖延',0,1,'2009-08-05','一小',19,'13666705035',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612940933555','朱雨墨',0,1,'2011-05-16','普陀小学',22,'13957226563',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612941878232','江晨烁',0,1,'2012-06-28','东港',0,'13656803988',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612942524616','林尚轩',0,1,'2012-09-10','和润',0,'13750717574',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612943371635','吴谦睿',0,1,'2012-11-20','熊猫',0,'13884318290',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612944051940','施童捷',0,1,'2012-03-30','熊猫',23,'13857215815',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612944899324','方彦栋',0,1,'2012-01-26','熊猫',0,'13655803080',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612945589084','竺帅辰',0,1,'2012-03-06','熊猫',24,'13506801383',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612946213793','吴陈熙',0,1,'2012-06-28','熊猫',22,'13967214349',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612947095478','杜少璞',0,1,'2012-09-11','熊猫',0,'13967206336',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612947799938','潘相予',0,1,'2008-08-31','沈小',9,'18058026630',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612948583512','王俊寓',0,1,'2009-12-20','沈小',20,'13735018756',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612949397565','徐铭浩',0,2,'2009-10-30','沈小',22,'15924039538',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612950156685','徐浩杰',0,1,'2009-10-10','普陀小学',22,'13454095956',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612950955907','林宸豪',0,1,'2011-07-02','普陀小学',9,'13884303156',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612951869941','马语蔚',0,1,'2011-02-20','普小',14,'13967206465',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612952766687','黄宣瑜',0,1,'2011-12-31','和津苑',22,'18969233098',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612953569157','郑博予',0,1,'2011-08-29','蓝盾',0,'13967216872',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612954202620','顾晨左',0,1,'2012-04-23','实验',0,'13857228966',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612955087166','高毓泽',0,1,'2012-05-02','实验',0,'13967205990',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612955797241','蒋佳辰',0,1,'2012-05-18','实验',0,'13506800991',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612956656179','虞卓骏',0,1,'2012-08-08','实验',0,'13867208400',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612957371488','朱珉磊',0,1,'2013-03-11','城建',0,'18967238048',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612958011939','张哲毓',0,1,'2012-11-09','北安',0,'13857217136',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612958813558','陈舟煜',0,1,'2013-01-24','北安',0,'13675806112',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612959566094','陈凯鑫',0,1,'2013-05-09','颐景园',0,'13857232488',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612960213303','姜柏丞',0,1,'2010-11-26','沈一小',0,'15068007077',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612960946144','虞思贤',0,1,'2012-08-06','城建',0,'13857207412',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612961868525','王千亦',0,1,'2012-01-01','城建',0,'13306807088',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612962545812','周奕轩',0,1,'2013-03-21','',0,'13867221789',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612963369542','张昊聘',0,1,'2013-05-14','沈家门',0,'13567655557',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612964071412','虞铠瑄',0,1,'2011-04-01','城建',23,'13362805153',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612964899118','卢嘉晨',0,1,'2012-09-20','物资',0,'13140849139',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612965547999','吴秉泽',0,1,'2012-06-10','城建',0,'13867238881',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612966217391','金彦含',0,1,'2008-07-08','蓝盾',0,'13857226558',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612966971030','黄禹哲',0,1,'2008-10-09','沈小',3,'13587077711',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0),('U154297612967796172','余昊泽',0,1,NULL,'',0,'13506605986',NULL,0,'NORMAL',0,0,'2018-11-23 20:28:49',NULL,0);

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

insert  into `tg_study_system_message`(`id`,`message_type`,`message_content`,`level`,`is_process`,`create_time`,`process_time`,`process_desc`) values ('1','STUDENT_REMAIN_COURSE_NOTE','学生小蓝仅剩余 3课时!   ',20,'YES','2018-11-21 09:08:22','2018-11-23 20:37:03',NULL);

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

insert  into `tg_study_teacher`(`id`,`name`,`phone`,`level`,`status`,`create_time`,`update_time`) values ('U154278954605976028','周宏斌','11','业余四段','NORMAL','2018-11-21 16:39:06','2018-11-21 16:39:28'),('U154278956053217488','孙为民','11','业余四段','NORMAL','2018-11-21 16:39:21',NULL),('U154278962301569613','蒋杰','11','业余四段','NORMAL','2018-11-21 16:40:23',NULL),('U154278963512684555','叶开良','11','业余四段','NORMAL','2018-11-21 16:40:35',NULL),('U154278965230025110','张国忠','11','业务四段','NORMAL','2018-11-21 16:40:52',NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
