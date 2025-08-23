<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html><html><head><title>Checkout</title><link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"></head><body>
<jsp:include page="shared/header.jsp" /><div class="container"><h1>Checkout</h1>
<c:if test="${not empty message}"><div class="alert success">${message}</div></c:if>
<form method="post" action="${pageContext.request.contextPath}/checkout" class="stack">
<label>Full Name<input type="text" name="name" required/></label>
<label>Email<input type="email" name="email" required/></label>
<label>Shipping Address<textarea name="address" required></textarea></label>
<button type="submit">Place Order</button></form></div><jsp:include page="shared/footer.jsp" /></body></html>