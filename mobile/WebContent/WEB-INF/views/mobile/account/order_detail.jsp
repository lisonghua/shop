<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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

<style>
	.weui-form-preview {
		margin-bottom:20px;
	}
</style>
<body>

	<div class="page js_show" style='padding-bottom:100px'>
		<div class="page__hd">
			<h1 class="page__title">订单编号：${orderItem.orderNum}</h1>
		</div>
		<div class="weui-form-preview">
            <div class="weui-form-preview__hd">
                <div class="weui-form-preview__item">
                    <label class="weui-form-preview__label">订单金额</label>
                    <em class="weui-form-preview__value">
                    ¥<fmt:formatNumber type="number" value="${orderItem.price/100}" pattern="0.00" maxFractionDigits="2"/>
                    </em>
                </div>
            </div>
            <div class="weui-form-preview__bd">
                <div class="weui-form-preview__item">
                    <label class="weui-form-preview__label">订单时间</label>
                    <span class="weui-form-preview__value">${orderItem.createTime}</span>
                </div>
                <div class="weui-form-preview__item">
                    <label class="weui-form-preview__label">订单状态</label>
                    <span class="weui-form-preview__value">
	                    <c:if test="${orderItem.status==0 || orderItem.status==null}">
							<div>订单编辑中</div>
						</c:if>
						<c:if test="${orderItem.status==1}">
							<div>已下单未付款</div>
						</c:if>
						<c:if test="${orderItem.status==2}">
							<div>配送中</div>
						</c:if>
						<c:if test="${orderItem.status==3}">
							<div>配送完成</div>
						</c:if>
						<c:if test="${orderItem.status==4}">
							<div>订单取消</div>
						</c:if>
					</span>
                </div>
                
                <div class="weui-form-preview__item">
                    <label class="weui-form-preview__label">联系人</label>
                    <span class="weui-form-preview__value">${orderItem.contactName}</span>
                </div>
                
                <div class="weui-form-preview__item">
                    <label class="weui-form-preview__label">联系人电话</label>
                    <span class="weui-form-preview__value">${orderItem.contactMobile}</span>
                </div>
                
				<div class="weui-form-preview__item">
                    <label class="weui-form-preview__label">物流单号</label>
                    <span class="weui-form-preview__value">${orderItem.logisticsList[0].logisticsNum}</span>
                </div>
                
                
                
                <div class="weui-form-preview__item">
                    <label class="weui-form-preview__label">物流公司</label>
                    <span class="weui-form-preview__value">${orderItem.logisticsList[0].companyName}</span>
                </div>
            </div>
        </div>
        
	        <div class="weui-form-preview">
	         <c:forEach items="${orderItem.orderItemList}" var="z" varStatus="i">
	            <div class="weui-form-preview__bd">
	                <div class="weui-form-preview__item">
	                    <label class="weui-form-preview__label">商品名称</label>
	                    <em class="weui-form-preview__value">${z.productList[0].name}</em>
	                </div>
	            </div>
	            <div class="weui-form-preview__bd">
	            	<c:if test="${z.jsonData!=null}">
		                <div class="weui-form-preview__item">
		                    <label class="weui-form-preview__label">规格</label>
		                    <span class="weui-form-preview__value">${z.jsonData}</span>
		                </div>
	                </c:if>
	                <div class="weui-form-preview__item">
	                    <label class="weui-form-preview__label">单价</label>
	                    <span class="weui-form-preview__value">
						¥<fmt:formatNumber type="number" value="${z.price/100}" pattern="0.00" maxFractionDigits="2"/>
						</span>
	                </div>
	                
	                <div class="weui-form-preview__item">
	                    <label class="weui-form-preview__label">数量</label>
	                    <span class="weui-form-preview__value">${z.quantity}</span>
	                </div>
	                
	                <div class="weui-form-preview__item">
	                    <label class="weui-form-preview__label">合计金额</label>
	                    <span class="weui-form-preview__value">
						¥<fmt:formatNumber type="number" value="${z.price*z.quantity/100}" pattern="0.00" maxFractionDigits="2"/>
						</span>
	                </div>
	            </div>
	        </c:forEach>
	    </div>
	</div>
	<script src="${root}/resources/mobile/zepto.min.js"></script>
	<jsp:include page="../include/menu.jsp"></jsp:include>
	<script>
	 $(function(){
	    	//设置当前菜单高亮
	        $('.weui-tabbar a').removeClass('weui-bar__item_on');
	        $('#menu_user_center').addClass('weui-bar__item_on');
	    });
	</script>
</body>
</html>
