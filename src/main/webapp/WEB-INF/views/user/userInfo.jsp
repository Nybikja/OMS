<%@ page language="java" contentType="text/html; charset=utf8"
		 pageEncoding="utf8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<script type="text/javascript" src="js/jquery-1.6.2.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {

			$(document).ready(function() {
				$(".all").fadeIn(1500);
			});


			$("#table tr:nth-child(2n)").addClass("odd");
		});
	</script>

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title><tiles:insertAttribute name="title"/>
	</title>
	<link rel="stylesheet" type="text/css"
		  href="<c:url value="/css/style.css"/>" />
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
					<spring:message code='tabs.adm' />
				</c:set>
				<c:set var="itemsLink">
					<spring:message code="tabs.iManage" />
				</c:set>
				<c:set var="ordersLink">
					<spring:message code="tabs.ordering" />
				</c:set>
				<c:set var="infoLink">
					<spring:message code="tabs.userinfo" />
				</c:set>

				<c:set var="current">
					info
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
				<div >
					<a href="?lang=en_US"><spring:message code="tabs.en" /></a>
					<a href="?lang=uk_UA"><spring:message code="tabs.ua" /></a>

					<fieldset>
						<legend><spring:message code="tabs.userinfo" /></legend>

						<table>
							<tr>
								<td><spring:message code="users.fName" /></td><td>${user.firstName }</td>
							</tr>

							<tr>
								<td><spring:message code="users.lName" /></td><td>${user.lastName }</td>
							</tr>

							<tr>
								<td><spring:message code="users.customerType" /></td><td>${user.customerType.typeName }</td>
							</tr>

							<tr>
								<td><spring:message code="users.role" /></td><td>${user.role.roleName }</td>
							</tr>
						</table>
					</fieldset>
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
