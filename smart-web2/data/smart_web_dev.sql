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
  `id` varchar(32) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `remark` varchar(500) DEFAULT NULL,
  `table_name` varchar(127) NOT NULL,
  `user_id` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_create_table` */

insert  into `t_create_table`(`id`,`create_time`,`remark`,`table_name`,`user_id`) values ('U143934487927380227','2015-08-12 10:01:19','请假表单表','t_pf_leave','U141770099155103287'),('U147230956895632564','2016-08-27 22:52:49','其他表','t_pf_other_user','U141770099155103287'),('U148047582266440688','2016-11-30 11:17:03','测试列表','t_pf_test_list','U141770099155103287'),('U149541854055529222','2017-05-22 10:02:21','测试表1','t_pf_test1','U141770099155103287');

/*Table structure for table `t_create_table_field` */

DROP TABLE IF EXISTS `t_create_table_field`;

CREATE TABLE `t_create_table_field` (
  `id` varchar(32) NOT NULL,
  `data_format` varchar(50) DEFAULT NULL,
  `field_name` varchar(127) NOT NULL,
  `field_remark` varchar(500) DEFAULT NULL,
  `length` varchar(10) DEFAULT NULL,
  `sort_order` int(11) DEFAULT NULL,
  `table_id` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_create_table_field` */

insert  into `t_create_table_field`(`id`,`data_format`,`field_name`,`field_remark`,`length`,`sort_order`,`table_id`) values ('U143934487932908016','text','leave_reason','请假原因','',3,'U143934487927380227'),('U143934487932911617','varchar','name','请假人','50',1,'U143934487927380227'),('U143934487932938828','int','days','请假天数','3',2,'U143934487927380227'),('U147230479479356878','varchar','leave_type','请假类型','255',4,'U143934487927380227'),('U147230956895893116','varchar','other_name','其他姓名','255',1,'U147230956895632564'),('U147230956895933555','varchar','other_days','其他请假天数','100',2,'U147230956895632564'),('U147245406891052771','varchar','is_trial','是否试用','255',5,'U143934487927380227'),('U147451002482226487','varchar','other','其他','255',6,'U143934487927380227'),('U148047582268647936','varchar','list_name','列表名称','255',1,'U148047582266440688'),('U148047582268788204','varchar','list_alias','列表别名','255',2,'U148047582266440688'),('U148047582268795530','varchar','remark','备注','255',3,'U148047582266440688'),('U149541854056344119','varchar','name','名称','255',1,'U149541854055529222'),('U149541854056420939','varchar','remark','备注','1000',2,'U149541854055529222'),('U150436604721675602','varchar','test_file','测试附件','255',3,'U149541854055529222');

/*Table structure for table `t_flow_attachment` */

DROP TABLE IF EXISTS `t_flow_attachment`;

CREATE TABLE `t_flow_attachment` (
  `id` varchar(32) NOT NULL,
  `att_type` varchar(127) DEFAULT NULL,
  `attachment_id` varchar(32) NOT NULL,
  `form_id` varchar(32) DEFAULT NULL,
  `order_id` varchar(50) DEFAULT NULL,
  `process_id` varchar(50) NOT NULL,
  `task_id` varchar(50) DEFAULT NULL,
  `task_key` varchar(50) DEFAULT NULL,
  `user_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_flow_attachment` */

/*Table structure for table `t_flow_form` */

DROP TABLE IF EXISTS `t_flow_form`;

CREATE TABLE `t_flow_form` (
  `id` varchar(32) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `execute_node_num` int(11) NOT NULL,
  `form_data_id` varchar(32) NOT NULL,
  `form_id` varchar(32) NOT NULL,
  `order_id` varchar(32) NOT NULL,
  `org_id` varchar(32) DEFAULT NULL,
  `process_id` varchar(32) NOT NULL,
  `progress` float DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `total_node_num` int(11) NOT NULL,
  `user_id` varchar(32) NOT NULL,
  `process_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_flow_form` */

insert  into `t_flow_form`(`id`,`create_time`,`execute_node_num`,`form_data_id`,`form_id`,`order_id`,`org_id`,`process_id`,`progress`,`title`,`total_node_num`,`user_id`,`process_name`) values ('U149382144673051033','2017-05-03 22:24:07',2,'U149382144649665681','U143934508368932354','c4b097e7c7464c30b5ce27870a6f13f6',NULL,'9ba0baa1819c4fb5878566f4dc2fddbf',50,'测试流程1-测试列表控件11',4,'U141770099155103287','test_01'),('U149396437741032947','2017-05-05 14:06:17',2,'U149396437693296499','U143934508368932354','829e9c9d24b9424aa19de392d55da669',NULL,'9ba0baa1819c4fb5878566f4dc2fddbf',50,'测试流程1-测试列表控件223',4,'U141770099155103287','test_01'),('U149397451075221629','2017-05-05 16:55:11',2,'U149397451070045545','U143934508368932354','a6b096b78b864fb88ff20770ec32e9a3',NULL,'9ba0baa1819c4fb5878566f4dc2fddbf',50,'测试流程1-测试列表控件456',4,'U141770099155103287','test_01'),('U149397712397330542','2017-05-05 17:38:44',1,'U149397712392523981','U143934508368932354','bf70da33036c49508ee7a858b988367d','ORG_U143919525899571244','9ba0baa1819c4fb5878566f4dc2fddbf',25,'测试流程1-测试列表控件678',4,'U_U146720855065737398','test_01'),('U149397718644486879','2017-05-05 17:39:46',2,'U149397718638059933','U143934508368932354','7bbfd222c5c84acda95bc91e4d3539b8','ORG_U143919525899571244','9ba0baa1819c4fb5878566f4dc2fddbf',50,'测试流程1-测试列表控件910',4,'U_U146720855065737398','test_01'),('U149420819575796377','2017-05-08 09:49:56',1,'U149420819554530252','U143934508368932354','e5d2d077685e448c897f1e72a4aac31c',NULL,'9ba0baa1819c4fb5878566f4dc2fddbf',25,'测试流程1-测试控件列表222',4,'U141770099155103287','test_01'),('U149459841302152772','2017-05-12 22:13:33',1,'U149459841279779009','U143934508368932354','8a26bb0109d7479fba4370922c584802',NULL,'9ba0baa1819c4fb5878566f4dc2fddbf',25,'测试流程1-测试123',4,'U141770099155103287','test_01'),('U149459848307933195','2017-05-12 22:14:43',1,'U149459848301079155','U143934508368932354','d277cb8dd44e4ab7821f9f7aaf147ef7',NULL,'9ba0baa1819c4fb5878566f4dc2fddbf',25,'测试流程1-测试IE浏览器1',4,'U141770099155103287','test_01'),('U149503593783522121','2017-05-17 23:45:38',1,'U149503593761768272','U143934508368932354','bed1de64e70649f58d1d5744728927a3',NULL,'9ba0baa1819c4fb5878566f4dc2fddbf',25,'测试流程1-超级管理员123',4,'U141770099155103287','test_01'),('U149542934564387601','2017-05-22 13:02:26',1,'U149542934548130084','U143934508368932354','bca7a28436fc47499f97f5d3fb7bafa0',NULL,'20c04875b55949cbaa932354fdbeb8c6',33.33,'请假条件判断-测试1',3,'U141770099155103287','leave_ judge_test'),('U149542944111956812','2017-05-22 13:04:01',1,'U149542944102850102','U143934508368932354','a714c685e4fd4d489d76ee922800b28f',NULL,'20c04875b55949cbaa932354fdbeb8c6',33.33,'请假条件判断-测试判断22',3,'U141770099155103287','leave_ judge_test'),('U149542953841500501','2017-05-22 13:05:38',1,'U149542953835202817','U143934508368932354','94dcce6defca4644b431970ad7c0974d',NULL,'20c04875b55949cbaa932354fdbeb8c6',33.33,'请假条件判断-测试判断33',3,'U141770099155103287','leave_ judge_test'),('U149542958506194367','2017-05-22 13:06:25',1,'U149542958499334375','U143934508368932354','d71aa87f35224bb8a0cc429e77439abc',NULL,'20c04875b55949cbaa932354fdbeb8c6',33.33,'请假条件判断-测试啊123',3,'U141770099155103287','leave_ judge_test'),('U149542980731256631','2017-05-22 13:10:07',1,'U149542980726512082','U143934508368932354','bae429c1e7d64f639fd0a8e158019b1c',NULL,'20c04875b55949cbaa932354fdbeb8c6',33.33,'请假条件判断-测试中123456',3,'U141770099155103287','leave_ judge_test'),('U149543010371353737','2017-05-22 13:15:04',1,'U149543010367275898','U143934508368932354','a522d77fd069401aa064e792b1097875',NULL,'20c04875b55949cbaa932354fdbeb8c6',33.33,'请假条件判断-测试中9876',3,'U141770099155103287','leave_ judge_test'),('U151050256669184212','2017-11-13 00:02:47',0,'U151050254025097218','U143934508368932354','a4f8a84aacaf434dbb0b8c813a65bc84',NULL,'9ba0baa1819c4fb5878566f4dc2fddbf',0,'测试流程1-测试请假人1238906',0,'U141770099155103287','test_01'),('U151239693104331710','2017-12-04 22:15:31',0,'U151239693081635767','U143934508368932354','efeefd054e964b739f9b18518ae591b5',NULL,'9ba0baa1819c4fb5878566f4dc2fddbf',0,'测试流程1-张三123',0,'U141770099155103287','test_01');

/*Table structure for table `t_flow_page_model` */

DROP TABLE IF EXISTS `t_flow_page_model`;

CREATE TABLE `t_flow_page_model` (
  `id` varchar(32) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `name` varchar(127) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `uri` varchar(127) DEFAULT NULL,
  `user_id` varchar(32) DEFAULT NULL,
  `view_uri` varchar(127) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_flow_page_model` */

insert  into `t_flow_page_model`(`id`,`create_time`,`name`,`state`,`uri`,`user_id`,`view_uri`) values ('UU142778776674157039','2015-03-31 15:42:46','默认表单模版',1,'process/form','U141770099155103287','process/viewForm');

/*Table structure for table `t_flow_process` */

DROP TABLE IF EXISTS `t_flow_process`;

CREATE TABLE `t_flow_process` (
  `id` varchar(32) NOT NULL,
  `attachment` varchar(2) DEFAULT NULL,
  `flow_type` varchar(127) DEFAULT NULL,
  `form_id` varchar(32) DEFAULT NULL,
  `node_name_collection` varchar(4000) DEFAULT NULL,
  `org_id` varchar(32) DEFAULT NULL,
  `process_id` varchar(50) DEFAULT NULL,
  `total_node_num` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_flow_process` */

insert  into `t_flow_process`(`id`,`attachment`,`flow_type`,`form_id`,`node_name_collection`,`org_id`,`process_id`,`total_node_num`) values ('U146772878883665506','1','normal_flow','U143934508368932354','申请;审核;审核2','ORG_U143919516611919370','ccc66871bed64124b3652e6f476c7e7c',3),('U147651486671347513','1','normal_flow','U143934508368932354','申请;审核;审核2;审核11','ORG_U143919516611919370','9ba0baa1819c4fb5878566f4dc2fddbf',4),('U147652579815056249','1','normal_flow','U2290532509406697968','任务1;任务2;任务3','ORG_U143919516611919370','1ec1851928ed4826836d240e05780c69',3),('U147653675850138836','1','normal_flow','U2290532509406697968','任务1;任务2','ORG_U143919516611919370','6c7530c601cf49ef806ecab9aa4fc3eb',2),('U147654261630549112','1','normal_flow','U2290532509406697968','任务1;任务2','ORG_U143919516611919370','a3306b8c51364f9bbb123cf55c053444',2),('U149542925323778003','1','normal_flow','U143934508368932354','申请;审核1;审核2','ORG_U143919519043844770','20c04875b55949cbaa932354fdbeb8c6',3);

/*Table structure for table `t_form` */

DROP TABLE IF EXISTS `t_form`;

CREATE TABLE `t_form` (
  `id` varchar(32) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `creator` varchar(32) NOT NULL,
  `field_num` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `original_html` text,
  `parse_html` text,
  `type` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_form` */

insert  into `t_form`(`id`,`create_time`,`creator`,`field_num`,`name`,`original_html`,`parse_html`,`type`) values ('U143934508368932354','2015-08-12 10:04:44','U141770099155103287',12,'请假表单','<p style=\"text-align: center;\"><span style=\"font-size: 18px;\">请假条</span><br/></p><p><span style=\"font-size: 18px;\"></span></p><p><br/></p><table class=\"table table-bordered table-condensed\"  class=\"table table-bordered table-condensed\" style=\"border-color: rgb(0, 0, 0);\" width=\"1176\"><tbody><tr class=\"firstRow\"><td style=\"word-break: break-all; border-color: rgb(0, 0, 0);\" width=\"123\" valign=\"top\" height=\"20\">请假人{|-<span leipiplugins=\"helpers\" name=\"data_12\" orgcontent=\"请填写请假人的名称；如：张三\" orgname=\"\" orgsource=\"custom_content\" orgurl=\"\" display_model=\"dis_popover\">【?】</span>-|}</td><td style=\"border-color: rgb(0, 0, 0);\" width=\"568\" valign=\"top\" height=\"20\"><input name=\"data_12\" leipiplugins=\"text\" value=\"\" title=\"请假人\" bind_table=\"U143934487927380227\" bind_table_field=\"U143934487932911617\" id=\"U143934487927380227-U143934487932911617\" dateformat=\"\" input_plugin=\"\" input_plugin_uri=\"\" class=\"form-control require\" orghide=\"0\" fieldflow=\"0\" institle=\"1\" fieldrequire=\"1\" style=\"text-align: left;\" orgalign=\"left\" orgwidth=\"\" orgtype=\"text\" data-format=\"\" date_format=\"\" relate_field=\"\" relate_field_value=\"\" data_format=\"\" type=\"text\"/></td><td style=\"word-break: break-all; border-color: rgb(0, 0, 0);\" width=\"110\" valign=\"top\" height=\"20\">请假天数</td><td style=\"border-color: rgb(0, 0, 0);\" width=\"374\" valign=\"top\" height=\"20\"><input name=\"data_13\" leipiplugins=\"text\" value=\"\" title=\"请假天数\" bind_table=\"U143934487927380227\" bind_table_field=\"U143934487932938828\" id=\"U143934487927380227-U143934487932938828\" input_plugin=\"\" input_plugin_uri=\"\" class=\"form-control require\" orghide=\"0\" fieldflow=\"1\" institle=\"0\" fieldrequire=\"1\" orgalign=\"left\" orgwidth=\"\" orgtype=\"integer\" data-format=\"integer\" style=\"text-align: left;\" dateformat=\"\" type=\"text\" date_format=\"\" relate_field=\"\" relate_field_value=\"\" data_format=\"integer\"/></td></tr><tr><td colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(0, 0, 0);\" width=\"123\" valign=\"top\">测试日期1</td><td colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(0, 0, 0);\" width=\"568\" valign=\"top\"><input name=\"data_12\" leipiplugins=\"text\" value=\"\" title=\"测试日期\" bind_table=\"U147230956895632564\" bind_table_field=\"U147230956895893116\" id=\"U147230956895632564-U147230956895893116\" input_plugin=\"\" input_plugin_uri=\"\" class=\"form-control require cnoj-date\" orghide=\"0\" fieldflow=\"0\" institle=\"0\" fieldrequire=\"1\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"date\" data-format=\"date\" style=\"text-align: left; width: 150px;\" type=\"text\"/>至<input name=\"data_13\" leipiplugins=\"text\" value=\"\" title=\"测试日期2\" bind_table=\"U147230956895632564\" bind_table_field=\"U147230956895933555\" id=\"U147230956895632564-U147230956895933555\" input_plugin=\"\" input_plugin_uri=\"\" class=\"form-control require cnoj-date\" orghide=\"0\" fieldflow=\"0\" institle=\"0\" fieldrequire=\"1\" orgalign=\"left\" orgwidth=\"150\" orgtype=\"date\" data-format=\"date\" style=\"text-align: left; width: 150px;\" type=\"text\"/></td><td colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(0, 0, 0);\" width=\"110\" valign=\"top\">测试日期</td><td colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(0, 0, 0);\" width=\"374\" valign=\"top\"><br/></td></tr><tr><td colspan=\"1\" rowspan=\"1\" style=\"word-break: break-all; border-color: rgb(0, 0, 0);\" width=\"123\" valign=\"top\">请假类型</td><td style=\"border-color: rgb(0, 0, 0);\" colspan=\"1\" rowspan=\"1\" width=\"568\" valign=\"top\">{|-<span leipiplugins=\"checkboxs\" fieldname=\"U143934487927380227-U147230479479356878\" orgchecked=\"orgchecked1\" title=\"请假类型\" orgtitle=\"请假类型\" from-data=\"dict\" data-value=\"D141787854035683659\" bind_table=\"U143934487927380227\" bind_table_field=\"U147230479479356878\" fieldflow=\"0\" name=\"checkboxs_0\" from_data=\"dict\" data_uri=\"dict/itemById/D141787854035683659.json\" data_value=\"D141787854035683659\" fieldrequire=\"1\" class=\" require require\" dynamicload=\"1\"><input name=\"checkboxs_0\" value=\"l-1-1#一行一列\" fieldname=\"_1\" type=\"checkbox\"/>一行一列&nbsp;<br/><input name=\"checkboxs_0\" value=\"l-1-2#一行两列\" fieldname=\"_2\" type=\"checkbox\"/>一行两列&nbsp;<br/><input name=\"checkboxs_0\" value=\"l-2-1#两行一列\" fieldname=\"_3\" type=\"checkbox\"/>两行一列&nbsp;<br/><input name=\"checkboxs_0\" value=\"l-2-2#两行两列\" fieldname=\"_4\" type=\"checkbox\"/>两行两列&nbsp;<br/></span>-|}</td><td colspan=\"1\" rowspan=\"1\" style=\"word-break: break-all; border-color: rgb(0, 0, 0);\" width=\"110\" valign=\"top\">是否试用</td><td style=\"border-color: rgb(0, 0, 0);\" colspan=\"1\" rowspan=\"1\" width=\"374\" valign=\"top\">{|-<span leipiplugins=\"radios\" fieldname=\"U143934487927380227-U147245406891052771\" orgchecked=\"orgchecked1\" title=\"是否试用\" orgtitle=\"是否试用\" from-data=\"dict\" data-value=\"D-UU143066280538891847\" bind_table=\"U143934487927380227\" bind_table_field=\"U147245406891052771\" name=\"data_18\" fieldflow=\"0\" from_data=\"dict\" data_value=\"D-UU143066280538891847\" data_uri=\"dict/itemById/D-UU143066280538891847.json\" fieldrequire=\"0\" dynamicload=\"0\"><input name=\"U143934487927380227-U147245406891052771\" value=\"1#是\" type=\"radio\"/>是&nbsp;<br/><input name=\"U143934487927380227-U147245406891052771\" value=\"0#否\" type=\"radio\"/>否&nbsp;<br/></span>-|}</td></tr><tr><td style=\"word-break: break-all; border-color: rgb(0, 0, 0);\" width=\"123\" valign=\"top\">请假原因</td><td style=\"border-color: rgb(0, 0, 0);\" rowspan=\"1\" colspan=\"3\" valign=\"top\"><textarea class=\"form-control\" title=\"请假原因\" name=\"data_15\" leipiplugins=\"textarea\" value=\"\" fieldflow=\"0\" orgrich=\"1\" orgwidth=\"\" orgheight=\"250\" bind_table=\"U143934487927380227\" bind_table_field=\"U143934487932908016\" style=\"height: 250px;\"></textarea></td></tr></tbody></table><p><input name=\"data_24\" leipiplugins=\"listctrl\" value=\"{列表控件}\" readonly=\"readonly\" title=\"列表控件\" orgtitle=\"列表名称`列表别名`备注\" orgcoltype=\"text`text`text\" plugintype=\"cnoj-input-select``\" pluginuri=\"op/query/select_user_list.json``\" orgcolvalue=\"``\" bind_table=\"U148047582266440688\" bind_table_field=\"U148047582268647936`U148047582268788204`U148047582268795530\" orgwidth=\"100%\" style=\"width: 100%;\" tablewidth=\"\" fieldrequire=\"0`0`0\" fieldhide=\"0`0`0\" type=\"text\" remarks=\"（名称备注）```\" orgunit=\"``\" orgsum=\"0`0`0\" csum_bind_table=\"``\" csum_bind_table_field=\"``\"/></p><p><br/><textarea class=\"form-control require\" fieldrequire=\"1\" title=\"测试\" name=\"data_19\" leipiplugins=\"textarea\" value=\"\" fieldflow=\"0\" orgrich=\"0\" orgwidth=\"300\" orgheight=\"80\" orghide=\"0\" relate_field=\"\" relate_field_value=\"\" bind_table=\"U143934487927380227\" bind_table_field=\"U147451002482226487\" style=\"width:300px;height:80px;\"></textarea></p><p><br/></p><p><button name=\"data_25\" type=\"button\" leipiplugins=\"files\" title=\"测试上传\" bind_table=\"U149541854055529222\" bind_table_field=\"U149541854056344119\" filetype=\"jpg,png,gif,doc,docx,xls,xlsx,ppt,pptx,pdf,zip,rar,txt\" org_btn_style=\"btn-success\" maxfiles=\"5\" filesize=\"10\" remarks=\"上传文件备注信息测试\" id=\"U149541854055529222-U149541854056344119\" relate_field=\"\" relate_field_value=\"\" formtype=\"flow_form\" jscallback=\"showFormAttList\" formid=\"\" orguri=\"process/attachment/upload\" orghide=\"0\" class=\"btn btn-sm btn-success\" fieldrequire=\"0\">添加附件</button></p><p><br/></p><p><span style=\"font-size: 18px;\"></span></p>','<p style=\"text-align: center;\"><span style=\"font-size: 18px;\">请假条</span><br/></p><p><span style=\"font-size: 18px;\"></span></p><p><br/></p><table class=\"table table-bordered table-condensed\"  class=\"table table-bordered table-condensed\" style=\"border-color: rgb(0, 0, 0);\" width=\"1176\"><tbody><tr class=\"firstRow\"><td style=\"word-break: break-all; border-color: rgb(0, 0, 0);\" width=\"123\" valign=\"top\" height=\"20\">请假人 <a title=\"帮助\" href=\"javascript:void(0)\" id=\"P41f6d53f6c3d46f5b100bf1baf6e18de\" class=\"mix-popover\" data-content=\"请填写请假人的名称；如：张三\"><i class=\"fa fa-question-circle-o\" aria-hidden=\"true\"></i> </a></td><td style=\"border-color: rgb(0, 0, 0);\" width=\"568\" valign=\"top\" height=\"20\"><input type=\"text\" name=\"U143934487932911617\" id=\"U143934487932911617\" data-label-name=\"请假人\" value=\"\"  style=\"text-align: left;\" class=\"form-control require   \" /></td><td style=\"word-break: break-all; border-color: rgb(0, 0, 0);\" width=\"110\" valign=\"top\" height=\"20\">请假天数</td><td style=\"border-color: rgb(0, 0, 0);\" width=\"374\" valign=\"top\" height=\"20\"><input type=\"text\" name=\"U143934487932938828\" id=\"U143934487932938828\" data-label-name=\"请假天数\" value=\"\"  style=\"text-align: left;\" data-format=\"integer\" class=\"form-control require  \" data-format=\"integer\"  /></td></tr><tr><td colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(0, 0, 0);\" width=\"123\" valign=\"top\">测试日期1</td><td colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(0, 0, 0);\" width=\"568\" valign=\"top\"><input type=\"text\" name=\"U147230956895893116\" id=\"U147230956895893116\" data-label-name=\"测试日期\" value=\"\"  style=\"text-align: left; width: 150px;\" class=\"form-control require cnoj-date   \" />至<input type=\"text\" name=\"U147230956895933555\" id=\"U147230956895933555\" data-label-name=\"测试日期2\" value=\"\"  style=\"text-align: left; width: 150px;\" class=\"form-control require cnoj-date   \" /></td><td colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(0, 0, 0);\" width=\"110\" valign=\"top\">测试日期</td><td colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(0, 0, 0);\" width=\"374\" valign=\"top\"><br/></td></tr><tr><td colspan=\"1\" rowspan=\"1\" style=\"word-break: break-all; border-color: rgb(0, 0, 0);\" width=\"123\" valign=\"top\">请假类型</td><td style=\"border-color: rgb(0, 0, 0);\" colspan=\"1\" rowspan=\"1\" width=\"568\" valign=\"top\"><span class=\"cnoj-checkbox checkbox-parent\" data-label-name=\"请假类型\" data-is-horizontal=\"no\" data-require=\"require\" data-name=\"U147230479479356878\" data-uri=\"dict/itemById/D141787854035683659.json\"></span></td><td colspan=\"1\" rowspan=\"1\" style=\"word-break: break-all; border-color: rgb(0, 0, 0);\" width=\"110\" valign=\"top\">是否试用</td><td style=\"border-color: rgb(0, 0, 0);\" colspan=\"1\" rowspan=\"1\" width=\"374\" valign=\"top\"><span class=\"radio-parent\" data-label-name=\"是否试用\"><div><input type=\"radio\" class=\"\" name=\"U147245406891052771\" id=\"U147245406891052771_1\" value=\"1\"   /><label class=\"text-normal\" for=\"U147245406891052771_1\">是</label>&nbsp;</div><div><input type=\"radio\" class=\"\" name=\"U147245406891052771\" id=\"U147245406891052771_0\" value=\"0\"   /><label class=\"text-normal\" for=\"U147245406891052771_0\">否</label>&nbsp;</div></span></td></tr><tr><td style=\"word-break: break-all; border-color: rgb(0, 0, 0);\" width=\"123\" valign=\"top\">请假原因</td><td style=\"border-color: rgb(0, 0, 0);\" rowspan=\"1\" colspan=\"3\" valign=\"top\"><textarea name=\"U143934487932908016\" id=\"U143934487932908016\" class=\" cnoj-richtext\"data-label-name=\"请假原因\" style=\"height: 250px;\" ></textarea></td></tr></tbody></table><p><script type=\"text/javascript\">\r\n var addRows=1;\r\n function tbAddRow(dname, isInputEvent) {addRows++;\r\n   var sTbid = dname+\"_table\";\r\n if(typeof(isInputEvent) == \'undefined\') isInputEvent = true;\r\n  var $addTr = $(\"#\"+sTbid+\" .template\") \r\n    //连同事件一起复制   \r\n    .clone();\r\n   //去除模板标记 \r\n      $addTr.removeClass(\"template\");$addTr.attr(\"id\",\"row\"+addRows);\r\n var $sum = $addTr.find(\'.sum\');if($sum.length>0){$sum.removeClass(\'sum\')}    //修改内部元素 \r\n    $addTr.find(\".delrow\").removeClass(\"hide\");\r\n   $addTr.find(\"input,textarea\").each(function(){\r\n var id = $(this).attr(\"id\");id = id.replace(\'row-\',\'row\'+addRows+\'-\');$(this).attr(\"id\",id);$(this).val(\'\');\r\n $(this).attr(\"name\", $(this).attr(\"original-name\")); \r\n $(this).removeClass(\'cnoj-auto-complete-relate-listener cnoj-input-tree-listener cnoj-input-select-relate-listener cnoj-input-org-tree-listener cnoj-auto-complete-listener cnoj-input-select-listener cnoj-datetime-listener cnoj-date-listener cnoj-time-listener\'); $(this).parent().find(\'.glyphicon-calendar\').remove(); \r\n});\r\n   //插入表格  \r\n   $addTr.appendTo($(\"#\"+sTbid));if(isInputEvent){inputPluginEvent()};if(typeof(formAddRow) !== \'undefined\' && !utils.isEmpty(formAddRow) && typeof(formAddRow)===\'function\'){formAddRow(addRows,$addTr);}}\r\n //统计\r\n function sumTotal(dname,e) {\r\n  var tsum = 0; \r\n  $(\'input[name=\"\'+dname+\'\"]\').each(function(){\r\n          var t = parseFloat($(this).val()); \r\n          if(!t) t=0;\r\n          if(t) tsum +=t;\r\n          $(this).val(t);\r\n      }); \r\n  $(\'#\'+dname+\'_total\').val(tsum);$(\'#\'+dname+\'_total\').trigger(\'change\'); \r\n}\r\n /*删除tr*/\r\nfunction fnDeleteRow(obj,dname) { \r\n  var sTbid = dname+\"_table\";\r\n  var oTable = document.getElementById(sTbid);\r\n  while(obj.tagName !=\"TR\") {\r\n     obj = obj.parentNode;\r\n}\r\n     var id = $(obj).find(\'.id-value\').val();\r\n if(utils.isNotEmpty(id)){ var delValue = $(oTable).find(\'.del-value\').val();\r\n if(utils.isNotEmpty(delValue)){delValue = delValue+\',\'+id;} else {delValue=id;}\r\n $(oTable).find(\'.del-value\').val(delValue);} \r\n  oTable.deleteRow(obj.rowIndex);\r\n//删除后重新计算合计\r\n $(\'.sum\').each(function(){var dname = $(this).attr(\'name\');sumTotal(dname, this)});\r\n } /*监听修改情况tr*/\r\n function changeValue(obj){ var $table = $(obj).parents(\"table:eq(0)\"); var id =$(obj).parents(\"tr:eq(0)\").find(\".id-value\").val();  if(utils.isNotEmpty(id)){ var changeValue = $table.find(\'.change-value\').val(); var isset=false \r\n if(utils.isNotEmpty(changeValue)){if(changeValue.indexOf(id) == -1){changeValue = changeValue+\',\'+id;isset=true}} else {changeValue=id;isset=true}\r\n if(isset){$table.find(\'.change-value\').val(changeValue); }}\r\n };\r\n</script><table id=\"U148047582266440688_table\" cellspacing=\"0\" class=\"list-ctrl table table-bordered table-condensed\" style=\"width:100%\"><thead><tr style=\"background-color: #f5f5f5;\"><th colspan=\"4\"><div class=\"col-sm-6 p-l-5 listctrl-title\">列表控件</div> <div class=\"col-sm-6 p-r-5 text-right\"><button class=\"btn btn-sm btn-success listctrl-add-row hidden-print \" type=\"button\" onclick=\"tbAddRow(\'U148047582266440688\')\">添加一行</button></div></th></tr><tr><tr><th class=\"hidden\"><input type=\"hidden\" class=\"del-value\" name=\"U148047582266440688_del\" /><input type=\"hidden\" class=\"change-value\" name=\"U148047582266440688_change\" /></th><th>列表名称<p class=\"help-block\" style=\"margin:0;padding:0\">（名称备注）</p></th><th>列表别名</th><th>备注</th><th><span class=\"hidden-print\">操作</span></th></tr></thead><tr class=\"template\" id=\'row-1\'><td class=\"hidden\"><input type=\"hidden\" class=\"id-value\" id=\"row-U148047582266440688-0\" name=\"U148047582266440688_id\" /></td><td><input id=\"row-U148047582268647936-1\" onchange=\"changeValue(this)\" class=\"form-control listctrl-input input-medium U148047582268647936 cnoj-input-select\" type=\"text\" data-label-name=\"列表名称\" data-uri=\"op/query/select_user_list.json\" name=\"U148047582268647936\" original-name=\"U148047582268647936\" value=\"\"></td><td><input id=\"row-U148047582268788204-2\" onchange=\"changeValue(this)\" class=\"form-control listctrl-input input-medium U148047582268788204 \" type=\"text\" data-label-name=\"列表别名\" data-uri=\"\" name=\"U148047582268788204\" original-name=\"U148047582268788204\" value=\"\"></td><td><input id=\"row-U148047582268795530-3\" onchange=\"changeValue(this)\" class=\"form-control listctrl-input input-medium U148047582268795530 \" type=\"text\" data-label-name=\"备注\" data-uri=\"\" name=\"U148047582268795530\" original-name=\"U148047582268795530\" value=\"\"></td><td><a href=\"javascript:void(0);\" onclick=\"fnDeleteRow(this,\'U148047582266440688\')\" class=\"delrow hide hidden-print\">删除</a></td></tr></tbody></table></p><p><br/><textarea name=\"U147451002482226487\" id=\"U147451002482226487\" class=\"form-control require\"data-label-name=\"测试\" style=\"width:300px;height:80px;\" ></textarea></p><p><br/></p><p><div class=\"file-upload-wrap\"><div id=\"U149541854056344119\" data-label-name=\"测试上传\" class=\"file-upload   hidden-print\"><span class=\"btn btn-success btn-sm fileinput-button upload-add\"><i class=\"glyphicon glyphicon-paperclip\" aria-hidden=\"true\"></i> <span>添加附件</span><input class=\"cnoj-upload\" data-limit-upload-num=\"5\" data-uri=\"process/attachment/upload\" data-close-after=\"showFormAttList\" data-accept-file-types=\"jpg,png,gif,doc,docx,xls,xlsx,ppt,pptx,pdf,zip,rar,txt\" id=\"U149541854056344119-mfile\" type=\"file\" name=\"atts\" multiple  data-max-file-size=\'10485760\'/></span><div class=\"clear\"></div><div class=\"help-block\"></div></div></div></p><p><br/></p><p><span style=\"font-size: 18px;\"></span></p>','flow_form'),('U148161626064193166','2016-12-13 16:04:21','U141770099155103287',0,'测试字体','<h1 style=\"text-align: center;\"><span style=\"font-size: 18pt;\">标题一</span><span style=\"font-size: 16pt;\"><br/></span></h1><p><span style=\"font-size: 16pt;\">测试一下字体问题</span></p><p><span style=\"font-size: 16pt;\">在测试一下字体16pt字体类型</span><br/></p>','<h1 style=\"text-align: center;\"><span style=\"font-size: 18pt;\">标题一</span><span style=\"font-size: 16pt;\"><br/></span></h1><p><span style=\"font-size: 16pt;\">测试一下字体问题</span></p><p><span style=\"font-size: 16pt;\">在测试一下字体16pt字体类型</span><br/></p>','normal_form'),('U148466937920272372','2017-01-18 00:09:39','U141770099155103287',0,'测试选项卡','<p>测试选项卡内容</p><ul class=\"nav nav-tabs\" role=\"tablist\"><li role=\"presentation\" class=\"active\"><a id=\"0B9E30FF0CF224CE07182F684B5AE5C6\" mixform-plugins=\"a_tabs\" href=\"#tab-0B9E30FF0CF224CE07182F684B5AE5C6\" role=\"tab\" data-toggle=\"tab\"> 基本信息 </a></li><li role=\"presentation\"><a id=\"35D967512E0D9737E82EAC0C75556CED\" mixform-plugins=\"a_tabs\" href=\"#tab-35D967512E0D9737E82EAC0C75556CED\" role=\"tab\" data-toggle=\"tab\"> 详细信息 </a></li></ul><div class=\"tab-content\"><div role=\"tabpanel\" class=\"tab-pane active\" id=\"tab-0B9E30FF0CF224CE07182F684B5AE5C6\"><br/><p>这里添加“基本信息”选项卡的内容</p></div><div role=\"tabpanel\" class=\"tab-pane \" id=\"tab-35D967512E0D9737E82EAC0C75556CED\"><br/><p>这里添加“详细信息”选项卡的内容</p></div></div><p><br/></p>','<p>测试选项卡内容</p><ul class=\"nav nav-tabs\" role=\"tablist\"><li role=\"presentation\" class=\"active\"><a id=\"0B9E30FF0CF224CE07182F684B5AE5C6\" mixform-plugins=\"a_tabs\" href=\"#tab-0B9E30FF0CF224CE07182F684B5AE5C6\" role=\"tab\" data-toggle=\"tab\"> 基本信息 </a></li><li role=\"presentation\"><a id=\"35D967512E0D9737E82EAC0C75556CED\" mixform-plugins=\"a_tabs\" href=\"#tab-35D967512E0D9737E82EAC0C75556CED\" role=\"tab\" data-toggle=\"tab\"> 详细信息 </a></li></ul><div class=\"tab-content\"><div role=\"tabpanel\" class=\"tab-pane active\" id=\"tab-0B9E30FF0CF224CE07182F684B5AE5C6\"><br/><p>这里添加“基本信息”选项卡的内容</p></div><div role=\"tabpanel\" class=\"tab-pane \" id=\"tab-35D967512E0D9737E82EAC0C75556CED\"><br/><p>这里添加“详细信息”选项卡的内容</p></div></div><p><br/></p>','flow_form'),('U150108080025383738','2017-07-26 22:53:20','U141770099155103287',6,'测试普通表单','<h3 style=\"text-align: center;\">问卷调查</h3><table class=\"table table-bordered table-condensed\"  class=\"table table-bordered table-condensed\" data-sort=\"sortDisabled\"><tbody><tr class=\"firstRow\"><td width=\"112.33333333333333\" valign=\"top\" style=\"word-break: break-all;\">名称</td><td width=\"366\" valign=\"top\"><input name=\"data_6\" type=\"text\" leipiplugins=\"text\" value=\"\" title=\"名称\" bind_table=\"U143934487927380227\" bind_table_field=\"U143934487932911617\" id=\"U143934487927380227-U143934487932911617\" date_format=\"\" input_plugin=\"\" input_plugin_uri=\"\" relate_field=\"\" relate_field_value=\"\" class=\"form-control require\" orghide=\"0\" institle=\"1\" is_log=\"0\" fieldrequire=\"1\" orgalign=\"left\" orgwidth=\"\" orgtype=\"text\" data_format=\"\" style=\"text-align: left;\"/></td><td width=\"104.33333333333334\" valign=\"top\" style=\"word-break: break-all;\">性别</td><td width=\"394\" valign=\"top\">{|-<span leipiplugins=\"radios\" fieldname=\"U143934487927380227-U147245406891052771\" orgchecked=\"orgchecked0\" title=\"性别\" orgtitle=\"性别\" from_data=\"cus_item\" data_value=\"\" data_uri=\"\" is_log=\"0\" dynamicload=\"0\" fieldrequire=\"0\" bind_table=\"U143934487927380227\" bind_table_field=\"U147245406891052771\" name=\"data_2\" fieldflow=\"0\"><input name=\"data_7\" value=\"男#男\" type=\"radio\"/>男&nbsp;<input name=\"data_7\" value=\"女#女\" type=\"radio\"/>女&nbsp;</span>-|}</td></tr><tr><td width=\"112.33333333333333\" valign=\"top\" style=\"word-break: break-all;\">出生年月日</td><td width=\"366\" valign=\"top\"><input name=\"data_3\" type=\"text\" leipiplugins=\"text\" value=\"\" title=\"出生日\" bind_table=\"U143934487927380227\" bind_table_field=\"U147451002482226487\" id=\"U143934487927380227-U147451002482226487\" date_format=\"\" input_plugin=\"\" input_plugin_uri=\"\" relate_field=\"\" relate_field_value=\"\" class=\"form-control cnoj-date\" orghide=\"0\" institle=\"0\" is_log=\"0\" fieldrequire=\"0\" orgalign=\"left\" orgwidth=\"\" orgtype=\"date\" data_format=\"date\" style=\"text-align: left;\"/></td><td width=\"104.33333333333334\" valign=\"top\" style=\"word-break: break-all;\">民族</td><td width=\"394\" valign=\"top\"><input name=\"data_4\" type=\"text\" leipiplugins=\"text\" value=\"\" title=\"民族\" bind_table=\"U143934487927380227\" bind_table_field=\"U147230479479356878\" id=\"U143934487927380227-U147230479479356878\" date_format=\"\" input_plugin=\"\" input_plugin_uri=\"\" relate_field=\"\" relate_field_value=\"\" class=\"form-control\" orghide=\"0\" institle=\"0\" is_log=\"0\" fieldrequire=\"0\" orgalign=\"left\" orgwidth=\"\" orgtype=\"text\" data_format=\"\" style=\"text-align: left;\"/></td></tr><tr><td width=\"112.33333333333333\" valign=\"top\" style=\"word-break: break-all;\">其他</td><td valign=\"top\" rowspan=\"1\" colspan=\"3\"><textarea 0=\"\" class=\"form-control\" fieldrequire=\"0\" title=\"其他\" name=\"data_5\" leipiplugins=\"textarea\" value=\"\" orgrich=\"0\" orgwidth=\"\" orgheight=\"150\" orghide=\"0is_log\" relate_field=\"\" relate_field_value=\"\" bind_table=\"U143934487927380227\" bind_table_field=\"U143934487932908016\" style=\"height:150px;\"></textarea></td></tr><tr><td width=\"112.33333333333333\" valign=\"top\" style=\"word-break: break-all;\">测试附件</td><td width=\"366\" valign=\"top\"><input name=\"data_12\" type=\"file\" leipiplugins=\"file\" title=\"测试附件\" bind_table=\"U149541854055529222\" bind_table_field=\"U150436604721675602\" filetype=\"jpg,png,gif,doc,docx,xls,xlsx,ppt,pptx,pdf,zip,rar,txt\" id=\"U149541854055529222-U150436604721675602\" relate_field=\"\" relate_field_value=\"\" orghide=\"0\" fieldrequire=\"0\" class=\"\" orgwidth=\"200\" is_log=\"0\" style=\"width: 200px;\"/></td><td width=\"104.33333333333334\" valign=\"top\"><br/></td><td width=\"394\" valign=\"top\"><br/></td></tr><tr><td width=\"112.33333333333333\" valign=\"top\"><br/></td><td width=\"366\" valign=\"top\"><br/></td><td width=\"104.33333333333334\" valign=\"top\"><br/></td><td width=\"394\" valign=\"top\"><br/></td></tr></tbody></table><p><br/></p>','<h3 style=\"text-align: center;\">问卷调查</h3><table class=\"table table-bordered table-condensed\"  class=\"table table-bordered table-condensed\" data-sort=\"sortDisabled\"><tbody><tr class=\"firstRow\"><td width=\"112.33333333333333\" valign=\"top\" style=\"word-break: break-all;\">名称</td><td width=\"366\" valign=\"top\"><input type=\"text\" name=\"U143934487932911617\" id=\"U143934487932911617\" data-label-name=\"名称\" value=\"\"  style=\"text-align: left;\" class=\"form-control require   \" /></td><td width=\"104.33333333333334\" valign=\"top\" style=\"word-break: break-all;\">性别</td><td width=\"394\" valign=\"top\"><span class=\"radio-parent\" data-label-name=\"性别\"><input type=\"radio\" class=\"\" name=\"U147245406891052771\" id=\"U147245406891052771_男\" value=\"男\"   /><label class=\"text-normal\" for=\"U147245406891052771_男\">男</label>&nbsp;<input type=\"radio\" class=\"\" name=\"U147245406891052771\" id=\"U147245406891052771_女\" value=\"女\"   /><label class=\"text-normal\" for=\"U147245406891052771_女\">女</label>&nbsp;</span></td></tr><tr><td width=\"112.33333333333333\" valign=\"top\" style=\"word-break: break-all;\">出生年月日</td><td width=\"366\" valign=\"top\"><input type=\"text\" name=\"U147451002482226487\" id=\"U147451002482226487\" data-label-name=\"出生日\" value=\"\"  style=\"text-align: left;\" data-format=\"date\" class=\"form-control cnoj-date   \" /></td><td width=\"104.33333333333334\" valign=\"top\" style=\"word-break: break-all;\">民族</td><td width=\"394\" valign=\"top\"><input type=\"text\" name=\"U147230479479356878\" id=\"U147230479479356878\" data-label-name=\"民族\" value=\"\"  style=\"text-align: left;\" class=\"form-control   \" /></td></tr><tr><td width=\"112.33333333333333\" valign=\"top\" style=\"word-break: break-all;\">其他</td><td valign=\"top\" rowspan=\"1\" colspan=\"3\"><textarea name=\"U143934487932908016\" id=\"U143934487932908016\" class=\"form-control\"data-label-name=\"其他\" style=\"height:150px;\" ></textarea></td></tr><tr><td width=\"112.33333333333333\" valign=\"top\" style=\"word-break: break-all;\">测试附件</td><td width=\"366\" valign=\"top\"><input type=\"file\" name=\"U150436604721675602\" id=\"U150436604721675602\" data-label-name=\"测试附件\" value=\"\"  style=\"width: 200px;\" accept=\"image/jpeg,image/png,image/gif,application/msword,application/vnd.openxmlformats-officedocument.wordprocessingml.document,application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,application/vnd.ms-powerpoint,application/vnd.openxmlformats-officedocument.presentationml.presentation,application/pdf,application/x-zip-compressed,application/octet-stream,text/plain\" class=\"\" /></td><td width=\"104.33333333333334\" valign=\"top\"><br/></td><td width=\"394\" valign=\"top\"><br/></td></tr><tr><td width=\"112.33333333333333\" valign=\"top\"><br/></td><td width=\"366\" valign=\"top\"><br/></td><td width=\"104.33333333333334\" valign=\"top\"><br/></td><td width=\"394\" valign=\"top\"><br/></td></tr></tbody></table><p><br/></p>','normal_form'),('U150523148906512260','2017-09-12 23:51:29','U141770099155103287',6,'普通表单测试2','<table class=\"table table-bordered table-condensed\"  class=\"table table-bordered table-condensed\"><tbody><tr class=\"firstRow\"><td width=\"108.33333333333334\" valign=\"top\" style=\"word-break: break-all;\">测试1</td><td width=\"390\" valign=\"top\"><input name=\"data_6\" type=\"text\" leipiplugins=\"text\" value=\"\" title=\"测试1\" bind_table=\"U143934487927380227\" bind_table_field=\"U143934487932911617\" id=\"U143934487927380227-U143934487932911617\" date_format=\"\" input_plugin=\"\" input_plugin_uri=\"\" relate_field=\"\" relate_field_value=\"\" class=\"form-control\" orghide=\"0\" institle=\"0\" is_log=\"0\" fieldrequire=\"0\" orgalign=\"left\" orgwidth=\"\" orgtype=\"text\" data_format=\"\" style=\"text-align: left;\"/></td><td width=\"129.33333333333334\" valign=\"top\" style=\"word-break: break-all;\">测试3</td><td width=\"369\" valign=\"top\"><input name=\"data_7\" type=\"text\" leipiplugins=\"text\" value=\"\" title=\"测试3\" bind_table=\"U143934487927380227\" bind_table_field=\"U143934487932908016\" id=\"U143934487927380227-U143934487932908016\" date_format=\"\" input_plugin=\"\" input_plugin_uri=\"\" relate_field=\"\" relate_field_value=\"\" class=\"form-control\" orghide=\"0\" institle=\"0\" is_log=\"0\" fieldrequire=\"0\" orgalign=\"left\" orgwidth=\"\" orgtype=\"text\" data_format=\"\" style=\"text-align: left;\"/></td></tr><tr><td width=\"108.33333333333334\" valign=\"top\" style=\"word-break: break-all;\">测试2</td><td width=\"390\" valign=\"top\"><input name=\"data_8\" type=\"text\" leipiplugins=\"text\" value=\"\" title=\"测试2\" bind_table=\"U147230956895632564\" bind_table_field=\"U147230956895893116\" id=\"U147230956895632564-U147230956895893116\" date_format=\"\" input_plugin=\"\" input_plugin_uri=\"\" relate_field=\"\" relate_field_value=\"\" class=\"form-control\" orghide=\"0\" institle=\"0\" is_log=\"0\" fieldrequire=\"0\" orgalign=\"left\" orgwidth=\"\" orgtype=\"text\" data_format=\"\" style=\"text-align: left;\"/></td><td width=\"129.33333333333334\" valign=\"top\" style=\"word-break: break-all;\">测试4</td><td width=\"369\" valign=\"top\"><br/></td></tr><tr><td width=\"108.33333333333334\" valign=\"top\"><br/></td><td width=\"390\" valign=\"top\"><br/></td><td width=\"129.33333333333334\" valign=\"top\"><br/></td><td width=\"369\" valign=\"top\"><br/></td></tr></tbody></table><p><input name=\"data_10\" type=\"text\" readonly=\"readonly\" leipiplugins=\"listctrl\" value=\"{列表控件}\" title=\"列表控件\" tablewidth=\"100%\" orgtitle=\"名称`小计\" orgcoltype=\"text`int\" orgunit=\"`天\" orgsum=\"0`1\" fieldrequire=\"0`0\" fieldhide=\"0`0\" plugintype=\"`\" pluginuri=\"`\" orgcolvalue=\"`\" bind_table=\"U148047582266440688\" bind_table_field=\"U148047582268647936`U148047582268788204\" remarks=\"``\" csum_bind_table=\"`U149541854055529222\" csum_bind_table_field=\"`U149541854056344119\" orgwidth=\"100%\" style=\"width: 100%;\"/></p>','<table class=\"table table-bordered table-condensed\"  class=\"table table-bordered table-condensed\"><tbody><tr class=\"firstRow\"><td width=\"108.33333333333334\" valign=\"top\" style=\"word-break: break-all;\">测试1</td><td width=\"390\" valign=\"top\"><input type=\"text\" name=\"U143934487932911617\" id=\"U143934487932911617\" data-label-name=\"测试1\" value=\"\"  style=\"text-align: left;\" class=\"form-control   \" /></td><td width=\"129.33333333333334\" valign=\"top\" style=\"word-break: break-all;\">测试3</td><td width=\"369\" valign=\"top\"><input type=\"text\" name=\"U143934487932908016\" id=\"U143934487932908016\" data-label-name=\"测试3\" value=\"\"  style=\"text-align: left;\" class=\"form-control   \" /></td></tr><tr><td width=\"108.33333333333334\" valign=\"top\" style=\"word-break: break-all;\">测试2</td><td width=\"390\" valign=\"top\"><input type=\"text\" name=\"U147230956895893116\" id=\"U147230956895893116\" data-label-name=\"测试2\" value=\"\"  style=\"text-align: left;\" class=\"form-control   \" /></td><td width=\"129.33333333333334\" valign=\"top\" style=\"word-break: break-all;\">测试4</td><td width=\"369\" valign=\"top\"><br/></td></tr><tr><td width=\"108.33333333333334\" valign=\"top\"><br/></td><td width=\"390\" valign=\"top\"><br/></td><td width=\"129.33333333333334\" valign=\"top\"><br/></td><td width=\"369\" valign=\"top\"><br/></td></tr></tbody></table><p><script type=\"text/javascript\">\r\n var addRows=1;\r\n function tbAddRow(dname) {addRows++;\r\n   var sTbid = dname+\"_table\";\r\n  var $addTr = $(\"#\"+sTbid+\" .template\") \r\n    //连同事件一起复制   \r\n    .clone();\r\n   //去除模板标记 \r\n      $addTr.removeClass(\"template\");$addTr.attr(\"id\",\"row\"+addRows);\r\n var $sum = $addTr.find(\'.sum\');if($sum.length>0){$sum.removeClass(\'sum\')}    //修改内部元素 \r\n    $addTr.find(\".delrow\").removeClass(\"hide\");\r\n   $addTr.find(\"input,textarea\").each(function(){\r\n var id = $(this).attr(\"id\");id = id.replace(\'row-\',\'row\'+addRows+\'-\');$(this).attr(\"id\",id);$(this).val(\'\');\r\n $(this).attr(\"name\", $(this).attr(\"original-name\")); \r\n $(this).removeClass(\'cnoj-auto-complete-relate-listener cnoj-input-tree-listener cnoj-input-select-relate-listener cnoj-input-org-tree-listener cnoj-auto-complete-listener cnoj-input-select-listener cnoj-datetime-listener cnoj-date-listener cnoj-time-listener\'); $(this).parent().find(\'.glyphicon-calendar\').remove(); \r\n});\r\n   //插入表格  \r\n   $addTr.appendTo($(\"#\"+sTbid));inputPluginEvent();if(typeof(formAddRow) !== \'undefined\' && !utils.isEmpty(formAddRow) && typeof(formAddRow)===\'function\'){formAddRow(addRows,$addTr);}}\r\n //统计\r\n function sumTotal(dname,e) {\r\n  var tsum = 0; \r\n  $(\'input[name=\"\'+dname+\'\"]\').each(function(){\r\n          var t = parseFloat($(this).val()); \r\n          if(!t) t=0;\r\n          if(t) tsum +=t;\r\n          $(this).val(t);\r\n      }); \r\n  $(\'#\'+dname+\'_total\').val(tsum);$(\'#\'+dname+\'_total\').trigger(\'change\'); \r\n}\r\n /*删除tr*/\r\nfunction fnDeleteRow(obj,dname) { \r\n  var sTbid = dname+\"_table\";\r\n  var oTable = document.getElementById(sTbid);\r\n  while(obj.tagName !=\"TR\") {\r\n     obj = obj.parentNode;\r\n}\r\n     var id = $(obj).find(\'.id-value\').val();\r\n if(utils.isNotEmpty(id)){ var delValue = $(oTable).find(\'.del-value\').val();\r\n if(utils.isNotEmpty(delValue)){delValue = delValue+\',\'+id;} else {delValue=id;}\r\n $(oTable).find(\'.del-value\').val(delValue);} \r\n  oTable.deleteRow(obj.rowIndex);\r\n//删除后重新计算合计\r\n $(\'.sum\').each(function(){var dname = $(this).attr(\'name\');sumTotal(dname, this)});\r\n } /*监听修改情况tr*/\r\n function changeValue(obj){ var $table = $(obj).parents(\"table:eq(0)\"); var id =$(obj).parents(\"tr:eq(0)\").find(\".id-value\").val();  if(utils.isNotEmpty(id)){ var changeValue = $table.find(\'.change-value\').val(); var isset=false \r\n if(utils.isNotEmpty(changeValue)){if(changeValue.indexOf(id) == -1){changeValue = changeValue+\',\'+id;isset=true}} else {changeValue=id;isset=true}\r\n if(isset){$table.find(\'.change-value\').val(changeValue); }}\r\n };\r\n</script><table id=\"U148047582266440688_table\" cellspacing=\"0\" class=\"list-ctrl table table-bordered table-condensed\" style=\"width:100%\"><thead><tr style=\"background-color: #f5f5f5;\"><th colspan=\"3\"><div class=\"col-sm-6 p-l-5 listctrl-title\">列表控件</div> <div class=\"col-sm-6 p-r-5 text-right\"><button class=\"btn btn-sm btn-success listctrl-add-row hidden-print \" type=\"button\" onclick=\"tbAddRow(\'U148047582266440688\')\">添加一行</button></div></th></tr><tr><tr><th class=\"hidden\"><input type=\"hidden\" class=\"del-value\" name=\"U148047582266440688_del\" /><input type=\"hidden\" class=\"change-value\" name=\"U148047582266440688_change\" /></th><th>名称</th><th>小计</th><th><span class=\"hidden-print\">操作</span></th></tr></thead><tr class=\"template\" id=\'row-1\'><td class=\"hidden\"><input type=\"hidden\" class=\"id-value\" id=\"row-U148047582266440688-0\" name=\"U148047582266440688_id\" /></td><td><input id=\"row-U148047582268647936-1\" onchange=\"changeValue(this)\" class=\"form-control listctrl-input input-medium U148047582268647936 \" type=\"text\" data-label-name=\"名称\" data-uri=\"\" name=\"U148047582268647936\" original-name=\"U148047582268647936\" value=\"\"></td><td><input id=\"row-U148047582268788204-2\" onchange=\"changeValue(this)\" class=\"form-control listctrl-input sum input-medium U148047582268788204\" type=\"text\" data-label-name=\"小计\" name=\"U148047582268788204\" original-name=\"U148047582268788204\" onblur=\"sumTotal(\'U148047582268788204\', this)\" value=\"\"> 天</td><td><a href=\"javascript:void(0);\" onclick=\"fnDeleteRow(this,\'U148047582266440688\')\" class=\"delrow hide hidden-print\">删除</a></td></tr></tbody><tfooter><tr id=\'row-tfooter-1\'><td></td><td>合计：<input id=\"U148047582268788204_total\" onchange=\"changeValue(this)\" type=\"text\" style=\"width:80%;\" class=\"form-control input-medium U149541854056344119 \" name=\"U149541854056344119\" original-name=\"U149541854056344119\" onblur=\"sumTotal(\'U148047582268788204\', this)\" /> 天</td><td></td></tr></tfooter></table></p>','normal_form'),('U1558977787092277233','2016-10-31 14:19:33','U141770099155103287',3,'测试列表控件2','<p><input name=\"data_1\" leipiplugins=\"listctrl\" type=\"text\" value=\"{列表控件}\" readonly=\"readonly\" title=\"测试列表控件\" orgtitle=\"表头1`表头2`表头3\" orgcoltype=\"text`text`text\" plugintype=\"``\" pluginuri=\"``\" orgcolvalue=\"``\" bind_table=\"U143934487927380227\" bind_table_field=\"U143934487932911617`U143934487932938828`U143934487932908016\" orgwidth=\"100%\" style=\"width: 100%;\"/></p>','<p><script type=\"text/javascript\">\r\n var addRows=1;\r\n function tbAddRow(dname) {addRows++;\r\n   var sTbid = dname+\"_table\";\r\n  var $addTr = $(\"#\"+sTbid+\" .template\") \r\n    //连同事件一起复制   \r\n    .clone();\r\n   //去除模板标记 \r\n      $addTr.removeClass(\"template\");$addTr.attr(\"id\",\"row\"+addRows);\r\n    //修改内部元素 \r\n    $addTr.find(\".delrow\").removeClass(\"hide\");\r\n $addTr.find(\"input[type=hidden]\").remove();   $addTr.find(\"input,textarea\").each(function(){\r\n var id = $(this).attr(\"id\");id = id.replace(\'row-\',\'row\'+addRows+\'-\');$(this).attr(\"id\",id);$(this).val(\'\');\r\n $(this).removeClass(\'cnoj-auto-complete-relate-listener cnoj-input-tree-listener cnoj-input-select-relate-listener cnoj-input-org-tree-listener cnoj-auto-complete-listener cnoj-input-select-listener cnoj-datetime-listener cnoj-date-listener cnoj-time-listener\'); $(this).parent().find(\'.glyphicon-calendar\').remove(); \r\n});\r\n   //插入表格  \r\n     $addTr.appendTo($(\"#\"+sTbid));inputPluginEvent();if(typeof(formAddRow) !== \'undefined\' && !utils.isEmpty(formAddRow) && typeof(formAddRow)===\'function\'){formAddRow(addRows);}}\r\n //统计\r\n function sum_total(dname,e) {\r\n  var tsum = 0; \r\n  $(\'input[name=\"\'+dname+\'\"]\').each(function(){\r\n          var t = parseFloat($(this).val()); \r\n          if(!t) t=0;\r\n          if(t) tsum +=t;\r\n          $(this).val(t);\r\n      }); \r\n  $(\'input[name=\"\'+dname+\'[total]\"]\').val(tsum);\r\n}\r\n /*删除tr*/\r\nfunction fnDeleteRow(obj,dname) { \r\n  var sTbid = dname+\"_table\";\r\n  var oTable = document.getElementById(sTbid);\r\n  while(obj.tagName !=\"TR\") {\r\n     obj = obj.parentNode;\r\n}\r\n  oTable.deleteRow(obj.rowIndex);\r\n}\r\n</script><table id=\"U143934487927380227_table\" cellspacing=\"0\" class=\"list-ctrl table table-bordered table-condensed\" style=\"width: 100%;\"><thead><tr><th colspan=\"4\"><div class=\"col-sm-6 p-l-5 listctrl-title\">测试列表控件</div> <div class=\"col-sm-6 p-r-5 text-right\"><button class=\"btn btn-sm btn-success listctrl-add-row hidden-print \" type=\"button\" onclick=\"tbAddRow(\'U143934487927380227\')\">添加一行</button></div></th></tr><tr><tr><td>表头1</td><td>表头2</td><td>表头3</td><th><span class=\"hidden-print\">操作</span></th></tr></thead><tr class=\"template\" id=\'row-1\'><td><input id=\"row-U143934487932911617-1\" class=\"form-control input-medium U143934487932911617 \" type=\"text\" data-uri=\"\" name=\"U143934487932911617\" value=\"\"></td><td><input id=\"row-U143934487932938828-2\" class=\"form-control input-medium U143934487932938828 \" type=\"text\" data-uri=\"\" name=\"U143934487932938828\" value=\"\"></td><td><input id=\"row-U143934487932908016-3\" class=\"form-control input-medium U143934487932908016 \" type=\"text\" data-uri=\"\" name=\"U143934487932908016\" value=\"\"></td><td><a href=\"javascript:void(0);\" onclick=\"fnDeleteRow(this,\'U143934487927380227\')\" class=\"delrow hide hidden-print\">删除</a></td></tr></tbody></table></p>','normal_form');

/*Table structure for table `t_form_attachment` */

DROP TABLE IF EXISTS `t_form_attachment`;

CREATE TABLE `t_form_attachment` (
  `id` varchar(50) NOT NULL,
  `attachment_id` varchar(50) NOT NULL,
  `form_data_id` varchar(50) NOT NULL,
  `form_id` varchar(50) NOT NULL,
  `create_timestamp` bigint(20) DEFAULT NULL,
  `user_id` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_form_attachment` */

insert  into `t_form_attachment`(`id`,`attachment_id`,`form_data_id`,`form_id`,`create_timestamp`,`user_id`) values ('U150281171522283819','ATT_U150281171521675346','','U150108080025383738',NULL,NULL);

/*Table structure for table `t_form_field` */

DROP TABLE IF EXISTS `t_form_field`;

CREATE TABLE `t_form_field` (
  `id` varchar(32) NOT NULL,
  `flow` varchar(50) DEFAULT NULL,
  `form_id` varchar(32) NOT NULL,
  `plugins` varchar(50) DEFAULT NULL,
  `table_field_id` varchar(32) NOT NULL,
  `table_id` varchar(32) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `type` varchar(126) DEFAULT NULL,
  `is_institle` varchar(10) DEFAULT NULL,
  `is_log` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_form_field` */

insert  into `t_form_field`(`id`,`flow`,`form_id`,`plugins`,`table_field_id`,`table_id`,`title`,`type`,`is_institle`,`is_log`) values ('U147789477283227352',NULL,'U1558977787092277233','listctrl','U143934487932908016','U143934487927380227','表头3',NULL,'0',NULL),('U147789477283253545',NULL,'U1558977787092277233','listctrl','U143934487932938828','U143934487927380227','表头2',NULL,'0',NULL),('U147789477283275359',NULL,'U1558977787092277233','listctrl','U143934487932911617','U143934487927380227','表头1',NULL,'0',NULL),('U150437227955720393',NULL,'U150108080025383738','text','U147230479479356878','U143934487927380227','民族','text','0',0),('U150437227955783429','0','U150108080025383738','radios','U147245406891052771','U143934487927380227','性别',NULL,NULL,0),('U150437227955784368',NULL,'U150108080025383738','text','U143934487932911617','U143934487927380227','名称','text','1',0),('U150437227955784792',NULL,'U150108080025383738','text','U147451002482226487','U143934487927380227','出生日','date','0',0),('U150437227955823991',NULL,'U150108080025383738','textarea','U143934487932908016','U143934487927380227','其他',NULL,NULL,0),('U150437227955854951',NULL,'U150108080025383738','file','U150436604721675602','U149541854055529222','测试附件',NULL,NULL,0),('U151188844241396767',NULL,'U150523148906512260','text','U143934487932911617','U143934487927380227','测试1','text','0',0),('U151188844241407158',NULL,'U150523148906512260','text','U143934487932908016','U143934487927380227','测试3','text','0',0),('U151188844241417184',NULL,'U150523148906512260','listctrl','U148047582268788204','U148047582266440688','小计',NULL,'0',0),('U151188844241422582',NULL,'U150523148906512260','listctrl','U148047582268647936','U148047582266440688','名称',NULL,'0',0),('U151188844241427033',NULL,'U150523148906512260','text','U147230956895893116','U147230956895632564','测试2','text','0',0),('U151188844241445510',NULL,'U150523148906512260','sum','U149541854056344119','U149541854055529222','合计',NULL,'0',0),('U151240130998452916','0','U143934508368932354','text','U143934487932911617','U143934487927380227','请假人','text','1',0),('U151240130998520724','1','U143934508368932354','text','U143934487932938828','U143934487927380227','请假天数','integer','0',0),('U151240130998520827','0','U143934508368932354','text','U147230956895893116','U147230956895632564','测试日期','date','0',0),('U151240130998559131','0','U143934508368932354','text','U147230956895933555','U147230956895632564','测试日期2','date','0',0),('U151240130999804521',NULL,'U143934508368932354','listctrl','U148047582268788204','U148047582266440688','列表别名',NULL,'0',0),('U151240130999823909',NULL,'U143934508368932354','listctrl','U148047582268647936','U148047582266440688','列表名称',NULL,'0',0),('U151240130999837282','0','U143934508368932354','checkboxs','U147230479479356878','U143934487927380227','请假类型',NULL,NULL,0),('U151240130999841321','0','U143934508368932354','radios','U147245406891052771','U143934487927380227','是否试用',NULL,NULL,0),('U151240130999845314',NULL,'U143934508368932354','listctrl','U148047582268795530','U148047582266440688','备注',NULL,'0',0),('U151240130999871828','0','U143934508368932354','textarea','U143934487932908016','U143934487927380227','请假原因',NULL,NULL,0),('U151240130999971918','0','U143934508368932354','textarea','U147451002482226487','U143934487927380227','测试',NULL,NULL,0),('U151240130999977079',NULL,'U143934508368932354','files','U149541854056344119','U149541854055529222','测试上传',NULL,NULL,0);

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

insert  into `t_form_helper`(`id`,`content`,`create_time`,`state`,`title`,`user_id`) values ('FH_U147693198269103042','<p>测试内容</p><p>测试跳转到<a href=\"http://www.baidu.com\" target=\"_blank\">百度</a></p>','2016-10-20 10:53:03',1,'测试1','U141770099155103287'),('FH_U147728017682531375','<style type=\"text/css\">\r\n		@page { margin: 2cm }\r\n		p { margin-bottom: 0.25cm; direction: ltr; line-height: 120%; text-align: justify; orphans: 0; widows: 0 }\r\n		p.western { font-family: \"Times New Roman\", serif }\r\n		p.cjk { font-family: \"宋体\" }\r\n		p.ctl { font-family: \"Times New Roman\"; font-size: 10pt }	</style><center><br/><table class=\"table table-bordered table-condensed\"  class=\"table table-bordered table-condensed\" width=\"634\" cellpadding=\"9\" cellspacing=\"0\"><colgroup><col width=\"70\"/><col width=\"277\"/><col width=\"108\"/><col width=\"105\"/></colgroup><tbody><tr class=\"firstRow\"><td width=\"70\" height=\"18\" style=\"border-color: rgb(0, 0, 10); padding: 0cm 0.19cm;\"><p class=\"cjk\" style=\"text-align:center;\"><span style=\"color:#000000\"><span style=\"font-size: 12pt\"><strong>序号</strong></span></span></p></td><td width=\"277\" style=\"border-top-color: rgb(0, 0, 10); border-bottom-color: rgb(0, 0, 10); border-left: none; border-right-color: rgb(0, 0, 10); padding: 0cm 0.19cm 0cm 0cm;\"><p class=\"cjk\" style=\"text-align:center;\"><span style=\"color:#000000\"><span style=\"font-size: 12pt\"><strong>产品（项目）名称</strong></span></span></p></td><td width=\"108\" style=\"border-top-color: rgb(0, 0, 10); border-bottom-color: rgb(0, 0, 10); border-left: none; border-right-color: rgb(0, 0, 10); padding: 0cm 0.19cm 0cm 0cm;\"><p class=\"cjk\" style=\"text-align:center;\"><span style=\"color:#000000\"><span style=\"font-size: 12pt\"><strong>数量</strong></span></span></p></td><td width=\"105\" style=\"border-top-color: rgb(0, 0, 10); border-bottom-color: rgb(0, 0, 10); border-left: none; border-right-color: rgb(0, 0, 10); padding: 0cm 0.19cm 0cm 0cm;\"><p class=\"cjk\" style=\"text-align:center;\"><span style=\"color:#000000\"><span style=\"font-size: 12pt\"><strong>计量单位</strong></span></span></p></td></tr><tr><td width=\"70\" height=\"4\" style=\"border-top: none; border-bottom-color: rgb(0, 0, 10); border-left-color: rgb(0, 0, 10); border-right-color: rgb(0, 0, 10); padding: 0cm 0.19cm;\">1</td><td width=\"277\" style=\"border-top: none; border-bottom-color: rgb(0, 0, 10); border-left: none; border-right-color: rgb(0, 0, 10); padding: 0cm 0.19cm 0cm 0cm;\"><br/></td><td width=\"108\" style=\"border-top: none; border-bottom-color: rgb(0, 0, 10); border-left: none; border-right-color: rgb(0, 0, 10); padding: 0cm 0.19cm 0cm 0cm;\"><br/></td><td width=\"105\" style=\"border-top: none; border-bottom-color: rgb(0, 0, 10); border-left: none; border-right-color: rgb(0, 0, 10); padding: 0cm 0.19cm 0cm 0cm;\"><br/></td></tr><tr><td width=\"70\" height=\"4\" style=\"border-top: none; border-bottom-color: rgb(0, 0, 10); border-left-color: rgb(0, 0, 10); border-right-color: rgb(0, 0, 10); padding: 0cm 0.19cm;\">2</td><td width=\"277\" style=\"border-top: none; border-bottom-color: rgb(0, 0, 10); border-left: none; border-right-color: rgb(0, 0, 10); padding: 0cm 0.19cm 0cm 0cm;\"><br/></td><td width=\"108\" style=\"border-top: none; border-bottom-color: rgb(0, 0, 10); border-left: none; border-right-color: rgb(0, 0, 10); padding: 0cm 0.19cm 0cm 0cm;\"><br/></td><td width=\"105\" style=\"border-top: none; border-bottom-color: rgb(0, 0, 10); border-left: none; border-right-color: rgb(0, 0, 10); padding: 0cm 0.19cm 0cm 0cm;\"><br/></td></tr><tr><td width=\"70\" height=\"4\" style=\"border-top: none; border-bottom-color: rgb(0, 0, 10); border-left-color: rgb(0, 0, 10); border-right-color: rgb(0, 0, 10); padding: 0cm 0.19cm;\">3</td><td width=\"277\" style=\"border-top: none; border-bottom-color: rgb(0, 0, 10); border-left: none; border-right-color: rgb(0, 0, 10); padding: 0cm 0.19cm 0cm 0cm;\"><br/></td><td width=\"108\" style=\"border-top: none; border-bottom-color: rgb(0, 0, 10); border-left: none; border-right-color: rgb(0, 0, 10); padding: 0cm 0.19cm 0cm 0cm;\"><br/></td><td width=\"105\" style=\"border-top: none; border-bottom-color: rgb(0, 0, 10); border-left: none; border-right-color: rgb(0, 0, 10); padding: 0cm 0.19cm 0cm 0cm;\"><br/></td></tr><tr><td width=\"70\" height=\"4\" style=\"border-top: none; border-bottom-color: rgb(0, 0, 10); border-left-color: rgb(0, 0, 10); border-right-color: rgb(0, 0, 10); padding: 0cm 0.19cm;\"><br/></td><td width=\"277\" style=\"border-top: none; border-bottom-color: rgb(0, 0, 10); border-left: none; border-right-color: rgb(0, 0, 10); padding: 0cm 0.19cm 0cm 0cm;\"><br/></td><td width=\"108\" style=\"border-top: none; border-bottom-color: rgb(0, 0, 10); border-left: none; border-right-color: rgb(0, 0, 10); padding: 0cm 0.19cm 0cm 0cm;\"><br/></td><td width=\"105\" style=\"border-top: none; border-bottom-color: rgb(0, 0, 10); border-left: none; border-right-color: rgb(0, 0, 10); padding: 0cm 0.19cm 0cm 0cm;\"><br/></td></tr><tr><td width=\"70\" height=\"4\" style=\"border-top: none; border-bottom-color: rgb(0, 0, 10); border-left-color: rgb(0, 0, 10); border-right-color: rgb(0, 0, 10); padding: 0cm 0.19cm;\"><br/></td><td width=\"277\" style=\"border-top: none; border-bottom-color: rgb(0, 0, 10); border-left: none; border-right-color: rgb(0, 0, 10); padding: 0cm 0.19cm 0cm 0cm;\"><br/></td><td width=\"108\" style=\"border-top: none; border-bottom-color: rgb(0, 0, 10); border-left: none; border-right-color: rgb(0, 0, 10); padding: 0cm 0.19cm 0cm 0cm;\"><br/></td><td width=\"105\" style=\"border-top: none; border-bottom-color: rgb(0, 0, 10); border-left: none; border-right-color: rgb(0, 0, 10); padding: 0cm 0.19cm 0cm 0cm;\"><br/></td></tr><tr><td width=\"70\" height=\"4\" style=\"border-top: none; border-bottom-color: rgb(0, 0, 10); border-left-color: rgb(0, 0, 10); border-right-color: rgb(0, 0, 10); padding: 0cm 0.19cm;\"><br/></td><td width=\"277\" style=\"border-top: none; border-bottom-color: rgb(0, 0, 10); border-left: none; border-right-color: rgb(0, 0, 10); padding: 0cm 0.19cm 0cm 0cm;\"><br/></td><td width=\"108\" style=\"border-top: none; border-bottom-color: rgb(0, 0, 10); border-left: none; border-right-color: rgb(0, 0, 10); padding: 0cm 0.19cm 0cm 0cm;\"><br/></td><td width=\"105\" style=\"border-top: none; border-bottom-color: rgb(0, 0, 10); border-left: none; border-right-color: rgb(0, 0, 10); padding: 0cm 0.19cm 0cm 0cm;\"><br/></td></tr><tr><td width=\"70\" height=\"3\" style=\"border-top: none; border-bottom-color: rgb(0, 0, 10); border-left-color: rgb(0, 0, 10); border-right-color: rgb(0, 0, 10); padding: 0cm 0.19cm;\"><br/></td><td width=\"277\" style=\"border-top: none; border-bottom-color: rgb(0, 0, 10); border-left: none; border-right-color: rgb(0, 0, 10); padding: 0cm 0.19cm 0cm 0cm;\"><br/></td><td width=\"108\" style=\"border-top: none; border-bottom-color: rgb(0, 0, 10); border-left: none; border-right-color: rgb(0, 0, 10); padding: 0cm 0.19cm 0cm 0cm;\"><br/></td><td width=\"105\" style=\"border-top: none; border-bottom-color: rgb(0, 0, 10); border-left: none; border-right-color: rgb(0, 0, 10); padding: 0cm 0.19cm 0cm 0cm;\"><br/></td></tr></tbody></table></center>','2016-10-24 11:36:17',1,'测试表格','U141770099155103287');

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
  `title` varchar(255) NOT NULL,
  `user_id` varchar(50) NOT NULL,
  `org_id` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_form_instance` */

insert  into `t_form_instance`(`id`,`create_time`,`form_data_id`,`form_id`,`title`,`user_id`,`org_id`) values ('FI_U151188595823617504','2017-11-29 00:19:18','U151188592941943488','U150523148906512260','普通表单测试2(超级管理员)','U141770099155103287','0'),('FI_U151188630418627789','2017-11-29 00:25:04','U151188627329270114','U150523148906512260','普通表单测试2(超级管理员)','U141770099155103287','0');

/*Table structure for table `t_form_table` */

DROP TABLE IF EXISTS `t_form_table`;

CREATE TABLE `t_form_table` (
  `id` varchar(32) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `remark` varchar(500) DEFAULT NULL,
  `table_name` varchar(127) NOT NULL,
  `user_id` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_form_table` */

/*Table structure for table `t_form_table_field` */

DROP TABLE IF EXISTS `t_form_table_field`;

CREATE TABLE `t_form_table_field` (
  `id` varchar(32) NOT NULL,
  `data_format` varchar(50) DEFAULT NULL,
  `field_name` varchar(127) NOT NULL,
  `field_remark` varchar(500) DEFAULT NULL,
  `length` varchar(10) DEFAULT NULL,
  `sort_order` int(11) DEFAULT NULL,
  `table_id` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_form_table_field` */

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
  `id` varchar(32) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `file_size` bigint(20) DEFAULT NULL,
  `file_suffix` varchar(50) DEFAULT NULL,
  `file_type` varchar(1024) DEFAULT NULL,
  `user_id` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_n_attachment` */

insert  into `t_n_attachment`(`id`,`create_time`,`file_name`,`file_path`,`file_size`,`file_suffix`,`file_type`,`user_id`) values ('ATT_U146773542286037050','2016-07-06 00:17:03','0d12f0a97aaa770d939882b4f993c00f.jpg','/upload/images/U146773542284497549.jpg',11829,'jpg','image/jpeg','U_U146773111652418878'),('ATT_U147447268540462136','2016-09-21 23:44:45','第一章 招标公告.docx','/upload/doc/5567c085382e40f2a2248e068b265087.docx',16890,'docx','application/wps-office.docx','U141770099155103287'),('ATT_U150281161920588868','2017-08-15 23:40:19','down_logo.png','/upload/images/3bf640d0c4b04aa9b18996ba0aa63e16.png',63133,'png','image/png','U141770099155103287'),('ATT_U150281171521675346','2017-08-15 23:41:55','down_logo.png','/upload/images/d87d052b351e4f39a1be8d8ebee41c3d.png',63133,'png','image/png','U141770099155103287');

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

insert  into `t_n_dict`(`id`,`busi_level`,`busi_name`,`busi_value`,`parent_id`,`sort_order`,`state`) values ('D-U143528452115354128',1,'表字段数据类型','TABLE_FIELD_DATA_FORMAT','0',11,1),('D-U143528456250084987',2,'字符串','varchar','D-U143528452115354128',1,1),('D-U143528460847918719',2,'整型','int','D-U143528452115354128',2,1),('D-U143528465248556356',2,'小数','numeric','D-U143528452115354128',3,1),('D-U143528469421736768',2,'日期时间','datetime','D-U143528452115354128',4,1),('D-UU141994787908554209',1,'组织机构类型','ORG_TYPE','0',5,1),('D-UU141994799754738879',2,'公司','company','D-UU141994787908554209',1,1),('D-UU141994802829255042',2,'部门','department','D-UU141994787908554209',2,1),('D-UU142649131272879431',1,'显示状态','VISIBLE_STATE','0',6,1),('D-UU142649132119031154',2,'显示','1','D-UU142649131272879431',1,1),('D-UU142649133056067830',2,'隐藏','0','D-UU142649131272879431',2,1),('D-UU142890921453238272',1,'资源类型','RESOURCE_TYPE','0',7,1),('D-UU142890925241329179',2,'流程菜单资源','flow_resource','D-UU142890921453238272',3,1),('D-UU142890927338225836',2,'表单资源','form_resource','D-UU142890921453238272',2,1),('D-UU142890931093087556',2,'其他资源','other_resource','D-UU142890921453238272',1,1),('D-UU142899881750676264',1,'表单类型','FORM_TYPE','0',8,1),('D-UU142899884488544351',2,'流程表单','flow_form','D-UU142899881750676264',1,1),('D-UU142899901902659586',2,'普通表单','normal_form','D-UU142899881750676264',2,1),('D-UU143066280538891847',1,'是否','YES_OR_NO','0',9,1),('D-UU143066282421563437',2,'是','1','D-UU143066280538891847',1,1),('D-UU143066283457564141',2,'否','0','D-UU143066280538891847',3,1),('D-UU143066288276869806',1,'流程类型','FLOW_TYPE','0',10,1),('D-UU143066293000095099',2,'普通流程','normal_flow','D-UU143066288276869806',1,1),('D-UU143066294971397701',2,'公文流程','office_flow','D-UU143066288276869806',2,1),('D141770362251230637',1,'数据状态','DATA_STATE','0',1,1),('D141770363532239881',2,'有效','1','D141770362251230637',1,1),('D141770364923252290',2,'无效','0','D141770362251230637',2,1),('D141787854035683659',1,'首页布局模板','INDEX_LAYOUT_TEMP','0',3,1),('D141787860820885393',2,'一行一列','l-1-1','D141787854035683659',1,1),('D141787863777042921',2,'一行两列','l-1-2','D141787854035683659',2,1),('D141787866943105931',2,'两行一列','l-2-1','D141787854035683659',3,1),('D141787869379953801',2,'两行两列','l-2-2','D141787854035683659',4,1),('D_U143668337727078367',1,'流程线类型','FLOW_LINE_TYPE','0',12,1),('D_U143668343657740283',2,'正常','normal','D_U143668337727078367',1,1),('D_U143668344965664408',2,'驳回','back','D_U143668337727078367',2,1),('D_U143935698601463174',1,'选择方式','SELECT_STYLE','0',30,1),('D_U143935702783733446',2,'单选','radio','D_U143935698601463174',1,1),('D_U143935703947681541',2,'多选','checkbox','D_U143935698601463174',2,1),('D_U147684954020967859',2,'文本','text','D-U143528452115354128',5,1),('D_U147798209987529948',2,'大文本','longtext','D-U143528452115354128',6,1),('D_U150072105118891605',1,'系统类型','SYS_TYPE','0',31,1),('D_U150072108430946258',2,'内部系统','internal_sys','D_U150072105118891605',1,1),('D_U150072111745594994',2,'外部系统','external_sys','D_U150072105118891605',2,1),('D_U150505689147319379',1,'报表类型','REPORT_TYPE','0',32,1),('D_U150505691852150657',2,'流程报表','flow_report','D_U150505689147319379',1,0),('D_U150505693536168279',2,'普通表单报表','form_report','D_U150505689147319379',2,0),('D_U150505697480974042',2,'其他报表','other_report','D_U150505689147319379',3,0),('D_U150514196143918923',2,'自定义SQL报表','custom_sql_report','D_U150505689147319379',0,1),('D_U150582974016514097',1,'页面打开类型','OPEN_URL_TYPE','0',33,1),('D_U150582986026620497',2,'弹出窗口','popup_win','D_U150582974016514097',1,1),('D_U150582998167066023',2,'新选项卡中打开','cnoj-open-tabs','D_U150582974016514097',2,1),('D_U150583000755452709',2,'当前选项卡中打开','cnoj-open-self','D_U150582974016514097',3,1),('D_U150583013803315345',2,'打开新窗口','_blank','D_U150582974016514097',4,1),('D_U150771101965610026',2,'报表资源','report_resource','D-UU142890921453238272',4,1);

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

insert  into `t_n_login_log`(`id`,`browser`,`browser_version`,`client_screen_height`,`client_screen_width`,`create_time`,`device_type`,`ip`,`login_type`,`msg`,`os`,`resolution`,`state`,`user_agent`,`user_id`,`username`) values ('L_U154224989676913727','Chrome','71.0.3554.0',1080,1920,'2018-11-15 10:44:57','Computer','0:0:0:0:0:0:0:1','normal','验证码输入错误','Windows 7','1920x1080',0,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36',NULL,NULL),('L_U154224990160716310','Chrome','71.0.3554.0',1080,1920,'2018-11-15 10:45:02','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154225042956000702','Chrome','71.0.3554.0',1080,1920,'2018-11-15 10:53:50','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154225048079478546','Chrome','71.0.3554.0',1080,1920,'2018-11-15 10:54:41','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154225202373627850','Chrome','71.0.3554.0',1080,1920,'2018-11-15 11:20:24','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154225216757224790','Chrome','71.0.3554.0',1080,1920,'2018-11-15 11:22:48','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154225234581870079','Chrome','71.0.3554.0',1080,1920,'2018-11-15 11:25:46','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154225248969907387','Chrome','71.0.3554.0',1080,1920,'2018-11-15 11:28:10','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154225251086236977','Chrome','71.0.3554.0',1080,1920,'2018-11-15 11:28:31','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154225268839391525','Chrome','71.0.3554.0',1080,1920,'2018-11-15 11:31:28','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154225440739007118','Chrome','71.0.3554.0',1080,1920,'2018-11-15 12:00:07','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154225456194621108','Chrome','71.0.3554.0',1080,1920,'2018-11-15 12:02:42','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154225885665929088','Chrome','71.0.3554.0',1080,1920,'2018-11-15 13:14:17','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154225943342391150','Chrome','71.0.3554.0',1080,1920,'2018-11-15 13:23:53','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154225948052945330','Chrome','71.0.3554.0',1080,1920,'2018-11-15 13:24:41','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154225962418656795','Chrome','71.0.3554.0',1080,1920,'2018-11-15 13:27:04','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154225995580025063','Chrome','71.0.3554.0',1080,1920,'2018-11-15 13:32:36','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154226025964096412','Chrome','71.0.3554.0',1080,1920,'2018-11-15 13:37:40','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154226141362096314','Chrome','71.0.3554.0',1080,1920,'2018-11-15 13:56:54','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154226149390996823','Chrome','71.0.3554.0',1080,1920,'2018-11-15 13:58:14','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154226164579078299','Chrome','71.0.3554.0',1080,1920,'2018-11-15 14:00:46','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154226211076595515','Chrome','71.0.3554.0',1080,1920,'2018-11-15 14:08:31','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154226258089817504','Chrome','71.0.3554.0',1080,1920,'2018-11-15 14:16:21','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154226297681124490','Chrome','71.0.3554.0',1080,1920,'2018-11-15 14:22:57','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154226340120013588','Chrome','71.0.3554.0',1080,1920,'2018-11-15 14:30:01','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154226374458042980','Chrome','71.0.3554.0',1080,1920,'2018-11-15 14:35:45','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154226393280876043','Chrome','71.0.3554.0',1080,1920,'2018-11-15 14:38:53','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154226509393697088','Chrome','71.0.3554.0',1080,1920,'2018-11-15 14:58:14','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154226528473021208','Chrome','71.0.3554.0',1080,1920,'2018-11-15 15:01:25','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154226535410523722','Chrome','71.0.3554.0',1080,1920,'2018-11-15 15:02:34','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154226657513223956','Chrome','71.0.3554.0',1080,1920,'2018-11-15 15:22:55','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154226699210494413','Chrome','71.0.3554.0',1080,1920,'2018-11-15 15:29:52','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154226865839548882','Chrome','71.0.3554.0',1080,1920,'2018-11-15 15:57:38','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154226897638852050','Chrome','71.0.3554.0',1080,1920,'2018-11-15 16:02:56','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154226963173467937','Chrome','71.0.3554.0',1080,1920,'2018-11-15 16:13:52','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154227071260476297','Chrome','71.0.3554.0',1080,1920,'2018-11-15 16:31:53','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154227247600813988','Chrome','71.0.3554.0',1080,1920,'2018-11-15 17:01:16','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154227261205289040','Chrome','71.0.3554.0',1080,1920,'2018-11-15 17:03:32','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154227266898880441','Chrome','71.0.3554.0',1080,1920,'2018-11-15 17:04:29','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154227275394775164','Chrome','71.0.3554.0',1080,1920,'2018-11-15 17:05:54','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154227411233926196','Chrome','71.0.3554.0',1080,1920,'2018-11-15 17:28:32','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154227467927452930','Chrome','71.0.3554.0',1080,1920,'2018-11-15 17:37:59','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1920x1080',1,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3554.0 Safari/537.36','U141770099155103287','admin'),('L_U154228634015651526','Chrome','70.0.3538.102',768,1366,'2018-11-15 20:52:20','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U141770099155103287','admin'),('L_U154228782645235075','Chrome','70.0.3538.102',768,1366,'2018-11-15 21:17:06','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U141770099155103287','admin'),('L_U154228797362844960','Chrome','70.0.3538.102',768,1366,'2018-11-15 21:19:33','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U141770099155103287','admin'),('L_U154228978569285383','Chrome','70.0.3538.102',768,1366,'2018-11-15 21:49:45','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U141770099155103287','admin'),('L_U154229071758859480','Chrome','70.0.3538.102',768,1366,'2018-11-15 22:05:17','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U141770099155103287','admin'),('L_U154229166304587632','Chrome','70.0.3538.102',768,1366,'2018-11-15 22:21:03','Computer','0:0:0:0:0:0:0:1','normal','登录成功 ','Windows 7','1366x768',1,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','U141770099155103287','admin');

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

insert  into `t_n_menu`(`id`,`icon`,`name`,`parent_id`,`resource_id`,`sort_order`,`state`) values ('M-U143386498490644858','','我的办公','','',15,1),('M-U143386499780007244','','我的待办','M-U143386498490644858','U143386875037004503',1,1),('M-U143386502139997938','','我的已办','M-U143386498490644858','U143891863167559700',2,1),('M-U143437637668627416','','流程实例管理','M-UU142674907787008431','U143437634716263470',5,1),('M-UU142493393340566190','','系统管理','0','',10,1),('M-UU142493393345840632','','菜单管理','M-UU142502912450567699','UU142493393303513551',2,1),('M-UU142493393345982202','','资源管理','M-UU142502912450567699','UU142493393323156274',1,1),('M-UU142502856650696782','','数据字典管理','M-UU142502912450567699','UU142494155606818866',3,1),('M-UU142502912450567699','','基础信息管理','M-UU142493393340566190','',4,1),('M-UU142508562386146072','','角色管理','M-UU142508565901356613','UU142494261976460581',5,1),('M-UU142508565901356613','','系统权限管理','M-UU142493393340566190','',6,1),('M-UU142508575818005410','','操作权限管理','M-UU142502912450567699','UU142494269829079292',6,1),('M-UU142508577364831096','','用户管理','M-UU142502912450567699','UU142494266546995694',7,1),('M-UU142508579506696266','','权限管理','M-UU142508565901356613','UU142494288694979665',6,1),('M-UU142508581582421400','','组织机构管理','M-UU142502912450567699','UU142494281162643857',8,1),('M-UU142508582672975095','','职位管理','M-UU142502912450567699','UU142494285272420160',9,1),('M-UU142508584581052708','','个人设置管理','M-UU142502912450567699','UU142494292374313391',10,0),('M-UU142508632307077913','','测试菜单','0','',11,1),('M-UU142509266596498359','','表单测试页面','M-UU142508632307077913','UU142508630396009472',1,1),('M-UU142536825033474422','','权限测试页面','M-UU142508632307077913','UU142536804561674717',2,1),('M-UU142537020883891213','','jqGrid测试页面','M-UU142508632307077913','UU142537018725515068',3,1),('M-UU142614435382531564','glyphicon-film','测试菜单1238','M-UU142508632307077913','UU142536483130282094',4,1),('M-UU142623915330541216','','小窗口管理','M-UU142502912450567699','UU142623880634351320',11,0),('M-UU142648905947706614','','上传文件','M-UU142508632307077913','UU142648904341707233',5,1),('M-UU142674907787008431','','流程管理','','',12,1),('M-UU142674914090993592','','流程设计器','M-UU142674907787008431','UU142674912100115069',1,1),('M-UU142725965216133778','','流程页面模版','M-UU142674907787008431','UU142725947101781158',2,1),('M-UU142726297434397142','','表单管理','','',13,1),('M-UU142726773386586759','','表单设计器','M-UU142726297434397142','UU142726304175200513',1,1),('M-UU142865516785678977','','流程列表','M-UU142674907787008431','UU142865507367695503',3,1),('M-UU142891059112535159','','流程菜单资源管理','M-UU142674907787008431','UU142891052568659983',4,1),('M-UU143065549041483387','','表单列表','M-UU142726297434397142','UU143065539369030702',2,1),('M-UU143148104616493973','','测试流程','','',14,1),('M_U143617405773277013','','表管理','M-UU142726297434397142','U143617398234893404',3,1),('M_U146772887866360899','','测试流程1','M-UU143148104616493973','U146772885528409688',5,1),('M_U147417441609808442','','测试jquery方法','M-UU142508632307077913','U147417439880357008',7,1),('M_U147522765545394886','','测试表单1','M-UU142508632307077913','U147522762933583369',8,1),('M_U147563798223468130','','版本管理','M-UU142493393340566190','U147563795975505594',7,1),('M_U147686536145550268','','表单帮助信息管理','M-UU142726297434397142','U147686532906967243',4,1),('M_U148248006315688612','','子系统管理','M-UU142493393340566190','U148248001874056364',8,1),('M_U148765649968126029','','自定义列列表','M-UU142508632307077913','U148765647626620413',9,1),('M_U148774379154981169','','测试异步列表树','M-UU142508632307077913','U148774376819175947',10,1),('M_U149542930364019298','','请假条件判断测试','M-UU143148104616493973','U149542927908493158',6,1),('M_U150107942410202851','','表单资源管理','M-UU142726297434397142','U150107939436631363',5,1),('M_U150271305138806638','','测试表单','','',16,1),('M_U150271311055026835','','测试单独表单1','M_U150271305138806638','U150108134134573562',1,1),('M_U150419026910267250','','表单实例','M-UU142726297434397142','U150419023701932892',6,1),('M_U150505743154581563','','报表管理','','',17,1),('M_U150505744589936513','','简单报表设计','M_U150505743154581563','U150505741534899631',1,1),('M_U150523152985112535','','测试单独表单2','M_U150271305138806638','U150523150955702051',2,1),('M_U150609787532592249','','报表管理列表','M_U150505743154581563','U150609785810770279',2,1),('M_U150773702650901782','','报表资源管理','M_U150505743154581563','U150773698819847933',3,1),('M_U150773725051970620','','测试简单报表','','',18,1),('M_U150773726492879051','','测试简单报表1','M_U150773725051970620','U150773721860798909',1,1),('M_U150894689375830371','','SQL资源管理','','',19,1),('M_U150894690539658983','','SQL资源管理列表','M_U150894689375830371','U150894686421341181',1,1),('M_U154225004073616144','','校务管理','','',20,1),('M_U154225007149324418','','校区管理','M_U154225004073616144','U154225067366985402',1,1),('M_U154226493530106359','','教师信息','M_U154225004073616144','U154226490927926250',21,1),('M_U154226856686813620','','教室信息','M_U154225004073616144','U154226854575116662',22,1),('M_U154227254133036595','','班级信息','M_U154225004073616144','U154227251858798941',23,1),('M_U154228787322754855','','学生信息','M_U154225004073616144','U154228785560711973',24,1);

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

insert  into `t_n_op_auth`(`id`,`create_time`,`name`,`value`,`sort_order`) values ('A-U143591450834502927','2015-07-03 17:08:28','审核','audit',1),('A-UU142534841115229345','2015-03-03 10:06:51','修改密码','changepwd',5),('A-UU142865511755998939','2015-04-10 16:38:38','修改','edit_designer',1),('A_U143936255049193524','2015-08-12 14:55:50','任意跳转','jump_task',1),('A_U147446697154526617','2016-09-21 22:09:32','流程表单编辑','flow_form_edit',6),('A_U150885497581940413','2017-10-24 22:22:56','导出','export',7),('B-UU141804293977346637','2014-12-08 20:48:59','添加','add',1),('B-UU141804295101229675','2014-12-08 20:49:11','编辑','edit',2),('B-UU141804296218585442','2014-12-08 20:49:22','删除','del',3),('B-UU141804297299702298','2014-12-08 20:49:32','刷新','refresh',4);

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

insert  into `t_n_org`(`id`,`code`,`name`,`parent_id`,`type`,`contact_number`,`contacts`,`create_time`,`seq_names`,`seq_parent_ids`,`sort_order`) values ('ORG_U143919516611919370','00test','测试组织机构1','0','company','','','2015-08-10 16:26:06','测试组织机构1','',21),('ORG_U143919519043844770','00test2','测试组织机构2','0','company','','','2015-08-10 16:26:30','测试组织机构2','null.ORG_U143919516611919370.',1),('ORG_U143919525899571244','00test1.test12','测试部门1','ORG_U143919516611919370','department','','','2015-08-10 16:27:39','测试组织机构1>测试部门1','ORG_U143919516611919370.',1);

/*Table structure for table `t_n_position` */

DROP TABLE IF EXISTS `t_n_position`;

CREATE TABLE `t_n_position` (
  `id` varchar(32) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `org_id` varchar(32) NOT NULL,
  `seq_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_n_position` */

insert  into `t_n_position`(`id`,`create_time`,`name`,`org_id`,`seq_name`) values ('P_U149071426541302672','2017-03-28 23:17:45','测试职位','ORG_U143919519043844770','测试组织机构2>测试职位'),('P_U149071428624050487','2017-03-28 23:18:06','测试职位2','ORG_U143919525899571244','测试组织机构1>测试部门1>测试职位2');

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

insert  into `t_n_resource`(`id`,`create_time`,`name`,`uri`,`state`,`op_auths`,`type`) values ('U143386875037004503','2015-06-10 00:52:30','待办资源','process/todo',1,NULL,'other_resource'),('U143437621125952385','2015-06-15 21:50:11','流程实例管理','process/mgr/orderList',1,'jump_task,flow_form_edit,del,refresh,','other_resource'),('U143437623207722734','2015-06-15 21:50:32','流程历史实例管理','process/mgr/histOrderList',1,'flow_form_edit,del,refresh,','other_resource'),('U143437634716263470','2015-06-15 21:52:27','流程实例管理页面','showPage/flow_process_mgr_list',1,NULL,'other_resource'),('U143617398234893404','2015-07-06 17:13:02','表单对应的数据库表管理','form/table/list',1,'add,edit,del,refresh,','other_resource'),('U143891863167559700','2015-08-07 11:37:12','已办','process/hasTodo',1,NULL,'other_resource'),('U146772885528409688','2016-07-05 22:27:35','测试流程1','process/form?processName=test_01',1,NULL,'flow_resource'),('U147417439880357008','2016-09-18 12:53:19','测试jquery方法','test/jqueryMethod',1,NULL,'other_resource'),('U147522762933583369','2016-09-30 17:27:09','测试表单1','test/inputSelect',1,NULL,'other_resource'),('U147563795975505594','2016-10-05 11:26:00','版本管理','version/list',1,'add,edit,del,refresh,','other_resource'),('U147686532906967243','2016-10-19 16:22:09','表单帮助信息管理列表','form/helper/list',1,'add,edit,del,refresh,','other_resource'),('U148248001874056364','2016-12-23 16:00:19','子系统管理列表','subSystem/list',1,'edit_designer,add,edit,del,refresh,','other_resource'),('U148765647626620413','2017-02-21 13:54:36','测试自定义列列表','test/cellList',1,'changepwd,edit_designer,add,edit,refresh,','other_resource'),('U148774376819175947','2017-02-22 14:09:28','测试异步列表树','test/tableAsyncTree',1,'add,edit,del,refresh,','other_resource'),('U149542927908493158','2017-05-22 13:01:19','请假判断测试1','process/form?processName=leave_ judge_test',1,NULL,'flow_resource'),('U150107939436631363','2017-07-26 22:29:54','表单资源管理','form/resource/list',1,'add,edit,del,refresh,','other_resource'),('U150108134134573562','2017-07-26 23:02:21','测试普通表单','form/instance/create?formId=U150108080025383738',1,NULL,'form_resource'),('U150419023701932892','2017-08-31 22:37:17','表单实例管理','form/instance/list',1,'edit,del,refresh,','other_resource'),('U150505741534899631','2017-09-10 23:30:15','简单报表设计','report/designer',1,NULL,'other_resource'),('U150523150955702051','2017-09-12 23:51:50','表单测试2','form/instance/create?formId=U150523148906512260',1,NULL,'form_resource'),('U150609785810770279','2017-09-23 00:30:58','报表管理列表','report/list',1,'edit_designer,del,refresh,','other_resource'),('U150773698819847933','2017-10-11 23:49:48','报表资源管理','report/resource/list',1,'add,edit,del,refresh,','other_resource'),('U150773721860798909','2017-10-11 23:53:39','测试报表1','report/instance/list?reportId=R_U150600830877642873',1,'export,','report_resource'),('U150894686421341181','2017-10-25 23:54:24','SQL资源管理列表','sql/resource/list',1,'add,edit,del,refresh,','other_resource'),('U154225067366985402','2018-11-15 10:57:54','校区信息','studySchool/list',1,'edit_designer,add,edit,','other_resource'),('U154226490927926250','2018-11-15 14:55:09','教师','studyTeacher/list',1,'add,edit,del,refresh,','other_resource'),('U154226854575116662','2018-11-15 15:55:46','教室信息','studyClassroom/list',1,'add,edit,del,refresh,','other_resource'),('U154227251858798941','2018-11-15 17:01:59','班级信息','studyClass/list',1,'add,edit,del,refresh,','other_resource'),('U154228785560711973','2018-11-15 21:17:35','学生信息','studyStudent/list',1,'add,edit,del,refresh,','other_resource'),('UU142493393303513551','2015-02-27 15:35:45','菜单管理','menu/list',1,'add,edit,del,refresh,',NULL),('UU142493393323156274','2015-02-26 14:58:53','资源管理','resource/list',1,'add,edit,del,refresh,','other_resource'),('UU142494155606818866','2015-02-26 17:05:56','数据字典管理','dict/list',1,'add,edit,del,refresh,',NULL),('UU142494261976460581','2015-02-26 17:23:39','角色管理','role/list',1,'add,edit,del,refresh,',NULL),('UU142494266546995694','2015-02-26 17:24:25','用户管理','user/list',1,'changepwd,add,edit,del,refresh,','other_resource'),('UU142494269829079292','2015-02-26 17:24:58','操作权限管理','opauth/list',1,'add,edit,del,refresh,',NULL),('UU142494281162643857','2015-02-26 17:26:51','组织机构管理','org/list',1,'add,edit,del,refresh,',NULL),('UU142494285272420160','2015-02-26 17:27:32','职位管理','showPage/base_position_org',1,NULL,'other_resource'),('UU142494288694979665','2015-02-26 17:28:06','权限管理','auth/index',1,NULL,NULL),('UU142494292374313391','2015-02-26 17:28:43','个人设置管理','user/setting/list',1,'add,edit,del,refresh,',NULL),('UU142508630396009472','2015-02-28 09:18:23','表单测试页面','test/test',1,NULL,NULL),('UU142536339652188513','2015-03-03 14:16:36','角色下的用户列表','role/userlist',1,'add,del,refresh,',NULL),('UU142536367109082749','2015-03-03 14:21:11','角色下的组织机构列表','role/orglist',1,'add,del,refresh,',NULL),('UU142536370298266280','2015-03-03 14:21:42','角色下的岗位列表','role/positionlist',1,'add,del,refresh,',NULL),('UU142536376280597829','2015-03-03 14:22:42','组织机构拥有的角色列表','org/rolelist',1,'add,del,refresh,',NULL),('UU142536417802440972','2015-03-03 14:29:38','岗位拥有的角色列表','position/rolelist',1,'add,del,refresh,',NULL),('UU142536421178574716','2015-03-03 14:30:11','用户拥有的角色列表','user/rolelist',1,'add,del,refresh,',NULL),('UU142536483130282094','2015-03-03 14:40:31','职位管理列表','position/list',1,'add,edit,del,refresh,','other_resource'),('UU142536804561674717','2015-03-03 15:34:05','测试权限按钮页面','test/auth',1,'add,edit,del,refresh,changepwd,',NULL),('UU142537018725515068','2015-03-03 16:09:47','jqGrid插件测试','test/jqGrid',1,'add,edit,del,refresh,',NULL),('UU142623880634351320','2015-03-13 17:26:46','小窗口管理','minwin/list',1,'add,edit,del,refresh,',NULL),('UU142648904341707233','2015-03-16 14:57:23','上传文件测试','test/upload',1,NULL,NULL),('UU142674912100115069','2015-03-19 15:12:01','流程设计器','flow/designer',1,NULL,NULL),('UU142725947101781158','2015-03-25 12:57:51','流程页面模版','flow/page/model/list',1,'add,edit,del,refresh,',NULL),('UU142726304175200513','2015-03-25 13:57:21','表单设计','form/designer',1,NULL,NULL),('UU142865507367695503','2015-04-10 16:37:54','流程列表','flow/list',1,'del,refresh,edit_designer,','other_resource'),('UU142891052568659983','2015-04-13 15:35:26','流程菜单资源','flow/resource/list',1,'add,edit,del,refresh,','other_resource'),('UU143065539369030702','2015-05-03 20:16:34','表单列表','form/list',1,'null,null,del,refresh,null,edit_designer,','other_resource');

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

insert  into `t_n_role`(`id`,`create_time`,`descr`,`name`,`flag`,`user_id`,`state`) values ('R-UU141994583098704113','2014-12-30 21:23:50','普通管理员角色','普通管理员',NULL,'U141770099155103287',1),('R-UU142509589602782910','2015-02-28 11:58:16','测试','测试角色',NULL,'U141770099155103287',1),('R141770099156750308','2014-12-04 21:49:51','系统超级管理员角色','超级管理员角色','super_admin','U141770099155103287',1);

/*Table structure for table `t_n_role_menu` */

DROP TABLE IF EXISTS `t_n_role_menu`;

CREATE TABLE `t_n_role_menu` (
  `id` varchar(32) NOT NULL,
  `menu_id` varchar(32) NOT NULL,
  `role_id` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_n_role_menu` */

insert  into `t_n_role_menu`(`id`,`menu_id`,`role_id`) values ('RM-U147670942807011776','M-U143386499780007244','R-UU142509589602782910'),('RM-U147670942807025586','M-U143386498490644858','R-UU142509589602782910'),('RM-U147670942807032935','M-UU142508632307077913','R-UU142509589602782910'),('RM-U147670942807041474','M-U143386502139997938','R-UU142509589602782910'),('RM-U147670942807139799','M_U146772887866360899','R-UU142509589602782910'),('RM-U147670942807154821','M-UU142509266596498359','R-UU142509589602782910'),('RM-U147670942807159253','M-UU143148104616493973','R-UU142509589602782910'),('RM-U150886070518111226','M-UU142493393345840632','R-UU141994583098704113'),('RM-U150886070518121538','M-UU142508579506696266','R-UU141994583098704113'),('RM-U150886070518122110','M-U143386502139997938','R-UU141994583098704113'),('RM-U150886070518127880','M-U143386499780007244','R-UU141994583098704113'),('RM-U150886070518128017','M-UU142508632307077913','R-UU141994583098704113'),('RM-U150886070518135585','M-UU142502856650696782','R-UU141994583098704113'),('RM-U150886070518153440','M-UU142537020883891213','R-UU141994583098704113'),('RM-U150886070518157302','M-UU142508562386146072','R-UU141994583098704113'),('RM-U150886070518159371','M-UU142508577364831096','R-UU141994583098704113'),('RM-U150886070518159626','M-UU143148104616493973','R-UU141994583098704113'),('RM-U150886070518165994','M-UU142508575818005410','R-UU141994583098704113'),('RM-U150886070518166813','M-U143386498490644858','R-UU141994583098704113'),('RM-U150886070518171343','M-UU142508581582421400','R-UU141994583098704113'),('RM-U150886070518203576','M-UU142536825033474422','R-UU141994583098704113'),('RM-U150886070518232826','M-UU142508582672975095','R-UU141994583098704113'),('RM-U150886070518247605','M-UU142508565901356613','R-UU141994583098704113'),('RM-U150886070518249899','M_U150773726492879051','R-UU141994583098704113'),('RM-U150886070518250127','M-UU142502912450567699','R-UU141994583098704113'),('RM-U150886070518268650','M_U150773725051970620','R-UU141994583098704113'),('RM-U150886070518289777','M-UU142509266596498359','R-UU141994583098704113'),('RM-U150886070518294230','M-UU142493393340566190','R-UU141994583098704113'),('RM-U154226495340127417','M-UU142648905947706614','R141770099156750308'),('RM-U154226495340232435','M-UU142502912450567699','R141770099156750308'),('RM-U154226495340240777','M-UU142508565901356613','R141770099156750308'),('RM-U154226495340243765','M_U147417441609808442','R141770099156750308'),('RM-U154226495340255956','M_U150609787532592249','R141770099156750308'),('RM-U154226495340263162','M-UU143065549041483387','R141770099156750308'),('RM-U154226495340267879','M_U143617405773277013','R141770099156750308'),('RM-U154226495340279877','M-U143386499780007244','R141770099156750308'),('RM-U154226495340281352','M-UU142508577364831096','R141770099156750308'),('RM-U154226495340282613','M-UU142674907787008431','R141770099156750308'),('RM-U154226495340284529','M_U148774379154981169','R141770099156750308'),('RM-U154226495340290498','M-UU142725965216133778','R141770099156750308'),('RM-U154226495340309526','M-UU142674914090993592','R141770099156750308'),('RM-U154226495340329824','M_U150271311055026835','R141770099156750308'),('RM-U154226495340360105','M_U149542930364019298','R141770099156750308'),('RM-U154226495340395055','M_U150894689375830371','R141770099156750308'),('RM-U154226495340398808','M_U150419026910267250','R141770099156750308'),('RM-U154226495340400042','M-UU143148104616493973','R141770099156750308'),('RM-U154226495340404875','M_U147563798223468130','R141770099156750308'),('RM-U154226495340406196','M-UU142508562386146072','R141770099156750308'),('RM-U154226495340417640','M_U150107942410202851','R141770099156750308'),('RM-U154226495340438751','M-UU142614435382531564','R141770099156750308'),('RM-U154226495340442732','M_U154225007149324418','R141770099156750308'),('RM-U154226495340449624','M_U150505744589936513','R141770099156750308'),('RM-U154226495340454314','M-UU142508579506696266','R141770099156750308'),('RM-U154226495340467119','M-UU142493393345982202','R141770099156750308'),('RM-U154226495340538876','M-UU142537020883891213','R141770099156750308'),('RM-U154226495340540433','M-UU142726297434397142','R141770099156750308'),('RM-U154226495340553537','M_U154225004073616144','R141770099156750308'),('RM-U154226495340567794','M-UU142508575818005410','R141770099156750308'),('RM-U154226495340582826','M-U143386498490644858','R141770099156750308'),('RM-U154226495340589623','M_U146772887866360899','R141770099156750308'),('RM-U154226495340598493','M_U150773702650901782','R141770099156750308'),('RM-U154226495340610595','M_U150505743154581563','R141770099156750308'),('RM-U154226495340629015','M_U150523152985112535','R141770099156750308'),('RM-U154226495340634955','M-U143437637668627416','R141770099156750308'),('RM-U154226495340635867','M_U148765649968126029','R141770099156750308'),('RM-U154226495340644584','M-UU142726773386586759','R141770099156750308'),('RM-U154226495340646534','M_U150271305138806638','R141770099156750308'),('RM-U154226495340647446','M_U154226493530106359','R141770099156750308'),('RM-U154226495340661580','M-UU142536825033474422','R141770099156750308'),('RM-U154226495340666207','M-UU142508584581052708','R141770099156750308'),('RM-U154226495340669724','M-UU142623915330541216','R141770099156750308'),('RM-U154226495340679054','M-UU142509266596498359','R141770099156750308'),('RM-U154226495340705954','M_U147522765545394886','R141770099156750308'),('RM-U154226495340711378','M-UU142502856650696782','R141770099156750308'),('RM-U154226495340724444','M_U150773726492879051','R141770099156750308'),('RM-U154226495340734258','M-U143386502139997938','R141770099156750308'),('RM-U154226495340736670','M-UU142493393345840632','R141770099156750308'),('RM-U154226495340744624','M-UU142508632307077913','R141770099156750308'),('RM-U154226495340752332','M-UU142865516785678977','R141770099156750308'),('RM-U154226495340758889','M_U148248006315688612','R141770099156750308'),('RM-U154226495340763283','M-UU142493393340566190','R141770099156750308'),('RM-U154226495340767387','M-UU142508581582421400','R141770099156750308'),('RM-U154226495340768630','M-UU142508582672975095','R141770099156750308'),('RM-U154226495340772507','M_U150894690539658983','R141770099156750308'),('RM-U154226495340790656','M-UU142891059112535159','R141770099156750308'),('RM-U154226495340840463','M_U147686536145550268','R141770099156750308'),('RM-U154226495340856747','M_U150773725051970620','R141770099156750308'),('RM-U154226856689030414','M_U154226856686813620','R141770099156750308'),('RM-U154227254135556320','M_U154227254133036595','R141770099156750308'),('RM-U154228787325306897','M_U154228787322754855','R141770099156750308');

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

insert  into `t_n_role_org`(`id`,`org_id`,`role_id`,`flag`) values ('141770099158434195','ORG141770098906478558','R141770099156750308','role'),('U143807026267420415','ORG_U143781444238608701','R141770099156750308','role'),('U143807026267503592','ORG_U143781429264856739','R141770099156750308','role'),('U143807026267508815','ORG_U143781424491515835','R141770099156750308','role'),('U143807026267587371','ORG_U143781427094033322','R141770099156750308','role'),('U143807026267622959','ORG_U143781436872880188','R141770099156750308','role'),('U143807026267653121','ORG_U143781439299536938','R141770099156750308','role'),('U143807026267661115','ORG_U143781418633095546','R141770099156750308','role'),('U143807026267673388','ORG_U143781434542612938','R141770099156750308','role'),('U143807026267755919','ORG_U143781376781766946','R141770099156750308','role'),('U143807026267812879','ORG_U143806590727689343','R141770099156750308','role'),('U143807026267826310','ORG_U143781441944628562','R141770099156750308','role'),('U143807026267848318','ORG_U143806582943509071','R141770099156750308','role'),('U143807026267856307','ORG_U143781379596867277','R141770099156750308','role'),('U143807026267910395','ORG_U143806592742875610','R141770099156750308','role'),('U143807026267912181','ORG_U143806588133596408','R141770099156750308','role'),('U143807026267949995','ORG_U143781372488726933','R141770099156750308','role'),('U143807026267984116','ORG_U143781370113972594','R141770099156750308','role'),('U143807026268001090','ORG_U143806595541436748','R141770099156750308','role'),('U143807026268033019','ORG_U143806599978100313','R141770099156750308','role'),('U143807026268054695','ORG_U143806597929193485','R141770099156750308','role'),('U146720873624562288','ORG_U143919516611919370','R141770099156750308','role'),('U146720873624670988','ORG_U143919519043844770','R141770099156750308','role'),('U146720873624688867','ORG_U143919525899571244','R141770099156750308','role'),('U146773102521073480','ORG_U146773102513694776','R141770099156750308','role'),('U146773105683480241','ORG_U146773105679787136','R141770099156750308','role'),('U146773108457347567','ORG_U146773108453453069','R141770099156750308','role'),('U146773154286827766','ORG_U146773105679787136','R-UU142509589602782910','role'),('U146773154286839356','ORG_U146773108453453069','R-UU142509589602782910','role'),('U146773154286990654','ORG_U143919525899571244','R-UU142509589602782910','role'),('U146773224504704114','ORG_U143919525899571244','R-UU142509589602782910','org'),('U146773225459064319','ORG_U146773105679787136','R-UU142509589602782910','org'),('U146773225953631565','ORG_U146773108453453069','R-UU142509589602782910','org'),('U148932427595869398','ORG_U143919516611919370','R-UU141994583098704113','role'),('U150485511090150548','ORG_U143919516611919370','R-UU142509589602782910','role'),('UU142485560013316363','ORG-UU142070879569950627','R141770099156750308','role'),('UU142485560013370812','ORG-UU142001300832233005','R141770099156750308','role'),('UU142485560013449781','ORG-UU142070100547125784','R141770099156750308','role'),('UU142485560013460108','ORG-UU142001326526339899','R141770099156750308','role'),('UU142485560013463120','ORG-UU142001293948308437','R141770099156750308','role'),('UU142485560013490658','ORG-UU142001312205127213','R141770099156750308','role'),('UU142485560013508213','ORG-UU142001319768851387','R141770099156750308','role'),('UU142485560013523221','ORG-UU142001331342114761','R141770099156750308','role'),('UU142485560013646608','ORG-UU142001333744500857','R141770099156750308','role');

/*Table structure for table `t_n_role_position` */

DROP TABLE IF EXISTS `t_n_role_position`;

CREATE TABLE `t_n_role_position` (
  `id` varchar(32) NOT NULL,
  `position_id` varchar(32) NOT NULL,
  `role_id` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_n_role_position` */

insert  into `t_n_role_position`(`id`,`position_id`,`role_id`) values ('U150976581442323118','P_U149071426541302672','R-UU141994583098704113');

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

insert  into `t_n_role_resource`(`id`,`op_auths`,`resource_id`,`role_id`) values ('U147670942807662638','','UU142508630396009472','R-UU142509589602782910'),('U150886070518459686','add,refresh,','UU142536804561674717','R-UU141994583098704113'),('U150886070518540630','add,del,','UU142537018725515068','R-UU141994583098704113'),('U150886070518579259','export,','U150773721860798909','R-UU141994583098704113'),('U154226495341233832','add,edit,del,refresh,','UU142493393323156274','R141770099156750308'),('U154226495341258442','add,edit,del,refresh,','UU142494155606818866','R141770099156750308'),('U154226495341272824','add,edit,del,refresh,','UU142494261976460581','R141770099156750308'),('U154226495341307598','add,del,refresh,','UU142536376280597829','R141770099156750308'),('U154226495341310298','add,edit,del,refresh,changepwd,','UU142494266546995694','R141770099156750308'),('U154226495341310328','add,del,refresh,','UU142536339652188513','R141770099156750308'),('U154226495341312738','add,del,refresh,','UU142536370298266280','R141770099156750308'),('U154226495341324739','','UU142508630396009472','R141770099156750308'),('U154226495341334131','add,edit,del,refresh,','UU142494292374313391','R141770099156750308'),('U154226495341342500','add,edit,del,refresh,','UU142493393303513551','R141770099156750308'),('U154226495341357984','','UU142494288694979665','R141770099156750308'),('U154226495341366022','add,edit,del,refresh,','UU142494269829079292','R141770099156750308'),('U154226495341372027','add,edit,del,refresh,','UU142494281162643857','R141770099156750308'),('U154226495341379906','add,del,refresh,','UU142536367109082749','R141770099156750308'),('U154226495341384673','','UU142494285272420160','R141770099156750308'),('U154226495341409282','add,edit,del,refresh,','UU142536483130282094','R141770099156750308'),('U154226495341409765','add,del,refresh,','UU142536421178574716','R141770099156750308'),('U154226495341431169','add,del,refresh,','UU142536417802440972','R141770099156750308'),('U154226495341478316','add,edit,del,refresh,changepwd,','UU142536804561674717','R141770099156750308'),('U154226495341524427','add,edit,del,refresh,','UU142891052568659983','R141770099156750308'),('U154226495341533544','edit_designer,del,refresh,','UU142865507367695503','R141770099156750308'),('U154226495341538678','add,edit,del,refresh,','UU142623880634351320','R141770099156750308'),('U154226495341550973','jump_task,del,refresh,flow_form_edit,','U143437621125952385','R141770099156750308'),('U154226495341554582','','U143437634716263470','R141770099156750308'),('U154226495341556181','','UU142674912100115069','R141770099156750308'),('U154226495341557229','','U143386875037004503','R141770099156750308'),('U154226495341565485','','UU142726304175200513','R141770099156750308'),('U154226495341566792','add,edit,del,refresh,','UU142725947101781158','R141770099156750308'),('U154226495341569708','del,refresh,flow_form_edit,','U143437623207722734','R141770099156750308'),('U154226495341570722','add,edit,del,refresh,','U143617398234893404','R141770099156750308'),('U154226495341572554','edit_designer,del,refresh,','UU143065539369030702','R141770099156750308'),('U154226495341585802','','UU142648904341707233','R141770099156750308'),('U154226495341593177','add,edit,del,refresh,','UU142537018725515068','R141770099156750308'),('U154226495341604918','','U147522762933583369','R141770099156750308'),('U154226495341609843','add,edit,del,refresh,','U150107939436631363','R141770099156750308'),('U154226495341623998','','U149542927908493158','R141770099156750308'),('U154226495341627248','edit_designer,add,edit,refresh,changepwd,','U148765647626620413','R141770099156750308'),('U154226495341627774','add,edit,del,refresh,','U148774376819175947','R141770099156750308'),('U154226495341627819','','U143891863167559700','R141770099156750308'),('U154226495341640221','add,edit,del,refresh,','U147563795975505594','R141770099156750308'),('U154226495341647589','','U147417439880357008','R141770099156750308'),('U154226495341684930','','U146772885528409688','R141770099156750308'),('U154226495341687874','add,edit,del,refresh,','U147686532906967243','R141770099156750308'),('U154226495341691044','edit_designer,add,edit,del,refresh,','U148248001874056364','R141770099156750308'),('U154226495341708455','','U150108134134573562','R141770099156750308'),('U154226495341717051','export,','U150773721860798909','R141770099156750308'),('U154226495341722695','add,edit,del,refresh,','U150894686421341181','R141770099156750308'),('U154226495341725602','edit_designer,add,edit,','U154225067366985402','R141770099156750308'),('U154226495341732131','add,edit,del,refresh,','U154226490927926250','R141770099156750308'),('U154226495341763981','edit,del,refresh,','U150419023701932892','R141770099156750308'),('U154226495341768511','','U150523150955702051','R141770099156750308'),('U154226495341773466','edit_designer,del,refresh,','U150609785810770279','R141770099156750308'),('U154226495341781605','','U150505741534899631','R141770099156750308'),('U154226495341799185','add,edit,del,refresh,','U150773698819847933','R141770099156750308'),('U154226854581327319','add,edit,del,refresh,','U154226854575116662','R141770099156750308'),('U154227251863724457','add,edit,del,refresh,','U154227251858798941','R141770099156750308'),('U154228785566755649','add,edit,del,refresh,','U154228785560711973','R141770099156750308');

/*Table structure for table `t_n_role_user` */

DROP TABLE IF EXISTS `t_n_role_user`;

CREATE TABLE `t_n_role_user` (
  `ID` varchar(32) NOT NULL,
  `ROLE_ID` varchar(32) DEFAULT NULL,
  `USER_ID` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_n_role_user` */

insert  into `t_n_role_user`(`ID`,`ROLE_ID`,`USER_ID`) values ('141770099157657188','R141770099156750308','U141770099155103287'),('U143462141469509690','R-UU141994583098704113','U-UU142406936416863226'),('U150485509319491457','R-UU141994583098704113','U_U146720855065737398'),('UU142407651985936553','R-UU141994583098704113','U-UU142062143880838422');

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

insert  into `t_n_sql_resource`(`id`,`create_time`,`descr`,`is_filter`,`last_modify_time`,`last_user_id`,`res_name`,`sql_`,`user_id`) values ('U151196871425889967','2017-11-29 23:18:34','选择用户列表',1,'2017-12-04 22:14:01','U141770099155103287','select_user_list','select t.full_name as value,t.full_name as name from t_n_user t order by t.create_time desc','U141770099155103287');

/*Table structure for table `t_n_sub_system` */

DROP TABLE IF EXISTS `t_n_sub_system`;

CREATE TABLE `t_n_sub_system` (
  `id` varchar(50) NOT NULL,
  `create_time` datetime NOT NULL,
  `icon` varchar(100) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `sort_order` int(11) NOT NULL,
  `state` varchar(2) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `user_id` varchar(50) NOT NULL,
  `sys_type` varchar(127) DEFAULT NULL,
  `sort_num` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_n_sub_system` */

insert  into `t_n_sub_system`(`id`,`create_time`,`icon`,`name`,`sort_order`,`state`,`url`,`user_id`,`sys_type`,`sort_num`) values ('U149563206152878545','2017-05-24 21:21:02','','百度',1,'1','https://www.baidu.com','U141770099155103287','external_sys',0),('U149563236716016916','2017-05-24 21:26:07','','开源中国',2,'0','https://www.oschina.net','U141770099155103287','external_sys',0);

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

insert  into `t_n_user`(`id`,`create_time`,`email`,`full_name`,`mobile_no`,`org_id`,`password`,`qq`,`remark`,`state`,`username`,`position_id`,`sort_order`) values ('U141770099155103287','2014-12-04 21:49:51','','超级管理员','13512345698','0','e10adc3949ba59abbe56e057f20f883e','','',1,'admin','',NULL),('U_U146720855065737398','2016-06-29 21:55:51','','测试用户1','','ORG_U143919525899571244','e10adc3949ba59abbe56e057f20f883e','','',1,'test1','P_U149071428624050487',NULL),('U_U146772964519572515','2016-07-05 22:40:45','','测试用户2','','ORG_U143919525899571244','e10adc3949ba59abbe56e057f20f883e','','',1,'test2','',NULL);

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
  `type_` varchar(50) NOT NULL,
  `update_date` varchar(20) DEFAULT NULL,
  `user_id` varchar(50) NOT NULL,
  `version_` varchar(50) NOT NULL,
  `num_version` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_n_version` */

/*Table structure for table `t_pf_leave` */

DROP TABLE IF EXISTS `t_pf_leave`;

CREATE TABLE `t_pf_leave` (
  `id` varchar(32) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `days` int(3) DEFAULT NULL,
  `leave_reason` text,
  `state` int(1) DEFAULT NULL,
  `creator` varchar(32) DEFAULT NULL,
  `form_data_id` varchar(32) DEFAULT NULL,
  `create_time` varchar(20) DEFAULT NULL,
  `leave_type` varchar(255) DEFAULT NULL,
  `is_trial` varchar(255) DEFAULT NULL,
  `other` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_pf_leave` */

insert  into `t_pf_leave`(`id`,`name`,`days`,`leave_reason`,`state`,`creator`,`form_data_id`,`create_time`,`leave_type`,`is_trial`,`other`) values ('U149382144649890999','测试列表控件11',2,'',0,'U141770099155103287','U149382144649665681','2017-05-03 22:24:06','l-2-1','0','测试'),('U149396437695186992','测试列表控件223',3,'<p><span style=\"color: rgb(255, 0, 0);\"><strong>测试中啊。。。hh</strong></span></p>',0,'U141770099155103287','U149396437693296499','2017-05-05 14:06:16','l-1-1,l-2-2','1','测试了啊'),('U149397451070202843','测试列表控件456',5,'<p><span style=\"color: rgb(255, 0, 0);\"><strong>在测试~~</strong></span><br/></p>',0,'U141770099155103287','U149397451070045545','2017-05-05 16:55:10','l-1-1,l-2-2','0','测试'),('U149397712392618863','测试列表控件678',5,'<p>测试中</p>',0,'U_U146720855065737398','U149397712392523981','2017-05-05 17:38:43','l-1-1,l-2-1','1','测试'),('U149397718638378631','测试列表控件910',5,'<p>测试</p>',0,'U_U146720855065737398','U149397718638059933','2017-05-05 17:39:46','l-2-1','0','测试'),('U149420819554757186','测试控件列表222',3,'<p><strong><span style=\"color: rgb(255, 0, 0);\">测试中了啊~~</span></strong></p>',0,'U141770099155103287','U149420819554530252','2017-05-08 09:49:55','l-1-1,l-2-2','1','测试中了啊'),('U149459841280019003','测试123',5,'<p>测试</p>',0,'U141770099155103287','U149459841279779009','2017-05-12 22:13:32','l-1-1,l-2-2','0','测试'),('U149459848301257481','测试IE浏览器1',3,'<p>测试</p>',0,'U141770099155103287','U149459848301079155','2017-05-12 22:14:43','l-1-2,l-2-1',NULL,'呵呵'),('U149503593762034602','超级管理员123',1,'<p>he</p>',0,'U141770099155103287','U149503593761768272','2017-05-17 23:45:37','l-2-1','0','cc'),('U149542934548522779','测试1',5,'<p>测试</p>',0,'U141770099155103287','U149542934548130084','2017-05-22 13:02:25','l-1-2,l-2-1','0','测试'),('U149542944103174995','测试判断22',2,'<p>测试</p>',0,'U141770099155103287','U149542944102850102','2017-05-22 13:04:01','l-2-1','0','测试'),('U149542953835461860','测试判断33',2,'',0,'U141770099155103287','U149542953835202817','2017-05-22 13:05:38','l-2-1','0','测试'),('U149542958499600414','测试啊123',3,'',0,'U141770099155103287','U149542958499334375','2017-05-22 13:06:24','l-2-2','0','测试'),('U149542980726824551','测试中123456',8,'<p>测试</p>',0,'U141770099155103287','U149542980726512082','2017-05-22 13:10:07','l-2-1','0','测试'),('U149543010367470103','测试中9876',8,'<p>测试</p>',0,'U141770099155103287','U149543010367275898','2017-05-22 13:15:03','l-2-1','0','测试'),('U151050255221472973','测试请假人1238906',2,'<p>测试</p>',0,'U141770099155103287','U151050254025097218','2017-11-13 00:02:32','l-2-1','0','测试中'),('U151188595822046052','测试请假人1238906',NULL,'测试3',0,'U141770099155103287','U151188592941943488','2017-11-29 00:19:18',NULL,NULL,NULL),('U151188630418032402','测试请假人1238908',NULL,'测试',0,'U141770099155103287','U151188627329270114','2017-11-29 00:25:04',NULL,NULL,NULL),('U151239693085777112','张三123',5,'<p>测试中</p>',0,'U141770099155103287','U151239693081635767','2017-12-04 22:15:30','l-1-2','0','测试');

/*Table structure for table `t_pf_other_user` */

DROP TABLE IF EXISTS `t_pf_other_user`;

CREATE TABLE `t_pf_other_user` (
  `id` varchar(32) NOT NULL,
  `other_name` varchar(255) DEFAULT NULL,
  `other_days` varchar(100) DEFAULT NULL,
  `state` int(1) DEFAULT NULL,
  `creator` varchar(32) DEFAULT NULL,
  `form_data_id` varchar(32) DEFAULT NULL,
  `create_time` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_pf_other_user` */

insert  into `t_pf_other_user`(`id`,`other_name`,`other_days`,`state`,`creator`,`form_data_id`,`create_time`) values ('U149382144650766347','2017-05-03','2017-05-04',0,'U141770099155103287','U149382144649665681','2017-05-03 22:24:06'),('U149396437696850706','2017-05-05','2017-05-06',0,'U141770099155103287','U149396437693296499','2017-05-05 14:06:16'),('U149397451070383238','2017-05-03','2017-05-05',0,'U141770099155103287','U149397451070045545','2017-05-05 16:55:10'),('U149397712393079130','2017-05-05','2017-05-09',0,'U_U146720855065737398','U149397712392523981','2017-05-05 17:38:43'),('U149397718638804244','2017-05-05','2017-05-10',0,'U_U146720855065737398','U149397718638059933','2017-05-05 17:39:46'),('U149420819555809745','2017-05-08','2017-05-11',0,'U141770099155103287','U149420819554530252','2017-05-08 09:49:55'),('U149459841280507137','2017-05-12','2017-05-13',0,'U141770099155103287','U149459841279779009','2017-05-12 22:13:32'),('U149459848301717672','2017-05-12','2017-05-13',0,'U141770099155103287','U149459848301079155','2017-05-12 22:14:43'),('U149503593762484180','2017-05-17','2017-05-18',0,'U141770099155103287','U149503593761768272','2017-05-17 23:45:37'),('U149542934549285237','2017-05-22','2017-05-27',0,'U141770099155103287','U149542934548130084','2017-05-22 13:02:25'),('U149542944104395803','2017-05-22','2017-05-25',0,'U141770099155103287','U149542944102850102','2017-05-22 13:04:01'),('U149542953835991674','2017-05-22','2017-05-25',0,'U141770099155103287','U149542953835202817','2017-05-22 13:05:38'),('U149542958500374795','2017-05-22','2017-05-26',0,'U141770099155103287','U149542958499334375','2017-05-22 13:06:25'),('U149542980727010787','2017-05-22','2017-05-30',0,'U141770099155103287','U149542980726512082','2017-05-22 13:10:07'),('U149543010367781233','2017-05-22','2017-05-27',0,'U141770099155103287','U149543010367275898','2017-05-22 13:15:03'),('U151050256646142510','2017-11-13','2017-11-15',0,'U141770099155103287','U151050254025097218','2017-11-13 00:02:46'),('U151188595822816375','2017-07-27',NULL,0,'U141770099155103287','U151188592941943488','2017-11-29 00:19:18'),('U151188630418562073','测试32',NULL,0,'U141770099155103287','U151188627329270114','2017-11-29 00:25:04'),('U151239693086535722','2017-12-04','2017-12-07',0,'U141770099155103287','U151239693081635767','2017-12-04 22:15:30');

/*Table structure for table `t_pf_test1` */

DROP TABLE IF EXISTS `t_pf_test1`;

CREATE TABLE `t_pf_test1` (
  `id` varchar(50) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `remark` varchar(1000) DEFAULT NULL,
  `state` int(1) DEFAULT NULL,
  `creator` varchar(50) DEFAULT NULL,
  `form_data_id` varchar(50) DEFAULT NULL,
  `create_time` varchar(20) DEFAULT NULL,
  `test_file` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_pf_test1` */

insert  into `t_pf_test1`(`id`,`name`,`remark`,`state`,`creator`,`form_data_id`,`create_time`,`test_file`) values ('U151188801469582708','9',NULL,0,'U141770099155103287','U151188627329270114','2017-11-29 00:53:34',NULL);

/*Table structure for table `t_pf_test_list` */

DROP TABLE IF EXISTS `t_pf_test_list`;

CREATE TABLE `t_pf_test_list` (
  `id` varchar(50) NOT NULL,
  `list_name` varchar(255) DEFAULT NULL,
  `list_alias` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `state` int(1) DEFAULT NULL,
  `creator` varchar(50) DEFAULT NULL,
  `form_data_id` varchar(50) DEFAULT NULL,
  `create_time` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_pf_test_list` */

insert  into `t_pf_test_list`(`id`,`list_name`,`list_alias`,`remark`,`state`,`creator`,`form_data_id`,`create_time`) values ('U149382144650427331','呵呵123','127','2',0,'U141770099155103287','U149382144649665681','2017-05-03 22:24:06'),('U149382144650632612','呵呵278','228','222',0,'U141770099155103287','U149382144649665681','2017-05-03 22:24:06'),('U149397365854573152','测试1','123','456',0,'U_U146720855065737398','U149396437693296499','2017-05-05 16:40:58'),('U149397454888084925','哈哈1','哈哈2','哈哈3',0,'U_U146720855065737398','U149397451070045545','2017-05-05 16:55:48'),('U149397712392844228','测试1','测试2','测试3',0,'U_U146720855065737398','U149397712392523981','2017-05-05 17:38:43'),('U149420819555201033','其他信息1','其他信息12','其他信息1323',0,'U141770099155103287','U149420819554530252','2017-05-08 09:49:55'),('U149542934549005271','测试','','',0,'U141770099155103287','U149542934548130084','2017-05-22 13:02:25'),('U149542944103772988','测试中111','','',0,'U141770099155103287','U149542944102850102','2017-05-22 13:04:01'),('U149542953835662691','测试','','',0,'U141770099155103287','U149542953835202817','2017-05-22 13:05:38'),('U149542958500025820','测试','','',0,'U141770099155103287','U149542958499334375','2017-05-22 13:06:25'),('U151050256645647751','M-U143386498490644858','','',0,'U141770099155103287','U151050254025097218','2017-11-13 00:02:46'),('U151050256645823754','M-UU142493393345840632','','',0,'U141770099155103287','U151050254025097218','2017-11-13 00:02:46'),('U151188595822332412','123','1',NULL,0,'U141770099155103287','U151188592941943488','2017-11-29 00:19:18'),('U151188595822660506','456','2',NULL,0,'U141770099155103287','U151188592941943488','2017-11-29 00:19:18'),('U151188630418125766','112','1',NULL,0,'U141770099155103287','U151188627329270114','2017-11-29 00:25:04'),('U151188630418242582','123','2',NULL,0,'U141770099155103287','U151188627329270114','2017-11-29 00:25:04'),('U151188630418320259','456','6',NULL,0,'U141770099155103287','U151188627329270114','2017-11-29 00:25:04'),('U151239693086066677','超级管理员','1','2',0,'U141770099155103287','U151239693081635767','2017-12-04 22:15:30'),('U151239693086226030','测试用户1','2','3',0,'U141770099155103287','U151239693081635767','2017-12-04 22:15:30');

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

insert  into `t_report`(`id`,`create_time`,`name`,`type`,`user_id`) values ('R_U150600830877642873','2017-09-21 23:38:29','测试报表1','custom_sql_report','U141770099155103287');

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

insert  into `t_report_field`(`id`,`create_time`,`custom_class`,`open_url_type`,`param_name`,`param_value`,`report_id`,`search_name`,`sort_order`,`title`,`url`,`width`) values ('RF-U150600830881500923','2017-09-21 23:38:29','','','','','R_U150600830877642873','',3,'手机号','',''),('RF-U150600830881556994','2017-09-21 23:38:29','','','','','R_U150600830877642873','fullName',1,'姓名','',''),('RF-U150600830881565997','2017-09-21 23:38:29','','','','','R_U150600830877642873','',2,'用户名','','');

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

insert  into `t_report_properties`(`id`,`is_checkbox`,`is_fixed_header`,`is_has_id`,`is_import`,`is_show_id`,`report_id`) values ('U150600830878759756',0,1,1,1,0,'R_U150600830877642873');

/*Table structure for table `t_report_sql_resource` */

DROP TABLE IF EXISTS `t_report_sql_resource`;

CREATE TABLE `t_report_sql_resource` (
  `id` varchar(50) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `is_filter` int(11) DEFAULT NULL,
  `name` varchar(127) NOT NULL,
  `report_id` varchar(50) NOT NULL,
  `sql_` varchar(1024) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_8fco6q6cytflnss8nf0u6ob1l` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_report_sql_resource` */

insert  into `t_report_sql_resource`(`id`,`create_time`,`is_filter`,`name`,`report_id`,`sql_`) values ('U150600830880172709',NULL,1,'test_report_1','R_U150600830877642873','SELECT t.id,t.full_name,t.username,t.mobile_no FROM t_n_user t where 1=1 [ and t.full_name like \'%:fullName%\'] order by t.create_time desc');

/*Table structure for table `t_wf_cc_order` */

DROP TABLE IF EXISTS `t_wf_cc_order`;

CREATE TABLE `t_wf_cc_order` (
  `ORDER_ID` varchar(32) NOT NULL,
  `ACTOR_ID` varchar(32) NOT NULL,
  `creator` varchar(50) DEFAULT NULL,
  `create_Time` varchar(50) DEFAULT NULL,
  `finish_Time` varchar(50) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`ORDER_ID`,`ACTOR_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_wf_cc_order` */

/*Table structure for table `t_wf_hist_order` */

DROP TABLE IF EXISTS `t_wf_hist_order`;

CREATE TABLE `t_wf_hist_order` (
  `id` varchar(32) NOT NULL,
  `process_Id` varchar(32) DEFAULT NULL,
  `order_State` int(11) DEFAULT NULL,
  `creator` varchar(50) DEFAULT NULL,
  `create_Time` varchar(50) DEFAULT NULL,
  `end_Time` varchar(50) DEFAULT NULL,
  `expire_Time` varchar(50) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `parent_Id` varchar(32) DEFAULT NULL,
  `order_No` varchar(50) DEFAULT NULL,
  `variable` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_wf_hist_order` */

insert  into `t_wf_hist_order`(`id`,`process_Id`,`order_State`,`creator`,`create_Time`,`end_Time`,`expire_Time`,`priority`,`parent_Id`,`order_No`,`variable`) values ('7bbfd222c5c84acda95bc91e4d3539b8','9ba0baa1819c4fb5878566f4dc2fddbf',1,'U_U146720855065737398','2017-05-05 17:39:46',NULL,NULL,NULL,NULL,'20170505-17:39:46-403-785','{\"U143934487932938828\":5,\"create_user\":\"U_U146720855065737398\",\"handleSuggest\":\"cs\"}'),('829e9c9d24b9424aa19de392d55da669','9ba0baa1819c4fb5878566f4dc2fddbf',1,'U141770099155103287','2017-05-05 14:06:17',NULL,NULL,NULL,NULL,'20170505-14:06:17-081-631','{\"U143934487932938828\":3,\"create_user\":\"U141770099155103287\",\"handleSuggest\":\"测试\"}'),('8a26bb0109d7479fba4370922c584802','9ba0baa1819c4fb5878566f4dc2fddbf',1,'U141770099155103287','2017-05-12 22:13:32',NULL,NULL,NULL,NULL,'20170512-22:13:32-918-319','{\"U143934487932938828\":5,\"create_user\":\"U141770099155103287\"}'),('94dcce6defca4644b431970ad7c0974d','20c04875b55949cbaa932354fdbeb8c6',1,'U141770099155103287','2017-05-22 13:05:38',NULL,NULL,NULL,NULL,'20170522-13:05:38-377-320','{\"create_user\":\"U141770099155103287\"}'),('a4f8a84aacaf434dbb0b8c813a65bc84','9ba0baa1819c4fb5878566f4dc2fddbf',1,'U141770099155103287','2017-11-13 00:02:46',NULL,NULL,NULL,NULL,'20171113-00:02:46-578-491','{\"U143934487932938828\":2,\"create_user\":\"U141770099155103287\"}'),('a522d77fd069401aa064e792b1097875','20c04875b55949cbaa932354fdbeb8c6',1,'U141770099155103287','2017-05-22 13:15:03',NULL,NULL,NULL,NULL,'20170522-13:15:03-691-999','{\"U143934487932938828\":8,\"create_user\":\"U141770099155103287\"}'),('a6b096b78b864fb88ff20770ec32e9a3','9ba0baa1819c4fb5878566f4dc2fddbf',1,'U141770099155103287','2017-05-05 16:55:10',NULL,NULL,NULL,NULL,'20170505-16:55:10-717-500','{\"U143934487932938828\":5,\"create_user\":\"U141770099155103287\",\"handleSuggest\":\"测试\"}'),('a714c685e4fd4d489d76ee922800b28f','20c04875b55949cbaa932354fdbeb8c6',1,'U141770099155103287','2017-05-22 13:04:01',NULL,NULL,NULL,NULL,'20170522-13:04:01-063-737','{\"U143934487932938828\":2,\"create_user\":\"U141770099155103287\"}'),('bae429c1e7d64f639fd0a8e158019b1c','20c04875b55949cbaa932354fdbeb8c6',1,'U141770099155103287','2017-05-22 13:10:07',NULL,NULL,NULL,NULL,'20170522-13:10:07-279-398','{\"create_user\":\"U141770099155103287\"}'),('bca7a28436fc47499f97f5d3fb7bafa0','20c04875b55949cbaa932354fdbeb8c6',1,'U141770099155103287','2017-05-22 13:02:25',NULL,NULL,NULL,NULL,'20170522-13:02:25-528-608','{\"U143934487932938828\":5,\"create_user\":\"U141770099155103287\"}'),('bed1de64e70649f58d1d5744728927a3','9ba0baa1819c4fb5878566f4dc2fddbf',1,'U141770099155103287','2017-05-17 23:45:37',NULL,NULL,NULL,NULL,'20170517-23:45:37-722-637','{\"U143934487932938828\":1,\"create_user\":\"U141770099155103287\"}'),('bf70da33036c49508ee7a858b988367d','9ba0baa1819c4fb5878566f4dc2fddbf',1,'U_U146720855065737398','2017-05-05 17:38:43',NULL,NULL,NULL,NULL,'20170505-17:38:43-939-314','{\"U143934487932938828\":5,\"create_user\":\"U_U146720855065737398\"}'),('c4b097e7c7464c30b5ce27870a6f13f6','9ba0baa1819c4fb5878566f4dc2fddbf',0,'U141770099155103287','2017-05-03 22:24:06','2017-05-05 13:54:28',NULL,NULL,NULL,'20170503-22:24:06-593-400','{\"U143934487932938828\":2,\"create_user\":\"U141770099155103287\",\"handleSuggest\":\"测试\"}'),('d277cb8dd44e4ab7821f9f7aaf147ef7','9ba0baa1819c4fb5878566f4dc2fddbf',1,'U141770099155103287','2017-05-12 22:14:43',NULL,NULL,NULL,NULL,'20170512-22:14:43-042-761','{\"U143934487932938828\":3,\"create_user\":\"U141770099155103287\"}'),('d71aa87f35224bb8a0cc429e77439abc','20c04875b55949cbaa932354fdbeb8c6',1,'U141770099155103287','2017-05-22 13:06:25',NULL,NULL,NULL,NULL,'20170522-13:06:25-017-319','{\"create_user\":\"U141770099155103287\"}'),('e5d2d077685e448c897f1e72a4aac31c','9ba0baa1819c4fb5878566f4dc2fddbf',1,'U141770099155103287','2017-05-08 09:49:55',NULL,NULL,NULL,NULL,'20170508-09:49:55-668-831','{\"U143934487932938828\":3,\"create_user\":\"U141770099155103287\",\"handleSuggest\":\"测试空行\"}'),('efeefd054e964b739f9b18518ae591b5','9ba0baa1819c4fb5878566f4dc2fddbf',1,'U141770099155103287','2017-12-04 22:15:30',NULL,NULL,NULL,NULL,'20171204-22:15:30-937-357','{\"U143934487932938828\":5,\"create_user\":\"U141770099155103287\"}');

/*Table structure for table `t_wf_hist_task` */

DROP TABLE IF EXISTS `t_wf_hist_task`;

CREATE TABLE `t_wf_hist_task` (
  `id` varchar(32) NOT NULL,
  `ORDER_ID` varchar(32) DEFAULT NULL,
  `TASK_NAME` varchar(100) DEFAULT NULL,
  `DISPLAY_NAME` varchar(200) DEFAULT NULL,
  `OPERATOR` varchar(50) DEFAULT NULL,
  `CREATE_TIME` varchar(50) DEFAULT NULL,
  `TAKE_TIME` varchar(50) DEFAULT NULL,
  `FINISH_TIME` varchar(50) DEFAULT NULL,
  `EXPIRE_TIME` varchar(50) DEFAULT NULL,
  `ACTION_URL` varchar(200) DEFAULT NULL,
  `TASK_TYPE` int(11) DEFAULT NULL,
  `TASK_STATE` int(11) DEFAULT NULL,
  `PERFORM_TYPE` int(11) DEFAULT NULL,
  `PARENT_TASK_ID` varchar(32) DEFAULT NULL,
  `VARIABLE` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_wf_hist_task` */

insert  into `t_wf_hist_task`(`id`,`ORDER_ID`,`TASK_NAME`,`DISPLAY_NAME`,`OPERATOR`,`CREATE_TIME`,`TAKE_TIME`,`FINISH_TIME`,`EXPIRE_TIME`,`ACTION_URL`,`TASK_TYPE`,`TASK_STATE`,`PERFORM_TYPE`,`PARENT_TASK_ID`,`VARIABLE`) values ('0255de074bcc4a33a9ae8446e6993133','a6b096b78b864fb88ff20770ec32e9a3','rect2','申请','U141770099155103287','2017-05-05 16:55:10',NULL,'2017-05-05 16:55:10',NULL,'process/form',0,0,0,'start','{\"U143934487932938828\":5,\"S-ACTOR\":\"U141770099155103287\",\"create_user\":\"U141770099155103287\"}'),('02575df15ae04514b98b65cde08fdb8b','a4f8a84aacaf434dbb0b8c813a65bc84','rect2','申请','U141770099155103287','2017-11-13 00:02:46',NULL,'2017-11-13 00:02:46',NULL,'process/form',0,0,0,'start','{\"U143934487932938828\":2,\"S-ACTOR\":\"U141770099155103287\",\"create_user\":\"U141770099155103287\"}'),('039501c925234e1783653d753c93090f','8a26bb0109d7479fba4370922c584802','rect2','申请','U141770099155103287','2017-05-12 22:13:32',NULL,'2017-05-12 22:13:32',NULL,'process/form',0,0,0,'start','{\"U143934487932938828\":5,\"S-ACTOR\":\"U141770099155103287\",\"create_user\":\"U141770099155103287\"}'),('059e2550547842c7b311f46a555250ea','829e9c9d24b9424aa19de392d55da669','rect2','申请','U141770099155103287','2017-05-05 14:44:04',NULL,'2017-05-05 14:46:34',NULL,'process/form',0,0,0,'651f9aae985f43a8b43105339f4fb7a6','{\"U143934487932938828\":3}'),('06a833dfa10f4b31a36b1f157aa44020','829e9c9d24b9424aa19de392d55da669','rect2','申请','U141770099155103287','2017-05-05 16:40:58',NULL,'2017-05-05 17:29:32',NULL,'process/form',0,0,0,'bcb43d41fd494b4f885bec47087bfce3','{\"U143934487932938828\":3}'),('09a8bfe3cbd74eefaface6b493090231','a714c685e4fd4d489d76ee922800b28f','rect2','申请','U141770099155103287','2017-05-22 13:04:01',NULL,'2017-05-22 13:04:01',NULL,'process/form',0,0,0,'start','{\"U143934487932938828\":2,\"S-ACTOR\":\"U141770099155103287\",\"create_user\":\"U141770099155103287\"}'),('13b90aa0ea514b699634b07e9f633501','a522d77fd069401aa064e792b1097875','rect2','申请','U141770099155103287','2017-05-22 13:15:03',NULL,'2017-05-22 13:15:03',NULL,'process/form',0,0,0,'start','{\"U143934487932938828\":8,\"S-ACTOR\":\"U141770099155103287\",\"create_user\":\"U141770099155103287\"}'),('14dd9c87a8794797a73ebe232d72d348','c4b097e7c7464c30b5ce27870a6f13f6','rect2','申请','U141770099155103287','2017-05-03 22:24:06',NULL,'2017-05-03 22:24:06',NULL,'process/form',0,0,0,'start','{\"U143934487932938828\":2,\"S-ACTOR\":\"U141770099155103287\",\"create_user\":\"U141770099155103287\"}'),('18c69822c89a4d18b3a9a3c7445078ba','94dcce6defca4644b431970ad7c0974d','rect2','申请','U141770099155103287','2017-05-22 13:05:38',NULL,'2017-05-22 13:05:38',NULL,'process/form',0,0,0,'start','{\"S-ACTOR\":\"U141770099155103287\",\"create_user\":\"U141770099155103287\"}'),('25f0d09b55044c649b2ca3a9b96d7ef5','efeefd054e964b739f9b18518ae591b5','rect2','申请','U141770099155103287','2017-12-04 22:15:30',NULL,'2017-12-04 22:15:31',NULL,'process/form',0,0,0,'start','{\"U143934487932938828\":5,\"S-ACTOR\":\"U141770099155103287\",\"create_user\":\"U141770099155103287\"}'),('26c7fb7c3fac457c9d6ed39f03d5a2a9','e5d2d077685e448c897f1e72a4aac31c','rect3','审核','U_U146720855065737398','2017-05-08 09:54:46',NULL,'2017-05-08 09:55:19','2017-05-08 09:55:22','process/form',0,0,0,'29ee93f3d16f403b9f4302fc22b585b3','{\"handleSuggest\":\"测试空行\"}'),('28a4c520c06845c7b945d0181a6aea6c','d277cb8dd44e4ab7821f9f7aaf147ef7','rect2','申请','U141770099155103287','2017-05-12 22:14:43',NULL,'2017-05-12 22:14:43',NULL,'process/form',0,0,0,'start','{\"U143934487932938828\":3,\"S-ACTOR\":\"U141770099155103287\",\"create_user\":\"U141770099155103287\"}'),('29ee93f3d16f403b9f4302fc22b585b3','e5d2d077685e448c897f1e72a4aac31c','rect2','申请','U141770099155103287','2017-05-08 09:54:02',NULL,'2017-05-08 09:54:46',NULL,'process/form',0,0,0,'ce794f8a8d4046a2b87ed592c9097e3e','{\"U143934487932938828\":3}'),('3ae1e482db9a4cb3bc8ac985368455e3','bca7a28436fc47499f97f5d3fb7bafa0','rect2','申请','U141770099155103287','2017-05-22 13:02:25',NULL,'2017-05-22 13:02:25',NULL,'process/form',0,0,0,'start','{\"U143934487932938828\":5,\"S-ACTOR\":\"U141770099155103287\",\"create_user\":\"U141770099155103287\"}'),('3c00a51297584e3dbb06757515450b39','829e9c9d24b9424aa19de392d55da669','rect3','审核','U_U146720855065737398','2017-05-05 17:29:32',NULL,'2017-05-05 17:30:41','2017-05-05 17:30:08','process/form',0,0,0,'06a833dfa10f4b31a36b1f157aa44020','{\"handleSuggest\":\"测试\"}'),('3f8c948a6cc1412a8dff375596b92a0d','829e9c9d24b9424aa19de392d55da669','rect3','审核','U_U146720855065737398','2017-05-05 14:46:34',NULL,'2017-05-05 14:48:43','2017-05-05 14:47:10','process/form',0,0,0,'059e2550547842c7b311f46a555250ea','{\"handleSuggest\":\"呵呵\"}'),('4100d807f9f1496c82fc3c47365ae4ad','c4b097e7c7464c30b5ce27870a6f13f6','rect3','审核','U_U146720855065737398','2017-05-04 19:48:27',NULL,'2017-05-04 19:50:10','2017-05-04 19:49:03','process/form',0,0,0,'c481f00ccea54bfeb2ecd6d86482e287','{\"handleSuggest\":\"测试\"}'),('4cf15e4c3cb64775914cace80b8e498a','829e9c9d24b9424aa19de392d55da669','rect3','审核','U_U146720855065737398','2017-05-05 17:31:44',NULL,'2017-05-05 17:33:06','2017-05-05 17:32:20','process/form',0,0,0,'5ba1d5249f3a4cd18b413767aad93ea0','{\"handleSuggest\":\"测试\"}'),('52b07019ea0a4f6cae33935bc8660126','c4b097e7c7464c30b5ce27870a6f13f6','rect3','审核','U_U146720855065737398','2017-05-04 18:39:59',NULL,'2017-05-04 19:37:53','2017-05-04 18:40:35','process/form',0,0,0,'c1cb684489e74e0bb46df8afa11b6fe6','{\"handleSuggest\":\"测试~~~\"}'),('582e94203a794f74b2da4322da751959','c4b097e7c7464c30b5ce27870a6f13f6','rect4','审核2','snaker.admin','2017-05-04 19:37:53',NULL,'2017-05-04 19:38:41','2017-05-04 19:38:29','process/form',0,0,0,'52b07019ea0a4f6cae33935bc8660126','{\"handleSuggest\":\"测试中\",\"isBack\":\"1\",\"nextLineName\":\"jump_rect3\",\"operator\":\"U141770099155103287\"}'),('5ba1d5249f3a4cd18b413767aad93ea0','829e9c9d24b9424aa19de392d55da669','rect4','审核2','snaker.admin','2017-05-05 17:30:41',NULL,'2017-05-05 17:31:44','2017-05-05 17:31:17','process/form',0,0,0,'3c00a51297584e3dbb06757515450b39','{\"handleSuggest\":\"测试\",\"isBack\":\"1\",\"nextLineName\":\"jump_rect3\",\"operator\":\"U141770099155103287\"}'),('651f9aae985f43a8b43105339f4fb7a6','829e9c9d24b9424aa19de392d55da669','rect3','审核','U_U146720855065737398','2017-05-05 14:06:17',NULL,'2017-05-05 14:44:04','2017-05-05 14:06:53','process/form',0,0,0,'e0a01189438a4ef18d9473b3954f688d','{\"handleSuggest\":\"测试中\"}'),('6a5b04c8bae146b298b2593a7180d416','c4b097e7c7464c30b5ce27870a6f13f6','rect4','审核2','snaker.admin','2017-05-04 20:46:24',NULL,'2017-05-05 13:54:28','2017-05-04 20:47:00','process/form',0,0,0,'7a4cbecd67c7499bac365796139fb3ea','{}'),('70f4bac727a346e58902c93e4ab44e83','d71aa87f35224bb8a0cc429e77439abc','rect2','申请','U141770099155103287','2017-05-22 13:06:25',NULL,'2017-05-22 13:06:25',NULL,'process/form',0,0,0,'start','{\"S-ACTOR\":\"U141770099155103287\",\"create_user\":\"U141770099155103287\"}'),('726feaf2620c4b2393b8059d7f6aab25','c4b097e7c7464c30b5ce27870a6f13f6','rect4','审核2','snaker.admin','2017-05-04 20:19:23',NULL,'2017-05-04 20:20:38','2017-05-04 20:19:59','process/form',0,0,0,'dae5284a7e6c42df93a3805211e6091a','{\"handleSuggest\":\"测试中\",\"isBack\":\"1\",\"nextLineName\":\"jump_rect3\",\"operator\":\"U141770099155103287\"}'),('76775fd39b72413a9f80e27a72d17b69','c4b097e7c7464c30b5ce27870a6f13f6','rect3','审核','U_U146720855065737398','2017-05-04 19:41:18',NULL,'2017-05-04 19:45:49','2017-05-04 19:41:54','process/form',0,0,0,'f4bfee62192147758445ef0a68ec507f','{\"handleSuggest\":\"测试中！\"}'),('7a4cbecd67c7499bac365796139fb3ea','c4b097e7c7464c30b5ce27870a6f13f6','rect3','审核','U_U146720855065737398','2017-05-04 20:20:38',NULL,'2017-05-04 20:46:24','2017-05-04 20:21:14','process/form',0,0,0,'726feaf2620c4b2393b8059d7f6aab25','{\"handleSuggest\":\"测试\"}'),('86ba6680dd07425ea85b588c3aabd4cf','829e9c9d24b9424aa19de392d55da669','rect4','审核2','snaker.admin','2017-05-05 16:38:23',NULL,'2017-05-05 16:40:22','2017-05-05 16:38:59','process/form',0,0,0,'8a5f4343eabc45e1a977a95478f6e322','{\"handleSuggest\":\"测试\",\"isBack\":\"1\",\"nextLineName\":\"jump_rect3\",\"operator\":\"U141770099155103287\"}'),('8a5f4343eabc45e1a977a95478f6e322','829e9c9d24b9424aa19de392d55da669','rect3','审核','U_U146720855065737398','2017-05-05 14:49:20',NULL,'2017-05-05 16:38:23','2017-05-05 14:49:56','process/form',0,0,0,'de83ae0d27024c23a44bb4e845392ca8','{\"handleSuggest\":\"cs\"}'),('8d4bd6f6deb544dd84e91d2a3bcfdb18','c4b097e7c7464c30b5ce27870a6f13f6','rect3','审核','U_U146720855065737398','2017-05-04 19:38:41',NULL,'2017-05-04 19:40:34','2017-05-04 19:39:17','process/form',0,0,0,'582e94203a794f74b2da4322da751959','{\"handleSuggest\":\"测试中\"}'),('ac8fb9701bb24714a1ade451682b7c95','c4b097e7c7464c30b5ce27870a6f13f6','rect3','审核','U_U146720855065737398','2017-05-04 19:46:30',NULL,'2017-05-04 19:48:16','2017-05-04 19:47:06','process/form',0,0,0,'ba0893112eff4daebec44dc3ba63c7fb','{\"handleSuggest\":\"测试\"}'),('acff88577e1041249ec6e0cffe45d2ab','c4b097e7c7464c30b5ce27870a6f13f6','rect4','审核2','snaker.admin','2017-05-04 19:50:10',NULL,'2017-05-04 20:05:52','2017-05-04 19:50:46','process/form',0,0,0,'4100d807f9f1496c82fc3c47365ae4ad','{\"handleSuggest\":\"测试\",\"isBack\":\"1\",\"nextLineName\":\"jump_rect3\",\"operator\":\"U141770099155103287\"}'),('ad2103701a274ae69f5138e7834bfae4','e5d2d077685e448c897f1e72a4aac31c','rect2','申请','U141770099155103287','2017-05-08 09:49:55',NULL,'2017-05-08 09:49:55',NULL,'process/form',0,0,0,'start','{\"U143934487932938828\":3,\"S-ACTOR\":\"U141770099155103287\",\"create_user\":\"U141770099155103287\"}'),('ba0893112eff4daebec44dc3ba63c7fb','c4b097e7c7464c30b5ce27870a6f13f6','rect4','审核2','snaker.admin','2017-05-04 19:45:49',NULL,'2017-05-04 19:46:30','2017-05-04 19:46:25','process/form',0,0,0,'76775fd39b72413a9f80e27a72d17b69','{\"handleSuggest\":\"测试\",\"isBack\":\"1\",\"nextLineName\":\"jump_rect3\",\"operator\":\"U141770099155103287\"}'),('bcb43d41fd494b4f885bec47087bfce3','829e9c9d24b9424aa19de392d55da669','rect3','审核','U_U146720855065737398','2017-05-05 16:40:22',NULL,'2017-05-05 16:40:58','2017-05-05 16:40:58','process/form',0,0,0,'86ba6680dd07425ea85b588c3aabd4cf','{\"handleSuggest\":\"测试中\"}'),('c1cb684489e74e0bb46df8afa11b6fe6','c4b097e7c7464c30b5ce27870a6f13f6','rect4','审核2','snaker.admin','2017-05-04 18:37:48',NULL,'2017-05-04 18:39:59','2017-05-04 18:38:24','process/form',0,0,0,'d97668418c59445cb30cdf3d27e10a04','{\"handleSuggest\":\"测试\",\"isBack\":\"1\",\"nextLineName\":\"jump_rect3\",\"operator\":\"U141770099155103287\"}'),('c481f00ccea54bfeb2ecd6d86482e287','c4b097e7c7464c30b5ce27870a6f13f6','rect4','审核2','snaker.admin','2017-05-04 19:48:16',NULL,'2017-05-04 19:48:27','2017-05-04 19:48:52','process/form',0,0,0,'ac8fb9701bb24714a1ade451682b7c95','{\"handleSuggest\":\"测试\",\"isBack\":\"1\",\"nextLineName\":\"jump_rect3\",\"operator\":\"U141770099155103287\"}'),('c79e9ba22d2347ebb55e0a65b1fd3370','bed1de64e70649f58d1d5744728927a3','rect2','申请','U141770099155103287','2017-05-17 23:45:37',NULL,'2017-05-17 23:45:37',NULL,'process/form',0,0,0,'start','{\"U143934487932938828\":1,\"S-ACTOR\":\"U141770099155103287\",\"create_user\":\"U141770099155103287\"}'),('ce794f8a8d4046a2b87ed592c9097e3e','e5d2d077685e448c897f1e72a4aac31c','rect3','审核','U_U146720855065737398','2017-05-08 09:49:55',NULL,'2017-05-08 09:54:02','2017-05-08 09:50:31','process/form',0,0,0,'ad2103701a274ae69f5138e7834bfae4','{\"handleSuggest\":\"测试中~~\"}'),('d97668418c59445cb30cdf3d27e10a04','c4b097e7c7464c30b5ce27870a6f13f6','rect3','审核','U_U146720855065737398','2017-05-03 22:24:06',NULL,'2017-05-04 18:37:48','2017-05-03 22:24:42','process/form',0,0,0,'14dd9c87a8794797a73ebe232d72d348','{\"handleSuggest\":\"测试中\"}'),('dae5284a7e6c42df93a3805211e6091a','c4b097e7c7464c30b5ce27870a6f13f6','rect3','审核','U_U146720855065737398','2017-05-04 20:05:52',NULL,'2017-05-04 20:19:23','2017-05-04 20:06:28','process/form',0,0,0,'acff88577e1041249ec6e0cffe45d2ab','{\"handleSuggest\":\"测试\"}'),('de83ae0d27024c23a44bb4e845392ca8','829e9c9d24b9424aa19de392d55da669','rect2','申请','U141770099155103287','2017-05-05 14:48:43',NULL,'2017-05-05 14:49:20',NULL,'process/form',0,0,0,'3f8c948a6cc1412a8dff375596b92a0d','{\"U143934487932938828\":3}'),('dfc29324a1ae48ebba0b844b633f3973','7bbfd222c5c84acda95bc91e4d3539b8','rect3','审核','U_U146720855065737398','2017-05-05 17:39:46',NULL,'2017-05-05 18:21:17','2017-05-05 17:40:22','process/form',0,0,0,'ed2bc8875a0c4d7eb3db7714d17fcd1e','{\"handleSuggest\":\"cs\"}'),('e0a01189438a4ef18d9473b3954f688d','829e9c9d24b9424aa19de392d55da669','rect2','申请','U141770099155103287','2017-05-05 14:06:17',NULL,'2017-05-05 14:06:17',NULL,'process/form',0,0,0,'start','{\"U143934487932938828\":3,\"S-ACTOR\":\"U141770099155103287\",\"create_user\":\"U141770099155103287\"}'),('e0aa7db0da25487e9eb5d144e3ebc321','a6b096b78b864fb88ff20770ec32e9a3','rect2','申请','snaker.admin','2017-05-05 16:55:48',NULL,'2017-05-05 17:31:14',NULL,'process/form',0,0,0,'eb65f8d6a5bd4b2b97e7dc9dcbcac5ed','{\"handleSuggest\":\"测试\",\"isBack\":\"0\",\"nextLineName\":\"jump_rect3\",\"operator\":\"U141770099155103287\"}'),('e80f1fe377c14d80b71f119c628b9af7','bf70da33036c49508ee7a858b988367d','rect2','申请','U_U146720855065737398','2017-05-05 17:38:43',NULL,'2017-05-05 17:38:43',NULL,'process/form',0,0,0,'start','{\"U143934487932938828\":5,\"S-ACTOR\":\"U_U146720855065737398\",\"create_user\":\"U_U146720855065737398\"}'),('eb65f8d6a5bd4b2b97e7dc9dcbcac5ed','a6b096b78b864fb88ff20770ec32e9a3','rect3','审核','U_U146720855065737398','2017-05-05 16:55:10',NULL,'2017-05-05 16:55:48','2017-05-05 16:55:46','process/form',0,0,0,'0255de074bcc4a33a9ae8446e6993133','{\"handleSuggest\":\"测试\"}'),('ed2bc8875a0c4d7eb3db7714d17fcd1e','7bbfd222c5c84acda95bc91e4d3539b8','rect2','申请','U_U146720855065737398','2017-05-05 17:39:46',NULL,'2017-05-05 17:39:46',NULL,'process/form',0,0,0,'start','{\"U143934487932938828\":5,\"S-ACTOR\":\"U_U146720855065737398\",\"create_user\":\"U_U146720855065737398\"}'),('edf8223a74a843e1a3d184d735b908e0','bae429c1e7d64f639fd0a8e158019b1c','rect2','申请','U141770099155103287','2017-05-22 13:10:07',NULL,'2017-05-22 13:10:07',NULL,'process/form',0,0,0,'start','{\"S-ACTOR\":\"U141770099155103287\",\"create_user\":\"U141770099155103287\"}'),('f4bfee62192147758445ef0a68ec507f','c4b097e7c7464c30b5ce27870a6f13f6','rect4','审核2','snaker.admin','2017-05-04 19:40:34',NULL,'2017-05-04 19:41:18','2017-05-04 19:41:10','process/form',0,0,0,'8d4bd6f6deb544dd84e91d2a3bcfdb18','{\"handleSuggest\":\"测试\",\"isBack\":\"1\",\"nextLineName\":\"jump_rect3\",\"operator\":\"U141770099155103287\"}'),('fa4113b87ccc4c2b931f0ef82d2e0528','e5d2d077685e448c897f1e72a4aac31c','rect2','申请','U141770099155103287','2017-05-08 09:55:19',NULL,'2017-05-08 09:56:05',NULL,'process/form',0,0,0,'26c7fb7c3fac457c9d6ed39f03d5a2a9','{\"U143934487932938828\":3}');

/*Table structure for table `t_wf_hist_task_actor` */

DROP TABLE IF EXISTS `t_wf_hist_task_actor`;

CREATE TABLE `t_wf_hist_task_actor` (
  `TASK_ID` varchar(32) NOT NULL,
  `ACTOR_ID` varchar(50) NOT NULL,
  PRIMARY KEY (`TASK_ID`,`ACTOR_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_wf_hist_task_actor` */

insert  into `t_wf_hist_task_actor`(`TASK_ID`,`ACTOR_ID`) values ('0255de074bcc4a33a9ae8446e6993133','U141770099155103287'),('02575df15ae04514b98b65cde08fdb8b','U141770099155103287'),('039501c925234e1783653d753c93090f','U141770099155103287'),('059e2550547842c7b311f46a555250ea','U141770099155103287'),('06a833dfa10f4b31a36b1f157aa44020','U141770099155103287'),('09a8bfe3cbd74eefaface6b493090231','U141770099155103287'),('13b90aa0ea514b699634b07e9f633501','U141770099155103287'),('14dd9c87a8794797a73ebe232d72d348','U141770099155103287'),('18c69822c89a4d18b3a9a3c7445078ba','U141770099155103287'),('25f0d09b55044c649b2ca3a9b96d7ef5','U141770099155103287'),('26c7fb7c3fac457c9d6ed39f03d5a2a9','U_U146720855065737398'),('28a4c520c06845c7b945d0181a6aea6c','U141770099155103287'),('29ee93f3d16f403b9f4302fc22b585b3','U141770099155103287'),('3ae1e482db9a4cb3bc8ac985368455e3','U141770099155103287'),('3c00a51297584e3dbb06757515450b39','U_U146720855065737398'),('3f8c948a6cc1412a8dff375596b92a0d','U_U146720855065737398'),('4100d807f9f1496c82fc3c47365ae4ad','U_U146720855065737398'),('4cf15e4c3cb64775914cace80b8e498a','U_U146720855065737398'),('52b07019ea0a4f6cae33935bc8660126','U_U146720855065737398'),('582e94203a794f74b2da4322da751959','U_U146720855065737398'),('5ba1d5249f3a4cd18b413767aad93ea0','U_U146720855065737398'),('651f9aae985f43a8b43105339f4fb7a6','U_U146720855065737398'),('6a5b04c8bae146b298b2593a7180d416','U_U146720855065737398'),('70f4bac727a346e58902c93e4ab44e83','U141770099155103287'),('726feaf2620c4b2393b8059d7f6aab25','U_U146720855065737398'),('76775fd39b72413a9f80e27a72d17b69','U_U146720855065737398'),('7a4cbecd67c7499bac365796139fb3ea','U_U146720855065737398'),('86ba6680dd07425ea85b588c3aabd4cf','U_U146720855065737398'),('8a5f4343eabc45e1a977a95478f6e322','U_U146720855065737398'),('8d4bd6f6deb544dd84e91d2a3bcfdb18','U_U146720855065737398'),('ac8fb9701bb24714a1ade451682b7c95','U_U146720855065737398'),('acff88577e1041249ec6e0cffe45d2ab','U_U146720855065737398'),('ad2103701a274ae69f5138e7834bfae4','U141770099155103287'),('ba0893112eff4daebec44dc3ba63c7fb','U_U146720855065737398'),('bcb43d41fd494b4f885bec47087bfce3','U_U146720855065737398'),('c1cb684489e74e0bb46df8afa11b6fe6','U_U146720855065737398'),('c481f00ccea54bfeb2ecd6d86482e287','U_U146720855065737398'),('c79e9ba22d2347ebb55e0a65b1fd3370','U141770099155103287'),('ce794f8a8d4046a2b87ed592c9097e3e','U_U146720855065737398'),('d97668418c59445cb30cdf3d27e10a04','U_U146720855065737398'),('dae5284a7e6c42df93a3805211e6091a','U_U146720855065737398'),('de83ae0d27024c23a44bb4e845392ca8','U141770099155103287'),('dfc29324a1ae48ebba0b844b633f3973','U_U146720855065737398'),('e0a01189438a4ef18d9473b3954f688d','U141770099155103287'),('e0aa7db0da25487e9eb5d144e3ebc321','U141770099155103287'),('e80f1fe377c14d80b71f119c628b9af7','U_U146720855065737398'),('eb65f8d6a5bd4b2b97e7dc9dcbcac5ed','U_U146720855065737398'),('ed2bc8875a0c4d7eb3db7714d17fcd1e','U_U146720855065737398'),('edf8223a74a843e1a3d184d735b908e0','U141770099155103287'),('f4bfee62192147758445ef0a68ec507f','U_U146720855065737398'),('fa4113b87ccc4c2b931f0ef82d2e0528','U141770099155103287');

/*Table structure for table `t_wf_order` */

DROP TABLE IF EXISTS `t_wf_order`;

CREATE TABLE `t_wf_order` (
  `id` varchar(32) NOT NULL,
  `version` int(11) NOT NULL,
  `process_Id` varchar(32) DEFAULT NULL,
  `creator` varchar(50) DEFAULT NULL,
  `create_Time` varchar(50) DEFAULT NULL,
  `expire_Time` varchar(50) DEFAULT NULL,
  `last_Update_Time` varchar(50) DEFAULT NULL,
  `last_Updator` varchar(50) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `parent_Id` varchar(32) DEFAULT NULL,
  `parent_Node_Name` varchar(50) DEFAULT NULL,
  `order_No` varchar(50) DEFAULT NULL,
  `variable` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_wf_order` */

insert  into `t_wf_order`(`id`,`version`,`process_Id`,`creator`,`create_Time`,`expire_Time`,`last_Update_Time`,`last_Updator`,`priority`,`parent_Id`,`parent_Node_Name`,`order_No`,`variable`) values ('7bbfd222c5c84acda95bc91e4d3539b8',2,'9ba0baa1819c4fb5878566f4dc2fddbf','U_U146720855065737398','2017-05-05 17:39:46',NULL,'2017-05-05 18:21:17','U_U146720855065737398',NULL,NULL,NULL,'20170505-17:39:46-403-785','{\"U143934487932938828\":5,\"create_user\":\"U_U146720855065737398\",\"handleSuggest\":\"cs\"}'),('829e9c9d24b9424aa19de392d55da669',16,'9ba0baa1819c4fb5878566f4dc2fddbf','U141770099155103287','2017-05-05 14:06:17',NULL,'2017-05-05 17:33:06','U_U146720855065737398',NULL,NULL,NULL,'20170505-14:06:17-081-631','{\"U143934487932938828\":3,\"create_user\":\"U141770099155103287\",\"handleSuggest\":\"测试\"}'),('8a26bb0109d7479fba4370922c584802',0,'9ba0baa1819c4fb5878566f4dc2fddbf','U141770099155103287','2017-05-12 22:13:32',NULL,'2017-05-12 22:13:32','U141770099155103287',NULL,NULL,NULL,'20170512-22:13:32-918-319','{\"U143934487932938828\":5,\"create_user\":\"U141770099155103287\"}'),('94dcce6defca4644b431970ad7c0974d',0,'20c04875b55949cbaa932354fdbeb8c6','U141770099155103287','2017-05-22 13:05:38',NULL,'2017-05-22 13:05:38','U141770099155103287',NULL,NULL,NULL,'20170522-13:05:38-377-320','{\"create_user\":\"U141770099155103287\"}'),('a4f8a84aacaf434dbb0b8c813a65bc84',0,'9ba0baa1819c4fb5878566f4dc2fddbf','U141770099155103287','2017-11-13 00:02:46',NULL,'2017-11-13 00:02:46','U141770099155103287',NULL,NULL,NULL,'20171113-00:02:46-578-491','{\"U143934487932938828\":2,\"create_user\":\"U141770099155103287\"}'),('a522d77fd069401aa064e792b1097875',0,'20c04875b55949cbaa932354fdbeb8c6','U141770099155103287','2017-05-22 13:15:03',NULL,'2017-05-22 13:15:03','U141770099155103287',NULL,NULL,NULL,'20170522-13:15:03-691-999','{\"U143934487932938828\":8,\"create_user\":\"U141770099155103287\"}'),('a6b096b78b864fb88ff20770ec32e9a3',3,'9ba0baa1819c4fb5878566f4dc2fddbf','U141770099155103287','2017-05-05 16:55:10',NULL,'2017-05-05 17:31:14','snaker.admin',NULL,NULL,NULL,'20170505-16:55:10-717-500','{\"U143934487932938828\":5,\"create_user\":\"U141770099155103287\",\"handleSuggest\":\"测试\"}'),('a714c685e4fd4d489d76ee922800b28f',0,'20c04875b55949cbaa932354fdbeb8c6','U141770099155103287','2017-05-22 13:04:01',NULL,'2017-05-22 13:04:01','U141770099155103287',NULL,NULL,NULL,'20170522-13:04:01-063-737','{\"U143934487932938828\":2,\"create_user\":\"U141770099155103287\"}'),('bae429c1e7d64f639fd0a8e158019b1c',0,'20c04875b55949cbaa932354fdbeb8c6','U141770099155103287','2017-05-22 13:10:07',NULL,'2017-05-22 13:10:07','U141770099155103287',NULL,NULL,NULL,'20170522-13:10:07-279-398','{\"create_user\":\"U141770099155103287\"}'),('bca7a28436fc47499f97f5d3fb7bafa0',0,'20c04875b55949cbaa932354fdbeb8c6','U141770099155103287','2017-05-22 13:02:25',NULL,'2017-05-22 13:02:25','U141770099155103287',NULL,NULL,NULL,'20170522-13:02:25-528-608','{\"U143934487932938828\":5,\"create_user\":\"U141770099155103287\"}'),('bed1de64e70649f58d1d5744728927a3',0,'9ba0baa1819c4fb5878566f4dc2fddbf','U141770099155103287','2017-05-17 23:45:37',NULL,'2017-05-17 23:45:37','U141770099155103287',NULL,NULL,NULL,'20170517-23:45:37-722-637','{\"U143934487932938828\":1,\"create_user\":\"U141770099155103287\"}'),('bf70da33036c49508ee7a858b988367d',0,'9ba0baa1819c4fb5878566f4dc2fddbf','U_U146720855065737398','2017-05-05 17:38:43',NULL,'2017-05-05 17:38:43','U_U146720855065737398',NULL,NULL,NULL,'20170505-17:38:43-939-314','{\"U143934487932938828\":5,\"create_user\":\"U_U146720855065737398\"}'),('d277cb8dd44e4ab7821f9f7aaf147ef7',0,'9ba0baa1819c4fb5878566f4dc2fddbf','U141770099155103287','2017-05-12 22:14:43',NULL,'2017-05-12 22:14:43','U141770099155103287',NULL,NULL,NULL,'20170512-22:14:43-042-761','{\"U143934487932938828\":3,\"create_user\":\"U141770099155103287\"}'),('d71aa87f35224bb8a0cc429e77439abc',0,'20c04875b55949cbaa932354fdbeb8c6','U141770099155103287','2017-05-22 13:06:25',NULL,'2017-05-22 13:06:25','U141770099155103287',NULL,NULL,NULL,'20170522-13:06:25-017-319','{\"create_user\":\"U141770099155103287\"}'),('e5d2d077685e448c897f1e72a4aac31c',6,'9ba0baa1819c4fb5878566f4dc2fddbf','U141770099155103287','2017-05-08 09:49:55',NULL,'2017-05-08 09:56:05','U141770099155103287',NULL,NULL,NULL,'20170508-09:49:55-668-831','{\"U143934487932938828\":3,\"create_user\":\"U141770099155103287\",\"handleSuggest\":\"测试空行\"}'),('efeefd054e964b739f9b18518ae591b5',1,'9ba0baa1819c4fb5878566f4dc2fddbf','U141770099155103287','2017-12-04 22:15:30',NULL,'2017-12-04 22:15:31','U141770099155103287',NULL,NULL,NULL,'20171204-22:15:30-937-357','{\"U143934487932938828\":5,\"create_user\":\"U141770099155103287\"}');

/*Table structure for table `t_wf_process` */

DROP TABLE IF EXISTS `t_wf_process`;

CREATE TABLE `t_wf_process` (
  `id` varchar(32) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `display_name` varchar(200) DEFAULT NULL,
  `instance_Url` varchar(200) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `content` longblob,
  `version` int(11) DEFAULT NULL,
  `create_Time` varchar(50) DEFAULT NULL,
  `creator` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_wf_process` */

insert  into `t_wf_process`(`id`,`name`,`display_name`,`instance_Url`,`type`,`state`,`content`,`version`,`create_Time`,`creator`) values ('1ec1851928ed4826836d240e05780c69','test_1','测试流程2','',NULL,1,'<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>\n<process name=\"test_1\" displayName=\"测试流程2\" orgId=\"ORG_U146773102513694776\" flowType=\"normal_flow\" formId=\"U2290532509406697968\" attachment=\"1\" expireTime=\"0\" >\n<start layout=\"-1,122,50,50\" name=\"start\" displayName=\"开始\" >\n<transition offset=\"0,-10\" to=\"rect2\" name=\"path4\" displayName=\"TO 任务1\" sortNum=\"0\" />\n</start>\n<task layout=\"131,124,100,50\" name=\"rect2\" displayName=\"任务1\" form=\"process/form\" assignee=\"create_user\" assigneeDisplay=\" 起草人\" taskType=\"Major\" performType=\"ANY\" isExeAssigner=\"1\" selectAssignerStyle=\"radio\" isDepartFilter=\"0\" isConcurrent=\"1\" isTakeTask=\"0\" isSug=\"0\" taskAttachment=\"0\" isPrint=\"0\" formPropIds=\"U147230956895893116,U143934487932911617,U147230956895933555,U147245406891052771,U143934487932938828,U147230479479356878,U143934487932908016,U147451002482226487\" expireTime=\"0\" reminderTime=\"0\" autoExecute=\"0\" >\n<transition offset=\"0,-10\" to=\"rect3\" name=\"path5\" displayName=\"TO 任务2\" sortNum=\"0\" />\n<transition offset=\"0,-10\" to=\"rect8\" name=\"path9\" displayName=\"TO 任务3\" sortNum=\"0\" />\n</task>\n<task layout=\"289,81,100,50\" name=\"rect3\" displayName=\"任务2\" form=\"process/form\" assignee=\"u_U_U146720855065737398,u_U_U146772964519572515\" assigneeDisplay=\" 测试用户1, 测试用户2\" taskType=\"Major\" performType=\"ANY\" isExeAssigner=\"1\" selectAssignerStyle=\"checkbox\" isDepartFilter=\"0\" isConcurrent=\"0\" isTakeTask=\"0\" isSug=\"1\" taskAttachment=\"0\" isPrint=\"0\" expireTime=\"0\" reminderTime=\"0\" autoExecute=\"0\" >\n<transition offset=\"0,-10\" to=\"end\" name=\"path7\" displayName=\"TO 结束\" sortNum=\"0\" />\n</task>\n<end layout=\"462,121,50,50\" name=\"end\" displayName=\"结束\" >\n</end>\n<task layout=\"288,200,100,50\" name=\"rect8\" displayName=\"任务3\" form=\"process/form\" assignee=\"u_U_U146773134816729897,u_U_U146773111652418878\" assigneeDisplay=\" 玉溪用户, 昆明市用户\" taskType=\"Major\" performType=\"ANY\" isExeAssigner=\"1\" selectAssignerStyle=\"radio\" isDepartFilter=\"0\" isConcurrent=\"0\" isTakeTask=\"0\" isSug=\"0\" taskAttachment=\"0\" isPrint=\"0\" expireTime=\"0\" reminderTime=\"0\" autoExecute=\"0\" >\n<transition offset=\"0,-10\" to=\"end\" name=\"path10\" displayName=\"TO 结束\" sortNum=\"0\" />\n</task>\n</process>',0,'2016-10-15 18:03:18','U141770099155103287'),('20c04875b55949cbaa932354fdbeb8c6','leave_ judge_test','请假条件判断','',NULL,1,'<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>\n<process name=\"leave_ judge_test\" displayName=\"请假条件判断\" orgId=\"ORG_U143919519043844770\" orgDisplay=\"测试组织机构2\" flowType=\"normal_flow\" formId=\"U143934508368932354\" attachment=\"1\" expireTime=\"0\" >\n<start layout=\"-6,170,50,50\" name=\"start\" displayName=\"开始\" >\n<transition offset=\"0,-10\" to=\"rect2\" name=\"path7\" displayName=\"TO 申请\" isCheckForm=\"1\" sortNum=\"0\" />\n</start>\n<task layout=\"113,171,100,50\" name=\"rect2\" displayName=\"申请\" form=\"process/form\" assignee=\"create_user\" assigneeDisplay=\" 起草人\" taskType=\"Major\" performType=\"ANY\" isExeAssigner=\"0\" selectAssignerStyle=\"radio\" isDepartFilter=\"0\" isConcurrent=\"0\" isTakeTask=\"0\" isSug=\"0\" taskAttachment=\"0\" isPrint=\"0\" formPropIds=\"U143934487932911617,U143934487932908016,U148047582268795530,U148047582268788204,U147230956895893116,U147230479479356878,U147230956895933555,U143934487932938828,U148047582268647936,U147245406891052771,U147451002482226487\" expireTime=\"0\" reminderTime=\"0\" autoExecute=\"0\" >\n<transition offset=\"0,-10\" to=\"rect5\" name=\"path8\" displayName=\"TO 判断\" isCheckForm=\"1\" sortNum=\"0\" />\n</task>\n<task layout=\"444,134,100,50\" name=\"rect3\" displayName=\"审核1\" form=\"process/form\" assignee=\"u_U_U146720855065737398\" assigneeDisplay=\" 测试用户1\" taskType=\"Major\" performType=\"ANY\" isExeAssigner=\"0\" selectAssignerStyle=\"radio\" isDepartFilter=\"0\" isConcurrent=\"0\" isTakeTask=\"0\" isSug=\"0\" taskAttachment=\"0\" isPrint=\"0\" expireTime=\"0\" reminderTime=\"0\" autoExecute=\"0\" >\n<transition offset=\"0,-10\" to=\"end\" name=\"path10\" displayName=\"TO 结束\" isCheckForm=\"1\" sortNum=\"0\" />\n</task>\n<task layout=\"445,242,100,50\" name=\"rect4\" displayName=\"审核2\" form=\"process/form\" assignee=\"u_U_U146772964519572515\" assigneeDisplay=\" 测试用户2\" taskType=\"Major\" performType=\"ANY\" isExeAssigner=\"0\" selectAssignerStyle=\"radio\" isDepartFilter=\"0\" isConcurrent=\"0\" isTakeTask=\"0\" isSug=\"0\" taskAttachment=\"0\" isPrint=\"0\" expireTime=\"0\" reminderTime=\"0\" autoExecute=\"0\" >\n<transition offset=\"0,-10\" to=\"end\" name=\"path12\" displayName=\"TO 结束\" isCheckForm=\"1\" sortNum=\"0\" />\n</task>\n<decision layout=\"275,173,100,50\" name=\"rect5\" displayName=\"判断\" expr=\"#U143934487932938828&gt;3?\'TO1\':\'TO2\'\" >\n<transition offset=\"0,-10\" to=\"rect3\" name=\"path9\" displayName=\"TO1\" type=\"normal\" isCheckForm=\"1\" sortNum=\"0\" />\n<transition offset=\"0,-10\" to=\"rect4\" name=\"path11\" displayName=\"TO2\" type=\"normal\" isCheckForm=\"1\" sortNum=\"0\" />\n</decision>\n<end layout=\"643,171,50,50\" name=\"end\" displayName=\"结束\" >\n</end>\n</process>',0,'2017-05-22 13:00:53','U141770099155103287'),('6c7530c601cf49ef806ecab9aa4fc3eb','test_1_2','测试流程21','',NULL,1,'<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>\n<process name=\"test_1_2\" displayName=\"测试流程21\" orgId=\"ORG_U146773102513694776\" orgDisplay=\"云南省公司\" flowType=\"normal_flow\" formId=\"U2290532509406697968\" attachment=\"1\" expireTime=\"0\" >\n<start layout=\"1,146,50,50\" name=\"start\" displayName=\"开始\" >\n<transition offset=\"0,-10\" to=\"rect2\" name=\"path5\" displayName=\"TO 任务1\" sortNum=\"0\" />\n</start>\n<task layout=\"122,145,100,50\" name=\"rect2\" displayName=\"任务1\" form=\"process/form\" assignee=\"create_user\" assigneeDisplay=\" 起草人\" taskType=\"Major\" performType=\"ANY\" isExeAssigner=\"0\" selectAssignerStyle=\"radio\" isDepartFilter=\"0\" isConcurrent=\"0\" isTakeTask=\"0\" isSug=\"0\" taskAttachment=\"0\" isPrint=\"0\" expireTime=\"0\" reminderTime=\"0\" autoExecute=\"0\" >\n<transition offset=\"0,-10\" to=\"rect3\" name=\"path6\" displayName=\"TO 任务2\" sortNum=\"0\" />\n</task>\n<task layout=\"290,143,100,50\" name=\"rect3\" displayName=\"任务2\" form=\"process/form\" assignee=\"u_U_U146720855065737398,u_U_U146772964519572515\" assigneeDisplay=\" 测试用户1, 测试用户2\" taskType=\"Major\" performType=\"ANY\" isExeAssigner=\"1\" selectAssignerStyle=\"radio\" isDepartFilter=\"0\" isConcurrent=\"0\" isTakeTask=\"0\" isSug=\"1\" taskAttachment=\"0\" isPrint=\"0\" expireTime=\"0\" reminderTime=\"0\" autoExecute=\"0\" >\n<transition offset=\"0,-10\" to=\"end\" name=\"path7\" displayName=\"TO 结束\" sortNum=\"0\" />\n</task>\n<end layout=\"484,143,50,50\" name=\"end\" displayName=\"结束\" >\n</end>\n</process>',0,'2016-10-15 21:05:58','U141770099155103287'),('9ba0baa1819c4fb5878566f4dc2fddbf','test_01','测试流程1','',NULL,1,'<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>\n<process name=\"test_01\" displayName=\"测试流程1\" orgId=\"ORG_U143919516611919370\" orgDisplay=\"测试组织机构1\" flowType=\"normal_flow\" formId=\"U143934508368932354\" attachment=\"1\" expireTime=\"0\" >\n<start layout=\"9,265,50,50\" name=\"start\" displayName=\"开始\" >\n<transition offset=\"0,-10\" to=\"rect2\" name=\"path6\" displayName=\"TO 申请\" isCheckForm=\"1\" sortNum=\"0\" />\n</start>\n<task layout=\"-15,163,100,50\" name=\"rect2\" displayName=\"申请\" form=\"process/form\" assignee=\"create_user\" assigneeDisplay=\" 起草人\" taskType=\"Major\" performType=\"ANY\" isExeAssigner=\"0\" selectAssignerStyle=\"radio\" isDepartFilter=\"0\" isConcurrent=\"0\" isTakeTask=\"0\" isSug=\"0\" taskAttachment=\"1\" isPrint=\"1\" formPropIds=\"U143934487932911617,U147230956895893116,U143934487932938828,U147230956895933555,U147230479479356878,U148047582268647936,U143934487932908016,U147245406891052771,U148047582268795530,U148047582268788204,U147451002482226487\" expireTime=\"0\" reminderTime=\"0\" autoExecute=\"0\" reminderRepeat=\"0\" >\n<transition offset=\"0,-10\" to=\"rect3\" name=\"path7\" displayName=\"审核\" type=\"normal\" isCheckForm=\"1\" sortNum=\"0\" />\n<transition offset=\"0,-10\" to=\"rect13\" name=\"path14\" displayName=\"审核11\" type=\"normal\" isCheckForm=\"1\" sortNum=\"2\" />\n</task>\n<task layout=\"147,165,100,50\" name=\"rect3\" displayName=\"审核\" form=\"process/form\" assignee=\"u_U_U146720855065737398\" assigneeDisplay=\" 测试用户1\" taskType=\"Major\" performType=\"ANY\" isExeAssigner=\"1\" selectAssignerStyle=\"radio\" isDepartFilter=\"0\" isConcurrent=\"0\" isTakeTask=\"0\" isSug=\"1\" taskAttachment=\"1\" isPrint=\"1\" formPropIds=\"U148047582268647936,U148047582268788204,U148047582268795530\" expireTime=\"0.01\" reminderTime=\"0\" autoExecute=\"1\" reminderRepeat=\"0\" >\n<transition offset=\"0,-10\" to=\"rect4\" name=\"path8\" displayName=\"审核2\" type=\"normal\" isCheckForm=\"1\" sortNum=\"1\" />\n<transition offset=\"0,-10\" to=\"end\" name=\"path10\" displayName=\"结束\" type=\"normal\" isCheckForm=\"1\" sortNum=\"2\" />\n<transition offset=\"0,-10\" to=\"rect2\"  g=\"141,116;36,116\" name=\"path12\" displayName=\"驳回\" type=\"back\" isCheckForm=\"1\" sortNum=\"2\" />\n</task>\n<task layout=\"333,162,100,50\" name=\"rect4\" displayName=\"审核2\" form=\"process/form\" assignee=\"d_ORG_U143919525899571244\" assigneeDisplay=\" 测试部门1\" taskType=\"Major\" performType=\"ANY\" isExeAssigner=\"1\" selectAssignerStyle=\"radio\" isDepartFilter=\"0\" isConcurrent=\"0\" isTakeTask=\"0\" isSug=\"1\" taskAttachment=\"1\" isPrint=\"1\" expireTime=\"0.01\" reminderTime=\"0\" autoExecute=\"1\" reminderRepeat=\"0\" >\n<transition offset=\"0,-10\" to=\"end\" name=\"path9\" displayName=\"结束\" type=\"normal\" isCheckForm=\"1\" sortNum=\"2\" />\n<transition offset=\"0,-10\" to=\"rect3\"  g=\"383,116;196,116\" name=\"path11\" displayName=\"审核\" type=\"back\" isCheckForm=\"1\" sortNum=\"1\" />\n</task>\n<end layout=\"339,280,50,50\" name=\"end\" displayName=\"结束\" >\n</end>\n<task layout=\"139,243,100,50\" name=\"rect13\" displayName=\"审核11\" form=\"process/form\" assignee=\"u_U_U146773111652418878\" assigneeDisplay=\" 昆明市用户\" taskType=\"Major\" performType=\"ANY\" isExeAssigner=\"0\" selectAssignerStyle=\"radio\" isDepartFilter=\"0\" isConcurrent=\"0\" isTakeTask=\"0\" isSug=\"0\" taskAttachment=\"0\" isPrint=\"0\" expireTime=\"0\" reminderTime=\"0\" autoExecute=\"0\" >\n<transition offset=\"0,-10\" to=\"end\" name=\"path15\" displayName=\"结束\" type=\"normal\" isCheckForm=\"1\" sortNum=\"0\" />\n</task>\n</process>',1,'2016-10-15 15:01:06','U141770099155103287'),('a3306b8c51364f9bbb123cf55c053444','test_1_2','测试流程21','',NULL,1,'<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>\n<process name=\"test_1_2\" displayName=\"测试流程21\" orgId=\"ORG_U146773102513694776\" flowType=\"normal_flow\" formId=\"U2290532509406697968\" attachment=\"1\" expireTime=\"0\" >\n<start layout=\"1,146,50,50\" name=\"start\" displayName=\"开始\" >\n<transition offset=\"0,-10\" to=\"rect2\" name=\"path5\" displayName=\"TO 任务1\" sortNum=\"0\" />\n</start>\n<task layout=\"122,145,100,50\" name=\"rect2\" displayName=\"任务1\" form=\"process/form\" assignee=\"create_user\" assigneeDisplay=\" 起草人\" taskType=\"Major\" performType=\"ANY\" isExeAssigner=\"0\" selectAssignerStyle=\"radio\" isDepartFilter=\"0\" isConcurrent=\"0\" isTakeTask=\"0\" isSug=\"0\" taskAttachment=\"0\" isPrint=\"1\" formPropIds=\"U147230479479356878,U147230956895893116,U147451002482226487,U143934487932908016,U143934487932911617\" expireTime=\"0\" reminderTime=\"0\" autoExecute=\"0\" >\n<transition offset=\"0,-10\" to=\"rect3\" name=\"path6\" displayName=\"TO 任务2\" sortNum=\"0\" />\n</task>\n<task layout=\"290,143,100,50\" name=\"rect3\" displayName=\"任务2\" form=\"process/form\" assignee=\"u_U_U146772964519572515,u_U_U146773111652418878,u_U_U146773134816729897\" assigneeDisplay=\" 测试用户2, 昆明市用户, 玉溪用户\" taskType=\"Major\" performType=\"ANY\" isExeAssigner=\"0\" selectAssignerStyle=\"radio\" isDepartFilter=\"1\" isConcurrent=\"0\" isTakeTask=\"0\" isSug=\"1\" taskAttachment=\"0\" isPrint=\"0\" expireTime=\"0\" reminderTime=\"0\" autoExecute=\"0\" >\n<transition offset=\"0,-10\" to=\"end\" name=\"path7\" displayName=\"TO 结束\" sortNum=\"0\" />\n<transition offset=\"0,-10\" to=\"rect2\"  g=\"339,110;173,111\" name=\"path8\" displayName=\"驳回\" type=\"back\" sortNum=\"0\" />\n</task>\n<end layout=\"484,143,50,50\" name=\"end\" displayName=\"结束\" >\n</end>\n</process>',1,'2016-10-15 22:43:36','U141770099155103287'),('ccc66871bed64124b3652e6f476c7e7c','test_01','测试流程1','',NULL,1,'<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>\n<process name=\"test_01\" displayName=\"测试流程1\" orgId=\"ORG_U146773102513694776\" orgDisplay=\"云南省公司\" flowType=\"normal_flow\" formId=\"U143934508368932354\" attachment=\"1\" expireTime=\"0\" >\n<start layout=\"-138,164,50,50\" name=\"start\" displayName=\"开始\" >\n<transition offset=\"0,-10\" to=\"rect2\" name=\"path6\" displayName=\"TO 申请\" sortNum=\"0\" />\n</start>\n<task layout=\"-22,166,100,50\" name=\"rect2\" displayName=\"申请\" form=\"process/form\" assignee=\"create_user\" assigneeDisplay=\" 起草人\" taskType=\"Major\" performType=\"ANY\" isConcurrent=\"0\" isExeAssigner=\"0\" selectAssignerStyle=\"radio\" isDepartFilter=\"0\" isTakeTask=\"0\" isSug=\"1\" taskAttachment=\"1\" isPrint=\"1\" formPropIds=\"U143934487932938828,U147230956895893116,U143934487932911617,U147230956895933555,U147451002482226487,U147230479479356878,U147245406891052771,U143934487932908016\" expireTime=\"0\" reminderTime=\"0\" autoExecute=\"0\" reminderRepeat=\"0\" >\n<transition offset=\"0,-10\" to=\"rect3\" name=\"path7\" displayName=\"审核\" type=\"normal\" sortNum=\"0\" />\n</task>\n<task layout=\"147,165,100,50\" name=\"rect3\" displayName=\"审核\" form=\"process/form\" assignee=\"u_U_U146720855065737398\" assigneeDisplay=\" 测试用户1\" taskType=\"Major\" performType=\"ANY\" isConcurrent=\"0\" isExeAssigner=\"1\" selectAssignerStyle=\"radio\" isDepartFilter=\"0\" isTakeTask=\"0\" isSug=\"1\" taskAttachment=\"1\" isPrint=\"1\" expireTime=\"0.01\" reminderTime=\"0\" autoExecute=\"1\" reminderRepeat=\"0\" >\n<transition offset=\"0,-10\" to=\"rect4\" name=\"path8\" displayName=\"审核2\" type=\"normal\" sortNum=\"1\" />\n<transition offset=\"0,-10\" to=\"end\" name=\"path10\" displayName=\"结束\" type=\"normal\" sortNum=\"2\" />\n<transition offset=\"0,-10\" to=\"rect2\"  g=\"141,116;36,116\" name=\"path12\" displayName=\"驳回\" type=\"back\" sortNum=\"2\" />\n</task>\n<task layout=\"333,162,100,50\" name=\"rect4\" displayName=\"审核2\" form=\"process/form\" assignee=\"d_ORG_U143919525899571244\" assigneeDisplay=\" 测试部门1\" taskType=\"Major\" performType=\"ANY\" isConcurrent=\"0\" isExeAssigner=\"1\" selectAssignerStyle=\"radio\" isDepartFilter=\"0\" isTakeTask=\"0\" isSug=\"1\" taskAttachment=\"1\" isPrint=\"1\" expireTime=\"0.01\" reminderTime=\"0\" autoExecute=\"1\" reminderRepeat=\"0\" >\n<transition offset=\"0,-10\" to=\"end\" name=\"path9\" displayName=\"结束\" type=\"normal\" sortNum=\"2\" />\n<transition offset=\"0,-10\" to=\"rect3\"  g=\"383,116;196,116\" name=\"path11\" displayName=\"审核\" type=\"back\" sortNum=\"1\" />\n</task>\n<end layout=\"264,306,50,50\" name=\"end\" displayName=\"结束\" >\n</end>\n</process>',0,'2016-07-05 22:26:28','U141770099155103287');

/*Table structure for table `t_wf_surrogate` */

DROP TABLE IF EXISTS `t_wf_surrogate`;

CREATE TABLE `t_wf_surrogate` (
  `id` varchar(32) NOT NULL,
  `process_Name` varchar(100) DEFAULT NULL,
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
  `ORDER_ID` varchar(32) DEFAULT NULL,
  `TASK_NAME` varchar(100) DEFAULT NULL,
  `DISPLAY_NAME` varchar(200) DEFAULT NULL,
  `OPERATOR` varchar(50) DEFAULT NULL,
  `CREATE_TIME` varchar(50) DEFAULT NULL,
  `FINISH_TIME` varchar(50) DEFAULT NULL,
  `TAKE_TIME` varchar(50) DEFAULT NULL,
  `EXPIRE_TIME` varchar(50) DEFAULT NULL,
  `ACTION_URL` varchar(200) DEFAULT NULL,
  `TASK_TYPE` int(11) DEFAULT NULL,
  `PERFORM_TYPE` int(11) DEFAULT NULL,
  `PARENT_TASK_ID` varchar(32) DEFAULT NULL,
  `VARIABLE` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_wf_task` */

insert  into `t_wf_task`(`id`,`version`,`ORDER_ID`,`TASK_NAME`,`DISPLAY_NAME`,`OPERATOR`,`CREATE_TIME`,`FINISH_TIME`,`TAKE_TIME`,`EXPIRE_TIME`,`ACTION_URL`,`TASK_TYPE`,`PERFORM_TYPE`,`PARENT_TASK_ID`,`VARIABLE`) values ('22a1997022ea4297aebed423ca8b9955',0,'bed1de64e70649f58d1d5744728927a3','rect3','审核',NULL,'2017-05-17 23:45:37',NULL,NULL,'2017-05-17 23:46:13','process/form',0,0,'c79e9ba22d2347ebb55e0a65b1fd3370','{\"U143934487932938828\":1,\"S-ACTOR\":\"U_U146720855065737398\",\"create_user\":\"U141770099155103287\"}'),('30e888829f2b4ae3ae5a45db517372e4',0,'a714c685e4fd4d489d76ee922800b28f','rect4','审核2',NULL,'2017-05-22 13:04:01',NULL,NULL,NULL,'process/form',0,0,'09a8bfe3cbd74eefaface6b493090231','{\"U143934487932938828\":2,\"S-ACTOR\":\"U_U146772964519572515\",\"create_user\":\"U141770099155103287\"}'),('33b22c8abba749f085365eebc10469b1',0,'829e9c9d24b9424aa19de392d55da669','rect2','申请',NULL,'2017-05-05 17:33:06',NULL,NULL,NULL,'process/form',0,0,'4cf15e4c3cb64775914cace80b8e498a','{\"handleSuggest\":\"测试\",\"U143934487932938828\":3,\"S-ACTOR\":\"U141770099155103287\",\"create_user\":\"U141770099155103287\"}'),('5192edba4cdc4f428a2ee0aa1dbcb6e3',0,'e5d2d077685e448c897f1e72a4aac31c','rect3','审核',NULL,'2017-05-08 09:56:05',NULL,NULL,'2017-05-08 09:56:41','process/form',0,0,'fa4113b87ccc4c2b931f0ef82d2e0528','{\"handleSuggest\":\"测试空行\",\"U143934487932938828\":3,\"S-ACTOR\":\"U_U146720855065737398\",\"create_user\":\"U141770099155103287\"}'),('611a63fd19d5495dabdee3d0c957093f',0,'a522d77fd069401aa064e792b1097875','rect3','审核1',NULL,'2017-05-22 13:15:03',NULL,NULL,NULL,'process/form',0,0,'13b90aa0ea514b699634b07e9f633501','{\"U143934487932938828\":8,\"S-ACTOR\":\"U_U146720855065737398\",\"create_user\":\"U141770099155103287\"}'),('65a5d27059844533852ac936c2169d18',0,'d71aa87f35224bb8a0cc429e77439abc','rect4','审核2',NULL,'2017-05-22 13:06:25',NULL,NULL,NULL,'process/form',0,0,'70f4bac727a346e58902c93e4ab44e83','{\"S-ACTOR\":\"U_U146772964519572515\",\"create_user\":\"U141770099155103287\"}'),('668cc7eaca414099818a5bedde595972',0,'bca7a28436fc47499f97f5d3fb7bafa0','rect3','审核1',NULL,'2017-05-22 13:02:25',NULL,NULL,NULL,'process/form',0,0,'3ae1e482db9a4cb3bc8ac985368455e3','{\"U143934487932938828\":5,\"S-ACTOR\":\"U_U146720855065737398\",\"create_user\":\"U141770099155103287\"}'),('6b85a68fcff949158d680858b40df6cf',0,'bae429c1e7d64f639fd0a8e158019b1c','rect4','审核2',NULL,'2017-05-22 13:10:07',NULL,NULL,NULL,'process/form',0,0,'edf8223a74a843e1a3d184d735b908e0','{\"S-ACTOR\":\"U_U146772964519572515\",\"create_user\":\"U141770099155103287\"}'),('6bf5769ad91347a4bdb03de2224b8af9',0,'7bbfd222c5c84acda95bc91e4d3539b8','rect2','申请',NULL,'2017-05-05 18:21:17',NULL,NULL,NULL,'process/form',0,0,'dfc29324a1ae48ebba0b844b633f3973','{\"handleSuggest\":\"cs\",\"U143934487932938828\":5,\"S-ACTOR\":\"U_U146720855065737398\",\"create_user\":\"U_U146720855065737398\"}'),('8287ecec359d4b93950a6ad21334376e',0,'94dcce6defca4644b431970ad7c0974d','rect4','审核2',NULL,'2017-05-22 13:05:38',NULL,NULL,NULL,'process/form',0,0,'18c69822c89a4d18b3a9a3c7445078ba','{\"S-ACTOR\":\"U_U146772964519572515\",\"create_user\":\"U141770099155103287\"}'),('8fc9f8bc8c8d4fd9863e55817f4d2236',0,'bf70da33036c49508ee7a858b988367d','rect3','审核',NULL,'2017-05-05 17:38:43',NULL,NULL,'2017-05-05 17:39:19','process/form',0,0,'e80f1fe377c14d80b71f119c628b9af7','{\"U143934487932938828\":5,\"S-ACTOR\":\"U_U146720855065737398\",\"create_user\":\"U_U146720855065737398\"}'),('9238d62c91074e9895f4ef7e0f5aa3f8',0,'8a26bb0109d7479fba4370922c584802','rect3','审核',NULL,'2017-05-12 22:13:32',NULL,NULL,'2017-05-12 22:14:08','process/form',0,0,'039501c925234e1783653d753c93090f','{\"U143934487932938828\":5,\"S-ACTOR\":\"U_U146720855065737398\",\"create_user\":\"U141770099155103287\"}'),('b060579880fe47cbbc0af20fa5a9af3e',0,'d277cb8dd44e4ab7821f9f7aaf147ef7','rect3','审核',NULL,'2017-05-12 22:14:43',NULL,NULL,'2017-05-12 22:15:19','process/form',0,0,'28a4c520c06845c7b945d0181a6aea6c','{\"U143934487932938828\":3,\"S-ACTOR\":\"U_U146720855065737398\",\"create_user\":\"U141770099155103287\"}'),('d7102ca6a48f41e6a59ab77f4992c892',0,'a6b096b78b864fb88ff20770ec32e9a3','rect3','审核',NULL,'2017-05-05 17:31:14',NULL,NULL,'2017-05-05 17:31:50','process/form',0,0,'e0aa7db0da25487e9eb5d144e3ebc321','{\"handleSuggest\":\"测试\",\"isBack\":\"0\",\"U143934487932938828\":5,\"S-ACTOR\":\"U_U146720855065737398\",\"create_user\":\"U141770099155103287\",\"nextLineName\":\"jump_rect3\",\"operator\":\"U141770099155103287\"}'),('e2857e463cc14223b614b396cf70e6bc',0,'a4f8a84aacaf434dbb0b8c813a65bc84','rect3','审核',NULL,'2017-11-13 00:02:46',NULL,NULL,'2017-11-13 00:03:22','process/form',0,0,'02575df15ae04514b98b65cde08fdb8b','{\"U143934487932938828\":2,\"S-ACTOR\":\"U_U146720855065737398\",\"create_user\":\"U141770099155103287\"}'),('ec44d4612dff45748beb4e0e01fa92af',0,'efeefd054e964b739f9b18518ae591b5','rect3','审核',NULL,'2017-12-04 22:15:31',NULL,NULL,'2017-12-04 22:16:07','process/form',0,0,'25f0d09b55044c649b2ca3a9b96d7ef5','{\"U143934487932938828\":5,\"S-ACTOR\":\"U_U146720855065737398\",\"create_user\":\"U141770099155103287\"}');

/*Table structure for table `t_wf_task_actor` */

DROP TABLE IF EXISTS `t_wf_task_actor`;

CREATE TABLE `t_wf_task_actor` (
  `TASK_ID` varchar(32) NOT NULL,
  `ACTOR_ID` varchar(50) NOT NULL,
  PRIMARY KEY (`TASK_ID`,`ACTOR_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_wf_task_actor` */

insert  into `t_wf_task_actor`(`TASK_ID`,`ACTOR_ID`) values ('22a1997022ea4297aebed423ca8b9955','U_U146720855065737398'),('30e888829f2b4ae3ae5a45db517372e4','U_U146772964519572515'),('33b22c8abba749f085365eebc10469b1','U141770099155103287'),('5192edba4cdc4f428a2ee0aa1dbcb6e3','U_U146720855065737398'),('611a63fd19d5495dabdee3d0c957093f','U_U146720855065737398'),('65a5d27059844533852ac936c2169d18','U_U146772964519572515'),('668cc7eaca414099818a5bedde595972','U_U146720855065737398'),('6b85a68fcff949158d680858b40df6cf','U_U146772964519572515'),('6bf5769ad91347a4bdb03de2224b8af9','U_U146720855065737398'),('8287ecec359d4b93950a6ad21334376e','U_U146772964519572515'),('8fc9f8bc8c8d4fd9863e55817f4d2236','U_U146720855065737398'),('9238d62c91074e9895f4ef7e0f5aa3f8','U_U146720855065737398'),('b060579880fe47cbbc0af20fa5a9af3e','U_U146720855065737398'),('d7102ca6a48f41e6a59ab77f4992c892','U_U146720855065737398'),('e2857e463cc14223b614b396cf70e6bc','U_U146720855065737398'),('ec44d4612dff45748beb4e0e01fa92af','U_U146720855065737398');

/*Table structure for table `t_wf_workitem` */

DROP TABLE IF EXISTS `t_wf_workitem`;

CREATE TABLE `t_wf_workitem` (
  `task_Id` varchar(255) NOT NULL,
  `process_Id` varchar(255) DEFAULT NULL,
  `order_Id` varchar(255) DEFAULT NULL,
  `order_No` varchar(255) DEFAULT NULL,
  `process_Name` varchar(255) DEFAULT NULL,
  `order_Title` varchar(255) DEFAULT NULL,
  `instance_Url` varchar(255) DEFAULT NULL,
  `parent_Id` varchar(255) DEFAULT NULL,
  `creator` varchar(255) DEFAULT NULL,
  `order_Create_Time` varchar(255) DEFAULT NULL,
  `order_Expire_Time` varchar(255) DEFAULT NULL,
  `order_Variable` varchar(255) DEFAULT NULL,
  `task_Name` varchar(255) DEFAULT NULL,
  `task_Key` varchar(255) DEFAULT NULL,
  `operator` varchar(255) DEFAULT NULL,
  `task_Create_Time` varchar(255) DEFAULT NULL,
  `task_Take_Time` varchar(255) DEFAULT NULL,
  `task_End_Time` varchar(255) DEFAULT NULL,
  `task_Expire_Time` varchar(255) DEFAULT NULL,
  `action_Url` varchar(255) DEFAULT NULL,
  `task_Type` int(11) DEFAULT NULL,
  `perform_Type` int(11) DEFAULT NULL,
  `task_Variable` varchar(255) DEFAULT NULL,
  `full_Name` varchar(255) DEFAULT NULL,
  `org_Name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`task_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_wf_workitem` */

/*Table structure for table `tg_study_class` */

DROP TABLE IF EXISTS `tg_study_class`;

CREATE TABLE `tg_study_class` (
  `id` varchar(64) NOT NULL,
  `name` varchar(64) DEFAULT NULL,
  `teacher_id` varchar(64) DEFAULT NULL,
  `teacher_name` varchar(64) DEFAULT NULL,
  `status` varchar(16) DEFAULT NULL,
  `level` varchar(16) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tg_study_class` */

insert  into `tg_study_class`(`id`,`name`,`teacher_id`,`teacher_name`,`status`,`level`,`create_time`,`update_time`,`description`) values ('2bac549b819a48e1ac29eda7ba8e8f72','沈家门_朱老师_暑期班','03b1250aaa464fe4adebf2202814bfe2',NULL,'NORMAL',NULL,'2018-06-04 20:32:36','2018-11-14 20:03:39',NULL),('b1fa8264db574c2f94a8bb933366acb8','沈家门_徐老师_入门班','03b1250aaa464fe4adebf2202814bfe2',NULL,'NORMAL',NULL,'2018-06-04 20:31:51','2018-11-13 21:14:41',NULL),('U154227417013576124','朱老师_中级班','cef39c169a4c416b86c3d3a56e30636a','徐闻益','NORMAL','primary','2018-11-15 17:29:30','2018-11-15 17:35:15','人数不限'),('U154227456344251175','朱老师_高级班','03b1250aaa464fe4adebf2202814bfe2','','NORMAL','senior','2018-11-15 17:36:03',NULL,'人数限制20'),('U154227462786554493','身份','03b1250aaa464fe4adebf2202814bfe2','','NORMAL','primary','2018-11-15 17:36:53',NULL,'水电费'),('U154227470424447226','213213','03b1250aaa464fe4adebf2202814bfe2','','NORMAL','medium','2018-11-15 17:38:09',NULL,'3123'),('U154227472848707505','123213','03b1250aaa464fe4adebf2202814bfe2','','NORMAL','primary','2018-11-15 17:38:43',NULL,'12312');

/*Table structure for table `tg_study_classroom` */

DROP TABLE IF EXISTS `tg_study_classroom`;

CREATE TABLE `tg_study_classroom` (
  `id` varchar(255) NOT NULL,
  `study_school_id` varchar(255) DEFAULT NULL,
  `study_school_name` varchar(64) DEFAULT NULL,
  `name` varchar(128) DEFAULT NULL,
  `status` varchar(64) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tg_study_classroom` */

insert  into `tg_study_classroom`(`id`,`study_school_id`,`study_school_name`,`name`,`status`,`description`,`create_time`,`update_time`) values ('U154227000302923426','U154226395138529830','东港-灵秀街','二楼西间','NORMAL','灵秀街围棋协会二楼西侧单间','2018-11-15 16:20:03','2018-11-15 16:43:06'),('U154227011874218810','U154226395138529830','东港-灵秀街','二楼东间','NORMAL','灵秀街围棋协会二楼东侧单间','2018-11-15 16:21:59','2018-11-15 16:43:13'),('U154227150080902367','U154226414245680199','东港-碧海莲缘','房间01号','正常','城市里','2018-11-15 16:45:01',NULL);

/*Table structure for table `tg_study_course` */

DROP TABLE IF EXISTS `tg_study_course`;

CREATE TABLE `tg_study_course` (
  `id` varchar(64) NOT NULL,
  `week_info` smallint(16) DEFAULT NULL,
  `course_time` varchar(32) DEFAULT NULL,
  `study_class_id` varchar(64) DEFAULT NULL,
  `study_class_name` varchar(128) DEFAULT NULL,
  `study_class_room_id` varchar(64) DEFAULT NULL,
  `study_class_room_name` varchar(128) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `status` varchar(16) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tg_study_course` */

insert  into `tg_study_course`(`id`,`week_info`,`course_time`,`study_class_id`,`study_class_name`,`study_class_room_id`,`study_class_room_name`,`create_date`,`status`,`description`,`update_date`) values ('417f92edd745418da6a841410fd8caf8',3,'710fe3c398a6429f900c0dd88c1f68cf','2bac549b819a48e1ac29eda7ba8e8f72',NULL,NULL,NULL,'2018-11-14 20:21:56','NORMAL',NULL,NULL),('6a13132e186a4f6da4e2d28e29845db8',4,'36d983f58a1c4ed3b8f59ee3db99eaa5','2bac549b819a48e1ac29eda7ba8e8f72',NULL,NULL,NULL,'2018-11-14 20:22:05','NORMAL',NULL,NULL),('75c0ea13e09c40f4ace9f91ee3d9ef55',1,'64774241ca394b65ad04d691cdb961c0','b1fa8264db574c2f94a8bb933366acb8',NULL,NULL,NULL,'2018-06-04 20:33:22','NORMAL',NULL,NULL),('7dd188ea48a94e37ab3148cc283af01c',1,'64774241ca394b65ad04d691cdb961c0','b1fa8264db574c2f94a8bb933366acb8',NULL,NULL,NULL,'2018-11-14 20:21:42','NORMAL',NULL,NULL);

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

insert  into `tg_study_school`(`id`,`name`,`address`,`create_time`,`status`) values ('U154226395138529830','东港-灵秀街','灵秀街29号普陀区围棋协会',NULL,'NORMAL'),('U154226414245680199','东港-碧海莲缘','碧海莲缘城市里6幢104室',NULL,'NORMAL');

/*Table structure for table `tg_study_student` */

DROP TABLE IF EXISTS `tg_study_student`;

CREATE TABLE `tg_study_student` (
  `id` varchar(64) NOT NULL,
  `name` varchar(64) DEFAULT NULL,
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tg_study_student` */

insert  into `tg_study_student`(`id`,`name`,`sex`,`birthday`,`school_name`,`level`,`parent_phone`,`parent_name`,`parent_type`,`status`,`total_course`,`remain_course`,`create_time`,`update_time`) values ('U154229171024559268','小白',1,'2010-02-02','东港小学',19,'18861537500','大白(父亲)',1,'NORMAL',22,0,'2018-11-15 22:21:50','2018-11-15 22:24:58');

/*Table structure for table `tg_study_teacher` */

DROP TABLE IF EXISTS `tg_study_teacher`;

CREATE TABLE `tg_study_teacher` (
  `id` varchar(32) NOT NULL,
  `name` varchar(32) DEFAULT NULL,
  `phone` varchar(64) DEFAULT NULL,
  `level` int(11) DEFAULT NULL,
  `status` varchar(16) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tg_study_teacher` */

insert  into `tg_study_teacher`(`id`,`name`,`phone`,`level`,`status`,`create_time`,`update_time`) values ('03b1250aaa464fe4adebf2202814bfe2','朱老师','18861537566',1,'NORMAL','2018-06-04 20:30:51',NULL),('cef39c169a4c416b86c3d3a56e30636a','徐闻益','18861537568',1,'NORMAL','2018-06-04 20:30:51',NULL),('U154226668821601812','老师小白','18861530001',1,'NORMAL','2018-06-04 20:30:51','2018-11-15 15:31:10');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
