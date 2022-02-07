<%@ page language="java" contentType="text/html; charset=utf8"
	pageEncoding="utf8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>


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
					none
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
				<div id="edit">
					<fieldset>
						<legend><spring:message code="lo.login" /></legend>
						<c:if test="${not empty param.login_error}">
							<font color="red"> <spring:message code="lo.tryAgain" /><br /> <br /> <spring:message code="lo.reason" /> <c:out
									value="${SPRING_SECURITY_LAST_EXCEPTION.message}" />. </font>
						</c:if>

						<form name="f" action="<c:url value='j_spring_security_check'/>"
							  method="POST">
							<table>
								<tr>
									<td><spring:message code="lo.user" /></td>
									<td><input type='text' name='j_username' />
									</td>
								</tr>
								<tr>
									<td><spring:message code="lo.pass" /></td>
									<td><input type='password' name='j_password'></td>
								</tr>
								<tr>
									<td><input type="checkbox" name="_spring_security_remember_me">
									</td>
									<td><spring:message code="lo.remember" /></td>
								</tr>

								<tr>
									<td colspan='2'><input name="submit" type="submit"><input
											name="reset" type="reset"></td>
								</tr>
							</table>
						</form>
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