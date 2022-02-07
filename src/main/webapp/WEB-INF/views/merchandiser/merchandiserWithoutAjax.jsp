<%@ page language="java" contentType="text/html; charset=utf8"
	pageEncoding="utf8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="com.softserveinc.edu.oms.web.ParameterNames"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<script type="text/javascript" src="js/jquery-1.6.2.js"></script>
	<script type="text/javascript">
		$(document).ready(function () {

			$(document).ready(function () {
				$(".all").fadeIn(1500);
			});


			$("#table tr:nth-child(2n)").addClass("odd");
		});
	</script>

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title><tiles:insertAttribute name="title"/>
	</title>
	<link rel="stylesheet" type="text/css"
		  href="<c:url value="/css/style.css"/>"/>
</head>
<body>

<div class="all" style="display: none;">
	<div id="main">

		<div id="logo">
			<h1>Ordering Management System.</h1>
			<h2>Simple. Slim. Genius.</h2>
		</div>

		<div id="menubar">
			<ul id="nav">
				<c:set var="adminLink">
					<spring:message code='tabs.adm'/>
				</c:set>
				<c:set var="itemsLink">
					<spring:message code="tabs.iManage"/>
				</c:set>
				<c:set var="ordersLink">
					<spring:message code="tabs.ordering"/>
				</c:set>
				<c:set var="infoLink">
					<spring:message code="tabs.userinfo"/>
				</c:set>

				<c:set var="current">
					orders
				</c:set>

				<sec:authorize access="hasRole('ROLE_Administrator')">
					<li <c:if test="${current == 'admin'}">class="cur"</c:if>><a
							href="/OMS/users.htm">${adminLink}</a>
					</li>
				</sec:authorize>

				<sec:authorize access="hasRole('ROLE_Supervisor')">
					<li <c:if test="${current == 'items'}">class="cur"</c:if>><a
							href="/OMS/itemManagement.htm">${itemsLink}</a>
					</li>
				</sec:authorize>

				<sec:authorize
						access="hasAnyRole('ROLE_Administrator','ROLE_Customer','ROLE_Merchandiser')">
					<li <c:if test="${current == 'orders'}">class="cur"</c:if>><a
							href="/OMS/order.htm">${ordersLink}</a>
					</li>
				</sec:authorize>

				<li <c:if test="${current=='info'}">class="cur"</c:if>><a
						href="/OMS/userInfo.htm">${infoLink}</a></li>

				<li class="spec"><a href="/OMS/logout.htm" class="spec"><img
						alt="logout" src="resources/logout.png"> </a></li>
			</ul>
		</div>


		<div id="site_content">
			<div id="content">
				<div id="list">
					<div id="list">
						<spring:message code="merch.wosimple" />
						<form name="withAjax" method="post" action="merchandiser.htm"
							  style="display: inline;">
							<input type="hidden" name="orderId" value="${selectedOrderID}">
							<a href="javascript:document.withAjax.submit()"><spring:message
									code="merch.toMainVersion" /> </a>
						</form>
						<c:choose>
							<c:when test="${pageModel.hasElementsToShow()}">
								<jsp:include
										page="/WEB-INF/views/pageableControlerViews/pageResizeListWithoutAjax.jsp"></jsp:include>
								<h3>
									<spring:message code="merch.h3" />
								</h3>
								<jsp:include page="components/merchandiserOrderItemsTable.jsp"></jsp:include>
								<h3>
									<spring:message code="merch.page" />
										${pageModel.getCurrentPage() } / ${pageModel.getNumberOfPages() }
								</h3>
								<jsp:include
										page="/WEB-INF/views/pageableControlerViews/pageActionButtonsWithoutAjax.jsp" />
							</c:when>
							<c:otherwise>
								<br><spring:message code="merch.noItemsInList" /></c:otherwise>
						</c:choose>
					</div>
					<div id="edit">
						<fieldset>
							<legend>
								<spring:message code="merch.totals" />
							</legend>
							<jsp:include page="components/generalOrderDataPart.jsp" />
							<c:choose>
								<c:when test="${orderStatus eq 'Delivered'}"><jsp:include
										page="components/merchandiserOrderDataNonEditable.jsp" /></c:when>
								<c:otherwise><jsp:include
										page="components/merchandiserOrderDataEditWithoutAjax.jsp" />
								</c:otherwise>
							</c:choose>
						</fieldset>
						<c:choose>
							<c:when test="${orderStatus eq 'Delivered'}"><jsp:include
									page="components/merchandiserOrderDataNonEditableButtons.jsp" /></c:when>
							<c:otherwise><jsp:include
									page="components/merchandiserOrderDataEditButtons.jsp" />
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</div>

		<div id="footer">
			<a href="http://www.google.com.ua">inspired by Google:)</a>
		</div>

	</div>
</div>
</body>
</html>