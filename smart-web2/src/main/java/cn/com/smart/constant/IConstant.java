package cn.com.smart.constant;

/**
 * 系统常量定义
 * @author XUWENYI
 *
 */
public interface IConstant {
	
	/**
	 * 系统配置文件
	 */
	String SYS_CONFIG_FILE = "/sysconfig.properties";
	
	/**
	 * 开发工具配置文件
	 */
	String DEV_TOOL_CONFIG_FILE = "/devtool-config.properties";
	
	/**
	* 项目状态----开发模式
	*/
	String PROJECT_DEV_MODEL = "1";
	
	/**
	* 项目状态----产品模式
	*/
	String PROJECT_PRODUCT_MODEL = "0";
	
	/**
	 * 角色状态---超级管理员角色
	 */
	String ROLE_SUPER_ADMIN = "super_admin";
	
	
	/////////////操作结果常量定义///////////////////
	/**
	* 操作标识--成功
	*/
	String OP_SUCCESS = "1";
	/**
	* 成功标识返回的默认提示信息
	*/
	String OP_SUCCESS_MSG = "数据操作成功";
	
	/**
	* 操作标识--没有数据
	*/
	String OP_NOT_DATA_SUCCESS = "0";
	/**
	* 没有数据标识返回的默认提示信息
	*/
	String OP_NOT_DATA_SUCCESS_MSG = "没有查询到相关数据";
	
	/**
	* 操作标识--有敏感词汇
	*/
	String OP_SW = "2";
	/**
	* 有敏感词汇标识返回的默认提示信息
	*/
	String OP_SW_MSG = "有敏感词汇";
	
	/**
	* 操作标识--失败
	*/
	String OP_FAIL = "-1";
	/**
	* 有敏感词汇标识返回的默认提示信息
	*/
	String OP_FAIL_MSG = "数据操作失败";
	
	/**
	 * 多值分隔符“,”
	 */
	String MULTI_VALUE_SPLIT = ",";
	
	/**
	 * 多条语句间分隔符“;”
	 */
	String MULTI_STATEMENT_SPLIT = ";";
	
	/**
	 * 组合值分隔符“_”
	 */
	String COMBINE_VALUE_SEPARATOR = "_";

	/**
	 *	对象状态
	 */
	String STATUS_NORMAL = "NORMAL";

	/* ----- 学生状态 -----*/
	// 退学
	String STATUS_DROP_OUT = "DROP_OUT";
	// 休学
	String STATUS_TEMP_LEAVE = "TEMP_LEAVE";
	// 删除
	String STATUS_DELETE = "DELETE";
	// 返校
	String STATUS_BACK_STUDY = "BACK_STUDY";


	// 退班
	String STATUS_EXIT_COURSE = "EXIT_COURSE";

	// 课时结课结束
	String STATUS_COURSE_END = "NORMAL_END";
	// 因退班而取消
	String STATUS_COURSE_CANCEL_AS_EXIT = "CANCEL_AS_EXIT";

	String IS_PROCESS_YES = "YES";
	String IS_PROCESS_NO = "NO";

	String IS_REGISTER_YES = "YES";
	String IS_REGISTER_NO = "NO";

}
