<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<spring:url value="/resources/pc/image" var="image" />
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
<title>SHOP</title>
<jsp:include page="include/top.jsp"></jsp:include>
<style>
	#category {
		list-style:none;
	}
	#category li {
		float:left;
		width:100px;
		heigth:20px;
	}
</style>
</head>
<body class="smoothscroll enable-animation">
	<!-- wrapper -->
	<div id="wrapper">
		<jsp:include page="include/head.jsp"></jsp:include>
		<section class="page-header page-header-xs">
			<div class="container">
				<h1>${productDetails.name}</h1>
			</div>
		</section>
		<!-- /PAGE HEADER -->
		<!-- -->
		<section>
			<div class="container">
				<h1>所有分类</h1>
				<ul id="category">
					<c:forEach var="categoryInfo" varStatus="status" items="${categoryList}">
						<li><a href="${root}/pc/category/${categoryInfo.id}/page/1" >${categoryInfo.name}</a></li>
					</c:forEach>
				</ul>
			</div>
		</section>
		<!-- / -->
		<jsp:include page="include/footer.jsp"></jsp:include>
	</div>
	<!-- /wrapper -->
	<!-- JAVASCRIPT FILES -->
	<script src="${js}/bootstrap.min.js"></script>
	<script src="${js}/bootstrap-touchspin-master/src/jquery.bootstrap-touchspin.js"></script>
	<script src="${js}/toastr/build/toastr.min.js"></script>
	<script src="${js}/swiper.min.js"></script>
<%-- 	<script src="${js}/common.js"></script> --%>
</body>

</html>
