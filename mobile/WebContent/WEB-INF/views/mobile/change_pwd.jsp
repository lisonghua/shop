<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="zh-cmn-Hans">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1,user-scalable=0">
<title>重置密码</title>
<link rel="stylesheet" href="${root}/resources/weui.min.css" />
<link rel="stylesheet" href="${root}/resources/style.css" />
<link rel="stylesheet" href="${root}/resources/font-awesome.min.css">
</head>
<body>

	<div class="page js_show">
		<div class="page__hd">
			<h1 class="page__title">重置密码</h1>
			<p class="page__desc">请牢记您重置的密码！</p>
		</div>
		<div class="weui-cells weui-cells_form">


			<div class="weui-cell">
				<div class="weui-cell__hd">
					<label class="weui-label">密码</label>
				</div>
				<div class="weui-cell__bd">
					<input class="weui-input" type="password" placeholder="输入密码">
				</div>
			</div>

			<div class="weui-cell">
				<div class="weui-cell__hd">
					<label class="weui-label">确认密码</label>
				</div>
				<div class="weui-cell__bd">
					<input class="weui-input" type="password" placeholder="确认密码">
				</div>
			</div>
		</div>

		<div class="weui-btn-area">
			<a class="weui-btn weui-btn_primary" href="#">重置密码</a>
		</div>
	<script src="${root}/resources/zepto.min.js"></script>
		<jsp:include page="include/menu.jsp"></jsp:include>
	</div>
</body>
</html>
