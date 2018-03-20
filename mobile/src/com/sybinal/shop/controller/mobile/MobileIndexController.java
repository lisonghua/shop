package com.sybinal.shop.controller.mobile;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sybinal.shop.common.ApiResponseEnum;
import com.sybinal.shop.common.ApiResponseObject;
import com.sybinal.shop.common.ApiServiceException;
import com.sybinal.shop.service.api.product.ApiProductService;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@SuppressWarnings({ "unchecked", "rawtypes" })
public class MobileIndexController extends MobileAbstractController {
	
	@Autowired
	private ApiProductService productService;
	
	/**
	 * mobile端首页
	 * @return
	 * @throws Exception 
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/mobile/index", method = RequestMethod.GET)
	public String mobileindexController(HttpServletRequest request) throws ApiServiceException {
		
		ApiResponseObject apiResponseObject = productService.getIndexProducts(new HashMap());
		if (apiResponseObject.getErrorCode().equals(ApiResponseEnum.SUCCESS.getCode())) {
			request.setAttribute("categoryList", apiResponseObject.getData());
		}
		return "mobile/index";
	}
	
	@RequestMapping(value = "/mobile/index_vue", method = RequestMethod.GET)
	public String index_vue(HttpServletRequest request) throws ApiServiceException {				
		return "mobile/index_vue";
	}
	
	@ResponseBody
	@RequestMapping(value = "/mobile/query_category")
	public List query_category(HttpServletRequest request) throws ApiServiceException {
		List r=null;
		ApiResponseObject apiResponseObject = productService.getIndexProducts(new HashMap());
		if (apiResponseObject.getErrorCode().equals(ApiResponseEnum.SUCCESS.getCode())) {
			r= (List)apiResponseObject.getData();
		}
		return r;
	}
	
	/**
	 * mobile端首页
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String indexController(HttpServletRequest request) throws ApiServiceException {				
		return "index";
	}

}
