/**
 * @author XUWENYI
 * 权限配置JS
 */
$(document).ready(function(){
	setTimeout(function(){
		authConfigSubmitBtnListener();
	}, 500);
	
});

/**
 * 
 * @param $elementWrap
 */
function authConfigSubmitBtnListener($elementWrap) {
	if(utils.isEmpty($elementWrap) || !utils.isExist($elementWrap)) {
		$(".cnoj-class-config-submit").click(function(event){
			_clickElement(event, $(this));
		});
	} else {
		$elementWrap.find(".cnoj-class-config-submit").click(function(event){
			_clickElement(event, $(this));
			return false;
		});
	}
	
	/**
	 * 点击元素处理方法
	 * @param event
	 * @param $this
	 */
	function _clickElement(event, $this) {

		var alertMsg = $this.data("alert-msg");
		var refreshUri = $this.data("refresh-uri");
		var refreshTarget = $this.data("refresh-target");
		var configId = $this.data("config-id");
		var submitUri = $this.data("uri");
		var formId = $this.data("form-id");
		if(!utils.isEmpty(alertMsg) && !utils.isEmpty(refreshUri) && 
				!utils.isEmpty(refreshTarget) && !utils.isEmpty(configId) && 
				!utils.isEmpty(submitUri)) {

            var $form = $("#" + formId);
            var param = decodeURIComponent($form.serialize());
            cnoj.submitDialogData(submitUri, param, null, refreshUri, refreshTarget, false);

		}
	}
}
