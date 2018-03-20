<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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
				<div class="row">
					<!-- LEFT -->
					<div class="col-lg-9 col-sm-8">
						<!-- CART -->
						<form class="cartContent clearfix" method="post" action="#">
							<input type="hidden" name="orderNum" value="${payment.orderNum}">
							<!-- cart content -->
							<div id="cartContent">
								<!-- cart header -->
								<div class="item head clearfix">
									<span class="cart_img"></span> <span
										class="product_name size-13 bold">产品名称</span> <span
										class="remove_item size-13 bold"></span> <span
										class="total_price size-13 bold">合计价格</span> <span
										class="qty size-13 bold">数量</span>
								</div>
								<!-- /cart header -->
								<c:forEach items="${payment.orderItemList}" var="z" varStatus="s">
									<div class="item">
										<div class="cart_img pull-left width-100 padding-10 text-left">
											<img src="${root}${z.productList[0].defaultImg}" alt="" width="40" />
										</div>
										<a href="shop-single-left.html" class="product_name"> <span>
												${z.productList[0].name}</span> <small>${z.jsonData}</small>
										</a> 
										<div name="total_price" class="total_price">
											$<span>${z.price*z.quantity/100}</span>
											<c:set var="totalPrice" value="${z.price*z.quantity/100}"></c:set>
										</div>
										<div class="qty">
										    <p class="zq" zid="${z.id}" 
										     zpid="${z.productList[0].id}"
										     sku="${z.skuId}" 
										     group="${z.optionValueKeyGroup}">${z.quantity}</p> 
										     &times;${z.price/100}
										</div>
										<div class="clearfix"></div>
									</div>
								</c:forEach>
								<div class='padding-20'>
									<strong style='font-size: 20px'>选择常用联系人</strong>
									<hr />
									<c:forEach items="${payment.contectList}" var="z" varStatus="s">
										<div class='padding-bottom-10'>
											<c:if test="${z.contactFlag==1}">
											<input type="radio" name="product-review-vote" value="${z.id}" checked="checked" />
											</c:if>
											<c:if test="${z.contactFlag!=1}">
											<input type="radio" value="${z.id}" name="product-review-vote" />
											</c:if>
											姓名：${z.name} &nbsp;&nbsp; 联系电话：${z.mobile} &nbsp;&nbsp; 地址：${z.address}
										</div>
									</c:forEach>
									<!-- 联系人 -->
								</div>

								<div class='padding-20'>
									<strong style='font-size: 20px'>请选择支付方式</strong>
									<hr />
									<div>
										<a onclick="payTreasure(1)" href="javascript:void(0);"><img src='${image}/pay/pc_wxqrpay.png' /></a> 
										<a onclick="payTreasure(0)" href="javascript:void(0);"><img src='${image}/pay/alipaypcnew.png' /></a>
										<a onclick="payTreasure(0)" href="${root}/pc/pay/ewallet?total_price=${totalPrice}">电子钱包</a>
									</div>
								</div>
								<div class="clearfix"></div>
							</div>
							<!-- /cart content -->
						</form>
						<!-- /CART -->
					</div>
					<!-- RIGHT -->
					<div class="col-lg-3 col-sm-4">
					<c:if test="${!empty payment.contectList}">
						<div class="toggle active">
							<div class='toggle-content' style='display: block;'>
								<div>
									<span class="clearfix"> <span id="sumCart" class="pull-right">￥${payment.price/100}</span>
										<strong class="pull-left">商品总价:</strong>
									</span> <span class="clearfix"> <span class="pull-right">包邮</span>
										<span class="pull-left">物流费用:</span>
									</span>

									<hr />
					
									<span class="clearfix"> <span class="pull-right size-20">￥${payment.price/100}</span>
										<strong class="pull-left">合计金额:</strong>
									</span>
								</div>
							</div>
						</div>
					</c:if>
					</div>
				</div>
			</div>
		</section>
		<jsp:include page="include/footer.jsp"></jsp:include>
	</div>
	<!-- /wrapper -->
	<!-- JAVASCRIPT FILES -->
	<script type="text/javascript" src="${root}/resources/pc/assets/js/common.js"></script>
	<script src="${root}/resources/pc/assets/js/toastr/build/toastr.min.js"></script>
	<script src="${root}/resources/pc/assets/js/swiper.min.js"></script>
</body>
<script type="text/javascript">
//支付功能
function payTreasure(Obj){
	//收集联系人数据 
	var val = $('input:radio[name=product-review-vote]:checked').val();
	var orderItem={};
	var order = {};
	var contect = {};
	contect["id"]=val;
	contect["paymentType"]=Obj;
	order["contect"]=contect;
	$.ajax({
		type : "POST",
		contentType : 'application/json;charset=utf-8',
		url : "${pageContext.request.contextPath}/pc/payment/order?${_csrf.parameterName}=${_csrf.token}",
		data: JSON.stringify(order),
		dataType : "json", //ajax返回值设置为text（json格式也可用它返回，可打印出结果，也可设置成json）  
		async : false,
		success : function(json) {
			//errorCode为0则为成功
			if(json.errorCode==0){
				toastr.success("支付成功，2秒钟后跳转到订单历史");
				setTimeout(function(){
					window.location.href="${pageContext.request.contextPath}/pc/account/order/list?${_csrf.parameterName}=${_csrf.token}";	
				}, 2000);
			}else{
				toastr.success("支付失败");
			}
		},
		error : function(json) {
			toastr.success("支付失败");
		}
	});
}
</script>
</html>
