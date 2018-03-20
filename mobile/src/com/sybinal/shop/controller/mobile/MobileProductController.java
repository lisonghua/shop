package com.sybinal.shop.controller.mobile;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sybinal.shop.common.AjaxResult;
import com.sybinal.shop.common.ApiResponseEnum;
import com.sybinal.shop.common.ApiResponseObject;
import com.sybinal.shop.common.ApiServiceException;
import com.sybinal.shop.model.Comments;
import com.sybinal.shop.service.api.catalog.ApiCategoryService;
import com.sybinal.shop.service.api.catalog.ApiOptionService;
import com.sybinal.shop.service.api.product.ApiProductService;

@Controller
public class MobileProductController {

	
	@Autowired
	ApiProductService productService;
	
	@Autowired
	ApiCategoryService categoryService;
	
	@Autowired
	ApiOptionService optionService;

	/**
	 * 查询商品
	 * @return
	 * @throws UnsupportedEncodingException 
	 * @throws ApiServiceException 
	 */
	@RequestMapping(value = "/mobile/product/search", method = RequestMethod.GET)
	public String searchProduct(String keyword, HttpServletRequest request) throws UnsupportedEncodingException, ApiServiceException {
		Map<String, Object> reqMap = new HashMap<String, Object>();
		keyword = URLDecoder.decode(keyword, "utf-8");
		if(keyword != null && keyword.trim().length() > 0)
			reqMap.put("productName", keyword.trim());
		reqMap.put("currentPage", 1);
		// 请求API获取分类下的商品
		ApiResponseObject productList = productService.getProductsByCategory(reqMap);
		// 请求API获取分类对象
		if (productList.getErrorCode().equals(ApiResponseEnum.SUCCESS.getCode()))
			request.setAttribute("productListPage", productList.getData());
		request.setAttribute("keyword", keyword);
		return "mobile/product_search";
	}
	/**
	 * 查询商品
	 * @return
	 * @throws UnsupportedEncodingException 
	 * @throws ApiServiceException 
	 */
	@ResponseBody
	@RequestMapping(value = "/mobile/product/search/page", method = RequestMethod.POST)
	public Object searchAjaxProduct(String keyword, int currentPage, HttpServletRequest request) throws UnsupportedEncodingException, ApiServiceException {
		Map<String, Object> reqMap = new HashMap<String, Object>();
		keyword = URLDecoder.decode(keyword, "utf-8");
		reqMap.put("productName", keyword.trim());
		reqMap.put("currentPage", currentPage);
		return productService.getProductsByCategory(reqMap).getData();
	}
	/**
	 * 按分类获取商品
	 * 
	 * @return
	 * @throws ApiServiceException
	 * @throws JsonProcessingException 
	 */
	@RequestMapping(value = "/mobile/category/{category}", method = RequestMethod.GET)
	public String getProductByCategory(@PathVariable("category") int categoryId, HttpServletRequest request) throws ApiServiceException, JsonProcessingException {
		Map<String, Object> reqMap = new HashMap<String, Object>();
		reqMap.put("categoryId", categoryId);
		reqMap.put("currentPage", 1);
		// 请求API获取分类对象
		ApiResponseObject category = categoryService.getCategoryById(reqMap);
		if (category.getErrorCode().equals(ApiResponseEnum.SUCCESS.getCode())) {
			request.setAttribute("categoryObject", category.getData());
			// 请求API获取分类下的商品
			ApiResponseObject productList = productService.getProductsByCategory(reqMap);
			if (productList.getErrorCode().equals(ApiResponseEnum.SUCCESS.getCode()))
				request.setAttribute("productListPage", productList.getData());
			return "mobile/product_category";
		}
		return "redirect:/mobile/error";
	}
	/**
	 * 按分类获取商品
	 * 
	 * @return
	 * @throws ApiServiceException
	 */
	@ResponseBody
	@RequestMapping(value = "/mobile/category/page", method = RequestMethod.POST)
	public Object getAjaxProductByCategory(int currentPage, int categoryId, HttpServletRequest request) throws ApiServiceException {
		Map<String, Object> reqMap = new HashMap<String, Object>();
		reqMap.put("categoryId", categoryId);
		reqMap.put("currentPage", currentPage);
		return productService.getProductsByCategory(reqMap).getData();
	}
	
	/**
	 * 获取产品信息
	 * @return
	 * @throws ApiServiceException 
	 * @throws JsonProcessingException 
	 */
	@RequestMapping(value = "/mobile/product/{productId:.+}")
	public String getProductInfoById(@PathVariable("productId") int productId, HttpServletRequest request) throws ApiServiceException, JsonProcessingException {
		Map<String, Object> reqMap = new HashMap<String, Object>();
		reqMap.put("productId", productId);
		Object userId = request.getSession().getAttribute("userid");
		if (userId != null)
			request.setAttribute("userId", userId);
		// 获取商品详细
		ApiResponseObject productDetails = productService.getProductDetailsById(reqMap);
		if (productDetails.getErrorCode().equals(ApiResponseEnum.SUCCESS.getCode())) {
			request.setAttribute("productDetails", productDetails.getData());
			// 获取当前商品评论
			ApiResponseObject reviewsList = productService.getReviews(reqMap);
			if (reviewsList.getErrorCode().equals(ApiResponseEnum.SUCCESS.getCode()))
				request.setAttribute("reviewsList", reviewsList.getData());
			// 获取当前商品Option
			ApiResponseObject optionList = optionService.getOptionDetailsByProductId(reqMap);
			if (optionList.getErrorCode().equals(ApiResponseEnum.SUCCESS.getCode()))
				request.setAttribute("optionList", optionList.getData());
			// 获取当前商品sku
			ObjectMapper objMapper = new ObjectMapper();
			ApiResponseObject skuList = optionService.getSkuByProductId(reqMap);
			if (skuList.getErrorCode().equals(ApiResponseEnum.SUCCESS.getCode()))
				request.setAttribute("skuList", objMapper.writeValueAsString(skuList.getData()));
			return "/mobile/product";
		}
		return "redirect:/mobile/error";
	}
	
	@ResponseBody
	@RequestMapping(value = "/mobile/product/reviews/add", method = RequestMethod.POST)
	public Object addReviews(Comments comments, HttpServletRequest request) throws ApiServiceException {
		Object userId = request.getSession().getAttribute("userid");
		if (userId == null)
			return new AjaxResult(false);
		comments.setUserId((int) userId);
		Object result = null;
		ApiResponseObject productDetails = productService.addReviews(comments);
		if (productDetails.getErrorCode().equals(ApiResponseEnum.SUCCESS.getCode()))
			result = productDetails.getData();
		return result;
	}
	
}
