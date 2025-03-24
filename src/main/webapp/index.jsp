<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My E-Commerce | Home</title>
    <link rel="stylesheet" href="assets/css/styles.css">
    <!-- Optionally include Bootstrap via CDN -->
    <!-- <link rel="stylesheet" 
          href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> -->
</head>
<body>

    <!-- Navigation Bar -->
    <header>
        <nav class="navbar">
            <a href="index.jsp" class="logo">Oak Essentials</a>
            <ul class="nav-links">
                <li><a href="index.jsp">Home</a></li>
                <li><a href="products.jsp">Products</a></li>
                <li><a href="contact.jsp">Contact</a></li>
            </ul>
        </nav>
    </header>

    <!-- Hero Section -->
    <section class="hero">
        <img src="assets/images/hero.jpg" alt="Hero Image" class="hero-img">
        <div class="hero-content">
            <h1>Spring Sale</h1>
            <p>Get up to 40% off on all items!</p>
            <a href="products.jsp" class="btn">Shop Now</a>
        </div>
    </section>

    <!-- Some Featured Products or Other Content -->
    <section class="featured-products">
        <h2>Featured Products</h2>
        <div class="product-list">
            <div class="product-item">
                <img src="assets/images/product1.jpg" alt="Product 1">
                <h3>Product 1</h3>
                <p>$19.99</p>
            </div>
            <div class="product-item">
                <img src="assets/images/product1.jpg" alt="Product 2">
                <h3>Product 2</h3>
                <p>$29.99</p>
            </div>
            <div class="product-item">
                <img src="assets/images/product1.jpg" alt="Product 3">
                <h3>Product 3</h3>
                <p>$39.99</p>
            </div>
        </div>
    </section>

    <footer>
        <p>© 2025 Oak Essentials. All rights reserved.</p>
    </footer>

</body>
</html>
