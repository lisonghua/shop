<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<title>商城后台</title>
<jsp:include page="../commonCss.jsp" />
</head>
<body class="blank">
	<jsp:include page="../main/top.jsp" />
	<jsp:include page="../main/left.jsp" />
	<jsp:include page="../commonJs.jsp" />
	<div id="wrapper">
		<div class="content">
			<div class="row">
				<div class="col-lg-12">
					<div class="hpanel">
						<div class="panel-body">
							<div class="row">
								<div class="hpanel">
									<div id="error_div" class="text-left"></div>
									<form id="form_ewallet" name="form_ewallet"
										action="" method="POST">
										<div class="form-group col-lg-12">
											<label>注册用户电子钱包初始金额设定</label> <input type="text" id="amount"
												name="amount" class="form-control" maxlength="50"
												placeholder="金额数量" />
										</div>
										<div class="text-right m-t-xs">
											<button id="save" class="btn btn-success"
												style="margin-right: 5px; margin-top: 5px" type="button">
												<strong>设定</strong>
											</button>
											<button id="reset" class="btn btn-success"
												style="margin-right: 5px; margin-top: 5px"
												style="margin-right: 20px;" type="reset">
												<strong>重置</strong>
											</button>

										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
var oTable;
var header = $("meta[name='_csrf_header']").attr("content");
var token = $("meta[name='_csrf']").attr("content");
var contextPath = '${pageContext.request.contextPath}';
$(function() {
	$(document).ajaxSend(function(e, xhr, options) {
		xhr.setRequestHeader(header, token);
	});
});
$("#save").bind("click",function(){
	$.ajax({
		type : "POST",
		contentType : "application/json;charset=utf-8", 
		url : '<c:url value="/admin/eWallet/save" />',
		data : formToJson($("#form_ewallet")),
		dataType : "json", 
		async : false,
		success : function(json) {
			swal({
			    title: "保存成功!",
			    text: "",
			    type: "success"
			});
		},
		error : function(json) {
			existFlag = true;
		}
	});
});
function formToJson($form) {
	var data = {};
	$($form.serializeArray()).each(function(i, v) {
		
			data[v.name] = v.value;

	
	});
	return JSON.stringify(data);
}
</script>
</html>