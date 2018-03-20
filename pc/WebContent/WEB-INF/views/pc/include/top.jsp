<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<spring:url value="/resources/pc/image" var="image" />
<spring:url value="/resources/pc/assets/css" var="css" />
<spring:url value="/resources/pc/assets/js" var="js" />
<!-- mobile settings -->
<meta name="viewport" content="width=device-width, maximum-scale=1, initial-scale=1, user-scalable=0" />
<!--[if IE]><meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1'><![endif]-->
<!-- CORE CSS -->
<link href="${css}/bootstrap.min.css" rel="stylesheet">

<!-- THEME CSS -->
<link href="${css}/essentials.css" rel="stylesheet" type="text/css" />
<link href="${css}/layout.css" rel="stylesheet" type="text/css" />
<link rel="shortcut icon" href="${root}/resources/assets/images/favicon.ico">
<!-- PAGE LEVEL SCRIPTS -->
<link href="${css}/header-1.css" rel="stylesheet" type="text/css" />
<link href="${css}/layout-shop.css" rel="stylesheet" type="text/css" />
<link href="${css}/color_scheme/orange.css" rel="stylesheet" type="text/css" id="color_scheme" />
<link href="${js}/bootstrap-touchspin-master/src/jquery.bootstrap-touchspin.js" rel="stylesheet" type="text/css" />
<link href="${js}/toastr/build/toastr.min.css" rel="stylesheet" />
<script src="${js}/jquery.js"></script>
<script src="${js}/toastr/build/toastr.min.js"></script>
<script src="${js}/jquery.validate.js"></script>
<script src="${js}/swiper.min.js"></script>
<script src="${js}/jquery.bootpag.min.js"></script>

