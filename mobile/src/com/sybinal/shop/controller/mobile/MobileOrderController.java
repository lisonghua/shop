package com.sybinal.shop.controller.mobile;

import javax.servlet.http.HttpServletRequest;

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
import com.sybinal.shop.service.api.order.ApiOrderService;

@Controller
public class MobileOrderController {

	@Autowired
	ApiOrderService orderService;
 	
	@RequestMapping(value = "/mobile/account/order/list",method = RequestMethod.GET)
	public ModelAndView userOrderList(HttpServletRequest request) throws ApiServiceException {
		ModelAndView modelAndView = new ModelAndView();
		Object userId = request.getSession().getAttribute("userid");
		if (userId == null){
			modelAndView.setViewName("redirect:/mobile/login");
			return modelAndView;			
		}
		Order order = new Order();
		order.setUserId((Integer) request.getSession().getAttribute("userid"));
		order.setType(0);
		ApiResponseObject apiResponseObject = orderService.getOrder(order);
		modelAndView.setViewName("mobile/account/order_list");
		modelAndView.addObject("orderList", apiResponseObject.getData());
		return modelAndView;
	}

	@RequestMapping(value = "/mobile/account/order/list",method = RequestMethod.POST)
	@ResponseBody
	public ApiResponseObject userOrderListPage(@RequestBody Order order, HttpServletRequest request) throws ApiServiceException {
		order.setUserId((Integer) request.getSession().getAttribute("userid"));
		order.setType(0);
		ApiResponseObject apiResponseObject = orderService.getOrder(order);
		return apiResponseObject;
	}

	@RequestMapping(value = "/mobile/account/order/detail",method = RequestMethod.POST)
	public ModelAndView userOrderItem(Order order, HttpServletRequest request) throws ApiServiceException {
		ModelAndView modelAndView = new ModelAndView();
		order.setUserId((Integer) request.getSession().getAttribute("userid"));
		order.setType(0);
		ApiResponseObject apiResponseObject = orderService.getOrderItem(order);
		modelAndView.setViewName("mobile/account/order_detail");
		modelAndView.addObject("orderItem", apiResponseObject.getData());
		return modelAndView;
	}
	
	@RequestMapping(value = "/mobile/account/item/update",method = RequestMethod.POST)
	@ResponseBody
	public ApiResponseObject userOrderItemUpdate(@RequestBody Order order, HttpServletRequest request) throws ApiServiceException {
		order.setUserId((Integer) request.getSession().getAttribute("userid"));
		order.setType(0);
		ApiResponseObject apiResponseObject = orderService.modOrderItem(order);
		return apiResponseObject;
	}
	
}
