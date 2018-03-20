<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="zh-cmn-Hans">

<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1,user-scalable=0">
<title>分类</title>
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
						<div class="page__hd">
							<h1 class="page__title">检索关键字:"${keyword}"</h1>
						</div>
						<!-- 搜索 -->
						<div class="weui-search-bar" id="searchBar">
							<form id="searchForm" action="${root}/mobile/product/search" onsubmit="return searchKeyword();" method="get"  class="weui-search-bar__form">
								<div class="weui-search-bar__box">
									<i class="weui-icon-search"></i>
									<input type="text" value="${keyword}" class="weui-search-bar__input" id="searchInput" placeholder="搜索"">
									<input type="hidden" id="encodeKeyword" name="keyword">
									<a href="javascript:" class="weui-icon-clear" id="searchClear"></a>
								</div>
								<label class="weui-search-bar__label" id="searchText" style="transform-origin: 0px 0px 0px; opacity: 1; transform: scale(1, 1);">
									<i class="weui-icon-search"></i> <span>搜索</span>
								</label>
							</form>
							<a href="javascript:" class="weui-search-bar__cancel-btn" id="searchCancel">取消</a>
						</div>
						<div class='weui-panel weui-panel_access'>
							<div class="weui-panel__bd" id="wishlistDiv">
								<c:forEach var="product" items="${productListPage.productList}">
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
								</c:forEach>
							</div>
							<div class="weui-panel__ft" id="loadMoreDiv" onclick="loadMore()">
								<a href="javascript:void(0);" class="weui-cell weui-cell_access weui-cell_link">
									<div class="weui-cell__bd">查看更多</div><span class="weui-cell__ft"></span>
									<input type="hidden" value="${productListPage.currentPage}" id="currentPage" />
									<input type="hidden" value="${productListPage.totalPage}" id="totalPage" />
								</a>
							</div>
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
		
		function loadMore() {
			var currentPage = Number($('#currentPage').val());
			$.ajax({
				type : "POST",
				url : '${root}' + '/mobile/product/search/page?${_csrf.parameterName}=${_csrf.token}',
				data: {"currentPage": (currentPage + 1), "keyword": '${keyword}'},
				dataType : "json", //ajax返回值设置为text(json格式也可用它返回，可打印出结果，也可设置成json)  
				success : function(data) {
					if (data.currentPage == data.totalPage) 
						$('#loadMoreDiv').remove();
					addMoreRow(data.productList);
					$('#currentPage').val(data.currentPage);
				}
			});
		}
		function addMoreRow(data) {
			for ( var i in data) {
				$('#wishlistDiv').append(
					'<a href="${root}/mobile/product/' + data[i].id + '" class="weui-media-box weui-media-box_appmsg">'+
					'    <div class="weui-media-box__hd">'+
					'        <img class="weui-media-box__thumb" src="/Shopping' + data[i].defaultImg + '" />'+
					'    </div>'+
					'    <div class="weui-media-box__bd">'+
					'        <h4 class="weui-media-box__title">' + data[i].name + '</h4>'+
					'        <p class="weui-media-box__desc">'+
					'            店面价格<strong class="link">￥' + (data[i].price / 100) + '</strong>'+
					'            市场价格<del>￥' + (data[i].shopPrice / 100) + '</del>'+
					'        </p>'+
					'    </div>'+
					'</a>'
				);
			}
		}
		$(function() {
			if ($('#currentPage').val() == $('#totalPage').val()) {
				$('#loadMoreDiv').remove();
			}
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
