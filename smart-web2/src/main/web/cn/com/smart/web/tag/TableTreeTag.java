package cn.com.smart.web.tag;

import cn.com.smart.web.utils.DataUtil;
import org.apache.commons.lang3.StringUtils;

/**
 * 表格树
 * @author XUWENYI
 *
 */
public class TableTreeTag extends AbstractTableTreeTag {

	private static final long serialVersionUID = -8947261853934909356L;
	
	@Override
	protected String getHtml(Boolean isParent,Object[] objArray, int row, int layer, String defaultValue, int startIndex, int cols, int headerCount) {
		StringBuilder strBuff = new StringBuilder();
		String classOpTree = null;
		if(isExpand==1) {
			classOpTree = "tr-open-tree";
		} else {
			classOpTree = "tr-shrink-tree";
		}
		strBuff.append("<tr id='t-"+ DataUtil.handleNull(objArray[0])+"' class='tr-tree "+classOpTree+" t-tree-layer"+layer+" t-"+DataUtil.handleNull(objArray[1])+"' parentid='t-"+DataUtil.handleNull(objArray[1])+"'>");
		int count = 0;
		String a = getTdContent(objArray, row, defaultValue, count, startIndex);
		String tdOpData =  "";
		String uiIconOpData = "";
		if(isParent) {
			if(isExpand==1) {
				tdOpData = "open-data";
				uiIconOpData = "ui-icon-triangle-1-s";
			} else {
				tdOpData = "shrink-data";
				uiIconOpData = "ui-icon-triangle-1-e";
			}
			tdOpData = "op-tree "+tdOpData;
		} else {
			uiIconOpData = "ui-icon-radio-on";
		}
		strBuff.append("<td class='"+tdOpData+" td-tree "+getTdClass(count)+ "' "+super.getTdWidthStyle(thWidth,count)+"><span class='ui-icon "+uiIconOpData+" left'></span>"+a+"</td>");
		count++;
		for (int i = startIndex; i < objArray.length; i++) {
			if(count > cols) {
				break;
			}
			a = getTdContent(objArray, row, DataUtil.handleNull(objArray[i]), count, i);
			strBuff.append("<td "+(StringUtils.isEmpty(getTdClass(count))?"":"class='"+getTdClass(count)+"'")+" "+super.getTdWidthStyle(thWidth,count)+">"+a+"</td>");
			count++;
		}
		strBuff.append(super.handleLastCustomCell(objArray, row, count, headerCount, tdStyles, thWidth));
		strBuff.append("</tr>");
		return strBuff.toString();
	}


	@Override
	protected String getTableDivTag() {
		return "cnoj-tree-table";
	}
}
