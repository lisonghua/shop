<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="zh-cmn-Hans">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1,user-scalable=0">
<title>密码修改成功</title>
<link rel="stylesheet" href="${root}/resources/weui.min.css" />
<link rel="stylesheet" href="${root}/resources/style.css" />
<link rel="stylesheet" href="${root}/resources/font-awesome.min.css">
</head>
<body>

	<div class="page js_show">
		<div class="page__hd">
        <h1 class="page__title">密码修改成功</h1>
        <p class="page__desc" id='smsMsgBox'>点击下列登录按钮登录商城</p>
    </div>
    	<div class="weui-btn-area">
			<a class="weui-btn weui-btn_default" href="<c:url value="/login" />" id="showTooltips">用户登录</a>
		</div>
	<script src="${root}/resources/zepto.min.js"></script>
		<jsp:include page="include/menu.jsp"></jsp:include>
	</div>
</body>
</html>
