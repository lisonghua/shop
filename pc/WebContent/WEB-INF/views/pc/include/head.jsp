<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!-- Top Bar -->
<div id="topBar">
	<div class="container">
		<!-- rightttt -->
		<ul class="top-links list-inline pull-right">
			<li class="text-welcome hidden-xs">${userid==null?"":"欢迎 "}<strong>${nickname==null?username:nickname}</strong></li>
			<li><c:if test="${userid!=null}">
					<a class="dropdown-toggle no-text-underline"
						data-toggle="dropdown" href="#"><i class="fa fa-user hidden-xs"></i>
							会员中心</a>
			    </c:if>
				<ul class="dropdown-menu pull-right">
					<li><a tabindex="-1" href="${root}/pc/account/order/list"><i class="fa fa-history"></i>订单历史</a></li>
					<li class="divider"></li>
					<li><a tabindex="-1" href="${root}/pc/account/wishlist/page/1"><i class="fa fa-bookmark"></i>收藏夹</a></li>
					<li><a tabindex="-1" href="${root}/pc/account/contact/list"><i class="fa fa-edit"></i>常用联系人</a></li>
					<li><a tabindex="-1" href="${root}/pc/account/user_setting"><i class="fa fa-cog"></i>个人设置</a></li>
					<li><a tabindex="-1" href="${root}/pc/account/ewallet"><i class="fa fa-cog"></i>充值</a></li>
					<li class="divider"></li>  
					<li><a tabindex="-1" href="${root}/pc/logout"><i class="glyphicon glyphicon-off"></i>退出</a></li>
				</ul></li>
			<c:if test="${username==null}">
				<li class="hidden-xs"><a class='sysBuilding' href="${root}/pc/register">注册</a></li>
				<li class="hidden-xs"><a class='sysBuilding'
					href="${root}/pc/login">登录</a></li>
			</c:if>
		</ul>
	</div>
</div>
<!-- /Top Bar -->

<div id="header" class="sticky clearfix">
	<!-- TOP NAV -->
	<header id="topNav">
		<div class="container">

			<!-- Mobile Menu Button -->
			<button class="btn btn-mobile" data-toggle="collapse"
				data-target=".nav-main-collapse">
				<i class="fa fa-bars"></i>
			</button>

			<!-- BUTTONS -->
			<ul class="pull-right nav nav-pills nav-second-main">

				<!-- QUICK SHOP CART -->
				<li class="quick-cart"><a href="javascript:void(0)"> <span
						id="cartItems" class="badge badge-aqua btn-xs badge-corner"></span>
						<c:if test="${userid!=null}">
							<i class="fa fa-shopping-cart"></i>
						</c:if>
				</a>
					<div class="quick-cart-box">
						<h4>购物车</h4>
						<div id="divCart" class="quick-cart-wrapper">
							<a id="cartnoitems" class="text-center" href="javascript:void(0)"
								style="display: none">
								<h6>0 ITEMS ON YOUR CART</h6>
							</a>
						</div>
						<!-- quick cart footer -->
						<div class="quick-cart-footer clearfix">
							<a href="${pageContext.request.contextPath}/pc/cart/item"
								class="btn btn-primary btn-xs pull-right">VIEW CART</a> <span
								id="sumprice" class="pull-left"></span>
						</div>
						<!-- /quick cart footer -->
					</div></li>
				<!-- /QUICK SHOP CART -->
			</ul>
			<div class='row'>
				<div class='col-lg-3 col-sm-3'>
					<a class="logo pull-left" href="${root}/pc/index"> <img
						src="${root}/resources/pc/assets/images/logo.gif" />
					</a>
				</div>
				<div class='col-lg-6 col-sm-6' style='padding-top: 30px'>

					<div class="search-box" style="display: block;">
						<form id='searchForm'
							onkeydown="if(event.keyCode==13)return false;"
							action="${root}/pc/search/page/1" method="get">
							<div class="input-group">
								<input type="text" id='keyword' placeholder="请输入查询关键字"
									class="form-control"> <input type='hidden'
									name='keyword' value="${keyword}" id='encodeKeyword'> <span
									class="input-group-btn">
									<button id="searchButton" class="btn btn-primary" type="button">搜索</button>
								</span>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</header>
<%-- 	<script src="${root}/resources/pc/assets/js/jquery.js"></script> --%>
	<script src="${root}/resources/pc/assets/js/common.js"></script>
	<!-- /Top Nav -->
	<script type="text/javascript">
		$(document).ready(function() {
			getCartCount("${root}", "?${_csrf.parameterName}=${_csrf.token}");
			jQuery('li.quick-cart>a') .click(function(e) {
				e.preventDefault();
				var _quick_cart_box = jQuery('li.quick-cart div.quick-cart-box');
				if (_quick_cart_box.is(":visible")) {
					_quick_cart_box.fadeOut(300);
				} else {
					_quick_cart_box.fadeIn(300);
					divCart("${root}","?${_csrf.parameterName}=${_csrf.token}");
				}
			});
			$('#searchButton').click(function() {
				if ($.trim($('#keyword').val()).length == 0) {
					toastr.warning("请输入查询关键字!");
					return false;
				}
				var keyword = $.trim($('#keyword').val());
				keyword = encodeURI(keyword);
				$('#encodeKeyword').val(keyword);
				$('#searchForm').submit();
			});
		});
	</script>
</div>