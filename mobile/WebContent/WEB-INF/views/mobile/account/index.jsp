<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="zh-cmn-Hans">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1,user-scalable=0">
<title>会员中心</title>
<link rel="stylesheet" href="${root}/resources/mobile/weui.min.css" />
<link rel="stylesheet" href="${root}/resources/mobile/style.css" />
<link rel="stylesheet" href="${root}/resources/mobile/font-awesome.min.css">
</head>
<body>

	<div class="page js_show">
		<div class="page__hd">
			<h1 class="page__title">会员中心</h1>
		</div>
		
		<div class="weui-grids">
        <a href="<c:url value='/mobile/account/order/list'/>" class="weui-grid">
            <div class="weui-grid__icon">
                <img src="${root}/resources/mobile/image/Shopping-bag-3@3x.png" alt="">
            </div>
            <p class="weui-grid__label">订单历史</p>
        </a>
        <a href="<c:url value='/mobile/account/contact/list'/>" class="weui-grid">
            <div class="weui-grid__icon">
                <img src="${root}/resources/mobile/image/User-V@3x.png" alt="">
            </div>
            <p class="weui-grid__label">常用联系人</p>
        </a>
        <a href="<c:url value='/mobile/account/wishlist/page/1'/>" class="weui-grid">
            <div class="weui-grid__icon">
                <img src="${root}/resources/mobile/image/Tag-2@3x.png" alt="">
            </div>
            <p class="weui-grid__label">我的收藏</p>
        </a>
        <a href="<c:url value='/mobile/account/user_setting'/>" class="weui-grid">
            <div class="weui-grid__icon">
                <img src="${root}/resources/mobile/image/Settings-3@3x.png" alt="">
            </div>
            <p class="weui-grid__label">会员设置</p>
        </a>
        <a href="<c:url value='/mobile/account/ewallet'/>" class="weui-grid">
            <div class="weui-grid__icon">
                <img src="${root}/resources/mobile/image/Settings-3@3x.png" alt="">
            </div>
            <p class="weui-grid__label">电子钱包充值</p>
        </a>
        <a href="${root}/mobile/logout" class="weui-grid">
            <div class="weui-grid__icon">
                
                <img src="${root}/resources/mobile/image/Lock-square@3x.png" alt="">
            </div>
            <p class="weui-grid__label">退出</p>
        </a>
        <a href="javascript:;" class="weui-grid">
            <div class="weui-grid__icon">
                
            </div>
            <p class="weui-grid__label">&nbsp;</p>
        </a>
        <a href="javascript:;" class="weui-grid">
            <div class="weui-grid__icon">
                
            </div>
            <p class="weui-grid__label">&nbsp;</p>
        </a>
        <a href="javascript:;" class="weui-grid">
            <div class="weui-grid__icon">
            </div>
            <p class="weui-grid__label">&nbsp;</p>
        </a>
        <a href="javascript:;" class="weui-grid">
            <div class="weui-grid__icon">
            </div>
            <p class="weui-grid__label">&nbsp;</p>
        </a>
    </div>
		
	<script src="${root}/resources/mobile/zepto.min.js"></script>
	<jsp:include page="../include/menu.jsp"></jsp:include>
	</div>
	<script>
	 $(function(){
	    	//设置当前菜单高亮
	        $('.weui-tabbar a').removeClass('weui-bar__item_on');
	        $('#menu_user_center').addClass('weui-bar__item_on');
	    });
	</script>
</body>
</html>
