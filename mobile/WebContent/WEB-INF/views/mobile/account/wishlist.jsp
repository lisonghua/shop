<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="zh-cmn-Hans">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1,user-scalable=0">
<title>我的收藏</title>
<link rel="stylesheet" href="${root}/resources/mobile/weui.min.css" />
<link rel="stylesheet" href="${root}/resources/mobile/style.css" />
<link rel="stylesheet" href="${root}/resources/mobile/font-awesome.min.css">
</head>
<body>
	<div class="page js_show">
		<div class="weui-tab__panel" style='padding-bottom: 100px'>
			<div class="page__hd">
				<h1 class="page__title">我的收藏</h1>
			</div>
			<div class="weui-panel weui-panel_access">
				<c:if test="${empty wishlistPage.wishlist}">
					<div class="weui-panel__bd" style="text-align: center;">
						<h2 style="padding: 30px 0 30px 0">暂无数据！</h2>
					</div>
				</c:if>
				<c:if test="${not empty wishlistPage.wishlist}">
					<div id="wishlistDiv" class="weui-panel__bd">
						<c:forEach items="${wishlistPage.wishlist}" var="wishlistObj">
							<a href="${root}/mobile/product/${wishlistObj.product.id}" class="weui-media-box weui-media-box_appmsg">
								<div class="weui-media-box__hd">
									<img class="weui-media-box__thumb" src="${root}${wishlistObj.product.defaultImg}" >
								</div>
								<div class="weui-media-box__bd">
									<h4 class="weui-media-box__title">${wishlistObj.product.name}</h4>
									<p class="weui-media-box__desc">
										店内价格：
										<span style='color: green'>￥${wishlistObj.product.shopPrice / 100}元</span>
										市场价格：<del>￥${wishlistObj.product.price / 100}元</del>
									</p>
								</div>
							</a>
						</c:forEach>
					</div>
					<c:if test="${wishlistPage.totalPage != wishlistPage.currentPage}">
						<div id="loadMoreDiv" class="weui-panel__ft" onclick="loadMore()" >
							<a href="javascript:void(0);" class="weui-cell weui-cell_access weui-cell_link">
								<div class="weui-cell__bd">查看更多</div><span class="weui-cell__ft"></span>
								<input type="hidden" value="${wishlistPage.currentPage}" id="currentPage" />
								<input type="hidden" value="${wishlistPage.totalPage}" id="totalPage" />
							</a>
						</div>
					</c:if>
				</c:if>
			</div>
		</div>
	</div>
	<script src="${root}/resources/mobile/zepto.min.js"></script>
	<script src="${root}/resources/mobile/common.js"></script>
	<jsp:include page="../include/menu.jsp"></jsp:include>
	<jsp:include page="../include/message.jsp" />
	<script type="text/javascript">
		
		function loadMore() {
			var currentPage = Number($('#currentPage').val());
			$.ajax({
				type : "POST",
				url : '${root}' + '/mobile/account/wishlist/page?${_csrf.parameterName}=${_csrf.token}',
				data: {"currentPage": (currentPage + 1)},
				dataType : "json", //ajax返回值设置为text(json格式也可用它返回，可打印出结果，也可设置成json)  
				success : function(data) {
					if (data.success) {
						showMsg(data.message);
						return;
					}
					if (data.currentPage == data.totalPage) 
						$('#loadMoreDiv').remove();
					addMoreRow(data.wishlist);
					$('#currentPage').val(data.currentPage);
				},
				error : function(json) {
					showMsg('错误 请登录,只有登录后才能收藏!');
				}
			});
		}
		function addMoreRow(data) {
			for ( var i in data) {
				$('#wishlistDiv').append(
					'<a href="${root}/mobile/product/' + data[i].product.id + '" class="weui-media-box weui-media-box_appmsg">'+
					'    <div class="weui-media-box__hd">'+
					'        <img class="weui-media-box__thumb" src="${root}' + data[i].product.defaultImg + '">'+
					'    </div>'+
					'    <div class="weui-media-box__bd">'+
					'        <h4 class="weui-media-box__title">' + data[i].product.name + '</h4>'+
					'        <p class="weui-media-box__desc">'+
					'            店内价格：'+
					'            <span style="color: green">￥' + (data[i].product.price / 100) + '元</span>'+
					'            市场价格：'+
					'            <del>￥' + (data[i].product.shopPrice / 100) + '元</del>'+
					'        </p>'+
					'    </div>'+
					'</a>'
				);
			}
		}
		$(function() {
			//设置当前菜单高亮
			$('.weui-tabbar a').removeClass('weui-bar__item_on');
			$('#menu_user_center').addClass('weui-bar__item_on');
		});
	</script>
</body>
</html>