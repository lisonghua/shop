package com.sybinal.shop.controller.mobile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

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
import com.sybinal.shop.service.api.cart.ApiCartService;
import com.sybinal.shop.service.api.order.ApiOrderService;

@Controller
public class MobilePaymentController {
	
	@Autowired
	ApiCartService cartService;
	
	@Autowired
	ApiOrderService orderService;

	@RequestMapping(value = "/mobile/payment",method = RequestMethod.GET)
	public ModelAndView payment(@Valid Order order, HttpServletRequest req) throws ApiServiceException {
		ModelAndView modelAndView = new ModelAndView();
		HttpSession session = req.getSession();
		Integer userId = (Integer) session.getAttribute("userid");
		order.setUserId(userId);
		order.setType(0);
		ApiResponseObject apiResponseObject = cartService.getCart(order);
		modelAndView.addObject("payment", apiResponseObject.getData());
		modelAndView.setViewName("mobile/payment");
		return modelAndView;
	}

	@RequestMapping(value = "/mobile/payment/order",method = RequestMethod.POST)
	@ResponseBody
	public ApiResponseObject paymentOrder(@RequestBody Order order, HttpServletRequest req) throws ApiServiceException {
		ModelAndView modelAndView = new ModelAndView();
		HttpSession session = req.getSession();
		Integer userId = (Integer) session.getAttribute("userid");
		order.setUserId(userId);
		ApiResponseObject apiResponseObject = orderService.payOrder(order);
		modelAndView.addObject("payment", apiResponseObject.getData());
		modelAndView.setViewName("mobile/payment");
		return apiResponseObject;
	}
	
}
