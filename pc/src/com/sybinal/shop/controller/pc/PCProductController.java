package com.sybinal.shop.controller.pc;

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
public class PCProductController {

	@Autowired
	ApiProductService productService;

	@Autowired
	ApiCategoryService categoryService;

	@Autowired
	ApiOptionService optionService;
	
	/**
	 * 按分类获取商品
	 * 
	 * @return
	 * @throws ApiServiceException
	 */
	@RequestMapping(value = "/pc/category/{category}/page/{currentPage}", method = RequestMethod.GET)
	public String getProductByCategory(@PathVariable("category") int categoryId,
			@PathVariable("currentPage") int currentPage, HttpServletRequest request) throws ApiServiceException {
		Map<String, Object> reqMap = new HashMap<String, Object>();
		reqMap.put("categoryId", categoryId);
		reqMap.put("currentPage", currentPage);
		// 请求API获取分类对象
		ApiResponseObject category = categoryService.getCategoryById(reqMap);
		if (category.getErrorCode().equals(ApiResponseEnum.SUCCESS.getCode())) {
			request.setAttribute("categoryObject", category.getData());
			// 请求API获取分类下的商品
			ApiResponseObject productList = productService.getProductsByCategory(reqMap);
			if (productList.getErrorCode().equals(ApiResponseEnum.SUCCESS.getCode()))
				request.setAttribute("productListPage", productList.getData());
			// 请求API获取全部分类对象
			ApiResponseObject categoryList = categoryService.getCategoryByCondition(reqMap);
			if (categoryList.getErrorCode().equals(ApiResponseEnum.SUCCESS.getCode()))
				request.setAttribute("categoryList", categoryList.getData());
			return "pc/category_products";
		}
		return "redirect:/pc/error";
	}

	/**
	 * 按分类获取商品
	 * 
	 * @return
	 * @throws ApiServiceException
	 */
	@RequestMapping(value = "/pc/category/category", method = RequestMethod.GET)
	public String getProductByCategory(HttpServletRequest request) throws ApiServiceException {
		Map<String, Object> reqMap = new HashMap<String, Object>();
		// 请求API获取全部分类对象
		ApiResponseObject categoryList = categoryService.getCategoryByCondition(reqMap);
		if (categoryList.getErrorCode().equals(ApiResponseEnum.SUCCESS.getCode()))
			request.setAttribute("categoryList", categoryList.getData());
		return "pc/category";
	}

	/**
	 * 按商品根据查询条件
	 * 
	 * @return
	 * @throws ApiServiceException
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping(value = "/pc/search/page/{currentPage}")
	public String searchProduct(String keyword,
			@PathVariable("currentPage") int currentPage, HttpServletRequest request) throws ApiServiceException, UnsupportedEncodingException {
		Map<String, Object> reqMap = new HashMap<String, Object>();
		keyword = URLDecoder.decode(keyword, "utf-8");
		if(keyword != null && keyword.trim().length() > 0)
			reqMap.put("productName", keyword.trim());
		reqMap.put("currentPage", currentPage);
		 //请求API获取分类下的商品
		 ApiResponseObject productList = productService.getSearchProducts(reqMap);
		if (productList.getErrorCode().equals(ApiResponseEnum.SUCCESS.getCode()))
			request.setAttribute("productListPage", productList.getData());
		request.setAttribute("keyword", keyword);
		return "pc/search_products";
	}

	/**
	 * 获取产品信息
	 * 
	 * @return
	 * @throws ApiServiceException
	 * @throws JsonProcessingException
	 */
	@RequestMapping(value = "/pc/product/{productId:.+}")
	public String getProductInfoById(@PathVariable("productId") int productId, HttpServletRequest request)
			throws ApiServiceException, JsonProcessingException {
		Map<String, Object> reqMap = new HashMap<String, Object>();
		reqMap.put("productId", productId);
		// 获取商品详细
		ApiResponseObject productDetails = productService.getProductDetailsById(reqMap);
		if (productDetails.getErrorCode().equals(ApiResponseEnum.SUCCESS.getCode())){
			request.setAttribute("productDetails", productDetails.getData());
			// 获取当前分类热销商品
			ApiResponseObject productHot = productService.getProductHot(reqMap);
			if (productDetails.getErrorCode().equals(ApiResponseEnum.SUCCESS.getCode()))
				request.setAttribute("productHot", productHot.getData());
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
			return "pc/product";
		}
		return "redirect:/pc/error";
	}
	
	@ResponseBody
	@RequestMapping(value = "/pc/product/reviews/add", method = RequestMethod.POST)
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
