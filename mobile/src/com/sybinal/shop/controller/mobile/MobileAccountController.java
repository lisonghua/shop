package com.sybinal.shop.controller.mobile;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.sybinal.shop.common.ApiResponseEnum;
import com.sybinal.shop.common.ApiResponseObject;
import com.sybinal.shop.common.ApiServiceException;
import com.sybinal.shop.model.Account;
import com.sybinal.shop.service.api.account.ApiAccountService;
import com.sybinal.shop.service.api.userinfo.ApiUserInfoService;

@Controller
public class MobileAccountController {

	@Autowired
	ApiAccountService accountService;

	@Autowired
	private ApiUserInfoService userInfoService;

	/**
	 * 获取用户电子钱包账户余额值
	 * 
	 * @return
	 * @throws ApiServiceException
	 */
	@RequestMapping(value = "/mobile/account/ewallet", method = RequestMethod.GET)
	public String getDefalutValueOfAccount(HttpServletRequest request)
			throws ApiServiceException {
		Object userId = request.getSession().getAttribute("userid");
		if (userId == null)
			return "pc/login";
		Map<String, Object> reqMap = new HashMap<String, Object>();
		reqMap.put("userId", (int) userId);
		ApiResponseObject obj = accountService.getAccount(reqMap);
		if (obj.getErrorCode().equals(ApiResponseEnum.SUCCESS.getCode()))
			request.setAttribute("userAccount", obj.getData());
		return "/mobile/account/ewallet";
	}

	/*
	 * 用户电子钱包充值
	 */
	@RequestMapping(value = "/mobile/account/recharge")
	@ResponseBody
	public Map<String, Object> recharge(HttpServletRequest request) throws ApiServiceException {
		Map<String, Object> map = new HashMap<String, Object>();
		Account account = new Account();
		String rechargeNum = request.getParameter("rechargeNum");
		Object userId = request.getSession().getAttribute("userid");
		account.setAmount(Integer.parseInt(rechargeNum));
		account.setUserId((int)userId);
		Date date = new Date();
		account.setUpdTime(date);
		account.setSource("充值");
		ApiResponseObject obj1 = accountService.rechargeAccount(account);
		int result = (int) obj1.getData();
		if (result > 0) {
			map.put("errorCode", "0"); // 成功
			map.put("data", account); // 数据
		} else {
			map.put("errorCode", "-1"); // 失败
			map.put("data", account); // 数据成
		}
		return map;

	}

	/*
	 * 用户利用电子钱包支付
	 */
	@RequestMapping("/mobile/pay/ewallet")
	@ResponseBody
	public Map<String, Object> payByEwallet(HttpServletRequest request)
			throws ApiServiceException {
		Map<String, Object> map = new HashMap<String, Object>();
		String totalPrice = request.getParameter("total_price");
		double amount = 0 - Double.parseDouble(totalPrice);
		Object userId = request.getSession().getAttribute("userid");
		Account account = new Account();
		account.setAmount(amount);
		account.setUserId((int) userId);
		account.setSource("商城消费");
		account.setUpdTime(new Date());
		ApiResponseObject obj = accountService.payOrderByEwallet(account);
		if (obj.getErrorCode().equals(ApiResponseEnum.SUCCESS.getCode())) {
			map.put("errorCode", "0"); // 成功
			request.setAttribute("payResult", obj.getData());
		} else {
			map.put("errorCode", "-1"); // 失败
			request.setAttribute("payResult", obj.getData());
		}
		return map;
	}
}
