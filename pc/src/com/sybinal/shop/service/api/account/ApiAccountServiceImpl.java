package com.sybinal.shop.service.api.account;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.sybinal.shop.common.ApiResponseObject;
import com.sybinal.shop.common.ApiServiceException;
import com.sybinal.shop.common.HttpClientTool;
import com.sybinal.shop.model.Account;

@Service
public class ApiAccountServiceImpl implements ApiAccountService {

	@Resource(name = "httpClientTool")
	private HttpClientTool httpClientTool;
	
	@Override
	public ApiResponseObject getAccount(Map<String, Object> reqMap)
			throws ApiServiceException {
		return httpClientTool.doPostJson(HttpClientTool.API_URL_CUSTOMER_Account, reqMap);
	}

	@Override
	public ApiResponseObject rechargeAccount(Account account)
			throws ApiServiceException {
		// TODO Auto-generated method stub
		return httpClientTool.doPostJson(HttpClientTool.API_URL_CUSTOMER_Recharge_Account, account);
	}

	@Override
	public ApiResponseObject payOrderByEwallet(Account account) throws ApiServiceException {
		// TODO Auto-generated method stub
		return httpClientTool.doPostJson(HttpClientTool.API_URL_CUSTOMER_Pay_Order, account);
	}

}
