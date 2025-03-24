<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My E-Commerce | Products</title>
    <link rel="stylesheet" href="assets/css/styles.css">
</head>
<body>

    <!-- Navigation Bar (repeated or extracted into a common fragment) -->
    <header>
        <nav class="navbar">
            <a href="index.jsp" class="logo">Oak Essentials</a>
            <ul class="nav-links">
                <li><a href="index.jsp">Home</a></li>
                <li><a href="products.jsp" class="active">Products</a></li>
                <li><a href="contact.jsp">Contact</a></li>
            </ul>
        </nav>
    </header>

    <section class="product-page">
        <h1>Our Products</h1>
        <div class="product-grid">
            <div class="product-item">
                <img src="assets/images/product1.jpg" alt="Product 1">
                <h2>Product 1</h2>
                <p>$19.99</p>
                <button>Add to Cart</button>
            </div>
            <div class="product-item">
                <img src="assets/images/product1.jpg" alt="Product 2">
                <h2>Product 2</h2>
                <p>$29.99</p>
                <button>Add to Cart</button>
            </div>
            <div class="product-item">
                <img src="assets/images/product1.jpg" alt="Product 3">
                <h2>Product 3</h2>
                <p>$39.99</p>
                <button>Add to Cart</button>
            </div>
            <!-- Add as many as you like -->
        </div>
    </section>

    <footer>
        <p>© 2025 Oak Essentials. All rights reserved.</p>
    </footer>

</body>
</html>
