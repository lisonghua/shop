<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="zh-cmn-Hans">

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
	<title>商品</title>
	<link rel="stylesheet" href="${root}/resources/mobile/weui.min.css" />
	<link rel="stylesheet" href="${root}/resources/mobile/style.css" />
	<link rel="stylesheet" href="${root}/resources/mobile/font-awesome.min.css">
	<style>
	.product_title {
		font-size: 14px;
		padding: 10px;
	}
	
	.product_price {
		padding: 10px;
	}
	
	.shop_price {
		color: #ff5000;
		font-size: 20px;
		font-weight: bold;
		display: block;
	}
	
	.m_price {
		color: #666;
		font-size: 10px;
		display: block;
	}
	
	.price {
		background-color: #eee;
		text-align: center;
		height: 57px;
	}
	
	.addCart {
		background-color: #ff5000;
		height: 57px;
		color: #fff;
		text-align: center;
		display: box;
		display: -webkit-box;
		display: -moz-box;
		-webkit-box-pack: center;
		-moz-box-pack: center;
		-webkit-box-align: center;
		-moz-box-align: center;
		font-size: 17px;
	}
	
	.buyNow {
		background-color: #09BB07;
		height: 57px;
		color: #fff;
		text-align: center;
		display: box;
		display: -webkit-box;
		display: -moz-box;
		-webkit-box-pack: center;
		-moz-box-pack: center;
		-webkit-box-align: center;
		-moz-box-align: center;
		font-size: 17px;
	}
	
	#product_tab_content img {
		width: 100%;
	}
	</style>
</head>

<body>
	<div class='container'>
		<div class="page tabbar js_show">
			<div class="page__bd" style="height: 100%;">
				<div class="weui-tab">
					<div class="weui-tab__panel">
						<!-- 商品开始 -->
						<div>
							<img width='100%' height="360px" src='/Shopping${productDetails.defaultImg}' />
						</div>
						<!-- 设置产品编号和产品名称 -->
						<div class='product_title' productId="10" id='product_title'>
							${productDetails.name}
							<input name="productId" type="hidden" value="${productDetails.id}">
						</div>
						<div class="weui-flex" style='padding: 0 10px; margin-bottom: 20px'>
							<div class="weui-flex__item">
								<div class="placeholder price">
									<div class='shop_price'>￥${productDetails.shopPrice / 100}元</div>
									<div>
										<del class='m_price'>￥${productDetails.price / 100}元</del>
									</div>
									<input id="submitPrice" type="hidden" value="${productDetails.shopPrice}">
									<input id="submitOptionValueKeyGroup" type="hidden">
								</div>
							</div>
							<div class="weui-flex__item">
								<div class="placeholder addCart">加入购物车</div>
							</div>
							<div class="weui-flex__item">
								<div class="placeholder buyNow">立即购买</div>
							</div>
						</div>
						<div class="weui-form-preview" style='margin-bottom: 20px'>
							<div class="weui-form-preview__bd">
								<div class="weui-form-preview__item">
									<label class="weui-form-preview__label">请填写购买数量</label> <em class="weui-form-preview__value">
										<div>
											<input type='tel' onchange="numberVerify(this)" class='weui-input' style='text-align: right' value="1" maxlength="5" id='quantity'>
										</div>
									</em>
								</div>
							</div>
						</div>
						<c:if test="${optionList!=null}">
							<!-- 循环商品option开始 -->
							<c:forEach var="option" items="${optionList}">
								<div name="optionItem" class="weui-form-preview optionGroup" style='margin-bottom: 20px'>
									<div class="weui-form-preview__hd">
										<div class="weui-form-preview__item">
											<label class="weui-form-preview__label option_title">${option.name}：</label>
											<em class="weui-form-preview__value"></em>
										</div>
									</div>
									<div class="weui-form-preview__bd">
										<div class="weui-form-preview__item">
											<c:forEach var="optionValues" items="${option.optionValuesList}">
												<div class="weui-form-preview__item option" style="display: none;" optionId="${option.id}" optionValueId='${optionValues.id}' optionValueName='${optionValues.name}'>
													<label class="weui-form-preview__label">${optionValues.name}</label>
													<span class="weui-form-preview__value"><i class="weui-icon-circle"></i></span>
												</div>
											</c:forEach>
										</div>
									</div>
								</div>
							</c:forEach>
							<!-- /循环商品option结束 -->
						</c:if>
						<div class="weui-tab" style='border-top: 1px solid #ccc;'>
							<div class="weui-navbar">
								<div id="product_tab" class="weui-navbar__item weui-bar__item_on">商品详情</div>
								<div id="review_tab" class="weui-navbar__item">商品评论</div>
							</div>
							<div class="weui-tab__panel">
								<div class="weui-panel weui-panel_access">
									<div id='product_tab_content' class='tab_content'>
										<div id="J_image_imgs" class="dtit-dt">
											${productDetails.explain}</div>
									</div>
									<div id='review_tab_content' class='tab_content' style='display: none'>
										<c:if test="${fn:length(reviewsList) != 0}">
											<div class="weui-panel__hd">用户评论</div>
											<div class="weui-panel__bd">
												<c:forEach var="reviews" items="${reviewsList}">
													<div class="weui-media-box weui-media-box_text">
														<h4 class="weui-media-box__title">
															${reviews.user.nickname} <small style='font-size: 8px; color: #333'>${reviews.createTime}</small>
														</h4>
														<p class="weui-media-box__desc">${reviews.content}</p>
													</div>
												</c:forEach>
											</div>
										</c:if>
										<!-- 添加评论 -->
										<c:if test="${userId != null}">
											<div class="weui-panel__hd">添加评论
												<div class="weui-panel__bd">
													<div class="weui-cells weui-cells_form">
														<div class="weui-cell">
															<div class="weui-cell__bd">
																<textarea name="content" class="weui-textarea" onpropertychange="smsCount(this)" oninput="smsCount(this)" placeholder="请输入文本" rows="3" maxlength="200"></textarea>
																<div class="weui-textarea-counter">
																	<span id="contentCount">0</span>/200
																</div>
															</div>
														</div>
														<div class="weui-cell__bd">
															<input type="radio" name="stars" value="1">1星
															<input type="radio" name="stars" value="2">2星
															<input type="radio" name="stars" value="3">3星
															<input type="radio" name="stars" value="4">4星
															<input type="radio" name="stars" value="5">5星
														</div>
													</div>
													<a href="javascript:;" onclick="addReviews()" class="weui-btn weui-btn_primary" style="margin: 15px 10% 15px 50%;">提交</a>
												</div>
											</div>
										</c:if>
										<c:if test="${userId == null}">
											<div class="weui-panel__bd">
												<div class="weui-media-box weui-media-box_text">
													<h4 class="weui-media-box__title">
														<font style="color: #3cc51f; font-size: 17px;">登录后即可评论</font>
													</h4>
												</div>
											</div>
										</c:if>
										<!-- /添加评论 -->
									</div>
								</div>
							</div>
						</div>
	<script src="${root}/resources/mobile/zepto.min.js"></script>
	<script src="${root}/resources/mobile/common.js"></script>
						<!-- 商品结束 -->
						<jsp:include page="include/menu.jsp" />
						<jsp:include page="include/message.jsp" />
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
	<c:if test = '${skuList == null}'>
		var skuList = null; 
	</c:if>

	<c:if test = '${skuList != null}'>
		var skuList = ${skuList};
	</c:if>

	function init() {
		if (skuList != null) {
			for (var key in skuList) {
				var optionValueKeyArray = skuList[key].optionValueKeyGroup.split('_');
				for (var i in optionValueKeyArray) {
					$('div[optionValueId="' + optionValueKeyArray[i] + '"]').show();
				}
			}
		}
	}
	init();
	// 添加评论
	function addReviews() {
		if($('textarea[name="content"]').val().trim().length == 0) {
			showMsg('还没填写评论呢!');
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
			url : '${root}' + '/mobile/product/reviews/add?${_csrf.parameterName}=${_csrf.token}',
			data : reviews,
			dataType : "json", //ajax返回值设置为text(json格式也可用它返回，可打印出结果，也可设置成json)  
			success : function(data) {
				if (data.success) {
					showMsg("添加评论成功,等待审核!");
				} else {
					showMsg("添加评论失败,请登录!");
				}
			},
			error : function(json) {
				showMsg('错误 请刷新页面!');
			}
		});
	}
	// 计算评论字数
	function smsCount(dom) {
		$('#contentCount').html($(dom).val().length);
	}
	function numberVerify(dom) {
		var num = $(dom).val();
		if (num > 1 && num < 99999) {
			$(dom).val(num);
			return;
		}
		$(dom).val('1');
	}
	$(function() {
		//商品明细 & 商品评论 
		$('.weui-navbar__item').on('click', function() {
			$(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
			$('.tab_content').hide();
			console.log('#' + $(this).attr('id') + '_content');
			$('#' + $(this).attr('id') + "_content").show();
		});


		//商品option选项
		$('.option').on('click', function() {
			$(this).find('.weui-form-preview__value').html('<i class="weui-icon-success"></i>');
			$(this).addClass('optionSelected').siblings('.optionSelected').removeClass('optionSelected');
			$(this).siblings().find('.weui-form-preview__value').html('<i class="weui-icon-circle"></i>');
		});


		//监听添加购物车
		$('.addCart').on('click', function() {
			if(!valdataUserId()){
				return;
			}
			if (loadCartCount() >= 15) {
				showMsg("购物车已达上限!");
				return;
			}
			//如果没有错误 新增当前商品到购物车
			if (!checkOption() && checkQuantity()) {
				console.log(getAddCartProductInfo());
			}
			carOrOrder(function(json) {
				loadCartCount();
				// 				getCartCount("${root}","?${_csrf.parameterName}=${_csrf.token}");
			});
		});

		$('.buyNow').on('click', function() {
			if(valdataUserId()==false){
				return;
			}
			if (loadCartCount() >= 15) {
				showMsg("购物车已达上限!");
				return;
			}
			//如果没有错误 新增当前商品到购物车
			if (!checkOption() && checkQuantity()) {
				console.log(getAddCartProductInfo());
			}
			carOrOrder(function(json) {
				// 				getCartCount("${root}","?${_csrf.parameterName}=${_csrf.token}");
				window.location.href = "${pageContext.request.contextPath}/mobile/cart/item";
			});
		});

		//检查用户是否选择商品选项
		function checkOption() {
			//检查该商品是否存在选项
			if ($('.optionGroup').length > 0) {
				//错误标识
				var errorFLAG = false;
				$('.optionGroup').each(function(index, item) {
					// 用户没有选择商品选项提示对话框
					if ($(item).find('.optionSelected').length == 0) {
						//设置错误标识
						errorFLAG = true;
						//显示错误消息内容
						$('#optionMsg').find('.weui-dialog__bd').html($(item).find('.option_title').html());
						//显示错误对话框
						$('#optionMsg').fadeIn(200);
						//退出当前循环
						return false;
					}
				});
				return errorFLAG;
			}
		}

		//购买数量验证
		function checkQuantity() {
			var pattern = /^[0-9]{1,2}$/;
			if (pattern.test($("#quantity").val())) {
				return true;
			} else {
				//显示错误消息内容
				$('#optionMsg').find('.weui-dialog__bd').html("购买数量输入错误, 最多购买99个哦");
				//显示错误对话框
				$('#optionMsg').fadeIn(200);
				return false;
			}
		}


		//获取添加购物车的产品信息
		function getAddCartProductInfo() {
			var productOption = new Array();
			if ($('.optionGroup').length > 0) {
				$('.optionGroup').each(function(index, item) {
					var optionObject = $(item).find('.optionSelected');
					productOption.push({
						"optionId": $(optionObject).attr("optionId"),
						"optionValueId": $(optionObject).attr("optionValueId"),
						"optionValueName": $(optionObject).attr("optionValueName")
					});
				});
			}

			return {
				"productId": $("#product_title").attr("productId"),
				"quantity": $("#quantity").val(),
				"productOption": productOption
			}

		}
	});
	//获取商品SKU
	function getSku(optionValueKeyGroup) {
		if (skuList != null) {
			for (var index in skuList) {
				if (skuList[index].optionValueKeyGroup == optionValueKeyGroup) {
					return skuList[index].id;
				}
			}
		}
		return null;
	}

	function carOrOrder(Obj) {
		if ($('.optionGroup').length != $('.optionSelected').length) {
			showMsg("您选择的类别没有库存!");
			return;
		}
		var optionValueKeyGroup = $('#submitOptionValueKeyGroup').val()
		for (var key in skuList) {
			if (skuList[key].optionValueKeyGroup == optionValueKeyGroup) {
				if (skuList[key].quantity < $('#quantity').val()) {
					showMsg("库存不足!");
					return;
				}
			}
		}
		var orderItem = {
			"productId": "${productDetails.id}",
			"quantity": $('#quantity').val(),
			"optionValueKeyGroup": optionValueKeyGroup,
			"skuId": getSku(optionValueKeyGroup),
			"jsonData":getJsonData(optionValueKeyGroup)
		}
		$.ajax({
			type: "POST",
			contentType: 'application/json;charset=utf-8',
			url: "${pageContext.request.contextPath}/mobile/cart/add?${_csrf.parameterName}=${_csrf.token}",
			data: JSON.stringify(orderItem),
			dataType: "json", //ajax返回值设置为text（json格式也可用它返回，可打印出结果，也可设置成json）  
			async: false,
			success: Obj,
			error: function(json) {
				showMsg("加入购物车失败!");
			}
		});
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
	function valdataUserId(){
		var flg = false;
		$.ajax({
			type : "POST",
			url : '${root}' + '/mobile/account/isLogin?${_csrf.parameterName}=${_csrf.token}',
			dataType : "json",  
			async: false,
			success : function(data) {
				if (!data.success) {
					showMsg('请登录,只有登录后才能操作!');
				} else {
					flg = true;
				}
			},
			error : function(json) {
	            showMsg('错误 请登录,只有登录后才能操作!');
			}
		});
		return flg;
	}
	</script>
</body>
</html>
