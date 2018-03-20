package com.sybinal.shop.controller.pc;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sybinal.shop.common.ApiResponseEnum;
import com.sybinal.shop.common.ApiResponseObject;
import com.sybinal.shop.common.ApiServiceException;
import com.sybinal.shop.service.api.catalog.ApiCategoryService;
import com.sybinal.shop.service.api.product.ApiProductService;

@Controller
public class PCIndexController extends PCAbstractController {

	@Autowired
	private ApiProductService productService;
	
	@Autowired
	private ApiCategoryService categoryService;
	
	
	/**
	 * PC端首页
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/pc/index", method = RequestMethod.GET)
	public String indexController(HttpServletRequest request) throws ApiServiceException {
		Map<String, Object> map = new HashMap<String, Object>();
		// 请求API获取全部分类对象
		ApiResponseObject categoryList = categoryService.getCategoryByCondition(map);
		if (categoryList.getErrorCode().equals(ApiResponseEnum.SUCCESS.getCode())) {
			request.setAttribute("categoryList", categoryList.getData());
		}
		// 获取首页商品数据
		if (categoryList.getErrorCode().equals(ApiResponseEnum.SUCCESS.getCode())) {
			map.put("pageSize", 8);
			request.setAttribute("categoryRelationList", productService.getIndexProducts(map).getData());	
		}
		return "pc/index";
	}
	
}
