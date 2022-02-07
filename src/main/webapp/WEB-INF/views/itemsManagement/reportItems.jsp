<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<script type="text/javascript" src="js/jquery-1.6.2.js"></script>

<script type="text/javascript">
	function deleteItem(id) {
		var url = "${deleteItem}?productID=" + id;
		var OK = confirm('proceed?');
		if (OK) {
			window.location = url;
		}
	}

	$(document).ready(function() {
		$('#field').change(function() {
			processSearch();
		});

		var timer = null;

		$('#searchField').keyup(function() {
			clearTimeout(timer);
			timer = setTimeout(function() {
				processSearch();
			}, 500);
		});
	});

	function processSearch() {
		var data = $('#searchForm').serialize();
		$.getJSON('productsAJAX.htm', data, function(response) {
			$("#table").find("tr:gt(0)").remove();
			var records = response.records;

			$.each(records, function() {
				var newRow = "<tr>";

				newRow += "<td>" + this.productName + "</td>";
				newRow += "<td>" + this.productDescription + "</td>";
				newRow += "<td>" + this.productPrice + "</td>";
				newRow += "</tr>";

				$("#table").append(newRow);
			});

			$('#recordsFound').html(response.recordsFound);
			$('#pageNumber').html(response.page);
			$('#pageCount').html(response.pageCount);

			var pageNumber = response.page * 1;
			var pagesCount = response.pageCount * 1;

			if (pageNumber == 1) {
				$('#first').attr('disabled', 'disabled');
				$('#previous').attr('disabled', 'disabled');
			} else {
				$('#first').removeAttr('disabled');
				$('#previous').removeAttr('disabled');
			}

			if (pageNumber == pagesCount) {
				$('#last').attr('disabled', 'disabled');
				$('#next').attr('disabled', 'disabled');
			} else {
				$('#last').removeAttr('disabled');
				$('#next').removeAttr('disabled');
			}
		});
	}
</script>


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
					items
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
					<h2>
						<spring:message code="users.h2" />
					</h2>

					<a href="${getPDF}"><spring:message code="report.save" />
					</a>

					<%@include file="itemsSearch.jsp"%>

					<table id="table">
						<thead>
						<tr>
							<th><a href="${itemSort}?propertyName=productName"><spring:message
									code="im.Name" />
							</a>
							</th>
							<th><a href="${itemSort}?propertyName=productDescription"><spring:message
									code="im.Description" /> </a>
							</th>
							<th><a href="${itemSort}?propertyName=productPrice"><spring:message
									code="im.Price" /> </a>
							</th>
						</tr>
						</thead>

						<c:forEach items="${products}" var="product">
							<tr>
								<td>${product.productName}</td>
								<td>${product.productDescription}</td>
								<td>${product.productPrice}</td>
							</tr>
						</c:forEach>
					</table>

					<%@include file="itemsNavigation.jsp"%>
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