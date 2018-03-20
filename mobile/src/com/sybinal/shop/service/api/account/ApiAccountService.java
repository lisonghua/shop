package com.sybinal.shop.service.api.account;

import java.util.Map;

import com.sybinal.shop.common.ApiResponseObject;
import com.sybinal.shop.common.ApiServiceException;
import com.sybinal.shop.model.Account;

public interface ApiAccountService {

	/*
	 * 获取某个用户的电子钱包余额
	 */
	public ApiResponseObject getAccount(Map<String, Object> reqMap) throws ApiServiceException;
	
	/*
	 * 用户充值
	 */
	public ApiResponseObject rechargeAccount(Account account) throws ApiServiceException;
	
	/*
	 * 用户使用电子钱包支付订单
	 */
	public ApiResponseObject payOrderByEwallet(Account account) throws ApiServiceException;
}
