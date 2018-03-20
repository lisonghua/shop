<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<spring:url value="/resources/pc/image" var="image" />
<spring:url value="/resources/pc/assets/css" var="css" />
<spring:url value="/resources/pc/assets/js" var="js" />

<c:set var="root" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<!--[if IE 8]>			<html class="ie ie8"> <![endif]-->
<!--[if IE 9]>			<html class="ie ie9"> <![endif]-->
<!--[if gt IE 9]><!-->	<html> <!--<![endif]-->
	<head>
		<meta charset="utf-8" />
		<title>SHOP-订单明细</title>

		<!-- mobile settings -->
		<meta name="viewport" content="width=device-width, maximum-scale=1, initial-scale=1, user-scalable=0" />
		<!--[if IE]><meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1'><![endif]-->

		<!-- CORE CSS -->
<link href="${css}/bootstrap.min.css" rel="stylesheet">
		
		<!-- THEME CSS -->
		<link href="${css}/essentials.css" rel="stylesheet" type="text/css" />
		<link href="${css}/layout.css" rel="stylesheet" type="text/css" />

		<!-- PAGE LEVEL SCRIPTS -->
		<link href="${css}/header-1.css" rel="stylesheet" type="text/css" />
		<link href="${css}/layout-shop.css" rel="stylesheet" type="text/css" />
		<link href="${css}/color_scheme/orange.css" rel="stylesheet" type="text/css" id="color_scheme" />
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
						<li class="active">订单明细</li>
					</ol><!-- /breadcrumbs -->
					<!-- page tabs -->
					<ul class="page-header-tabs list-inline">
						<li class="active"><a href="${root}/pc/account/order/list">我的订单</a></li>
						<li><a href="${root}/pc/account/contact/list">常用联系人</a></li>
					<li><a href="${root}/pc/account/wishlist/page/1">我的收藏</a></li>
						<li><a href="${root}/pc/account/user_setting">个人设置</a></li>
						<li><a href="${root}/pc/account/ewallet">充值</a></li>
					</ul><!-- /page tabs -->
				</div>
			</section>
			<section>
				<div class="container">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h2 class="panel-title">订单编号：${orderItem.orderNum}</h2>
						</div>
						<div class="panel-body">
							<c:if test="${orderItem.status==0 || orderItem.status==null}">
								<div>订单状态：订单编辑中</div>
							</c:if>
							<c:if test="${orderItem.status==1}">
								<div>订单状态：已下单</div>
							</c:if>
							<c:if test="${orderItem.status==2}">
								<div>订单状态：配送中</div>
							</c:if>
							<c:if test="${orderItem.status==3}">
								<div>订单状态：配送完成</div>
							</c:if>
							<c:if test="${orderItem.status==4}">
								<div>订单状态：订单取消</div>
							</c:if>
							<div>联系人姓名：${orderItem.contactName}</div>
							<div>联系人电话：${orderItem.contactMobile}</div>
							<div>送货地址：${orderItem.contactAddress}</div>
							<div>订单金额：${orderItem.price/100}</div>
							<hr />
							<c:if test="${!empty orderItem.logisticsList}">
								<div>物流单号：${orderItem.logisticsList[0].logisticsNum}</div>
								<div>物流公司：${orderItem.logisticsList[0].companyName}</div>
								<div>物流费用：(包邮)</div>
								<div>物流状态：
									<c:if test="${orderItem.logisticsList[0].state==null || orderItem.logisticsList[0].state==0}">
										订单编辑中
									</c:if>
									<c:if test="${orderItem.logisticsList[0].state==1}">
										已下单
									</c:if>
									<c:if test="${orderItem.logisticsList[0].state==2}">
										配送中
									</c:if>
									<c:if test="${orderItem.logisticsList[0].state==3}">
										配送完了
									</c:if>
									<c:if test="${orderItem.logisticsList[0].state==4}">
										订单取消
									</c:if>
								</div>
								<div>发货时间：${orderItem.logisticsList[0].timestamp}</div>
							</c:if>
						</div>
						<table class="table">
							<thead>
								<tr>
									<th>商品</th>
									<th>选项</th>
									<th>单价</th>
									<th>数量</th>
									<th>合计金额</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach items="${orderItem.orderItemList}" var="z" varStatus="s">
								<tr>
									<td><div class="cart_img pull-left width-100 padding-10 text-left">
										<img src="${root}${z.productList[0].defaultImg}" alt="" width="40" />
									</div>${z.productList[0].name}</td>
									<td>${z.jsonData}</td>
									<td>${z.price/100}</td>
									<td>${z.quantity}</td>
									<td>${z.price*z.quantity/100}</td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</section>
			<jsp:include page="../include/footer.jsp"></jsp:include>
		</div>
		<!-- /wrapper -->
		<!-- JAVASCRIPT FILES -->
	</body>
</html>