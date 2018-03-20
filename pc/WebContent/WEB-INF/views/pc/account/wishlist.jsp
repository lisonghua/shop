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
<title>SHOP-我的收藏</title>

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
					<li class="active">我的订单</li>
				</ol>
				<!-- /breadcrumbs -->

				<!-- page tabs -->
				<ul class="page-header-tabs list-inline">
					<li><a href="${root}/pc/account/order/list">我的订单</a></li>
					<li><a href="${root}/pc/account/contact/list">常用联系人</a></li>
					<li class="active"><a href="${root}/pc/account/wishlist/page/1">我的收藏</a></li>
					<li><a href="${root}/pc/account/user_setting">个人设置</a></li>
					<li><a href="${root}/pc/account/ewallet">充值</a></li>
				</ul>
				<!-- /page tabs -->
			</div>
		</section>
		<section style="padding-top: 25px">
			<div class="container">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h2 class="panel-title">个人收藏</h2>
					</div>
					<c:if test="${empty wishlistPage.wishlist}">
						<fieldset class="padding-40 ">
							<div class="row">
								<h4>暂无数据！</h4>
							</div>
						</fieldset>
					</c:if>
					<c:if test="${not empty wishlistPage.wishlist}">
						<table class="table margin-top-20">
							<thead>
								<tr>
									<th>商品名称</th>
									<th class="text-center">市场价格</th>
									<th class="text-center">店内价格</th>
									<th class="text-center">操作</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${wishlistPage.wishlist}" var="wishlistObj">
									<tr>
										<td>
											<img class="weui-media-box__thumb" style="width: 65px; height: 65px" src="${root}${wishlistObj.product.defaultImg}" >
											${wishlistObj.product.name}
										</td>
										<td class="text-center">
											<span class="line-through">
												￥${wishlistObj.product.price / 100}
											</span>
										</td>
										<td class="text-center">￥${wishlistObj.product.shopPrice / 100}</td>
										<td class="text-center">
											<a href='${root}/pc/account/wishlist/remove/${wishlistObj.id}'>删除收藏</a>
											<a href='${root}/pc/product/${wishlistObj.productId}'>查看商品</a>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<div id="bootpag" class="pull-right"></div>
					</c:if>
				</div>
			</div>
		</section>
		<jsp:include page="../include/footer.jsp"></jsp:include>
	</div>
	<!-- /wrapper -->
	<script type="text/javascript">
		$('#bootpag').bootpag({
		   total: '${wishlistPage.totalPage}',
		   page: '${wishlistPage.currentPage}',
		   maxVisible: 6,
		   href: "${root}/pc/account/wishlist/page/{{number}}",
		   leaps: false,
		   next: '>',
		   prev: '<'
		}).on('page', function(event, num) {
			window.location.href = '${root}/account/wishlist/page/' + num;
		});
	</script>
</body>
</html>