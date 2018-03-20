<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
<meta charset="utf-8" />
<title>SHOP</title>

<!-- mobile settings -->
<meta name="viewport"
	content="width=device-width, maximum-scale=1, initial-scale=1, user-scalable=0" />
<!--[if IE]><meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1'><![endif]-->

<!-- CORE CSS -->
<link href="${css}/bootstrap.min.css" rel="stylesheet">

<!-- THEME CSS -->
<link href="${css}/essentials.css" rel="stylesheet" type="text/css" />
<link href="${css}/layout.css" rel="stylesheet" type="text/css" />
<link href="${root}/resources/pc/assets/js/bootstrap-touchspin-master/src/jquery.bootstrap-touchspin.js" rel="stylesheet" type="text/css" />
<link href="${root}/resources/pc/assets/js/toastr/build/toastr.min.css" rel="stylesheet" />
<!-- PAGE LEVEL SCRIPTS -->
<link href="${css}/header-1.css" rel="stylesheet" type="text/css" /><link href="${css}/layout-shop.css" rel="stylesheet" type="text/css" />

<link href="${css}/color_scheme/orange.css" rel="stylesheet" type="text/css" id="color_scheme" />

<jsp:include page="include/top.jsp"></jsp:include>
</head>
<body class="smoothscroll enable-animation">
	<!-- wrapper -->
	<div id="wrapper">
		<jsp:include page="include/head.jsp"></jsp:include>
		<section class="page-header page-header-xs">
			<div class="container">
				<h1>我的购物车</h1>
				<ol class="breadcrumb">
					<li><a href="${root}/pc/index">首页</a></li>
					<li>购物车</li>
				</ol>
			</div>
		</section>
		<!-- /PAGE HEADER -->
		<!-- 购物车 -->
		<section>
			<div class="container">
				<!-- 如果购物车为空 -->
				<div id="msgDiv" class="panel panel-default" style="display: none">
					<div class="panel-body">
						<strong style='font-size: 25px'>购物车里无商品!</strong><br />
						随便看看，优惠多多，赶紧抢购吧！
					</div>
				</div>
				<!-- 如果购物车为空 -->
				<!-- CART -->
				<div class="row">
					<!-- LEFT -->
					<div class="col-lg-9 col-sm-8">
						<!-- CART -->
						<form class="cartContent clearfix" method="post" action="#">
							<!-- cart content -->
							<div id="cartContent">
								<!-- cart header -->
								<c:if test="${!empty cart.orderItemList}">
									<div class="item head clearfix">
										<span class="cart_img"></span> <span
											class="product_name size-13 bold">产品名称</span> <span
											class="remove_item size-13 bold"></span> <span
											class="total_price size-13 bold">合计价格</span> <span
											class="qty size-13 bold">数量</span>
									</div>
								</c:if>
								<!-- /cart header -->
								<c:if test="${empty cart.orderItemList}">
									<div id="msgDiv" class="panel panel-default">
										<div class="panel-body">
											<strong style='font-size: 25px'>购物车里无商品!</strong><br />
												随便看看，优惠多多，赶紧抢购吧！
										</div>
									</div>
								</c:if>
								<c:forEach items="${cart.orderItemList}" var="z" varStatus="s">
									<div class="item">
										<div class="cart_img pull-left width-100 padding-10 text-left">
											<img src="${root}${z.productList[0].defaultImg}" alt="" width="40" />
										</div>
										<a href="${root}/pc/product/${z.productList[0].id}" class="product_name"> <span>
												${z.productList[0].name}</span> <small>${z.jsonData}</small>
										</a> <a href="javascript:void(0)" name="removeItem" zid="${z.id}" zprice="${z.price/100}" class="remove_item"><i class="fa fa-times"></i></a>
										<div name="total_price" class="total_price">¥<span><fmt:formatNumber type="number" value="${(z.price*z.quantity)/100}" pattern="0.00" maxFractionDigits="2"/></span></div>
										<div class="qty">
											<input type="number" 
											value="${z.quantity}" 
											zprice="${z.price/100}" 
											zid="${z.id}" 
											zpid="${z.productList[0].id}"
										    sku="${z.skuId}" 
										    group="${z.optionValueKeyGroup}"
											name="qty" maxlength="3"
											max="999" min="1"  /> &times;
											¥<fmt:formatNumber type="number" value="${z.price/100}" pattern="0.00" maxFractionDigits="2"/>
										</div>
										<div class="clearfix"></div>
									</div>
								</c:forEach>
								<c:if test="${!empty cart.orderItemList}">
									<button id="updateCart" type="button" class="btn btn-success margin-top-20 pull-right noradius">
										<i class="glyphicon glyphicon-ok"> </i> 更新购物车
									</button>
									<button id="removeCart" type="button" class="btn btn-danger margin-top-20 pull-right noradius">
										<i class="glyphicon glyphicon-remove"> </i> 清空购物车
									</button>
								</c:if>
								<!-- /update cart -->
								<div class="clearfix"></div>
							</div>
							<!-- /cart content -->

						</form>
						<!-- /CART -->
					</div>
					<!-- RIGHT -->
					<div class="col-lg-3 col-sm-4">
						<div>
							<div>
							<c:if test="${!empty cart.orderItemList}">
								<div class="hideDiv">
									<span class="clearfix"> <span id="sumCart" class="pull-right">
									¥<fmt:formatNumber type="number" value="${cart.price/100}" pattern="0.00" maxFractionDigits="2"/>
									</span>
										<strong class="pull-left">商品总价:</strong>
									</span> <span class="clearfix"> <span class="pull-right">包邮</span>
										<span class="pull-left">物流费用:</span>
									</span>
									<hr />
									<span class="clearfix"> <span class="pull-right size-20">
									¥<fmt:formatNumber type="number" value="${cart.price/100}" pattern="0.00" maxFractionDigits="2"/></span>
										<strong class="pull-left">合计金额:</strong>
									</span>
									<hr />
									<button id="payCart" type="button" class="btn btn-success margin-top-20 pull-right noradius">
										<i class="glyphicon glyphicon-ok"> </i> 立即支付
									</button>
								</div>
								</c:if>
							</div>
						</div>
					</div>
				</div>
				<!-- /CART -->
			</div>
		</section>
		<!-- /购物车 -->
		<jsp:include page="include/footer.jsp"></jsp:include>
	</div>
	<!-- /wrapper -->
	<!-- JAVASCRIPT FILES -->
	<script src="${root}/resources/pc/assets/js/bootstrap-touchspin-master/src/jquery.bootstrap-touchspin.js"></script>
	<script src="${root}/resources/pc/assets/js/toastr/build/toastr.min.js"></script>
	<script src="${root}/resources/pc/assets/js/swiper.min.js"></script>

</body>
<script type="text/javascript">
	$('input[name="number"]').TouchSpin({
	    min: 1,
	    max: 999,
	    step: 1,
	    boostat: 5,
	    maxboostedstep: 10
	});
	$("#removeCart").bind('click', function() {
		$.ajax({
			type : "POST",
			url : "${pageContext.request.contextPath}/pc/cart/removeall?${_csrf.parameterName}=${_csrf.token}",
			dataType : "json", //ajax返回值设置为text（json格式也可用它返回，可打印出结果，也可设置成json）  
			async : false,
			success : function(json) {
				getCartCount("${root}","?${_csrf.parameterName}=${_csrf.token}");
				$("#msgDiv").show();
				$(".item").hide();
				$(".noradius").hide();
				$(".hideDiv").hide();
			},
			error : function(json) {
				 toastr.warning("删除失败");
			}
		});
	});
	$("[name=removeItem]").bind('click', function() {
		var sumPrice = 0;
		var orderMap={};
		orderMap["id"] = $(this).attr("zid");
		var orderItem = {};
		orderItem["orderItem"] = orderMap;
		$(this).parent().remove();
		for(var i = 0;i<$("[name='total_price']").length;i++){
			sumPrice+=Number($("[name=total_price]").eq(i).find("span").text()*100);
		}
		$(".size-20").text("￥"+(sumPrice/100).toFixed(2));
		$("#sumCart").text("￥"+(sumPrice/100).toFixed(2));
		$.ajax({
			type : "POST",
			contentType : 'application/json;charset=utf-8',
			url : "${pageContext.request.contextPath}/pc/cart/removeid?${_csrf.parameterName}=${_csrf.token}",
			data: JSON.stringify(orderItem),
			dataType : "json", //ajax返回值设置为text（json格式也可用它返回，可打印出结果，也可设置成json）  
			async : false,
			success : function(json) {
				getCartCount("${root}","?${_csrf.parameterName}=${_csrf.token}");
				if($("[name=qty]")[0]==undefined){
					$("#msgDiv").show();
					$(".item").hide();
					$(".noradius").hide();
					$(".hideDiv").hide();
				}
			},
			error : function(json) {
				toastr.warning("删除失败");
			}
		});
		
		
	})
	$("[name=qty]").bind('change', function() {
		var sumPrice = 0;
		$(this).parent().prev("[name=total_price]").find("span").text(((($(this).attr("zprice")*100)*$(this).val())/100).toFixed(2));
		for(var i = 0;i<$("[name=total_price]").length;i++){
			sumPrice+=Number($("[name=total_price]").eq(i).find("span").text()*100);
		}
		$(".size-20").text("￥"+(sumPrice/100).toFixed(2));
		$("#sumCart").text("￥"+(sumPrice/100).toFixed(2));
	})
	
	$("#payCart").bind('click', function() {
		updateOrPay(function(json) {
			if(json.errorCode==0){
				window.location.href="${pageContext.request.contextPath}/pc/payment?${_csrf.parameterName}=${_csrf.token}";
			} else {
	            toastr.warning(json.errorMsg);
			}
		})
	})
	$("#updateCart").bind('click', function() {
		updateOrPay(function(json) {
			if(json.errorCode==0){
				 toastr.success("更新成功");
			} else {
	            toastr.warning("更新失败");
			}
		})
	})
	function updateOrPay(obj){
		var orderItemList = [];
		var orderItem={};
		var order = {};
		for(var i= 0;i<$("[name=qty]").length;i++){
			orderItem = {};
			orderItem["id"]=$("[name=qty]").eq(i).attr("zid");
			orderItem["quantity"]=$("[name=qty]").eq(i).val();
	 		orderItem["productId"]=$("[name=qty]").eq(i).attr("zpid");
	 		orderItem["skuId"]=$("[name=qty]").eq(i).attr("sku");
	 		orderItem["optionValueKeyGroup"]=$("[name=qty]").eq(i).attr("group");
			orderItemList[i]=(orderItem);
		}
		order["orderItemList"]=orderItemList;
		$.ajax({
			type : "POST",
			contentType : 'application/json;charset=utf-8',
			url : "${pageContext.request.contextPath}/pc/account/item/update?${_csrf.parameterName}=${_csrf.token}",
			data: JSON.stringify(order),
			dataType : "json", //ajax返回值设置为text（json格式也可用它返回，可打印出结果，也可设置成json）  
			async : false,
			success : obj,
			error : function(json) {
				toastr.warning("更新失败");
			}
		});
	}
</script>
</html>