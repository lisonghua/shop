<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<spring:url value="/resources/pc/image" var="image" />
<spring:url value="/resources/pc/assets/css" var="css" />
<spring:url value="/resources/pc/assets/js" var="js" />
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<!--[if IE 8]>			<html class="ie ie8"> <![endif]-->
<!--[if IE 9]>			<html class="ie ie9"> <![endif]-->
<!--[if gt IE 9]><!-->
<html>
<!--<![endif]-->

<head>
<meta charset="utf-8" />
<title>SHOP</title>
<jsp:include page="include/top.jsp"></jsp:include>
<link href="${css}/swiper.min.css" rel="stylesheet" />
</head>
<style>
.optionGroup {
	padding: 10px;
}

.option {
	padding: 4px;
	border: 1px solid #8ab933;
	border-radius: 3px;
	display: none;
}

.optionSelected {
	background-color: #8ab933;
	color: #fff;
}

.quantityBox>.input-group {
	width: 100px;
}

.swiper-slide {
	background-position: center;
	background-size: cover;
	width: 300px;
	height: 300px;
}

.swiper-container {
	width: 300px;
	height: 300px;
}
</style>
<body class="smoothscroll enable-animation">
	<!-- wrapper -->
	<div id="wrapper">
		<jsp:include page="include/head.jsp"></jsp:include>
		<section class="page-header page-header-xs">
			<div class="container">
				<h1>${productDetails.name}</h1>
			</div>
		</section>
		<!-- /PAGE HEADER -->
		<!-- -->
		<section>
			<div class="container">
				<div class="row">
					<!-- RIGHT -->
					<div class="col-lg-9 col-md-9 col-sm-9">
						<div class="row">
							<!-- IMAGE -->
							<div class="col-lg-6 col-sm-6">
								<div class="thumbnail relative margin-bottom-3">
									<figure id="zoom-primary" class="zoom" data-mode="mouseover">
										<div class="swiper-container swiper-container-horizontal"
											data-space-between='10'>
											<div class="swiper-wrapper">
												<div class="swiper-slide">
													<img src="/Shopping${productDetails.defaultImg}" />
												</div>
												<c:if
													test="${fn:length(productDetails.productImageList) != 0}">
													<c:forEach var="productImage"
														items="${productDetails.productImageList}">
														<div class="swiper-slide">
															<img src="/Shopping${productImage.url}" />
														</div>
													</c:forEach>
												</c:if>
											</div>
											<div class="swiper-pagination"></div>
										</div>
									</figure>
								</div>
								<!-- Thumbnails (required height:100px) -->
								<div data-for="zoom-primary"
									class="zoom-more owl-carousel owl-padding-3 featured"
									data-plugin-options='{"singleItem": false, "autoPlay": false, "navigation": true, "pagination": false}'></div>
								<!-- /Thumbnails -->
							</div>
							<!-- /IMAGE -->
							<!-- ITEM DESC -->
							<div class="col-lg-6 col-sm-6">
								<!-- buttons -->
								<div class="pull-right">
									<!-- replace data-item-id width the real item ID - used by js/view/demo.shop.js -->
									<a class="btn btn-default add-wishlist sysBuilding"
										href="javascript:void(0);" onclick="addWishlist(this)"
										data-item-id="1" data-toggle="tooltip" title="添加收藏"><i
										class="fa fa-heart nopadding"></i><input name="productId"
										type="hidden" value="${productDetails.id}"> </a>
								</div>
								<!-- /buttons -->
								<!-- price -->
								<div class="shop-item-price">
									<span class="line-through nopadding-left"> 市场价:￥<font
										id="price">${productDetails.price / 100}</font>
									</span>￥<font id="shopPrice">${productDetails.shopPrice / 100}</font>
									<input id="submitPrice" type="hidden"
										value="${productDetails.shopPrice}"> <input
										id="submitOptionValueKeyGroup" type="hidden">
								</div>
								<!-- /price -->
								<hr />
								<div class="clearfix margin-bottom-30">
									<span id="inStock" style="display: none;"
										class="pull-right text-success"><i class="fa fa-check"></i>有货</span>
									<span id="outOfStock" style="display: none;"
										class="pull-right text-danger"><i
										class="glyphicon glyphicon-remove"></i>无货</span> <strong>商品简介:</strong>
								</div>
								<!-- short description -->
								<p>${productDetails.generalExplain}</p>
								<!-- /short description -->
								<!-- countdown -->

								<!-- display option -->
								<c:if test="${optionList!=null && fn:length(optionList) > 0}">
									<div class="text-center" id="">
										<h5>请选择购买商品选项</h5>
										<c:forEach var="option" items="${optionList}">
											<div class='optionGroup' option>
												${option.name}：
												<c:forEach var="optionValues"
													items="${option.optionValuesList}">
													<span optionId="${option.id}"
														optionValueId='${optionValues.id}'
														optionValueName='${optionValues.name}' class='option'>${optionValues.name}</span>
												</c:forEach>
											</div>
										</c:forEach>
									</div>
								</c:if>
								<!-- /display option -->
								<!-- /countdown -->
								<!-- FORM -->
								<div class="clearfix form-inline nomargin"></div>
								<!-- /FORM -->
								<hr />
								<div class='row'>
									<div class='col-lg-4 col-sm-4'
										style='padding-top: 10px; text-align: right'>购买数量:</div>
									<div class='col-lg-8 col-sm-8 quantityBox'>
										<input name="number" type='text' value='1' style='width: 50px' />
									</div>
								</div>

								<div style='text-align: center; margin-top: 20px'>

									<p class='padding-top-8'>
										<button onclick="submit(1)"
											class="btn btn-warning product-add-cart sysBuilding noradius">
											加入购物车</button>
										<button onclick="submit(2)"
											class="btn btn-primary product-add-cart sysBuilding noradius">
											立即购买</button>
									</p>
								</div>
							</div>
							<!-- /ITEM DESC -->
						</div>
						<ul id="myTab" class="nav nav-tabs nav-top-border margin-top-80"
							role="tablist">
							<li role="presentation" class="active"><a
								href="#description" role="tab" data-toggle="tab">商品描述</a></li>
							<li role="presentation">
							<a href="#reviews" role="tab" data-toggle="tab">商品评论 (${fn:length(reviewsList)}) </a></li>
						</ul>
						<div class="tab-content padding-top-20">
							<!-- DESCRIPTION -->
							<div role="tabpanel" class="tab-pane fade in active"
								id="description">${productDetails.explain}</div>
							<!-- REVIEWS -->
							<div role="tabpanel" class="tab-pane fade" id="reviews">
								<!-- REVIEW ITEM -->
								<c:forEach var="reviews" items="${reviewsList}">
									<div class="block margin-bottom-60">
										<div class="media-body">
											<h4 class="media-heading size-14">
												${reviews.user.nickname} &ndash;
												<span class="text-muted"> ${reviews.createTime} </span>&ndash;
												<span class="size-14 text-muted">
													<c:forEach var="i" begin="1" end="5" step="1">
														<c:choose>
															<c:when test="${reviews.stars >= i}">
																<i class="fa fa-star"></i>
															</c:when>
															<c:otherwise>
																<i class="fa fa-star-o"></i>
															</c:otherwise>
														</c:choose>
													</c:forEach>
												</span>
											</h4>
											<p>${reviews.content}</p>
										</div>
									</div>
								</c:forEach>
								<!-- /REVIEW ITEM -->
								<!-- REVIEW FORM -->
								<h4 class="page-header margin-bottom-40">添加评论</h4>
								<!-- Comment -->
								<div class="margin-bottom-30">
									<textarea name="content" id="text" class="form-control"
										rows="6" placeholder="评论内容" maxlength="1000"></textarea>
								</div>
								<!-- Stars -->
								<div class="product-star-vote clearfix">
									<label class="radio pull-left"> <input type="radio"
										name="stars" value="1" /><i></i>1星
									</label> <label class="radio pull-left"> <input type="radio"
										name="stars" value="2" /><i></i>2星
									</label> <label class="radio pull-left"> <input type="radio"
										name="stars" value="3" /><i></i>3星
									</label> <label class="radio pull-left"> <input type="radio"
										name="stars" value="4" /><i></i>4星
									</label> <label class="radio pull-left"> <input type="radio"
										name="stars" value="5" /><i></i>5星
									</label>
								</div>
								<button onclick="addReviews()" type="button"
									class="btn btn-primary sysBuilding">
									<i class="fa fa-check"></i>提交
								</button>
								<!-- Send Button -->
								<!-- /REVIEW FORM -->
							</div>
						</div>
					</div>
					<!-- LEFT -->
					<div class="col-lg-3 col-md-3 col-sm-3">
						<!-- FEATURED -->
						<div class="margin-bottom-60">
							<h2 class="owl-featured">热销商品</h2>
							<div class="">
								<div>
									<!-- SLIDE -->
									<ul class="list-unstyled nomargin nopadding text-left">
										<c:forEach var="productHot" items="${productHot}">
											<li class="clearfix">
												<!-- item -->
												<div class="thumbnail featured clearfix pull-left">
													<a href="${root}/pc/product/${productHot.id}"> <img
														src="/Shopping${productHot.defaultImg}" width="80"
														height="80" alt="featured item">
													</a>
												</div> <a class="block size-12"
												href="${root}/pc/product/${productHot.id}">${productHot.name}</a>
												<div class="size-18 text-left padding-top-8">￥${productHot.shopPrice / 100}</div>
												<span class="line-through nopadding-left">市场价:￥${productHot.price / 100}</span>
											</li>
										</c:forEach>
										<!-- /item -->
									</ul>
								</div>
								<!-- /SLIDE -->
							</div>
						</div>
						<!-- /FEATURED -->
						<!-- HTML BLOCK -->
					</div>
				</div>
			</div>
		</section>
		<!-- / -->
		<jsp:include page="include/footer.jsp"></jsp:include>
	</div>
	<!-- /wrapper -->
	<!-- JAVASCRIPT FILES -->
	<script src="${js}/bootstrap.min.js"></script>
	<script src="${js}/bootstrap-touchspin-master/src/jquery.bootstrap-touchspin.js"></script>
	<script src="${js}/swiper.min.js"></script>
	<script type="text/javascript">
		//图片轮播开始
		 var swiper = new Swiper('.swiper-container', {
	        pagination: '.swiper-pagination',
	        paginationClickable: true
	    });
		<c:if test='${skuList == null}'>
			var skuList = null;
		</c:if>
		<c:if test='${skuList != null}'>
			var skuList = ${skuList};
		</c:if>
		init();
		function init() {
			if (skuList != null) {
				for ( var key in skuList) {
					var optionValueKeyArray = skuList[key].optionValueKeyGroup.split('_');
					for ( var i in optionValueKeyArray) {
						$('span[optionValueId="'+optionValueKeyArray[i]+'"]').show();
					}
				}
			}
			if (${productDetails.quantity} > 0) {
				$('#inStock').show();
			} else {
				$('#outOfStock').show();
			}
		}
		function submit(flg){
			$.ajax({
				type : "POST",
				url : '${root}' + '/pc/account/isLogin?${_csrf.parameterName}=${_csrf.token}',
				dataType : "json",  
				success : function(data) {
					if (data.success) {
						if (getCartCount("${root}","?${_csrf.parameterName}=${_csrf.token}") >= 15){
				            toastr.warning('购物车已达上限!');
							return;
						}
						//2立即购买   1加入购物车
						if(flg==2){
							carOrOrder(function(json){
								getCartCount("${root}","?${_csrf.parameterName}=${_csrf.token}");
								window.location.href = "${pageContext.request.contextPath}/pc/cart/item";
							});
						}else{
							carOrOrder(function(json){
								getCartCount("${root}","?${_csrf.parameterName}=${_csrf.token}");
							});
						}
					} else {
			            toastr.warning('请登录,只有登录后才能操作!');
					}
				},
				error : function(json) {
		            toastr.error('错误 请登录,只有登录后才能操作!');
				}
			});
		}
		function carOrOrder(Obj) {
			if ($('.optionGroup').length != $('.optionSelected').length) {
				toastr.warning("您选择的类别没有库存!");
				return;
			}
			var optionValueKeyGroup = $('#submitOptionValueKeyGroup').val()
			for ( var key in skuList) {
				if (skuList[key].optionValueKeyGroup == optionValueKeyGroup) {
					if(skuList[key].quantity < $('input[name="number"]').val()){
						toastr.warning("库存不足!");
						return;
					} 
				}
			}
			var orderItem = {
				"productId": "${productDetails.id}",
				"quantity": $('input[name="number"]').val(),
				"optionValueKeyGroup" : optionValueKeyGroup,
				"skuId": getSku(optionValueKeyGroup),
				"jsonData":getJsonData(optionValueKeyGroup)
			}
			$.ajax({
				type : "POST",
				contentType : 'application/json;charset=utf-8',
				url : "${pageContext.request.contextPath}/pc/cart/add?${_csrf.parameterName}=${_csrf.token}",
				data: JSON.stringify(orderItem),
				dataType : "json", //ajax返回值设置为text（json格式也可用它返回，可打印出结果，也可设置成json）  
				async : false,
				success : Obj,
				error : function(json) {
					toastr.warning("加入购物车失败!");
				}
			});
		}

		$('input[name="number"]').TouchSpin({
	        min: 1,
	        max: 999,
	        step: 1,
	        boostat: 5,
	        maxboostedstep: 10
		});
		
		$('.option').click(function() {
			$(this).addClass('optionSelected');
			$(this).siblings('.optionSelected').removeClass('optionSelected');
			if ($('.optionGroup').length == $('.optionSelected').length) {
				var keyGroup = new Array();
				$('.optionSelected').each(function(index, item) {
					keyGroup.push($(item).attr('optionValueId'));
				});
				var keyGroupStr = keyGroup.join('_');
				for ( var key in skuList) {
					if (skuList[key].optionValueKeyGroup == keyGroupStr) {
						$('#shopPrice').html('').html(skuList[key].price / 100);
						$('#submitPrice').val(skuList[key].price);
						$('#submitOptionValueKeyGroup').val(skuList[key].optionValueKeyGroup);
						$('#inStock').hide();
						$('#outOfStock').hide();
						if (skuList[key].quantity > 0)
							$('#inStock').show();
						else
							$('#outOfStock').show();
					}
				}
			}
		});
	
		function addReviews() {
			if($('textarea[name="content"]').val().trim().length == 0) {
				toastr.warning('还没填写评论呢!');
				return false;
			}
			var reviews = {
				"content": $('textarea[name="content"]').val().trim(),
				"stars":0,
				"productId" : ${productDetails.id}
			};
			$("input[name='stars']").each(function() {
				if (this.checked)
					reviews.stars = this.value;
			});
			$.ajax({
				type : "POST",
				url : '${root}' + '/pc/product/reviews/add?${_csrf.parameterName}=${_csrf.token}',
				data : reviews,
				dataType : "json", //ajax返回值设置为text(json格式也可用它返回，可打印出结果，也可设置成json)  
				success : function(data) {
					if (data.success) {
			            toastr.success("添加评论成功,等待审核!");
					} else {
			            toastr.warning("添加评论失败,请登录!");
					}
				},
				error : function(json) {
		            toastr.error('错误 请刷新页面!');
				}
			});
		}
		
		function addWishlist(dom) {
			var productId = ${productDetails.id};
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
		
		//获取商品SKU
		function getSku(optionValueKeyGroup) {
			if (skuList != null) {
				for(var index in skuList) {
					if (skuList[index].optionValueKeyGroup == optionValueKeyGroup) {
						return skuList[index].id;
					}
				}
			}
			return null;
		}
		function getJsonData(optionValueKeyGroup) {
			if (skuList != null) {
				for(var index in skuList) {
					if (skuList[index].optionValueKeyGroup == optionValueKeyGroup) {
						return skuList[index].skuJson;
					}
				}
			}
			return null;
		}
	</script>
</body>

</html>
