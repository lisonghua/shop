package com.sybinal.shop.controller.pc;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.sybinal.shop.common.ApiResponseEnum;
import com.sybinal.shop.common.ApiResponseObject;
import com.sybinal.shop.common.ApiServiceException;
import com.sybinal.shop.model.User;
import com.sybinal.shop.service.api.ewallet.ApiEwalletService;
import com.sybinal.shop.service.api.userinfo.ApiSendSmsMessageService;
import com.sybinal.shop.service.api.userinfo.ApiUserInfoService;
import com.sybinal.shop.validator.UserValidator;

/**
 * 用户控制器
 * 
 */
@Controller
public class PCAcountController {

	@Autowired
	ApiSendSmsMessageService sendSmsMessageService;

	@Autowired
	ApiUserInfoService userInfoService;
	
	@Autowired
	ApiEwalletService eWalletService;
	
	@InitBinder
	protected void initBinder(WebDataBinder binder) {
		binder.addValidators(new UserValidator());
	}

	@RequestMapping(value = "pc/login", method = RequestMethod.GET)
	public String login() {
		return "pc/login";
	}

	@RequestMapping(value = "pc/logout", method = RequestMethod.GET)
	public String logout(HttpServletRequest req) {
		req.getSession().invalidate();
		return "redirect:/pc/login";
	}

	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "pc/login", method = RequestMethod.POST)
	public ModelAndView dologin(@Valid User user, BindingResult result, ModelMap model, HttpServletRequest request)
			throws ApiServiceException {
		ModelAndView modelAndView = new ModelAndView();
		ApiResponseObject apiResponseObject = userInfoService.getUserInfo(user);
		if("0".equals(apiResponseObject.getErrorCode())){
			Map mapCart = (Map) apiResponseObject.getData();
			Integer id = (Integer) mapCart.get("id");
			user.setId(id);
			if (ApiResponseEnum.SUCCESS.getCode().equals(apiResponseObject.getErrorCode())) {
//				modelAndView.setViewName("redirect:category_products");
				modelAndView.setViewName("redirect:/pc/index");
//				pcIndexController.indexController(request);
				HttpSession session = request.getSession();
				session.setAttribute("username", mapCart.get("userName"));
				session.setAttribute("nickname", mapCart.get("nickname"));
				session.setAttribute("userid", id);
				return modelAndView;
			}
		}
		modelAndView.setViewName("pc/login");
		request.setAttribute("loginError", "用户名不存在或密码错误！");
		return modelAndView;
	}

	@RequestMapping(value = "pc/register", method = RequestMethod.GET)
	public String register(ModelMap model) {
		User user = new User();
		model.addAttribute("user", user);
		return "pc/register";
	}

	@RequestMapping(value = "pc/register", method = RequestMethod.POST)
	public ModelAndView doRegister(@Valid User user, BindingResult result, ModelMap model, HttpServletRequest request) throws ApiServiceException {
		ModelAndView mav = new ModelAndView();
		if(!user.getUserName().equals(request.getSession().getAttribute("userName"))){
			mav.setViewName("pc/register");
			result.addError(new ObjectError("registerErrorMsg", new String[] { "register.error" }, null, null));
			return mav;
		}
			
		if(!user.getSmsCode().equals(request.getSession().getAttribute("sendCode"))){
			mav.setViewName("pc/register");
			result.addError(new ObjectError("registerErrorMsg", new String[] { "register.errorMsg" }, null, null));
			return mav;
		}
		if (result.hasErrors()) {
			mav.setViewName("pc/register");
		} else {
			try {
				ApiResponseObject apiResponseObjectAmount = eWalletService.getDefalutValueOfAccount();
				int amount = (int)apiResponseObjectAmount.getData();
				System.out.println("在PC中获取的默认值是："+amount);
				user.setAmount(amount);
				ApiResponseObject apiResponseObject = userInfoService.registerUserInfo(user);
				if (apiResponseObject.getErrorCode().equals(ApiResponseEnum.SUCCESS.getCode())) {
					mav.setViewName("redirect:/pc/login");
					request.getSession().invalidate();
				}
			} catch (Exception e) {
				result.addError(new ObjectError("registerError", new String[] { "register.error" }, null, null));
				mav.setViewName("pc/register");
			}
		}
		return mav;
	}

	@RequestMapping(value = "pc/forget_password", method = RequestMethod.GET)
	public String forgetPassword(ModelMap model) {
		User user = new User();
		model.addAttribute("user", user);
		return "pc/forget_password";
	}

	@RequestMapping(value = "pc/change_password", method = RequestMethod.POST)
	public String changePassword() {
		return "pc/change_password";
	}

	@RequestMapping(value = "pc/sendSmsMsg", method = RequestMethod.POST)
	@ResponseBody
	public ApiResponseObject sendSmsMsg(User user, HttpServletRequest request) throws ApiServiceException {
		try {
			ApiResponseObject apiResponseObject = userInfoService.getUserInfo(user);

			if (apiResponseObject.getErrorCode().equals(ApiResponseEnum.SUCCESS.getCode())) {
				apiResponseObject.setErrorCode(ApiResponseEnum.ERROR_PARAM.getCode());
			} else {
				apiResponseObject = sendSmsMessageService.getSmsMessage(user);
				request.getSession().setAttribute("userName",user.getUserName());
				request.getSession().setAttribute("sendCode",apiResponseObject.getData());
			}
			return apiResponseObject;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

	}
	
	@RequestMapping(value = "pc/recovery/sendSmsMsg", method = RequestMethod.POST)
	@ResponseBody
	public ApiResponseObject recoverySendSmsMsg(User user, HttpServletRequest request) throws ApiServiceException {
		try {
			ApiResponseObject apiResponseObject = userInfoService.getUserInfo(user);
			if (apiResponseObject.getErrorCode().equals(ApiResponseEnum.SUCCESS.getCode())) {
				apiResponseObject = sendSmsMessageService.getSmsMessage(user);
				request.getSession().setAttribute("userName",user.getUserName());
				request.getSession().setAttribute("sendCode",apiResponseObject.getData());
			}else{
				apiResponseObject.setErrorCode(ApiResponseEnum.ERROR_PARAM.getCode());
			}
			return apiResponseObject;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	@RequestMapping(value = "pc/recovery", method = RequestMethod.POST)
	public ModelAndView doRecovery(@Valid User user, BindingResult result, ModelMap model, HttpServletRequest request)
			throws ApiServiceException {
		ModelAndView mav = new ModelAndView();
		if(!user.getUserName().equals(request.getSession().getAttribute("userName")) ||  !user.getSmsCode().equals(request.getSession().getAttribute("sendCode"))){
			mav.setViewName("pc/forget_password");
			result.addError(new ObjectError("registerErrorMsg", new String[] { "register.errorMsg" }, null, null));
			return mav;
		}
		if (result.hasErrors()) {
			mav.setViewName("pc/forget_password");
		} else {
			ApiResponseObject apiResponseObject = userInfoService.recoveryUserPwd(user);
			if (apiResponseObject.getErrorCode().equals(ApiResponseEnum.SUCCESS.getCode())) {
				mav.setViewName("pc/login");
			}
		}
		return mav;
	}
}
