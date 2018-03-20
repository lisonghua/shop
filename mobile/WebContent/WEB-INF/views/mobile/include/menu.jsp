<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<style type="text/css">
.cornerMark {
	display: inline-block;
	padding: 0.1rem 0.25rem 0.14rem 0.30rem;
	font-size: 0.6rem;
	line-height: 1;
	color: #ffffff;
	background-color: rgba(239, 28, 16, 0.7);
	border-radius: 5rem;
	position: absolute;
	margin-left: 1rem;
}
/* #EF1C10 */
</style>
<div class="weui-tabbar">
	<a href="${root}/mobile/index" class="weui-tabbar__item" id='menu_index'>
		<i class="fa fa-home weui-tabbar__icon" aria-hidden="true"></i>
		<p class="weui-tabbar__label">首页</p>
	</a>
	<a href="${root}/mobile/cart/item" class="weui-tabbar__item" id='menu_cart'>
		<span id="cartCount" class="cornerMark"></span>
		<i class="fa fa-shopping-cart weui-tabbar__icon " aria-hidden="true"></i>
		<p class="weui-tabbar__label">购物车</p>
	</a>
	<a href="${root}/mobile/account/center" class="weui-tabbar__item" id='menu_user_center'>
		<i class="fa fa-user weui-tabbar__icon" aria-hidden="true"></i>
		<p class="weui-tabbar__label">会员中心</p>
	</a>
</div>
<script type="text/javascript">
function loadCartCount() {
	var cartCount = 0;
	$.ajax({
		type : "POST",
		url : '${root}'+'/mobile/cart/count'+'?${_csrf.parameterName}=${_csrf.token}',
		dataType : "json", //ajax返回值设置为text（json格式也可用它返回，可打印出结果，也可设置成json）  
		async : false,
		success : function(json) {
			if (json.data == 0 || json.data == null) {
				$('#cartCount').hide();
			} else {
				$('#cartCount').html('').html(json.data);
				cartCount = json.data;
			}
		}
	});
	return cartCount;
}
$(loadCartCount);
</script>