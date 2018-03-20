<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="zh-cmn-Hans">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
	<title>常用联系人</title>
	<link rel="stylesheet" href="${root}/resources/mobile/weui.min.css" />
	<link rel="stylesheet" href="${root}/resources/mobile/style.css" />
	<link rel="stylesheet" href="${root}/resources/mobile/font-awesome.min.css">
</head>
<body>
	<div class="page js_show">
		<div class="page__hd">
			<h1 class="page__title">常用联系人</h1>
		</div>
		<form id="perform" method="post" action="${pageContext.request.contextPath}/contect/add">
			<div class="weui-cells weui-cells_form">
				<div class="weui-cell">
					<input type="hidden" name="id">
					<div class="weui-cell__hd">
						<label class="weui-label">联系人姓名</label>
					</div>
					<div class="weui-cell__bd">
						<input class="weui-input" maxlength="50" name="name" type="text" placeholder="联系人姓名">
					</div>
					<div class="erro"></div>
				</div>
				<div class="weui-cell">
					<div class="weui-cell__hd">
						<label class="weui-label">联系人电话</label>
					</div>
					<div class="weui-cell__bd">
						<input class="weui-input" maxlength="11" name="mobile" type="tel" placeholder="联系人电话">
					</div>
					<div class="erro"></div>
				</div>
				<div class="weui-cell">
					<div class="weui-cell__hd">
						<label class="weui-label">联系人地址</label>
					</div>
					<div class="weui-cell__bd">
						<input class="weui-input" name="address" maxlength="255" type="text" placeholder="联系人地址">
					</div>
					<div class="erro"></div>
				</div>
			</div>
		</form>
		<div class="weui-btn-area" style='margin-bottom:20px'>
			<a id="save" class="weui-btn weui-btn_primary" href="javascript:void(0)">保存</a>
		</div>
		<c:forEach items="${accountList.data}" var="z" varStatus="s">
			<div class="weui-form-preview">
				<div class="weui-form-preview__bd">
					<div class="weui-form-preview__item">
						<label class="weui-form-preview__label">联系人</label>
						<span class="weui-form-preview__value">${z.name}</span>
					</div>
					<div class="weui-form-preview__item">
						<label class="weui-form-preview__label">联系人电话</label>
						<span class="weui-form-preview__value">${z.mobile}</span>
					</div>
					<div class="weui-form-preview__item">
						<label class="weui-form-preview__label">联系人地址</label>
						<span class="weui-form-preview__value">${z.address}</span>
					</div>
					<div class="weui-form-preview__item">
						<label class="weui-form-preview__label">操作</label>
						<span class="weui-form-preview__value">
						<a href="javascript:void(0);" zid="${z.id}" onclick="changeById(this)">编辑</a>
						<a href="javascript:void(0);" zid="${z.id}" onclick="deleteById(this)">删除</a>
						<a href="javascript:void(0);" zid="${z.id}" onclick="contect(this)">设为默认联系人</a></span>
					</div>
				</div>
			</div>
		</c:forEach>
		<div class="weui-form-preview" style="margin-bottom: 80px;"></div>
	</div>
	<script src="${root}/resources/mobile/zepto.min.js"></script>
	<script src="${root}/resources/mobile/common.js"></script>
	<jsp:include page="../include/menu.jsp"></jsp:include>
	<jsp:include page="../include/message.jsp" />
	<script>
	$(function() {
		//设置当前菜单高亮
		$('.weui-tabbar a').removeClass('weui-bar__item_on');
		$('#menu_user_center').addClass('weui-bar__item_on');
	});
	//校验input;
	function valdate() {
		$(".erro").text("");
		var idx = 0;
		for (var i = 0; i < $(".weui-input").length; i++) {
			if ($(".weui-input").eq(i).val().trim() == "") {
				$(".erro").eq(i).text("此项为必填项");
				idx = 1;
			} else {
				if (i == 1) {
					var mobile = /^(13[0-9]{9})|(18[0-9]{9})|(14[0-9]{9})|(17[0-9]{9})|(15[0-9]{9})$/;
					if (!mobile.test($(".weui-input").eq(i).val()) || $(".weui-input").eq(i).val().length != 11) {
						$(".erro").eq(i).text("请输入正确的手机号码");
						idx = 1;
					}
				}
			}
		}
		//校验flg
		if (idx == 1) {
			return false;
		}
	}
	//添加联系人 最多为5条
	$("#save").bind("click", function() {
			//调用校验
			if (valdate() == false) {
				return;
			}
			$.ajax({
				type: "POST",
				url: "${pageContext.request.contextPath}/mobile/contect/add?${_csrf.parameterName}=${_csrf.token}",
				data: $("#perform").serialize(),
				dataType: "json", //ajax返回值设置为text（json格式也可用它返回，可打印出结果，也可设置成json）  
				async: false,
				success: function(json) {
					if (json.data == true) {
						//刷新页面
						window.location.href = "${pageContext.request.contextPath}/mobile/account/contact/list?${_csrf.parameterName}=${_csrf.token}";
					} else {
						showMsg("联系人至多添加5人!");
					}
				},
				error: function(json) {
					showMsg("添加失败");
				}
			});
		})
		//根据id删除联系人
	function deleteById(Obj) {
		$.ajax({
			type: "POST",
			contentType: 'application/json;charset=utf-8',
			url: "${pageContext.request.contextPath}/mobile/contect/remove?${_csrf.parameterName}=${_csrf.token}",
			data: JSON.stringify({
				"id": $(Obj).attr("zid")
			}),
			dataType: "json", //ajax返回值设置为text（json格式也可用它返回，可打印出结果，也可设置成json）  
			async: false,
			success: function(json) {
				if (json.errorCode == 0) {
					$(Obj).parent().parent().parent().remove();
					showMsg("删除成功");
				} else {
					showMsg("删除失败");
				}
			},
			error: function(json) {
				showMsg("删除失败");
			}
		});
	}
	//编辑联系人
	function changeById(Obj) {
		for (var i = 0; i < $(".weui-input").length; i++) {
			$(".weui-input").eq(i).val($(Obj).parent().parent().parent().find("div").eq(i).find("span").text());
		}
		$("[name=id]").val($(Obj).attr("zid"));
	}
	//设置默认联系人
	function contect(Obj) {
		$.ajax({
			type: "POST",
			contentType: 'application/json;charset=utf-8',
			url: "${pageContext.request.contextPath}/mobile/contect/default?${_csrf.parameterName}=${_csrf.token}",
			data: JSON.stringify({
				"id": $(Obj).attr("zid")
			}),
			dataType: "json", //ajax返回值设置为text（json格式也可用它返回，可打印出结果，也可设置成json）  
			async: false,
			success: function(json) {
				if (json.errorCode != 0) {
					showMsg("默认联系人设置失败");
				} else {
					showMsg("默认联系人设置成功");
				}
			},
			error: function(json) {
				showMsg("默认联系人设置失败");
			}
		});
	}
	</script>
</body>

</html>
