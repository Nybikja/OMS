<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript" src="js/jquery-1.6.2.js"></script>


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
                <fieldset>
                    <legend>Item search</legend>
                    <%@include file="searchProduct.jsp" %>

                    <div id="list">
                        <%@include file="list.jsp" %>
                    </div>

                    <br>

                    <%@include file="selectedItem.jsp" %>


                    <!-- 		<br> -->
                    <!-- 		<fieldset style="width: 95%; padding: 10px;"> -->
                    <!-- 			<table style="clear: both;"> -->
                    <!-- 				<tr> -->
                    <!-- 					<td>Item:</td> -->
                    <%-- 					<td><c:if --%>
                    <%-- 							test="${(!empty productId) &&(productId!='')&&(productId!=null)}"> --%>
                    <%-- 							<c:out value="${findByIDProduct.productName}" /> --%>
                    <%-- 						</c:if> --%>
                    <!-- 					</td> -->
                    <!-- 				</tr> -->
                    <!-- 				<tr> -->
                    <!-- 					<td>Price</td> -->
                    <%-- 					<td><c:if --%>
                    <%-- 							test="${(!empty productId) &&(productId!='')&&(productId!=null)}"> --%>
                    <%-- 							<c:out value="${findByIDProduct.productPrice}" /> &nbsp$ --%>
                    <%-- 					</c:if> --%>
                    <!-- 					</td> -->
                    <!-- 				</tr> -->
                    <!-- 			</table> -->

                    <%-- 			<form:form method="POST" commandName="orderItemModel" --%>
                    <!-- 				action="addOrderItem.htm"> -->
                    <%-- 				<input type="hidden" name="productId" value=${productId } /> --%>
                    <%-- 				<input type="hidden" name="orderId" value=${orderId } /> --%>
                    <!-- 				<table style="border-collapse: collapse;"> -->
                    <!-- 					<tr> -->
                    <!-- 						<td>Quantity</td> -->
                    <%-- 						<td><form:input path="quantity" /> <form:errors --%>
                    <!-- 								path="quantity" /></td> -->
                    <!-- 					</tr> -->
                    <!-- 					<tr> -->
                    <!-- 						<td>Dimension</td> -->
                    <%-- 						<td><form:select path="dimensionRef" items="${dimensions}" --%>
                    <%-- 								itemValue="id" /> <form:errors path="dimensionRef" /></td> --%>
                    <!-- 					</tr> -->
                    <!-- 					<tr> -->
                    <!-- 						<td></td> -->
                    <%-- 						<td><c:if test="${empty productId}"> --%>
                    <!-- 								<script type="text/javascript"> -->
                    <!-- 									function message() { -->
                    <!-- 										alert("You must select a product."); -->
                    <!-- 									} -->
                    <!-- 								</script> -->
                    <%-- 							</c:if> <c:if test="${orderId=='/'|| empty orderId}"> --%>
                    <!-- 								<script type="text/javascript"> -->
                    <!-- 									function message() { -->
                    <!-- 										alert("You are illegal user."); -->
                    <!-- 									} -->
                    <!-- 								</script> -->
                    <%-- 							</c:if> <input type="reset" value="Remove" --%>
                    <%-- 							onclick="javascript:window.location = 'products.htm?orderId=${orderId}'" /> --%>
                    <!-- 							<input type="submit" onclick="javascript:message()" value="Done" /> -->
                    <!-- 							<input type="button" value="Cancel" -->
                    <!-- 							onclick="javascript:window.location = 'cancelAndRedirect.htm'" /> -->
                    <!-- 						<td> -->
                    <!-- 					</tr> -->
                    <!-- 				</table> -->
                    <%-- 			</form:form> --%>
                    <!-- 		</fieldset> -->
                </fieldset>
            </div>
        </div>

        <div id="footer">
            <a href="http://www.google.com.ua">inspired by Google:)</a>
        </div>

    </div>
</div>
</body>
</html>
