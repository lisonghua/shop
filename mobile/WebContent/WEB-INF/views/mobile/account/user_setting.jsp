<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="zh-cmn-Hans">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
<title>会员设置</title>
<link rel="stylesheet" href="${root}/resources/mobile/weui.min.css" />
<link rel="stylesheet" href="${root}/resources/mobile/style.css" />
<link rel="stylesheet" href="${root}/resources/mobile/font-awesome.min.css">
<body>

	<div class="page js_show">
		<div class="page__hd">
			<h1 class="page__title">会员设置</h1>
		</div>

		<div class="weui-cells weui-cells_form">
			<div class="weui-panel__hd">完善基本信息</div>

			<form id="userBasicFrom" onsubmit="return false;">
				<div class="weui-cell">
					<div class="weui-cell__hd">
						<label class="weui-label">昵称</label>
					</div>
					<div class="weui-cell__bd">
						<input class="weui-input" value="${userBasic.nickname}" type="text" placeholder="昵称" maxlength="20" name="nickName">
					</div>
				</div>

				<div class="weui-cell">
					<div class="weui-cell__hd">
						<label class="weui-label">Email</label>
					</div>
					<div class="weui-cell__bd">
						<input class="weui-input" value="${userBasic.email}" type="text" placeholder="Email" maxlength="50" name="email">
					</div>
				</div>
			</form>
		</div>

		<div class="weui-btn-area" style='margin-bottom: 20px' id="editBasic">
			<a class="weui-btn weui-btn_primary" href="javascript:void(0);">保存</a>
		</div>

		<div class="weui-cells weui-cells_form">
			<div class="weui-panel__hd">密码修改</div>
			<form id="userPwdFrom" onsubmit="return false;">
				<div class="weui-cell">
					<div class="weui-cell__hd">
						<label class="weui-label">原始密码</label>
					</div>
					<div class="weui-cell__bd">
						<input class="weui-input" type="password" placeholder="原始密码" maxlength="20" name="oldpassword">
					</div>
				</div>
	
				<div class="weui-cell">
					<div class="weui-cell__hd">
						<label class="weui-label">新密码</label>
					</div>
					<div class="weui-cell__bd">
						<input class="weui-input" type="password" placeholder="新密码" maxlength="20" name="password">
					</div>
				</div>
	
				<div class="weui-cell">
					<div class="weui-cell__hd">
						<label class="weui-label">确认密码</label>
					</div>
					<div class="weui-cell__bd">
						<input class="weui-input" type="password" placeholder="确认密码" maxlength="20" name="rpassword">
					</div>
				</div>
			</form>
		</div>

		<div class="weui-btn-area" style='margin-bottom: 20px' id="editPwd">
			<a class="weui-btn weui-btn_primary" href="javascript:void(0);" >保存</a>
		</div>

		<script src="${root}/resources/mobile/zepto.min.js"></script>
		<script src="${root}/resources/mobile/common.js"></script>
		<jsp:include page="../include/menu.jsp"></jsp:include>
		<jsp:include page="../include/message.jsp" />
	</div>
	<script>
		$(document).ready(function() {
			var emailreg = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
			$("#editBasic").click(function() {
				var nickName = $('input[name="nickName"]').val().trim();
				var email = $('input[name="email"]').val().trim();
				if(nickName.length == 0){
					showMsg('昵称不能为空!');
			        return;
			   	}
				if(email.length != 0 && !emailreg.test(email)){
					showMsg('Email格式不正确!');
			        return;
			   	}
				var userBasic = {
					"email" : email,
					"nickname" : nickName
				};
				$.ajax({
					type : "POST",
					url : '${root}' + '/mobile/account/userBasic/edit?${_csrf.parameterName}=${_csrf.token}',
					data : userBasic,
					dataType : "json", //ajax返回值设置为text(json格式也可用它返回，可打印出结果，也可设置成json)  
					success : function(data) {
						showMsg(data.message);
					},
					error : function(json) {
						showMsg('错误 登录超时,请重新登录!');
					}
				});
			});
	
			$("#editPwd").click(function() {
				var oldpassword = $('input[name="oldpassword"]').val();
				var password = $('input[name="password"]').val();
				var rpassword = $('input[name="rpassword"]').val();
				if(oldpassword.length == 0) {
					showMsg('请输入原始密码！');
					return;
				}
				if(password.length == 0) {
					showMsg('请输入新密码！');
					return;
				}
				if(rpassword.length == 0) {
					showMsg('请输入确认密码！');
					return;
				}
				if(password != rpassword) {
					showMsg('密码与确认密码不一致！');
					return;
				}
				$.ajax({
					type : "POST",
					url : '${root}' + '/mobile/account/userBasic/pwd?${_csrf.parameterName}=${_csrf.token}',
					data : {
						"oldpassword" : oldpassword,
						"rpassword" : rpassword
					},
					dataType : "json", //ajax返回值设置为text(json格式也可用它返回，可打印出结果，也可设置成json)  
					success : function(data) {
						showMsg(data.message, function() {
							window.location.href = '${root}/mobile/logout';
						});
					},
					error : function(json) {
						showMsg('错误 登录超时,请重新登录!');
					}
				});
			});
	
		});
		$(function() {
			//设置当前菜单高亮
			$('.weui-tabbar a').removeClass('weui-bar__item_on');
			$('#menu_user_center').addClass('weui-bar__item_on');
		});
	</script>
</body>
</html>
