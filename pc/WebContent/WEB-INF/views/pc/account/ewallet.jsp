<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<meta charset="utf-8" />
<title>SHOP-电子钱包充值</title>

<!-- mobile settings -->
<meta name="viewport"
	content="width=device-width, maximum-scale=1, initial-scale=1, user-scalable=0" />
<!--[if IE]><meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1'><![endif]-->

<!-- CORE CSS -->
<link href="${css}/bootstrap.min.css" rel="stylesheet">

<!-- THEME CSS -->
<link href="${css}/essentials.css" rel="stylesheet" type="text/css" />
<link href="${css}/layout.css" rel="stylesheet" type="text/css" />

<!-- PAGE LEVEL SCRIPTS -->
<link href="${css}/header-1.css" rel="stylesheet" type="text/css" />
<link href="${css}/layout-shop.css" rel="stylesheet" type="text/css" />
<link href="${css}/color_scheme/orange.css" rel="stylesheet"
	type="text/css" id="color_scheme" />
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
					<li class="active">充值</li>
				</ol>
				<!-- /breadcrumbs -->

				<!-- page tabs -->
				<ul class="page-header-tabs list-inline">
					<li><a href="${root}/pc/account/order/list">我的订单</a></li>
					<li><a href="${root}/pc/account/contact/list">常用收货地址</a></li>
					<li><a href="${root}/pc/account/wishlist/page/1">我的收藏</a></li>
					<li><a href="${root}/pc/account/user_setting">个人设置</a></li>
					<li class="active"><a href="${root}/pc/account/ewallet">充值</a></li>
				</ul>
				<!-- /page tabs -->
			</div>
		</section>
		<section>
			<div class="container">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h2 class="panel-title">账户充值</h2>
					</div>
					<br />
					<div class="row">
						<h4 class='text-center'>当前电子钱包账户余额为：${userAccount.amount }</h4>
					</div>


					<div class="panel-body">
						<fieldset class="margin-top-10 ">
							<div class="row">
								<form id="form_account" name="form_account" method="post"
									action="">
									<div class="form-group col-lg-12">
										<label for="account">请输入充值金额 *</label> <input id="account"
											name="account" type="text" class="form-control required"
											placeholder="请输入充值金额" maxlength="255">
										<div class="erro"></div>
									</div>
								</form>
							</div>
							<button id="save" type="button"
								class="btn btn-success margin-top-20 pull-right noradius"
								onclick="javascript:valdate()">
								<i class="glyphicon glyphicon-user"></i> 充值
							</button>
						</fieldset>
					</div>

				</div>
			</div>
		</section>
		<jsp:include page="../include/footer.jsp"></jsp:include>
	</div>
	<script src="${root}/resources/pc/assets/js/toastr/build/toastr.min.js"></script>
	<script src="${root}/resources/pc/assets/js/swiper.min.js"></script>
	<script>
		//校验input;
		function valdate() {
			var rechargeNum = $("#account").val();
			$(".erro").text("");
			var idx = 0;

			if ($("#account").val().trim() == "") {
				$(".erro").text("此项为必填项！");
				idx = 1;
			} else {

				var mobile = /^[0-9]+.?[0-9]*$/;
				if (!mobile.test($("#account").val())) {
					$(".erro").text("请输入充值金额!");
					idx = 1;

				}
			}

			//校验flg
			if (idx == 1) {
				return false;
			} else {
				$
						.ajax({
							type : "POST",
							contentType : 'application/json;charset=utf-8',
							url : "${pageContext.request.contextPath}/pc/account/recharge?rechargeNum="
									+ rechargeNum,
							data : $("#account").val(),
							dataType : "json", //ajax返回值设置为text（json格式也可用它返回，可打印出结果，也可设置成json）  
							async : false,
							success : function(json) {
								//errorCode为0则为成功
								if (json.errorCode == 0) {
									toastr.success("充值成功！");
									setTimeout(
											function() {
												window.location.href = "${pageContext.request.contextPath}/pc/account/ewallet";
											}, 2000);
								} else {
									toastr.warning("充值失败！");
								}
							},
							error : function(json) {
								toastr.warning("充值失败！");
							}
						});
			}
		}
	</script>
</body>

</html>