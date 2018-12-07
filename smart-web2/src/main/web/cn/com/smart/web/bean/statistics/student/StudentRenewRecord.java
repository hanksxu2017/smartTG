package cn.com.smart.web.bean.statistics.student;

import lombok.Getter;
import lombok.Setter;

/**
 * 描述:
 * 学生当月续费统计
 *
 * @outhor xuwenyi
 * @create 2018-12-07 9:26
 */
@Getter
@Setter
public class StudentRenewRecord {

	private String studentId;

	private String month;
	// 结余课时
	private int remainCourse;
	// 应付款项,单位元
	private int amountPayable;
	// 实付金额,单位元
	private int amountPay;
	// 付款日期,多个使用逗号连接
	private String payDate = "";
}
