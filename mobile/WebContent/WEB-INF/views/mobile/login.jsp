<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="zh-cmn-Hans">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1,user-scalable=0">
<title>登录</title>
<link rel="stylesheet" href="${root}/resources/mobile/weui.min.css" />
<link rel="stylesheet" href="${root}/resources/mobile/style.css" />
<link rel="stylesheet" href="${root}/resources/mobile/font-awesome.min.css">
</head>
<body>

	<div class="page js_show">
		<div class="page__hd">
        <h1 class="page__title">用户登录</h1>
    </div>
    	<div class="weui-cells__title" style='color:red'>${loginError}</div>
		<div class="weui-cells weui-cells_form">
		<form id='loginForm' method='post' action='${root}/mobile/login?${_csrf.parameterName}=${_csrf.token}'>
			<div class="weui-cell">
				<div class="weui-cell__hd">
					<label class="weui-label">手机号</label>
				</div>
				<div class="weui-cell__bd">
					<input class="weui-input" maxlength="11" type="tel" id='mobile' name="userName"
						placeholder="请输入手机号" value='${user.userName}'>
				</div>
			</div>


			<div class="weui-cell">
				<div class="weui-cell__hd">
					<label class="weui-label">密码</label>
				</div>
				<div class="weui-cell__bd">
					<input class="weui-input" type="password" name="pwd" id="password" placeholder="输入密码">
				</div>
			</div>
		</div>
		
		<div class="weui-btn-area">
			<a class="weui-btn weui-btn_primary" href="javascript:void(0)" id="loginButton">用户登录</a>
		</div>
		</form>
		<div class="weui-btn-area">
			<a class="weui-btn weui-btn_default" href="<c:url value="/mobile/register" />">用户注册</a>
		</div>

		<div class="weui-cells__tips"><a class='link' href='<c:url value="/mobile/forget_password" />'>找回密码</a></div>
		
		
		<!-- 错误消息 -->
		<div class="js_dialog" id="msgBox" style="opacity: 0; display: none;">
            <div class="weui-mask"></div>
            <div class="weui-dialog">
                <div class="weui-dialog__bd">...</div>
                <div class="weui-dialog__ft">
                    <a href="javascript:;" class="weui-dialog__btn weui-dialog__btn_primary">确认</a>
                </div>
            </div>
        </div>
	<script src="${root}/resources/mobile/zepto.min.js"></script>
		<jsp:include page="include/menu.jsp"/>
	</div>
	
	
	<script type="text/javascript">
		$(function() {
			function getUserObject() {
				return userObject = {
					"username":$.trim($('#mobile').val()),
					"password":$.trim($('#password').val())
				}
			}
			
			
		   	//关闭消息对话框
	    	$('.weui-dialog__btn_primary').on('click', function() {
	    		$('#msgBox').fadeOut(200);
	    	});
		   	
		   	
			//注册表单提交
			$('#loginButton').on('click', function() {
				//手机号码合法性验证
				if (!checkMobile(getUserObject().username)) {
					return;
				}
				
				//密码验证
				if (!checkPassword(getUserObject().password)) {
					return;
				}
				
				//表单提交
				$('#loginForm').submit();
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
			

			//密码合法性检查
			function checkPassword(pw) {
				if (pw == '') {
					$('#msgBox').find('.weui-dialog__bd').html("请输入密码");
					$('#msgBox').fadeIn(200);
					return false;
				}
				return true;
			}
			
				
		});
	</script>
</body>
</html>
