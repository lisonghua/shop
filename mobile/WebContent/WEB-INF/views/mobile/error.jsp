<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="zh-cmn-Hans">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1,user-scalable=0">
<title>错误</title>
<link rel="stylesheet" href="${root}/resources/mobile/weui.min.css" />
<link rel="stylesheet" href="${root}/resources/mobile/style.css" />
<link rel="stylesheet" href="${root}/resources/mobile/font-awesome.min.css">
</head>
<body>

	<div class="page js_show">
		<div class="page__hd">
        <h1 class="page__title">温馨提示</h1>
    </div>
    	
    	<div class="weui-cells__title" style='color:red'>
    		该版本不支持此功能
    	</div>
		
	<script src="${root}/resources/mobile/zepto.min.js"></script>
		<jsp:include page="include/menu.jsp"/>
	</div>
	
	
</body>
</html>
