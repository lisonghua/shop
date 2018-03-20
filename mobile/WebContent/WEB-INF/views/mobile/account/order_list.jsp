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
			<div class="page__bd" style="height: 100%;">
        <div class="weui-tab">
            <div class="weui-navbar">
                <div class="weui-navbar__item">
                    	全部订单
                </div>
<!--                 <div class="weui-navbar__item weui-bar__item_on"> -->
<!--                  	         已支付订单 -->
<!--                 </div> -->
<!--                 <div class="weui-navbar__item"> -->
<!--                     	未支付订单 -->
<!--                 </div> -->
            </div>
            <div class="weui-tab__panel">
				<div class="weui-form-preview">
					<c:forEach items="${orderList.orderListData}" var="z" varStatus="i">
			            <div class="weui-form-preview__hd">
			                <div class="weui-form-preview__item">
			                    <label class="weui-form-preview__label">订单金额</label>
			                    <em class="weui-form-preview__value">
			                    ¥<fmt:formatNumber type="number" value="${z.price/100}" pattern="0.00" maxFractionDigits="2"/>
			                    </em>
			                </div>
			            </div>
			            <div class="weui-form-preview__bd">
			                <div class="weui-form-preview__item">
			                    <label class="weui-form-preview__label">订单编号</label>
			                    <span class="weui-form-preview__value">${z.orderNum}</span>
			                </div>
			                <div class="weui-form-preview__item">
			                    <label class="weui-form-preview__label">订单时间</label>
			                    <span class="weui-form-preview__value">${z.createTime}</span>
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
			                    <span class="weui-form-preview__value">${z.contactName}</span>
			                </div>
			                
			                <div class="weui-form-preview__item">
			                    <label class="weui-form-preview__label">联系人电话</label>
			                    <span class="weui-form-preview__value">${z.contactMobile}</span>
			                </div>
			            </div>
			            <div class="weui-form-preview__ft">
			                <a class="weui-form-preview__btn weui-form-preview__btn_primary" zid="${z.orderNum}" onclick="orderitem(this)" href="javascript:void(0)">查看订单明细</a>
			            </div>
			        </c:forEach>
			    </div>
		        <c:if test="${orderList.nowPage<orderList.pageCount}">
		        	<div class="weui-panel__ft" onclick="loadMore()" id="loadMoreDiv" zid="${orderList.nowPage}">
						<a href="javascript:void(0);" class="weui-cell weui-cell_access weui-cell_link">
							<div class="weui-cell__bd">查看更多</div><span class="weui-cell__ft"></span>
						</a>
					</div>
				</c:if>
            </div>
        </div>
    </div>
	<script src="${root}/resources/mobile/zepto.min.js"></script>
	<script src="${root}/resources/mobile/common.js"></script>
	<jsp:include page="../include/menu.jsp"></jsp:include>
	</div>
	<form id="itemData" method="post" action="${pageContext.request.contextPath}/mobile/account/order/detail?${_csrf.parameterName}=${_csrf.token}">
		<input type="hidden" name="orderNum">
	</form>
	<script>
	 $(function(){
    	//设置当前菜单高亮
        $('.weui-tabbar a').removeClass('weui-bar__item_on');
        $('#menu_user_center').addClass('weui-bar__item_on');
	 });
	 function orderitem(Obj){
		 $("[name=orderNum]").val($(Obj).attr("zid"));
		 $("#itemData").submit();
	 }
	 var zid = 1;
	 function loadMore(){
		zid += Number($("#loadMoreDiv").attr("zid"));
		var order = {};
		order["nowPage"] = zid;
		$.ajax({
			type : "POST",
			contentType : 'application/json;charset=utf-8',
			url : '${pageContext.request.contextPath}/mobile/account/order/list?${_csrf.parameterName}=${_csrf.token}',
			data: JSON.stringify(order),
			dataType : "json", //ajax返回值设置为text(json格式也可用它返回，可打印出结果，也可设置成json)  
			success : function(data) {
				if(data.errorCode==0){
					addMoreRow(data.data["orderListData"]);
				}
				if(zid>=data.data.pageCount){
					$("#loadMoreDiv").remove();
				}
			}
		 })
	 }
	 function addMoreRow(data){
		 var html = "";
		 for(var key in data){
			 var orderStatus = numberText(data[key].status);
			 html += '<div class="weui-form-preview__hd">'+
			 '        <div class="weui-form-preview__item">'+
			 '            <label class="weui-form-preview__label">订单金额</label>'+
			 '            <em class="weui-form-preview__value">¥'+(Number(data[key].price)/100).toFixed(2)+'</em>'+
			 '        </div>'+
			 '    </div>'+
			 '    <div class="weui-form-preview__bd">'+
			 '        <div class="weui-form-preview__item">'+
			 '            <label class="weui-form-preview__label">订单编号</label>'+
			 '            <span class="weui-form-preview__value">'+data[key].orderNum+'</span>'+
			 '        </div>'+
			 '        <div class="weui-form-preview__item">'+
			 '            <label class="weui-form-preview__label">订单时间</label>'+
			 '            <span class="weui-form-preview__value">'+data[key].createTime+'</span>'+
			 '        </div>'+
			 '        <div class="weui-form-preview__item">'+
			 '            <label class="weui-form-preview__label">订单状态</label>'+
			 '            <span class="weui-form-preview__value">'+orderStatus+'</span>'+
			 '        </div>'+
			 '        '+
			 '        <div class="weui-form-preview__item">'+
			 '            <label class="weui-form-preview__label">联系人</label>'+
			 '            <span class="weui-form-preview__value">'+data[key].contactName+'</span>'+
			 '        </div>'+
			 '        '+
			 '        <div class="weui-form-preview__item">'+
			 '            <label class="weui-form-preview__label">联系人电话</label>'+
			 '            <span class="weui-form-preview__value">'+data[key].contactMobile+'</span>'+
			 '        </div>'+
			 '    </div>'+
			 '    <div class="weui-form-preview__ft">'+
			 '        <a class="weui-form-preview__btn weui-form-preview__btn_primary" zid="'+data[key].orderNum+'" onclick="orderitem(this)" href="javascript:void(0)">查看订单明细</a>'+
			 '    </div>';
		 }
		 $(".weui-form-preview").append(html);
	 }
	 function numberText(obj){
		 if(obj==null || obj==0){
			return "订单编辑中";
		 }else if(obj==1){
			return "已下单未付款";
		 }else if(obj==2){
			return "配送中"; 
		 }else if(obj==3){
			return "配送完了";
		 }else if(obj==4){
			return "订单取消";
		 }
	 }
	</script>
</body>
</html>
