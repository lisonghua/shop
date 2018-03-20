<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<spring:url value="/resources/pc/image" var="image" />
<spring:url value="/resources/pc/assets/css" var="css" />
<spring:url value="/resources/pc/assets/js" var="js" />

<c:set var="root" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<!--[if IE 8]><html class="ie ie8"><![endif]-->
<!--[if IE 9]><html class="ie ie9"><![endif]-->
<!--[if gte IE 9]><!-->
<html>
<!--<![endif]-->
<head>
<meta charset="utf-8" />
<title>SHOP</title>

<jsp:include page="include/top.jsp"></jsp:include>

</head>
<body class="smoothscroll enable-animation">
	<!-- wrapper -->
	<div id="wrapper">
		<jsp:include page="include/head.jsp"></jsp:include>
		<section>
			<div class="container">
				<div id='page'></div>
				<div class='row'>
				<div class='col-lg-9 col-md-9 col-sm-9 col-lg-push-3 col-md-push-3 col-sm-push-3'>
				<c:forEach var="category" items="${categoryRelationList}">${category.name}
					<div class="divider divider-border divider-center"><!-- divider -->
						<i class="fa fa-users"></i>
					</div>
					<ul class="shop-item-list row list-inline nomargin">
					<c:forEach var="product" items="${category.productRelationList}">
						<!-- 产品-->
						<li class="col-lg-3 col-sm-3">
							<div class="shop-item">
								<div class="thumbnail">
									<!-- product image(s) -->
									<a class="shop-item-image" href="${root}/pc/product/${product.id}">
										<img class="img-responsive" src="/Shopping${product.defaultImg}"/>
									</a>
									<!-- /product image(s) -->
									<!-- hover buttons -->
									<div class="shop-option-over">
										<a class="btn btn-default add-wishlist" onclick="addWishlist(this)" href="javascript:void(0);" data-item-id="1" data-toggle="tooltip" title="添加收藏">
											<input type="hidden" name="productId" value="${product.id}" >
											<i class="fa fa-heart nopadding"></i>
										</a>
									</div>
									<!-- /hover buttons -->
									<!-- product more info -->
									<div class="shop-item-info">
									</div>
									<!-- /product more info -->
								</div>
								<div class="shop-item-summary text-center">
									<h2>${product.name}</h2>
									<!-- price -->
									<div class="shop-item-price">
										<span class="line-through">￥${product.price / 100}</span>￥${product.shopPrice / 100}
									</div>
									<!-- /price -->
								</div>
								<!-- /buttons -->
							</div>
						</li>
						<!-- /产品 -->
						</c:forEach>
					</ul>
					</c:forEach>
					<hr />
					<!-- Pagination Default -->
					<div name="bootpagFooter" class="text-center"></div>
					<!-- /Pagination Default -->
				</div>
				
				<div class="col-lg-3 col-md-3 col-sm-3 col-lg-pull-9 col-md-pull-9 col-sm-pull-9">

							<!-- CATEGORIES -->
							<div class="side-nav margin-bottom-60">
								<div class="side-nav-head">
									<button class="fa fa-bars"></button>
									<h4>分类</h4>
								</div>
								<ul class="list-group list-group-bordered list-group-noicon uppercase">
									<c:forEach var="categoryInfo" varStatus="status" items="${categoryList}">
										<c:if test="${status.index < 15}">
											<li class="list-group-item"><a href="${root}/pc/category/${categoryInfo.id}/page/1" ><span class="size-11 text-muted pull-right"></span>${categoryInfo.name}</a></li>
										</c:if>
									</c:forEach>
									<c:if test="${fn:length(categoryList) >= 15}">
										<li class="list-group-item">
											<a href="${root}/pc/category/category" >
												<span class="size-11 text-muted pull-right"></span>
												查看更多分类 >>
											</a>
										</li>
									</c:if>
								</ul>
							</div>
							
							<!-- /CATEGORIES -->
							
						</div>
				</div>
			</div>
		</section>
		<!-- / -->
		<jsp:include page="include/footer.jsp"></jsp:include>
	</div>
	<!-- /wrapper -->
	<script type="text/javascript">
		function addWishlist(dom) {
			var productId = Number($(dom).find('input[name="productId"]').val());
			$.ajax({
				type : "POST",
				url : '${root}' + '/pc/account/wishlist/add?${_csrf.parameterName}=${_csrf.token}',
				data : {
					"productId" : productId
				},
				dataType : "json", //ajax返回值设置为text(json格式也可用它返回，可打印出结果，也可设置成json)  
				success : function(data) {
					if (data.success) {
			            toastr.success(data.message);
					} else {
			            toastr.warning(data.message);
					}
				},
				error : function(json) {
		            toastr.error('错误 请登录,只有登录后才能收藏!');
				}
			});
		}
	</script>
</body>
</html>