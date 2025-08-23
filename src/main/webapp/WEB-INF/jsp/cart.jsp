<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html><html><head><title>Your Cart</title><link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"></head><body>
<jsp:include page="shared/header.jsp" /><div class="container"><h1>Your Cart</h1><c:set var="hasItems" value="${not empty cart}" />
<c:choose><c:when test="${hasItems}"><table><thead><tr><th>Product</th><th>Price</th><th>Qty</th><th>Total</th><th>Action</th></tr></thead><tbody>
<c:set var="grand" value="0" scope="page" /><c:forEach var="entry" items="${cart}"><c:set var="item" value="${entry.value}" />
<tr><td>${item.product.name}</td><td>$${item.product.price}</td><td>
<form method="post" action="${pageContext.request.contextPath}/cart" class="inline"><input type="hidden" name="action" value="update"/><input type="hidden" name="id" value="${item.product.id}"/>
<input type="number" name="qty" value="${item.quantity}" min="1" class="qty"/><button type="submit">Update</button></form></td><td>$${item.total}</td><td>
<form method="post" action="${pageContext.request.contextPath}/cart" class="inline"><input type="hidden" name="action" value="remove"/><input type="hidden" name="id" value="${item.product.id}"/>
<button type="submit" class="danger">Remove</button></form></td></tr>
<c:set var="grand" value="${grand + item.total}" scope="page" /></c:forEach></tbody><tfoot><tr><td colspan="3" class="right">Grand Total</td><td colspan="2">$${grand}</td></tr></tfoot></table>
<div class="actions"><form method="post" action="${pageContext.request.contextPath}/cart" class="inline"><input type="hidden" name="action" value="clear"/>
<button type="submit" class="secondary">Clear Cart</button></form><a class="link" href="${pageContext.request.contextPath}/products">Continue Shopping</a>
<a class="button" href="${pageContext.request.contextPath}/checkout">Proceed to Checkout</a></div></c:when>
<c:otherwise><p>Your cart is empty.</p><a class="button" href="${pageContext.request.contextPath}/products">Browse Products</a></c:otherwise></c:choose></div>
<jsp:include page="shared/footer.jsp" /></body></html>