<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My E-Commerce | Contact</title>
    <link rel="stylesheet" href="assets/css/styles.css">
</head>
<body>

    <!-- Navigation Bar -->
    <header>
        <nav class="navbar">
            <a href="index.jsp" class="logo">Oak Essentials</a>
            <ul class="nav-links">
                <li><a href="index.jsp">Home</a></li>
                <li><a href="products.jsp">Products</a></li>
                <li><a href="contact.jsp" class="active">Contact</a></li>
            </ul>
        </nav>
    </header>

    <section class="contact-section">
        <h1>Contact Us</h1>
        <p>We would love to hear from you. Please fill out the form below.</p>
        <form action="#" method="post">
            <label for="name">Name:</label><br>
            <input type="text" id="name" name="name"><br>

            <label for="email">Email:</label><br>
            <input type="email" id="email" name="email"><br>

            <label for="message">Message:</label><br>
            <textarea id="message" name="message"></textarea><br>

            <button type="submit">Submit</button>
        </form>
    </section>

    <footer>
        <p>© 2025 Oak Essentials. All rights reserved.</p>
    </footer>

</body>
</html>
