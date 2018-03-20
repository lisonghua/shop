package com.sybinal.shop.service.api.ewallet;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.sybinal.shop.common.ApiResponseObject;
import com.sybinal.shop.common.ApiServiceException;
import com.sybinal.shop.common.HttpClientTool;

@Service
public class ApiEwalletServiceImpl implements ApiEwalletService{

	@Resource(name = "httpClientTool")
	private HttpClientTool httpClientTool;
	@Override
	public ApiResponseObject getDefalutValueOfAccount() throws ApiServiceException {
		// TODO Auto-generated method stub
		return httpClientTool.doPostJson(HttpClientTool.API_URL_EWALLET_DEFAULT,null);
	}

}
