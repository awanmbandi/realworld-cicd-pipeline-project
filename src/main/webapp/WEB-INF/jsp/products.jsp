<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html><html><head><title>Products</title><link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"></head><body>
<jsp:include page="shared/header.jsp" /><div class="container"><h1>Product Catalog</h1><div class="grid">
<c:forEach var="p" items="${products}"><div class="card"><h3>${p.name}</h3><p class="desc">${p.description}</p><div class="price">$${p.price}</div>
<form method="post" action="${pageContext.request.contextPath}/cart"><input type="hidden" name="action" value="add"/><input type="hidden" name="id" value="${p.id}"/><button type="submit">Add to Cart</button></form>
</div></c:forEach></div></div><jsp:include page="shared/footer.jsp" /></body></html>