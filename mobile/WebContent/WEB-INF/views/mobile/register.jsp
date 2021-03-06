<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="zh-cmn-Hans">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1,user-scalable=0">
<title>注册</title>
<link rel="stylesheet" href="${root}/resources/mobile/weui.min.css" />
<link rel="stylesheet" href="${root}/resources/mobile/style.css" />
<link rel="stylesheet" href="${root}/resources/mobile/font-awesome.min.css">
</head>
<body>

	<div class="page js_show">
		<div class="page__hd">
        <h1 class="page__title">用户注册</h1>
        <p class="page__desc" id='smsMsgBox'></p>
    </div>
    	<form id='registerForm' name='register' action='${root}/mobile/register?${_csrf.parameterName}=${_csrf.token}' method='post'>
			<div class="weui-cells__title" style='color:red'>${errorMsg}</div>
			<div class="weui-cells weui-cells_form">
				<div class="weui-cell weui-cell_vcode">
					<div class="weui-cell__hd">
						<label class="weui-label">手机号</label>
					</div>
					<div class="weui-cell__bd">
						<input class="weui-input" id='mobile' name='userName' maxlength="11" type="tel"
							placeholder="请输入手机号" value='${userObject.userName}'>
					</div>
					<div class="weui-cell__ft">
						<a href="javascript:;" id='sendSmsCode' class="weui-vcode-btn">获取验证码</a>
					</div>
				</div>
	
				<div class="weui-cell">
					<div class="weui-cell__hd">
						<label class="weui-label">验证码</label>
					</div>
					<div class="weui-cell__bd">
						<input class="weui-input" maxlength="6" id='smsCode' name='smsCode' type="tel"
							placeholder="请输入验证码">
					</div>
				</div>
	
				<div class="weui-cell">
					<div class="weui-cell__hd">
						<label class="weui-label">密码</label>
					</div>
					<div class="weui-cell__bd">
						<input class="weui-input" id='password' name='pwd' type="password" placeholder="输入密码">
					</div>
				</div>
				
				<div class="weui-cell">
					<div class="weui-cell__hd">
						<label class="weui-label">确认密码</label>
					</div>
					<div class="weui-cell__bd">
						<input class="weui-input" id='confirmPassword' name='confirmPassword' type="password" placeholder="确认密码">
					</div>
				</div>
			</div>
			
			<div class="weui-btn-area">
				<a class="weui-btn weui-btn_primary" id='registerButton' href="javascript:;">用户注册</a>
			</div>
		</form>
		
		<div class="weui-btn-area">
			<a class="weui-btn weui-btn_default" href="<c:url value="/mobile/login" />" id="showTooltips">用户登录</a>
		</div>

		<script src="${root}/resources/mobile/zepto.min.js"></script>
		<script src="${root}/resources/mobile/common.js"></script>
		<jsp:include page="include/menu.jsp"></jsp:include>
		<jsp:include page="include/message.jsp"></jsp:include>
		
	</div>
	<script type="text/javascript">
		$(function() {
			
			function getUserObject() {
				return userObject = {
					"username":$.trim($('#mobile').val()),
					"smsCode":$.trim($('#smsCode').val()),
					"password":$.trim($('#password').val()),
					"confirmPassword":$.trim($('#confirmPassword').val())
				}
			}
			
			
		   	//关闭消息对话框
	    	$('.weui-dialog__btn_primary').on('click', function() {
	    		$('#msgBox').fadeOut(200);
	    	});
			//注册表单提交
			$('#registerButton').on('click', function() {
				//手机号码合法性验证
				if (!checkMobile(getUserObject().username)) {
					return;
				}
				
				//短信验证码合法性验证
				if (!checkSmsCode(getUserObject().smsCode)) {
					return;
				}
				
				//密码验证
				if (!checkPassword(getUserObject().password)) {
					return;
				}
				
				//表单提交
				$('#registerForm').submit();
			});
			
			
			//验证手机号码合法性检查
			function checkMobile(mobile) {
				
				if (mobile == '') {
					$('#msgBox').find('.weui-dialog__bd').html("请填写手机号码");
					$('#msgBox').fadeIn(200);
					return false;
				}
				
				if (/^1[0-9]{10}$/.test(mobile)) {
	                if(!/^1[34578]\d{9}$/.test(mobile)) {
	                	$('#msgBox').find('.weui-dialog__bd').html("手机号码不正确");
	    				$('#msgBox').fadeIn(200);
	    				return false;
	                } 
	            } else {
	                if(!/^\+\d+$/.test(mobile)) {
	                	$('#msgBox').find('.weui-dialog__bd').html("手机号码不正确");
	    				$('#msgBox').fadeIn(200);
	    				return false;
	                } 
	            }
				return true;
			}
			
			//短信验证码合法性检查
			function checkSmsCode(smsCode) {
				if (smsCode == '') {
					$('#msgBox').find('.weui-dialog__bd').html("请输入短信验证码");
					$('#msgBox').fadeIn(200);
					return false;
				}
				return true;
			}
			
			//密码合法性检查
			function checkPassword(pw) {
				if (pw == '') {
					$('#msgBox').find('.weui-dialog__bd').html("请输入密码");
					$('#msgBox').fadeIn(200);
					return false;
				}

				if (pw.match(/^[0-9a-zA-Z]+$/) && pw.match(/\d/) && pw.match(/[a-zA-Z]/) && pw.length >= 6 && pw.length <= 16) {
					$('#msgBox').find('.weui-dialog__bd').html("密码为6-16位的字母和数字组成");
					$('#msgBox').fadeIn(200);
					return false;	
				}
				if(pw != $("#confirmPassword").val()){
					$('#msgBox').find('.weui-dialog__bd').html("两次密码输入不一致");
					$('#msgBox').fadeIn(200);
					return false;
				}
				return true;
			}
			
			//获取短信验证码
			$('#sendSmsCode').on('click', function() {
				if (!checkMobile(getUserObject().username)) {
					return;
				} 
				//获取短信验证码
				$.ajax({
					  type: 'POST',
					  url: '${root}/mobile/sendSmsMsg?${_csrf.parameterName}=${_csrf.token}',
					  data: {"userName":$.trim($('#mobile').val())},
					  dataType: 'json',
					  success: function(resData) {
						  //通讯成功mobile
						  if (resData.errorCode == "0") {
							  $('#smsMsgBox').html("短信验证码" + resData.data);
						  }else if(resData.errorCode == '-2'){
							  showMsg("您已注册,请登录");
						  }
					  }
				})
			});
		});
	</script>
</body>
</html>
