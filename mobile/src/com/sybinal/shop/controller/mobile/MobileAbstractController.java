package com.sybinal.shop.controller.mobile;

import com.sybinal.shop.common.ApiResponseObject;

public abstract class MobileAbstractController {
	
	/**
	 * 响应前台AJAX请求
	 * @param code
	 * @param error
	 * @param data
	 * @return
	 */
	public ApiResponseObject getResponseJsonObject(String code, String error, Object data) {
		ApiResponseObject jsonObject = new ApiResponseObject();
		jsonObject.setData(data);
		jsonObject.setErrorCode(code);
		jsonObject.setErrorMsg(error);
		return jsonObject;
	}
}
