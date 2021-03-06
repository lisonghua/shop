package com.sybinal.shop.controller.pc;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.sybinal.shop.common.ApiResponseObject;
import com.sybinal.shop.common.ApiServiceException;
import com.sybinal.shop.model.Order;
import com.sybinal.shop.model.OrderItem;
import com.sybinal.shop.model.User;
import com.sybinal.shop.service.api.cart.ApiCartService;
import com.sybinal.shop.service.api.userinfo.ApiUserInfoService;

@Controller
public class PCCartController {
	
	@Autowired
	ApiCartService cartService;
	
	@Autowired
	ApiUserInfoService userInfoService;
	
	@RequestMapping(value = "/pc/cart")
	public String cart() {
		return "pc/cart";
	}

	@RequestMapping(value = "/pc/cart/add",method = RequestMethod.POST)
	@ResponseBody
	public ApiResponseObject addCart(@RequestBody OrderItem orderItem, HttpServletRequest req) throws ApiServiceException {
		HttpSession session = req.getSession();
		Integer userId = (Integer) session.getAttribute("userid");
		Order order = new Order();
		order.setOrderItem(orderItem);
		order.setUserId(userId);
		order.setType(1);
		order.getOrderItem().setUserId(userId);
		ApiResponseObject apiResponseObject = cartService.addCart(order);
		return apiResponseObject;
	}
	
	@RequestMapping(value = "/pc/cart/removeall",method = RequestMethod.POST)
	@ResponseBody
	public ApiResponseObject removeAllCart(HttpServletRequest req) throws ApiServiceException {
		HttpSession session = req.getSession();
		Integer userId = (Integer) session.getAttribute("userid");
		Order order = new Order();
		order.setUserId(userId);
		ApiResponseObject apiResponseObject = cartService.removeCart(order);
		return apiResponseObject;
	}
	
	@RequestMapping(value = "/pc/cart/count",method = RequestMethod.POST)
	@ResponseBody
	public ApiResponseObject getCartCount(HttpServletRequest req) throws ApiServiceException {
		HttpSession session = req.getSession();
		Integer userId = (Integer) session.getAttribute("userid");
		User user = new User();
		user.setId(userId);
		ApiResponseObject apiResponseObject = userInfoService.getUserCartCount(user);
		return apiResponseObject;
	}
	
	@RequestMapping(value = "/pc/cart/item/view",method = RequestMethod.POST)
	@ResponseBody
	public ApiResponseObject getCartItemView(HttpServletRequest req) throws ApiServiceException {
		HttpSession session = req.getSession();
		Integer userId = (Integer) session.getAttribute("userid");
		Order order = new Order();
		order.setUserId(userId);
		order.setType(1);
		ApiResponseObject apiResponseObject = cartService.getCart(order);
		return apiResponseObject;
	}
	
	@RequestMapping(value = "/pc/cart/item",method = RequestMethod.GET)
	@ResponseBody
	public ModelAndView getCartItem(HttpServletRequest req) throws ApiServiceException {
		ModelAndView modelAndView = new ModelAndView();
		HttpSession session = req.getSession();
		Integer userId = (Integer) session.getAttribute("userid");
		Order order = new Order();
		order.setUserId(userId);
		order.setType(1);
		ApiResponseObject apiResponseObject = cartService.getCart(order);
		modelAndView.addObject("cart", apiResponseObject.getData());
		modelAndView.setViewName("pc/cart");
		return modelAndView;
	}
	
	@RequestMapping(value = "/pc/cart/removeid",method = RequestMethod.POST)
	@ResponseBody
	public ApiResponseObject deleteCartById(@RequestBody Order order, HttpServletRequest req) throws ApiServiceException{
		HttpSession session = req.getSession();
		Integer userId = (Integer) session.getAttribute("userid");
		order.setUserId(userId);
		ApiResponseObject ApiResponseObject = cartService.removeCartById(order);
		return ApiResponseObject;
	}
	
}