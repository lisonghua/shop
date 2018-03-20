<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="zh-cmn-Hans">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1,user-scalable=0">
<title>支付</title>
<link rel="stylesheet" href="${root}/resources/mobile/weui.min.css" />
<link rel="stylesheet" href="${root}/resources/mobile/style.css" />
<link rel="stylesheet"
	href="${root}/resources/mobile/font-awesome.min.css">
</head>
<body>
	<div class='container'>
		<div class="page tabbar js_show">
			<div class="page__bd" style="height: 100%;">
				<div class="weui-tab">
					<div class="weui-tab__panel" style='padding-bottom: 100px'>

						<div class="page__hd">
							<h1 class="page__title">支付</h1>
							<p class="page__desc">当前支付：${payment.orderItemList.size()}件商品
								合计金额 ￥${payment.price/100}元</p>
						</div>
						<div class="weui-form-preview__bd">
							<div class="weui-form-preview__item">
								<label class="weui-form-preview__label">订单合计金额</label> <em
									class="weui-form-preview__value">￥${payment.price/100}元</em>
							</div>
						</div>
						<div class="weui-form-preview__bd">
							<c:forEach items="${payment.orderItemList}" var="z" varStatus="s">
								<div class="weui-form-preview__item">
									<label class="weui-form-preview__label">商品名称</label> <span
										class="weui-form-preview__value" style='font-size: 11px'>${z.productList[0].name}</span>
								</div>
								<div class="weui-form-preview__item">
									<label class="weui-form-preview__label">单价</label> <span
										class="weui-form-preview__value">￥${z.price/100}元</span>
								</div>
								<div class="weui-form-preview__item">
									<label class="weui-form-preview__label">数量</label> <span
										class="weui-form-preview__value">${z.quantity}</span>
								</div>
								<c:if test="${!empty z.jsonData}">
									<div class="weui-form-preview__item">
										<label class="weui-form-preview__label">商品选项</label> <span
											class="weui-form-preview__value">${z.jsonData}</span>
									</div>
								</c:if>
							</c:forEach>
						</div>
						<div class="weui-cells__title">
							<a href='javascript:;' class='link'>选择联系人</a>
						</div>
						<div class='weui-cells weui-cells_form'>
							<div class="weui-cell weui-cell_select">
								<div class="weui-cell__bd">
									<select id="contect" class="weui-select" name="select">
										<c:forEach items="${payment.contectList}" var="z"
											varStatus="s">
											<c:if test="${z.contactFlag==1}">
												<option selected="selected" value="${z.id}">${z.name}</option>
											</c:if>
											<c:if test="${z.contactFlag!=1}">
												<option value="${z.id}">${z.name}</option>
											</c:if>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
						<div class="weui-cells__title" style='text-align: right'>
							<!-- 		            		<a id='addContactButton' href='javascript:;' class='link'>新增联系人</a> -->
						</div>
						<div class='weui-cells weui-cells_form' style="display: none"
							id='contactForm'>
							<div class="weui-cell">
								<div class="weui-cell__hd">
									<label class="weui-label">联系人姓名</label>
								</div>
								<div class="weui-cell__bd">
									<input class="weui-input" type="text" placeholder="联系人姓名"
										maxlength="10">
								</div>
							</div>
							<div class="weui-cell">
								<div class="weui-cell__hd">
									<label class="weui-label">联系人电话</label>
								</div>
								<div class="weui-cell__bd">
									<input class="weui-input" type="tel" placeholder="联系人电话"
										maxlength="11">
								</div>
							</div>

							<div class="weui-cell">
								<div class="weui-cell__hd">
									<label class="weui-label">联系人地址</label>
								</div>
								<div class="weui-cell__bd">
									<input class="weui-input" type="tel" placeholder="联系人地址"
										maxlength="100">
								</div>
							</div>
							<div class="weui-cell">
								<a href="javascript:;"
									class="weui-btn weui-btn_mini weui-btn_default">保存联系人</a>
							</div>
						</div>

						<div class="weui-cells__title">
							<a href='javascript:;' class='link'>选择支付类型</a>
						</div>
						<div class='weui-cells weui-cells_form'>
							<div class="weui-cell weui-cell_select">
								<div class="weui-cell__bd">
									<select class="weui-select" name="select1">
										<option value="0">支付宝支付</option>
										<option value="1">微信支付</option>
										<option selected="selected" value="2">电子钱包支付</option>
									</select>
								</div>
							</div>
						</div>



						<div class="page__bd page__bd_spacing" style='margin-top: 20px'>
							<a href="javascript:;" class="weui-btn weui-btn_primary">立即支付</a>
						</div>

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
		$(function() {
			$('#addContactButton').on('click', function() {
				$('#contactForm').show();
			});
		});
		$(".weui-btn_primary")
				.on(
						"click",
						function() {
							//收集联系人数据 
							var contectVal = $('[name=select1]').val();
							var payVal = $('[name=select]').val();
							var orderItem = {};
							var order = {};
							var contect = {};
							contect["id"] = payVal;
							//支付类型
							contect["paymentType"] = contectVal;
							order["contect"] = contect;
							$
									.ajax({
										type : "POST",
										contentType : 'application/json;charset=utf-8',
										url : "${pageContext.request.contextPath}/mobile/pay/ewallet?total_price=${payment.price/100}",
										data : JSON.stringify(order),
										dataType : "json", //ajax返回值设置为text（json格式也可用它返回，可打印出结果，也可设置成json）  
										async : false,
										success : function(json) {
											//errorCode为0则为成功
											if (json.errorCode == 0) {
												showMsg("支付成功，2秒钟后跳转到订单历史");
												setTimeout(
														function() {
															window.location.href = "${pageContext.request.contextPath}/mobile/account/order/list?${_csrf.parameterName}=${_csrf.token}";
														}, 2000);
											} else {
												showMsg("电子钱包余额不足,支付失败！");
											}
										},
										error : function(json) {
											showMsg("支付失败");
										}
									});
						})
	</script>
</body>
</html>
