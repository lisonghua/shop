<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<spring:url value="/resources/pc/image" var="image" />
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
<title>SHOP-用户信息设置</title>

<!-- mobile settings -->
<meta name="viewport"
	content="width=device-width, maximum-scale=1, initial-scale=1, user-scalable=0" />
<!--[if IE]><meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1'><![endif]-->
<jsp:include page="../include/top.jsp"></jsp:include>
</head>
<body class="smoothscroll enable-animation">
	<!-- wrapper -->
	<div id="wrapper">
		<jsp:include page="../include/head.jsp"></jsp:include>


		<section class="page-header page-header-xs">
			<div class="container">

				<h1>个人中心</h1>

				<!-- breadcrumbs -->
				<ol class="breadcrumb">
					<li><a href="${root}/pc/index">首页</a></li>
					<li>个人中心</li>
					<li class="active">个人信息设置</li>
				</ol>
				<!-- /breadcrumbs -->

				<!-- page tabs -->
				<ul class="page-header-tabs list-inline">
					<li><a href="${root}/pc/account/order/list">我的订单</a></li>
					<li><a href="${root}/pc/account/contact/list">常用联系人</a></li>
					<li><a href="${root}/pc/account/wishlist/page/1">我的收藏</a></li>
					<li class="active"><a href="${root}/pc/account/user_setting">个人设置</a></li>
					<li><a href="${root}/pc/account/ewallet">充值</a></li>
				</ul>
				<!-- /page tabs -->

			</div>
		</section>



		<section>
			<div class="container">

				<div class="panel panel-default">
					<div class="panel-heading">
						<h2 class="panel-title">个人信息设置</h2>
					</div>

					<fieldset class="padding-40 ">
						<div class="row">
							<h3 class='text-center'>个人信息</h3>
							<form id="userBasicFrom" onsubmit="return false;">
								<div class="col-md-6 col-sm-6">
									<label for="nickName">昵称 </label> <input id="nickName"
										name="nickName" type="text" class="form-control required"
										value="${userBasic.nickname}">
								</div>
	
								<div class="col-md-6 col-sm-6">
									<label for="email">Email </label> <input id="email" name="email"
										type="text" class="form-control required"
										value="${userBasic.email}">
								</div>
							</form>
						</div>
						<button id="editBasic"
							class="btn btn-success margin-top-20 pull-right noradius">保存</button>
					</fieldset>

					<hr />
					<h3 class='text-center'>修改密码</h3>
					<fieldset class="padding-40 ">
						<div class="row">
							<form id="userPwdFrom" onsubmit="return false;">
								<div class="col-md-12 col-sm-12">
									<label for="oldpassword">输入当前密码 </label> <input id="oldpassword"
										name="oldpassword" type="password"
										class="form-control required">
								</div>
	
								<div class="col-md-6 col-sm-6">
									<label for="password">新的密码 </label>
									<input id="password" name="password" type="password" class="form-control required">
								</div>
	
								<div class="col-md-6 col-sm-6">
									<label for="rpassword">确认密码 </label> <input id="rpassword"
										name="rpassword" type="password" class="form-control required">
								</div>
							</form>
						</div>
						<button id="editPwd" class="btn btn-success margin-top-20 pull-right noradius">保存</button>
					</fieldset>
				</div>
			</div>
		</section>

		<jsp:include page="../include/footer.jsp"></jsp:include>

	</div>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#userBasicFrom").validate({
				onsubmit : false,
				focusInvalid : false,
				errorClass : "error",
				onfocusout : false,
				onkeyup : false,
				onclick : false,
				ignoreTitle : true,
				rules : {
					nickName:{
		                required: true,
		                maxlength : 20
					},
					email: {
		                maxlength : 50,
		                email: true
		            }
				},
				messages : {
					nickName: {
		                required: "昵称不能为空!",
		                maxlength : "昵称不能超过20位！"
		            },
		            email: {
			            maxlength: "Email不能超过50位！",
		                email:"Email格式不正确!"
			        }
				}
			});
			$("#userPwdFrom").validate({
				onsubmit : false,
				focusInvalid : false,
				errorClass : "error",
				onfocusout : false,
				onkeyup : false,
				onclick : false,
				ignoreTitle : true,
				rules : {
					oldpassword:{
		                required: true,
		                maxlength : 20
					},
					password: {
		                required: true,
		                maxlength : 20
		            },
		            rpassword: {
		                required: true,
		                maxlength : 20,
		                equalTo: "#password"
		            }
				},
				messages : {
					oldpassword: {
		                required: "请输入原始密码！",
		                maxlength : "密码不能超过20位！"
		            },
		            password : {
						required : "请输入新密码！",
						maxlength : "密码不能超过20位！"
					},
					rpassword: {
			            required: "请输入确认密码！",
			            maxlength: "确认密码不能超过20位！",
			            equalTo: "密码与确认密码不一致！"
			        }
				}
			});
			
			$("#editBasic").click(function() {
				if(!$("#userBasicFrom").valid()){
			        return;
			   	}
				var userBasic = {
					"email" : $('input[name="email"]').val(),
					"nickname" : $('input[name="nickName"]').val()
				};
				$.ajax({
					type : "POST",
					url : '${root}' + '/pc/account/userBasic/edit?${_csrf.parameterName}=${_csrf.token}',
					data : userBasic,
					dataType : "json", //ajax返回值设置为text(json格式也可用它返回，可打印出结果，也可设置成json)  
					success : function(data) {
						if (data.success) {
							toastr.success(data.message);
						} else {
							toastr.warning(data.message);
						}
					},
					error : function(json) {
						toastr.error('错误 登录超时,请重新登录!');
					}
				});
			});

			$("#editPwd").click(function() {
				if(!$("#userPwdFrom").valid())
			        return;
				$.ajax({
					type : "POST",
					url : '${root}' + '/pc/account/userBasic/pwd?${_csrf.parameterName}=${_csrf.token}',
					data : {
						"oldpassword" : $("#oldpassword").val(),
						"rpassword" : $("#password").val()
					},
					dataType : "json", //ajax返回值设置为text(json格式也可用它返回，可打印出结果，也可设置成json)  
					success : function(data) {
						if (data.success) {
							toastr.success(data.message);
						} else {
							toastr.warning(data.message);
						}
					},
					error : function(json) {
						toastr.error('错误 登录超时,请重新登录!');
					}
				});
			});

		});
	</script>
</body>
</html>