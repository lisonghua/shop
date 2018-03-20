package com.sybinal.shop.controller.pc;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class PCErrorController {
	
	@RequestMapping(value = "/pc/error",method = RequestMethod.GET)
	public String showErrorPage() {
		return "pc/error";
	}
}
