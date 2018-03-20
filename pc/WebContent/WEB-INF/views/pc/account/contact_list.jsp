<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<title>SHOP-联系人列表</title>

<!-- mobile settings -->
<meta name="viewport"
	content="width=device-width, maximum-scale=1, initial-scale=1, user-scalable=0" />
<!--[if IE]><meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1'><![endif]-->

<!-- CORE CSS -->
<link href="${css}/bootstrap.min.css" rel="stylesheet">

<!-- THEME CSS -->
<link href="${css}/essentials.css" rel="stylesheet" type="text/css" />
<link href="${css}/layout.css" rel="stylesheet" type="text/css" />

<!-- PAGE LEVEL SCRIPTS -->
<link href="${css}/header-1.css" rel="stylesheet" type="text/css" />
<link href="${css}/layout-shop.css" rel="stylesheet" type="text/css" />
<link href="${css}/color_scheme/orange.css" rel="stylesheet" type="text/css" id="color_scheme" />
<jsp:include page="../include/top.jsp"></jsp:include>
</head>
<body class="smoothscroll enable-animation">
	<!-- wrapper -->
	<div id="wrapper">
		<jsp:include page="../include/head.jsp"></jsp:include>
		<section class="page-header page-header-xs">
			<div class="container">

				<h1>个人中心</h1>

				<!-- breadcrumbs -->
				<ol class="breadcrumb">
					<li><a href="${root}/pc/index">首页</a></li>
					<li>个人中心</li>
					<li class="active">我的订单</li>
				</ol>
				<!-- /breadcrumbs -->

				<!-- page tabs -->
				<ul class="page-header-tabs list-inline">
					<li><a href="${root}/pc/account/order/list">我的订单</a></li>
					<li class="active"><a href="${root}/pc/account/contact/list">常用联系人</a></li>
					<li><a href="${root}/pc/account/wishlist/page/1">我的收藏</a></li>
					<li><a href="${root}/pc/account/user_setting">个人设置</a></li>
					<li><a href="${root}/pc/account/ewallet">充值</a></li>
				</ul>
				<!-- /page tabs -->
			</div>
		</section>
		<section>
			<div class="container">

				<div class="panel panel-default">
					<div class="panel-heading">
						<h2 class="panel-title">常用联系人</h2>
					</div>


					<table class="table margin-top-20">
						<thead>
							<tr>
								<th>默认联系人</th>
								<th>联系人姓名</th>
								<th>联系人电话</th>
								<th>联系人地址</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${accountList.data}" var="z" varStatus="s">
								<tr>
									<c:if test="${z.contactFlag==1}">
										<td><input type="radio" name="contect" value="${z.id}" checked="checked" /></td>
									</c:if>
									<c:if test="${z.contactFlag!=1}">
										<td><input type="radio" name="contect" value="${z.id}" /></td>
									</c:if>
									<td>${z.name}</td>
									<td>${z.mobile}</td>
									<td>${z.address}</td>
									<td><a href="javascript:void(0);" zid="${z.id}"
										onclick="changeById(this)">编辑</a> <a
										href="javascript:void(0);" zid="${z.id}"
										onclick="deleteById(this)">删除</a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<form id="perform" method="post"
						action="${pageContext.request.contextPath}/pc/contect/add">
						<div class="panel-body">
							<fieldset class="margin-top-10 ">
								<div class="row">
									<div class="col-md-6 col-sm-6">
										<input type="hidden" name="id">
										<label for="billing_firstname">姓名 *</label> <input
											id="billing_firstname" name="name" type="text"
											class="form-control required" maxlength="50">
											<div class="erro"></div>
									</div>
									<div class="col-md-6 col-sm-6">
										<label for="billing_lastname">电话 *</label> <input
											id="billing_lastname" name="mobile" type="text"
											class="form-control required" maxlength="11">
											<div class="erro"></div>
									</div>
								</div>


								<div class="row">
									<div class="col-lg-12">
										<label for="billing_address1">地址 *</label> <input
											id="billing_address1" name="address" type="text"
											class="form-control required" placeholder="" maxlength="255">
											<div class="erro"></div>
									</div>
								</div>
								<button id="save" type="button"
									class="btn btn-success margin-top-20 pull-right noradius">
									<i class="glyphicon glyphicon-user"></i> 保存联系人
								</button>
							</fieldset>
						</div>
					</form>
				</div>
			</div>
		</section>
		<jsp:include page="../include/footer.jsp"></jsp:include>
	</div>
	<!-- /wrapper -->
	<!-- JAVASCRIPT FILES -->
	<script src="${root}/resources/pc/assets/js/toastr/build/toastr.min.js"></script>
	<script src="${root}/resources/pc/assets/js/swiper.min.js"></script>
</body>
<script type="text/javascript">
	//校验input;
	function valdate(){
		$(".erro").text("");
		var idx = 0;
		for(var i = 0;i<$(".required").length;i++){
			if($(".required").eq(i).val().trim()==""){
			    $(".erro").eq(i).text("此项为必填项");
			    idx = 1;
			}else{
				if(i==1){
					var mobile = /^(13[0-9]{9})|(18[0-9]{9})|(14[0-9]{9})|(17[0-9]{9})|(15[0-9]{9})$/;
					if(!mobile.test($(".required").eq(i).val()) || $(".required").eq(i).val().length!=11){
						$(".erro").eq(i).text("请输入正确的手机号码");
						idx = 1;
					}
				}
			}
		}
		//校验flg
		if(idx==1){
			return false;
		}
	}
	//添加联系人 最多为5条
	$("#save").bind("click", function() {
		//调用校验
		if(valdate()==false){
			return;
		}
		$.ajax({
			type : "POST",
			url : "${pageContext.request.contextPath}/pc/contect/add?${_csrf.parameterName}=${_csrf.token}",
			data : $("#perform").serialize(),
			dataType : "json", //ajax返回值设置为text（json格式也可用它返回，可打印出结果，也可设置成json）  
			async : false,
			success : function(json) {
				if(json.data==true){
					//刷新页面
					window.location.href="${pageContext.request.contextPath}/pc/account/contact/list?${_csrf.parameterName}=${_csrf.token}";
				}else{
					showMsg("联系人至多添加5人!");
				}
			},
			error : function(json) {
				 toastr.warning("添加失败");
			}
		});
	})
	//根据id删除联系人
	function deleteById(Obj) {
		if($("[name=id]").val()==$(Obj).attr("zid")){
			toastr.warning("联系人编辑中,不允许删除");
			return;
		}
		$.ajax({
			type : "POST",
			contentType : 'application/json;charset=utf-8',
			url : "${pageContext.request.contextPath}/pc/contect/remove?${_csrf.parameterName}=${_csrf.token}",
			data : JSON.stringify({"id":$(Obj).attr("zid")}),
			dataType : "json", //ajax返回值设置为text（json格式也可用它返回，可打印出结果，也可设置成json）  
			async : false,
			success : function(json) {
				if(json.errorCode==0){
					$(Obj).parent().parent().remove();
				}
			},
			error : function(json) {
				 toastr.warning("删除失败");
			}
		});
	}
	//编辑联系人
	function changeById(Obj) {
		for(var i = 0;i<$(".required").length;i++){
			$(".required").eq(i).val($(Obj).parent().prevAll("td")[$(".required").length-i-1].innerText);
		}
		$("[name=id]").val($(Obj).attr("zid"));
	}
	//设置默认联系人
   $("[name=contect]").bind("click", function() {
		$.ajax({
			type : "POST",
			contentType : 'application/json;charset=utf-8',
			url : "${pageContext.request.contextPath}/pc/contect/default?${_csrf.parameterName}=${_csrf.token}",
			data : JSON.stringify({"id":$(this).val()}),
			dataType : "json", //ajax返回值设置为text（json格式也可用它返回，可打印出结果，也可设置成json）  
			async : false,
			success : function(json) {
				if(json.errorCode!=0){
					console.log(json.errorCode,json.errorName);
				}
			},
			error : function(json) {
				console.log("-1","失败");
			}
		});
	})
</script>
</html>