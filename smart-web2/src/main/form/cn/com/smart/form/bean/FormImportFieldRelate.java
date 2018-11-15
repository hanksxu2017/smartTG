package cn.com.smart.form.bean;

/**
 * 导入字段关联
 * @author XUWENYI
 * @version 1.0
 * @since 1.0
 */
public class FormImportFieldRelate extends FormImportFieldVO {

    private String tableFieldName;

    public String getTableFieldName() {
        return tableFieldName;
    }

    public void setTableFieldName(String tableFieldName) {
        this.tableFieldName = tableFieldName;
    }
}
