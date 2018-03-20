<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<title>SHOP-订单列表</title>

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
					<li class="active">我的订单</li>
				</ol>
				<!-- /breadcrumbs -->
				<!-- page tabs -->
				<ul class="page-header-tabs list-inline">
					<li class="active"><a href="${root}/pc/account/order/list">我的订单</a></li>
					<li><a href="${root}/pc/account/contact/list">常用联系人</a></li>
					<li><a href="${root}/pc/account/wishlist/page/1">我的收藏</a></li>
					<li><a href="${root}/pc/account/user_setting">个人设置</a></li>
					<li><a href="${root}/pc/account/ewallet">充值</a></li>
				</ul>
				<!-- /page tabs -->
			</div>
		</section>
		<section>
			<div class="container">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h2 class="panel-title">我的订单</h2>
					</div>
					<div class="panel-body">
						<p>
							<span>全部订单</span> <span>未支付订单</span> <span>支付订单</span>
						</p>
					</div>

					<table class="table">
						<thead>
							<tr>
								<th>订单编号</th>
								<th>联系人姓名</th>
								<th>联系人电话</th>
								<th>订单状态</th>
								<th>订单金额</th>
							</tr>
						</thead>
						<tbody id="tbody">
							<c:forEach items="${orderList.orderListData}" var="z"
								varStatus="s">
								<tr>
									<td><a href="javascript:void(0)" onclick="orderitem(this)">${z.orderNum}</a></td>
									<td>${z.contactName}</td>
									<td>${z.contactMobile}</td>
										<c:if test="${z.status==0 || z.status==null}">
											<td>订单编辑中</td>
										</c:if>
										<c:if test="${z.status==1}">
											<td>已下单</td>
										</c:if>
										<c:if test="${z.status==2}">
											<td>配送中</td>
										</c:if>
										<c:if test="${z.status==3}">
											<td>配送完成</td>
										</c:if>
										<c:if test="${z.status==4}">
											<td>订单取消</td>
										</c:if>
									<td>${z.price/100}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<ul class="pagination pagination-sm">
					<li><a href="javascript:void(0)"
						onclick="pagego('${orderList.nowPage-1}')">&laquo;</a></li>
					<c:forEach varStatus="i" begin="1" end="${orderList.pageCount}">
						<c:choose>
							<c:when test="${orderList.nowPage ==i.count}">
								<li class="active"><a href="javascript:void(0)"
									onclick="pagego('${i.count}')"> ${i.count} </a></li>
							</c:when>
							<c:otherwise>
								<li><a href='javascript:void(0)'
									onclick="pagego('${i.count}')">${i.count}</a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<li><a href="javascript:void(0)"
						onclick="pagego('${orderList.nowPage+1}')">&raquo;</a></li>
				</ul>
			</div>
		</section>
		<jsp:include page="../include/footer.jsp"></jsp:include>
	</div>
	<!-- /wrapper -->
	<!-- JAVASCRIPT FILES -->
</body>
<form id="turnpage" method="post"
	action="${pageContext.request.contextPath}/pc/account/order/list?${_csrf.parameterName}=${_csrf.token}">
	<input type="hidden" name="nowPage">
</form>
<form id="itemData" method="post"
	action="${pageContext.request.contextPath}/pc/account/order/detail?${_csrf.parameterName}=${_csrf.token}">
	<input type="hidden" name="orderNum">
</form>
<script type="text/javascript">
	// 下一页
	function pagego(Obj){
		if(Obj==0 || Obj>${orderList.pageCount}){
			return;
		}
		$("[name=nowPage]").val(Obj);
		$("#turnpage").submit();
	}
	//订单详细
	function orderitem(Obj){
		$("[name=orderNum]").val($(Obj).text());
		$("#itemData").submit();
	}
</script>
</html>