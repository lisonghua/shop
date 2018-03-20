package com.sybinal.shop.service.api.ewallet;


import com.sybinal.shop.common.ApiResponseObject;
import com.sybinal.shop.common.ApiServiceException;


public interface ApiEwalletService {

	public ApiResponseObject getDefalutValueOfAccount() throws ApiServiceException;
	
}
