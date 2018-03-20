<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<spring:url value="/resources/image" var="image" />
<spring:url value="/resources/assets/css" var="css" />
<spring:url value="/resources/assets/js" var="js" />

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
</head>
<body class="smoothscroll enable-animation">
	<!-- wrapper -->
	<div id="wrapper">
		<section class="padding-xlg">
				<div class="container">
					
					<div class="row">

						<div class="col-md-6 col-sm-6 hidden-xs">
							
							<div class="error-404">
								404
							</div>
						
						</div>

						<div class="col-md-6 col-sm-6 padding-top-40">
						
							<h3 class="nomargin">抱歉, <strong>您访问的页面不存在!</strong></h3>
							<p class="nomargin-top size-20 font-lato text-muted">请稍后再试.</p>

						</div>
					</div>
					
				</div>
			</section>
			
		
	</div>
	
</body>

</html>