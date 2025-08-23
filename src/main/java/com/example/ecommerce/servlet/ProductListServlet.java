package com.example.ecommerce.servlet;
import com.example.ecommerce.store.ProductRepository; import javax.servlet.*; import javax.servlet.annotation.WebServlet; import javax.servlet.http.*; import java.io.IOException;
@WebServlet(name="ProductListServlet", urlPatterns={"/products"})
public class ProductListServlet extends HttpServlet { protected void doGet(HttpServletRequest req,HttpServletResponse resp) throws ServletException,IOException {
req.setAttribute("products", ProductRepository.findAll()); req.getRequestDispatcher("/WEB-INF/jsp/products.jsp").forward(req, resp);} }