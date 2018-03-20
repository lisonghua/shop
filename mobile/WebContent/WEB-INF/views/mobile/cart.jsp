<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="zh-cmn-Hans">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1,user-scalable=0">
<title>我的购物车</title>
<link rel="stylesheet" href="${root}/resources/mobile/weui.min.css" />
<link rel="stylesheet" href="${root}/resources/mobile/style.css" />
<link rel="stylesheet" href="${root}/resources/mobile/font-awesome.min.css">

</head>
<body>
	<div class='container'>
		<div class="page tabbar js_show">
			<div class="page__bd" style="height: 100%;">
				<div class="weui-tab">
					<div class="weui-tab__panel" style='padding-bottom:100px'>
					
						<div class="page__hd">
					        <h1 class="page__title"><i class="fa fa-shopping-cart" aria-hidden="true"></i>我的购物车</h1>
					        <p class="page__desc">当前购物车：${empty cart?0:cart.orderItemList.size()}件商品 合计金额 ¥<fmt:formatNumber type="number" value="${cart.price/100}" pattern="0.00" maxFractionDigits="2"/>元</p>
					    </div>
						
						<!-- 循环购物车商品开始 -->
						<c:forEach items="${cart.orderItemList}" var="z" varStatus="s">
							<div class="weui-form-preview" style='margin-bottom:20px'>
								 <div class="weui-form-preview__bd">
					                <div class="weui-form-preview__item">
					                    <label class="weui-form-preview__label">商品名称</label>
					                    <em class="weui-form-preview__value"><a class='link' href='${root}/mobile/product/${z.productList[0].id}'>${z.productList[0].name}</a></em>
					                </div>
					                <div class="weui-form-preview__item">
					                    <label class="weui-form-preview__label">单价</label>
					                    <span class="weui-form-preview__value">¥<fmt:formatNumber type="number" value="${z.price/100}" pattern="0.00" maxFractionDigits="2"/></span>
					                </div>
					                <div class="weui-form-preview__item">
					                    <label class="weui-form-preview__label">数量</label>
					                    <span class="weui-form-preview__value">${z.quantity}</span>
					                </div>
					                <c:if test="${!empty z.jsonData}">
						                <div class="weui-form-preview__item">
						                    <label class="weui-form-preview__label">商品选项</label>
						                    <span class="weui-form-preview__value">${z.jsonData}</span>
						                </div>
					                </c:if>
						            <div class="weui-form-preview__ft">
						                <a class="weui-form-preview__btn weui-form-preview__btn_primary" zid="${z.id}" name="removeItem" href="javascript:">删除</a>
						            </div>
						        </div>
					       </div>
				        </c:forEach>
				        <!-- /循环购物车商品结束 -->
				        <c:if test="${!empty cart}">
				        	<c:if test="${cart.orderItemList.size()!=0}">
					        	<div class="page__bd page__bd_spacing">
							        <a href="javascript:void(0)" id="payCart" class="weui-btn weui-btn_primary">立即支付</a>
							        <a href="javascript:void(0);" id="removeCart" class="weui-btn weui-btn_warn">清空购物车</a>
						    	</div>	
					    	</c:if>
				        </c:if>
						
					</div>
	<script src="${root}/resources/mobile/zepto.min.js"></script>
	<script src="${root}/resources/mobile/common.js"></script>
					<jsp:include page="include/menu.jsp" />
					<jsp:include page="include/message.jsp" />
				</div>
			</div>
		</div>
	</div>
	<script>
    $(function(){
    	//设置当前菜单高亮
        $('.weui-tabbar a').removeClass('weui-bar__item_on');
        $('#menu_cart').addClass('weui-bar__item_on');
    });
    $("[name=removeItem]").bind('click', function() {
		var sumPrice = 0;
		var orderMap={};
		orderMap["id"] = $(this).attr("zid");
		var orderItem = {};
		orderItem["orderItem"] = orderMap;
		$.ajax({
			type : "POST",
			contentType : 'application/json;charset=utf-8',
			url : "${pageContext.request.contextPath}/mobile/cart/removeid?${_csrf.parameterName}=${_csrf.token}",
			data: JSON.stringify(orderItem),
			dataType : "json", //ajax返回值设置为text（json格式也可用它返回，可打印出结果，也可设置成json）  
			async : false,
			success : function(json) {
				if(json.errorCode=="0"){
					window.location.href="${pageContext.request.contextPath}/mobile/cart/item?${_csrf.parameterName}=${_csrf.token}";
				}else{
					showMsg("删除失败");
				}
			},
			error : function(json) {
				showMsg("删除失败");
			}
		});
	})
	$("#removeCart").bind('click', function() {
		$.ajax({
			type : "POST",
			url : "${pageContext.request.contextPath}/mobile/cart/removeall?${_csrf.parameterName}=${_csrf.token}",
			dataType : "json", //ajax返回值设置为text（json格式也可用它返回，可打印出结果，也可设置成json）  
			async : false,
			success : function(json) {
				window.location.href="${pageContext.request.contextPath}/mobile/cart/item?${_csrf.parameterName}=${_csrf.token}";
			},
			error : function(json) {
				showMsg("删除失败");
			}
		});
	});
	$("#payCart").bind('click', function() {
		window.location.href="${pageContext.request.contextPath}/mobile/payment?${_csrf.parameterName}=${_csrf.token}";
	})
	</script>
</body>
</html>
