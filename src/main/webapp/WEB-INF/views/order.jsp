<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title><spring:message code="order.ordering" /></title>
	<script type="text/javascript" src="js/jquery-1.6.2.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {

			$(document).ready(function() {
				$(".all").fadeIn(1500);
			});


			$("#table tr:nth-child(2n)").addClass("odd");
		});
	</script>
<script type="text/javascript">
	function askDelete(url) {
		var isOK = confirm('<spring:message code="order.askDel" />');
		if (isOK) {
			window.location = url;
		}
	}
</script>
<script type="text/javascript">
	var filterValues = new Array(2);
	//filterValues["orderStatus"] = ["None", "Ordered", "Pending", "Delivered"]; 
	//filterValues["role"] = ["None", "Merchandiser", "Administrator", "Supervisor"];
	filterValues["orderStatus"] = $
	{
		searchFilter.filter1
	};
	filterValues["role"] = $
	{
		searchFilter.filter2
	};

	function filterChange(selectObj) {
		//var isOK = confirm(filterValues[selectObj.options[selectObj.selectedIndex].value]);

		// get the index of the selected option 
		//var idx = selectObj.selectedIndex;

		// get the value of the selected option 
		//var which = selectObj.options[idx].value;
		// use the selected option value to retrieve the list of items from the array 
		cList = filterValues[selectObj.options[selectObj.selectedIndex].value]
		// get the select element via its known id 
		var cSelect = document.getElementById("filterValue");
		// remove the current options from the country select 

		while (cSelect.options.length > 0) {
			cSelect.remove(0);
		}
		var newOption;
		// create new options 
		for ( var i = 0; i < cList.length; i++) {
			newOption = document.createElement("option");
			newOption.value = cList[i]; // assumes option string and value are the same 
			newOption.text = cList[i];
			// add the new option 
			try {
				cSelect.add(newOption); // this will fail in DOM browsers but is needed for IE 
			} catch (e) {
				cSelect.appendChild(newOption);
			}
		}
	}
</script>
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
					<a href="orderItemsCreate.htm"><spring:message code="order.crNew" />
					</a>
					<br>
					<!--table for filters and search-->
					<div id="edit">
						<form:form action="order.htm" method="POST"
								   modelAttribute="searchFilter">
							<form:input type="hidden" path="start" />
							<form:input type="hidden" path="allFoundAndFiltered" />
							<table>
								<tr>
									<td><spring:message code="order.filter" /></td>
									<td><form:select path="filterBy" size="1"
													 onchange="filterChange(this);">
										<form:option value="orderStatus" label="Status" ><spring:message code="order.status" /></form:option>
										<form:option value="role" label="Role" ><spring:message code="order.role" /></form:option>
									</form:select>
									</td>
									<td><form:select path="filterValue" size="1"
													 items="${searchFilter.filterValues}" />
									</td>
									<td></td>
								</tr>

								<tr>
									<td><spring:message code="order.search" /></td>
									<td><form:select path="search">
										<form:option value="orderName" label="Order Name" ><spring:message code="order.orName" /></form:option>
										<form:option value="orderStatus" label="Status" ><spring:message code="order.status" /></form:option>
										<form:option value="assignee" label="Assignee" ><spring:message code="order.assignee" /></form:option>
									</form:select>
									</td>
									<td><form:input path="searchValue" />
									</td>
									<td><input type="submit"
											   value="<spring:message code="order.apply" />" name="Apply" />
									</td>
								</tr>
							</table>

						</form:form>
					</div>
					<br>
					<div id="list">
						<table>
							<tr>
								<th><a href=order.htm?propertyName=orderName><spring:message
										code="order.orName" /> </a></th>
								<th><a href=order.htm?propertyName=totalPrice><spring:message
										code="order.totPrice" /> </a></th>
								<th><a href=order.htm?propertyName=maxDiscount><spring:message
										code="order.maxDisc" /> </a></th>
								<th><a href=order.htm?propertyName=deliveryDate><spring:message
										code="order.delivDate" /> </a></th>
								<th><a href=order.htm?propertyName=status><spring:message
										code="order.status" /> </a></th>
								<th><a href=order.htm?propertyName=assignee><spring:message
										code="order.assignee" /> </a></th>
								<th><a href=order.htm?propertyName=role><spring:message
										code="order.role" /> </a></th>
								<th><spring:message code="order.edit" /></th>
								<th><spring:message code="order.del" /></th>

							</tr>
							<c:forEach items="${orders}" var="order">
								<tr>
									<td>${order.orderName}</td>
									<td>${order.totalPrice}</td>
									<td>${order.maxDiscount}</td>
									<td>${order.deliveryDate}</td>
									<td>${order.orderStatus}</td>
									<td>${order.assigne.login}</td>
									<td>${order.assigne.role}</td>
									<td>
										<a href="orderItemsOpen.htm?orderId=${order.id}"><spring:message
												code="order.edit" /> </a></td>
									<td><a
											href="javascript:askDelete('deleteOrder.htm?orderId=${order.id}')"><spring:message
											code="order.del" /> </a></td>
								</tr>
							</c:forEach>

						</table>
					</div>
					<br>
					<div>
						<table>
							<tr>
								<td>
									<form action="orderFirstPage.htm">
										<input type="submit"
											   value="<spring:message code='order.bFirst' />" name="firstPage" />
									</form>
								</td>
								<td>
									<form action="orderPreviousPage.htm">
										<input type="submit" value="<spring:message code='order.bPrev' />"
											   name="previousPage" />
									</form>
								</td>
								<td>
									<form action="orderNextPage.htm">
										<input type="submit" value="<spring:message code='order.bNext' />"
											   name="nextPage" />
									</form>
								</td>
								<td>
									<form action="orderLastPage.htm">
										<input type="submit" value="<spring:message code='order.bLast' />"
											   name="lastPage" />
									</form>
								</td>
							</tr>
						</table>
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