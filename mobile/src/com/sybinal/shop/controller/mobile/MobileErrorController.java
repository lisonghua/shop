package com.sybinal.shop.controller.mobile;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MobileErrorController {
	@RequestMapping(value = "mobile/error",method = RequestMethod.GET)
	public String showErrorPage() {
		return "mobile/error";
	}
}
