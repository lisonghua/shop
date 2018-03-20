<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="zh-cmn-Hans">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1,user-scalable=0">
<title>电子钱包充值</title>
<link rel="stylesheet" href="${root}/resources/mobile/weui.min.css" />
<link rel="stylesheet" href="${root}/resources/mobile/style.css" />
<link rel="stylesheet"
	href="${root}/resources/mobile/font-awesome.min.css">
</head>
<body>
	<div class="page js_show">
		<div class="page__hd">
			<h1 class="page__title">电子钱包充值</h1>
		</div>
		<div class="weui-panel__bd" style="text-align: center;">
						<h2 style="padding: 30px 0 30px 0">当前电子钱包账户余额为：${userAccount.amount }</h2>
					</div>
		<form id="form_account" name="form_account" method="post"
			action="${pageContext.request.contextPath}/contect/add">
			<div class="weui-cells weui-cells_form">
			<div class="weui-panel__hd">电子钱包充值</div>
				<div class="weui-cell">
					<input type="hidden" name="id">
					<div class="weui-cell__hd">
						<label class="weui-label">充值金额 </label>
					</div>
					<div class="weui-cell__bd">
						<input class="weui-input" maxlength="50" name="account"
							type="text" placeholder="请输入充值金额">
					</div>
					<div class="erro"></div>
				</div>
			</div>
		</form>
		<div class="weui-btn-area" style='margin-bottom: 20px'>
			<a id="save" class="weui-btn weui-btn_primary"
				href="javascript:valdate()">保存</a>
		</div>
		<div class="weui-form-preview" style="margin-bottom: 80px;"></div>
	</div>
	<script src="${root}/resources/mobile/zepto.min.js"></script>
	<script src="${root}/resources/mobile/common.js"></script>
	<jsp:include page="../include/menu.jsp"></jsp:include>
	<jsp:include page="../include/message.jsp" />
	<script>
		$(function() {
			//设置当前菜单高亮
			$('.weui-tabbar a').removeClass('weui-bar__item_on');
			$('#menu_user_center').addClass('weui-bar__item_on');
		});
		//校验input;
		function valdate() {
			var rechargeNum = $(".weui-input").val();
			$(".erro").text("");
			var idx = 0;
			for (var i = 0; i < $(".weui-input").length; i++) {
				if ($(".weui-input").eq(i).val().trim() == "") {
					$(".erro").eq(i).text("此项为必填项");
					idx = 1;
				} else {
					if (i == 1) {
						var mobile = /^(13[0-9]{9})|(18[0-9]{9})|(14[0-9]{9})|(17[0-9]{9})|(15[0-9]{9})$/;
						if (!mobile.test($(".weui-input").eq(i).val())
								|| $(".weui-input").eq(i).val().length != 11) {
							$(".erro").eq(i).text("请输入充值金额");
							idx = 1;
						}
					}
				}
			}
			//校验flg
			if (idx == 1) {
				return false;
			}else{
				$.ajax({
					type : "POST",
					contentType : 'application/json;charset=utf-8',
					url : "${pageContext.request.contextPath}/mobile/account/recharge?rechargeNum="+rechargeNum,
					data : $(".weui-input").val(),
					dataType : "json", //ajax返回值设置为text（json格式也可用它返回，可打印出结果，也可设置成json）  
					async : false,
					success : function(json) {
						//errorCode为0则为成功
						if (json.errorCode == 0) {
							showMsg("充值成功！");
							setTimeout(
									function() {
										window.location.href = "${pageContext.request.contextPath}/mobile/account/ewallet";
									}, 2000);
						} else {
							showMsg("充值失败！");
						}
					},
					error : function(json) {
						showMsg("充值失败");
					}
				});
			}
		}
	</script>
</body>

</html>
