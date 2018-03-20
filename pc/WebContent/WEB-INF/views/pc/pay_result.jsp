<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<spring:url value="/resources/pc/assets/images" var="image" />
<spring:url value="/resources/pc/assets/css" var="css" />
<spring:url value="/resources/pc/assets/js" var="js" />

<c:set var="root" value="${pageContext.request.contextPath}" />
<c:set var="payResult" value="${payResult}" />
<!DOCTYPE html>
<!--[if IE 8]>			<html class="ie ie8"> <![endif]-->
<!--[if IE 9]>			<html class="ie ie9"> <![endif]-->
<!--[if gt IE 9]><!-->
<html>
<!--<![endif]-->

<head>
<meta charset="utf-8" />
<title>SHOP-支付</title>

<!-- mobile settings -->
<meta name="viewport"
	content="width=device-width, maximum-scale=1, initial-scale=1, user-scalable=0" />
<!--[if IE]><meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1'><![endif]-->

<jsp:include page="include/top.jsp"></jsp:include>
</head>
<body class="smoothscroll enable-animation">
	<!-- wrapper -->
	<div id="wrapper">
		<jsp:include page="include/head.jsp"></jsp:include>
		<section class="page-header page-header-xs">
			<div class="container">
				<h1>支付</h1>

				<ol class="breadcrumb">
					<li><a href="${root}/pc/index">首页</a></li>
					<li>支付</li>
				</ol>
			</div>
		</section>
		<!-- /PAGE HEADER -->
		<!-- 购物车 -->
		<section>
			<div class="container">
				<!-- 如果购物车为空 -->
				<div class="panel panel-default" style='display: none'>
					<div class="panel-body">
						<strong style='font-size: 25px'>购物车里无商品!</strong> <br />
						随便看看，优惠多多，赶紧抢购吧！
					</div>
				</div>
				<!-- /EMPTY CART -->
				<!-- CART -->
				<fieldset class="margin-top-10">
					<div class="row">
						<!-- LEFT -->
						<div class="col-lg-9 col-sm-8">

							<c:if test="${payResult ==1 }">
								<strong style='font-size: 20px'>订单支付成功！</strong>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<a style='font-size: 16px' href="${root }/pc/account/order/list">到个人中心查看订单>></a>
							</c:if>
							<c:if test="${payResult ==-1 }">
								<strong style='font-size: 20px'>余额不足，订单支付失败！</strong>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<a style='font-size: 16px' href="${root }/pc/account/ewallet">去充值>></a>
							</c:if>
						</div>
						<!-- RIGHT -->
						<div class="col-lg-3 col-sm-4"></div>
					</div>
				</fieldset>
			</div>
		</section>
		<jsp:include page="include/footer.jsp"></jsp:include>
	</div>
	<!-- /wrapper -->
	<!-- JAVASCRIPT FILES -->
	<script type="text/javascript"
		src="${root}/resources/pc/assets/js/common.js"></script>
	<script src="${root}/resources/pc/assets/js/toastr/build/toastr.min.js"></script>
	<script src="${root}/resources/pc/assets/js/swiper.min.js"></script>
</body>
<script type="text/javascript">
	
</script>
</html>
