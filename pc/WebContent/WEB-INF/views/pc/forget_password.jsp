<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<spring:url value="/resources/pc/assets/images" var="image" />
<spring:url value="/resources/pc/assets/css" var="css" />
<spring:url value="/resources/pc/assets/js" var="js" />
<c:set var="root" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<!--[if IE 8]>			<html class="ie ie8"> <![endif]-->
<!--[if IE 9]>			<html class="ie ie9"> <![endif]-->
<!--[if gt IE 9]><!-->
<html>
<!--<![endif]-->

<head>
<meta charset="utf-8" />
<title>SHOP-忘记密码</title>

<!-- mobile settings -->
<meta name="viewport"
	content="width=device-width, maximum-scale=1, initial-scale=1, user-scalable=0" />
<!--[if IE]><meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1'><![endif]-->
<jsp:include page="include/top.jsp"></jsp:include>
<style type="text/css">
.error {
	font-weight: bold;
}
</style>

</head>
<script
	src="${pageContext.request.contextPath}/resources/pc/assets/js/jquery.js"></script>
<body class="smoothscroll enable-animation">
	<!-- wrapper -->
	<div id="wrapper">
		<jsp:include page="include/head.jsp"></jsp:include>
		<section class="page-header page-header-xs">
			<div class="container">
				<h1>忘记密码</h1>

				<ol class="breadcrumb">
					<li><a href="${root}/index">首页</a></li>
					<li><a href="${root}/register">忘记密码</a></li>
				</ol>
			</div>
		</section>
		<!-- /PAGE HEADER -->

		<!-- -->
		<section>
			<div class="container">

				<div class="row">

					<!-- LEFT TEXT -->
					<div class="col-md-5 col-md-offset-1">

						<img class="img-responsive"
							src="${root}/resources/pc/assets/images/shop/login-png.png">
					</div>
					<!-- /LEFT TEXT -->
					<!-- LOGIN -->
					<div class="col-md-4">
						<h2 class="size-16">忘记密码</h2>
						<!-- login form -->
						<form:form id="recoveryForm" method="post" action="#" autocomplete="off" modelAttribute="user">
							<div class="clearfix">
								<!-- ALERT -->
								<div id="error"class="alert alert-mini alert-danger margin-bottom-30"style="display: none">
									<strong>手机验证码错误!</strong>
								</div>
								<!-- /ALERT -->
								<div id="message" style="display: none"></div>
								<form:errors />
								<!--
									<!-- mobile -->
								<div class="form-group">
									<form:input path="userName" class="form-control"
										placeholder="手机号码" required="" maxlength="11"
										cssErrorClass="form-control error" />
									<form:errors path="userName" class="error" />
								</div>
								<!-- 验证码 -->
								<div class="form-group">
									<form:input path="smsCode" class="form-control"
										placeholder="请输入手机验证码" maxlength="6"
										cssErrorClass="form-control error" />
									<form:errors path="smsCode" cssClass="error" />
								</div>
								<!-- Password -->
								<div class="form-group">
									<form:password path="pwd" class="form-control" placeholder="密码"
										required="" maxlength="20" cssErrorClass="form-control error" />
									<form:errors path="pwd" cssClass="error" />
								</div>
								<!-- Password -->
								<div class="form-group">
									<form:password path="confirmPassword" class="form-control"
										placeholder="确认密码" required="" maxlength="20"
										cssErrorClass="form-control error" />
									<form:errors path="confirmPassword" cssClass="error" />
								</div>
							</div>
							<div class="row">
								<div class="col-md-6 col-sm-6 col-xs-6">
									<!-- Inform Tip -->
									<div class="form-tip pt-20">
										<button id="smsBtn" class="btn btn-info noradius"
											type="button">发送手机验证码</button>
									</div>
								</div>

								<div class="col-md-6 col-sm-6 col-xs-6 text-right">
									<button id="recoveryBtn" class="btn btn-primary noradius"
										type="button">找回密码</button>
								</div>
							</div>
							<div>
								<a href="${root}/pc/login">立即登录</a>
							</div>
							<input type="hidden" name="fromAPI" class="form-control"
								value="0">
						</form:form>
						<!-- /login form -->
					</div>
					<!-- /LOGIN -->
				</div>
			</div>
		</section>
		<jsp:include page="include/footer.jsp"></jsp:include>
	</div>
	<!-- /wrapper -->
	<!-- JAVASCRIPT FILES -->
	<script
		src="${pageContext.request.contextPath}/resources/pc/assets/js/jquery.validate.js"></script>
	<input type="hidden" id="btnFlag" />
</body>
<script type="text/javascript">
var validate
$(document).ready(function() {
	validate = $("#recoveryForm").validate({
		onsubmit : false,
		focusInvalid : false,
		errorClass : "error",
		onfocusout : false,
		onkeyup : false,
		onclick : false,
		ignoreTitle : true,
		rules : {
			userName : {
				required : true,
				maxlength : 11,
				isMobile : true
			},
			smsCode : {
				required : function(element) {
					return ($('#btnFlag').val() == "1");
				},
				maxlength : 6
			},
			pwd : {
				required : function(element) {
					return ($('#btnFlag').val() == "1");
				},
				maxlength : 20
			},
			confirmPassword : {
				required : function(element) {
					return ($('#btnFlag').val() == "1");
				},
				maxlength : 20,
				equalTo : "#pwd"
			},
		},
		messages : {
			userName : {
				required : "请输入手机号码！",
				maxlength : "手机号码不能超过11位！",
				isMobile : "请正确填写您的手机号码"
			},
			smsCode : {
				required : "请输入手机验证码！",
				maxlength : "手机验证码必须是6位！"
			},
			pwd : {
				required : "请输入密码！",
				maxlength : "密码不能超过20位！"
			},
			confirmPassword : {
				required : "请输入确认密码！",
				maxlength : "确认密码不能超过20位！",
				equalTo : "密码与确认密码不一致！"
			}
		}
	});
	jQuery.validator.addMethod("isMobile",function(value, element) {
		var length = value.length;
		var mobile = /^(13[0-9]{9})|(18[0-9]{9})|(14[0-9]{9})|(17[0-9]{9})|(15[0-9]{9})$/;
		return this.optional(element)|| (length == 11 && mobile.test(value));
	}, "请正确填写您的手机号码");
});
	/**
	 * 发送手机验证码
	 */
	$("#smsBtn").bind('click',function() {
		$('span[class="error"]').remove();

		$('#btnFlag').val("0");
		if ($("#recoveryForm").valid() == false) {
			return;
		};
		var params = {};
		params.userName = $("[name=userName]").val();
		$.ajax({
			type : "POST",
			url : "${pageContext.request.contextPath}/pc/recovery/sendSmsMsg?${_csrf.parameterName}=${_csrf.token}",
			data : params,
			dataType : "json", //ajax返回值设置为text（json格式也可用它返回，可打印出结果，也可设置成json）  
			async : false,
			success : function(json) {
				var smsMessage = "";
				if (json.errorCode == '0') {
					smsMessage = "您的手机验证码：" + json.data;
				} else if (json.errorCode == '-2') {
					smsMessage = "用户不存在"
				}
				$("#message").show();
				$("#message").html("<strong>" + smsMessage+ "</strong>");
			},
			error : function(json) {
				alert(json);
			}
		});
	});
	/**
	 * 发送手机验证码
	 */
	$("#recoveryBtn").bind('click',function() {
		$('#btnFlag').val("1");
		if ($("#recoveryForm").valid() == false) {
			return;
		}
		;
		$('#recoveryForm').attr("action","${pageContext.request.contextPath}/pc/recovery?${_csrf.parameterName}=${_csrf.token}")
		$('#recoveryForm').submit();
	});
</script>

</html>
