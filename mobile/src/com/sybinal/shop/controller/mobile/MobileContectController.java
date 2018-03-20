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
import com.sybinal.shop.model.Contect;
import com.sybinal.shop.service.api.contect.ApiContectService;

@Controller
public class MobileContectController {

	@Autowired
	ApiContectService contectService;

	@RequestMapping(value = "/mobile/account/contact/list")
	public ModelAndView contactList(HttpServletRequest req) throws ApiServiceException {
		ModelAndView modelAndView = new ModelAndView();
		Integer userId = (Integer) req.getSession().getAttribute("userid");
		if (userId == null){
			modelAndView.setViewName("redirect:/mobile/login");
			return modelAndView;			
		}
		Contect contect = new Contect();
		contect.setUserId(userId);
		ApiResponseObject apiResponseObject = contectService.getContect(contect);
		modelAndView.setViewName("mobile/account/contact_list");
		modelAndView.addObject("accountList", apiResponseObject.getData());
		return modelAndView;
	}

	@RequestMapping(value = "/mobile/contect/add", method = RequestMethod.POST)
	@ResponseBody
	public ApiResponseObject addContect(Contect contect, HttpServletRequest req) throws ApiServiceException {
		Integer userId = (Integer) req.getSession().getAttribute("userid");
		contect.setUserId(userId);
		ApiResponseObject apiResponseObject = null;
		if (contect.getId() == null) {
			// 新增
			apiResponseObject = contectService.addContect(contect);
		} else {
			// 修改
			apiResponseObject = contectService.modContect(contect);
		}
		return apiResponseObject;
	}

	@RequestMapping(value = "/mobile/contect/remove", method = RequestMethod.POST)
	@ResponseBody
	public ApiResponseObject removeContect(@RequestBody Contect contect, HttpServletRequest req)
			throws ApiServiceException {
		Integer userId = (Integer) req.getSession().getAttribute("userid");
		contect.setUserId(userId);
		ApiResponseObject apiResponseObject = contectService.removeContect(contect);
		return apiResponseObject;
	}

	@RequestMapping(value = "/mobile/contect/default", method = RequestMethod.POST)
	@ResponseBody
	public ApiResponseObject defaultContect(@RequestBody Contect contect, HttpServletRequest req)
			throws ApiServiceException {
		Integer userId = (Integer) req.getSession().getAttribute("userid");
		contect.setUserId(userId);
		contect.setContactFlag(1);
		ApiResponseObject apiResponseObject = contectService.updateContect(contect);
		return apiResponseObject;
	}
}
