package com.sybinal.shop.controller.mobile;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sybinal.shop.common.AjaxResult;
import com.sybinal.shop.common.ApiResponseEnum;
import com.sybinal.shop.common.ApiResponseObject;
import com.sybinal.shop.common.ApiServiceException;
import com.sybinal.shop.model.User;
import com.sybinal.shop.model.Wishlist;
import com.sybinal.shop.service.api.userinfo.ApiUserInfoService;
import com.sybinal.shop.service.api.userinfo.ApiWishlistService;

@Controller
public class MobileUserInfoController {
	
	@Autowired
	private ApiWishlistService wishlistService;
	
	@Autowired
	private ApiUserInfoService userInfoService;

	/**
	 * 修改个人信息
	 * @return
	 */
	@RequestMapping(value = "mobile/account/center")
	public String accountIndex(HttpServletRequest request) {
		Object userId = request.getSession().getAttribute("userid");
		if (userId == null)
			return "redirect:/mobile/login";
		return "mobile/account/index";
	}
	
	/**
	 * 修改个人信息
	 * 
	 * @return
	 * @throws ApiServiceException 
	 */
	@RequestMapping(value = "/mobile/account/user_setting")
	public String updateUserBasic(HttpServletRequest request) throws ApiServiceException {
		Object userId = request.getSession().getAttribute("userid");
		if (userId == null)
			return "mobile/login";
		Map<String, Object> reqMap = new HashMap<String, Object>();
		reqMap.put("userId", (int) userId);
		ApiResponseObject obj = userInfoService.getUserBasic(reqMap);
		if (obj.getErrorCode().equals(ApiResponseEnum.SUCCESS.getCode()))
			request.setAttribute("userBasic", obj.getData());
		return "/mobile/account/user_setting";
	}

	/**
	 * 修改个人基本信息
	 * 
	 * @return
	 * @throws ApiServiceException 
	 */
	@ResponseBody
	@RequestMapping(value = "/mobile/account/userBasic/edit", method = RequestMethod.POST)
	public Object editUserBasic(User user, HttpServletRequest request) throws ApiServiceException {
		Object userId = request.getSession().getAttribute("userid");
		if (userId == null)
			return new AjaxResult(false, "登录超时,请重新登录!");
		user.setId((int) userId);
		Object result = null;
		ApiResponseObject productDetails = userInfoService.editUserBasic(user);
		if (productDetails.getErrorCode().equals(ApiResponseEnum.SUCCESS.getCode()))
			result = productDetails.getData();
		return result;
	}

	/**
	 * 修改密码
	 * 
	 * @return
	 * @throws ApiServiceException 
	 */
	@ResponseBody
	@RequestMapping(value = "/mobile/account/userBasic/pwd", method = RequestMethod.POST)
	public Object editUserPwd(String oldpassword, String rpassword, HttpServletRequest request) throws ApiServiceException {
		Object userId = request.getSession().getAttribute("userid");
		if (userId == null)
			return new AjaxResult(false, "登录超时,请重新登录!");
		Map<String, Object> reqMap = new HashMap<>();
		reqMap.put("userId", (int) userId);
		reqMap.put("oldpassword", oldpassword);
		reqMap.put("rpassword", rpassword);
		ApiResponseObject productDetails = userInfoService.editUserPwd(reqMap);
		return productDetails.getData();
	}

	/**
	 * 加入心愿单
	 * 
	 * @return
	 * @throws ApiServiceException
	 */
	@ResponseBody
	@RequestMapping(value = "/mobile/account/wishlist/add", method = RequestMethod.POST)
	public Object addWishList(Wishlist wishlist, HttpServletRequest request) throws ApiServiceException {
		Object userId = request.getSession().getAttribute("userid");
		if (userId == null)
			return new AjaxResult(false, "请先登录再收藏商品!");
		wishlist.setUserId((int) userId);
		Object result = null;
		ApiResponseObject productDetails = wishlistService.addWishlistByUserId(wishlist);
		if (productDetails.getErrorCode().equals(ApiResponseEnum.SUCCESS.getCode()))
			result = productDetails.getData();
		return result;
	}

	/**
	 * 移除心愿单
	 * 
	 * @return
	 * @throws ApiServiceException
	 */
	@RequestMapping(value = "/mobile/account/wishlist/remove/{keyword}", method = RequestMethod.GET)
	public String removeWishList(@PathVariable("keyword") int keyword, HttpServletRequest request)
			throws ApiServiceException {
		Object userId = request.getSession().getAttribute("userid");
		if (userId == null)
			return "mobile/login";
		Map<String, Object> reqMap = new HashMap<String, Object>();
		reqMap.put("userId", (int) userId);
		reqMap.put("wishlisId", keyword);
		ApiResponseObject obj = wishlistService.removeWishlist(reqMap);
		if (obj.getErrorCode().equals(ApiResponseEnum.SUCCESS.getCode()))
			return getWishList(1, request);
		return "mobile/login";
	}

	/**
	 * 获取心愿单
	 * 
	 * @return
	 * @throws ApiServiceException
	 */
	@RequestMapping(value = "/mobile/account/wishlist/page/{currentPage}")
	public String getWishList(@PathVariable("currentPage") int currentPage, HttpServletRequest request) throws ApiServiceException {
		Object userId = request.getSession().getAttribute("userid");
		if (userId == null)
			return "redirect:/mobile/login";
		Map<String, Object> reqMap = new HashMap<String, Object>();
		reqMap.put("userId", (int) userId);
		reqMap.put("currentPage", currentPage);
		ApiResponseObject obj = wishlistService.getUserWishlist(reqMap);
		request.setAttribute("wishlistPage", obj.getData());
		return "/mobile/account/wishlist";
	}
	
	/**
	 * 获取心愿单
	 * @return
	 * @throws ApiServiceException 
	 */
	@ResponseBody
	@RequestMapping(value = "/mobile/account/wishlist/page", method = RequestMethod.POST)
	public Object getWishListAjax(int currentPage, HttpServletRequest request) throws ApiServiceException {
		Object userId = request.getSession().getAttribute("userid");
		if (userId == null)
			return new AjaxResult(true, "登录超时!");
		Map<String, Object> reqMap = new HashMap<String, Object>();
		reqMap.put("userId", (int) userId);
		reqMap.put("currentPage", currentPage);
		return wishlistService.getUserWishlist(reqMap).getData();
	}
	/**
	 * 判断是否登录
	 * 
	 * @return
	 * @throws ApiServiceException
	 */
	@ResponseBody
	@RequestMapping(value = "/mobile/account/isLogin")
	public AjaxResult isLogin(HttpServletRequest request) {
		Object userId = request.getSession().getAttribute("userid");
		if (userId == null)
			return new AjaxResult(false);
		return new AjaxResult(true);
	}

}