<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="zh-cmn-Hans">

<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1,user-scalable=0">
<title>首页</title>
<link rel="stylesheet" href="${root}/resources/mobile/weui.min.css" />
<link rel="stylesheet" href="${root}/resources/mobile/style.css" />
<link rel="stylesheet" href="${root}/resources/mobile/font-awesome.min.css">
</head>

<body>
	<div class='container'>
		<div class="page tabbar js_show">
			<div class="page__bd" style="height: 100%;">
				<div class="weui-tab">
					<div class="weui-tab__panel" style='padding-bottom: 100px'>
						<!-- 搜索 -->
						<div class="weui-search-bar" id="searchBar">
							<form id="searchForm" action="${root}/mobile/product/search" onsubmit="return searchKeyword();" method="get"  class="weui-search-bar__form">
								<div class="weui-search-bar__box">
									<i class="weui-icon-search"></i>
									<input type="text" class="weui-search-bar__input" id="searchInput" placeholder="搜索"">
									<input type="hidden" id="encodeKeyword" name="keyword">
									<a href="javascript:" class="weui-icon-clear" id="searchClear"></a>
								</div>
								<label class="weui-search-bar__label" id="searchText"
									style="transform-origin: 0px 0px 0px; opacity: 1; transform: scale(1, 1);">
									<i class="weui-icon-search"></i> <span>搜索</span>
								</label>
							</form>
							<a href="javascript:" class="weui-search-bar__cancel-btn" id="searchCancel">取消</a>
						</div>
						<c:forEach var="category" items="${categoryList}">
							<!-- 分类开始 -->
							<div class='weui-panel weui-panel_access'>
								<div class="weui-panel__hd">${category.name}</div>
								<c:forEach var="product" items="${category.productRelationList}">
									<div class="weui-panel__bd">
										<a href="${root}/mobile/product/${product.id}" class="weui-media-box weui-media-box_appmsg">
											<div class="weui-media-box__hd">
												<img class="weui-media-box__thumb" src='/Shopping${product.defaultImg}' />
											</div>
											<div class="weui-media-box__bd">
												<h4 class="weui-media-box__title">${product.name}</h4>
												<p class="weui-media-box__desc">
													店面价格 <strong class='link'>￥${product.shopPrice / 100}</strong>
													市场价格 <del>￥${product.price / 100}</del>
												</p>
											</div>
										</a>
									</div>
								</c:forEach>
								<div class="weui-panel__ft">
									<a href="${root}/mobile/category/${category.id}" class="weui-cell weui-cell_access weui-cell_link">
										<div class="weui-cell__bd">查看更多</div><span class="weui-cell__ft"></span>
									</a>
								</div>
							</div>
							<!-- /分类结束 -->
						</c:forEach>
					</div>>
					<script src="${root}/resources/mobile/zepto.min.js"></script>
					<script src="${root}/resources/mobile/common.js"></script>
					<jsp:include page="include/menu.jsp" />
					<jsp:include page="include/message.jsp" />
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
	function searchKeyword() {
		if ($.trim($('#searchInput').val()).length == 0) {
			showMsg("请输入查询关键字!");
			return false;
		}
		var keyword = $.trim($('#searchInput').val());
		keyword = encodeURI(keyword);
		$('#encodeKeyword').val(keyword);
		return true;
	}
		$(function() {
			var $searchBar = $('#searchBar'), $searchResult = $('#searchResult'), $searchText = $('#searchText'), $searchInput = $('#searchInput'), $searchClear = $('#searchClear'), $searchCancel = $('#searchCancel');

			function hideSearchResult() {
				$searchResult.hide();
				$searchInput.val('');
			}
			function cancelSearch() {
				hideSearchResult();
				$searchBar.removeClass('weui-search-bar_focusing');
				$searchText.show();
			}

			$searchText.on('click', function() {
				$searchBar.addClass('weui-search-bar_focusing');
				$searchInput.focus();
			});
			$searchInput.on('blur', function() {
				if (!this.value.length)
					cancelSearch();
			}).on('input', function() {
				if (this.value.length) {
					$searchResult.show();
				} else {
					$searchResult.hide();
				}
			});
			$searchClear.on('click', function() {
				hideSearchResult();
				$searchInput.focus();
			});
			$searchCancel.on('click', function() {
				cancelSearch();
				$searchInput.blur();
			});

			//设置当前菜单高亮
			$('.weui-tabbar a').removeClass('weui-bar__item_on');
			$('#menu_index').addClass('weui-bar__item_on');
		});
	</script>
</body>

</html>
