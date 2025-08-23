package com.example.ecommerce.servlet;
import com.example.ecommerce.model.CartItem; import javax.servlet.*; import javax.servlet.annotation.WebServlet; import javax.servlet.http.*; import java.io.IOException; import java.util.Map;
@WebServlet(name="CheckoutServlet", urlPatterns={"/checkout"})
public class CheckoutServlet extends HttpServlet {
protected void doGet(HttpServletRequest req,HttpServletResponse resp) throws ServletException,IOException { req.getRequestDispatcher("/WEB-INF/jsp/checkout.jsp").forward(req, resp); }
@SuppressWarnings("unchecked") protected void doPost(HttpServletRequest req,HttpServletResponse resp) throws ServletException,IOException {
Object obj=req.getSession(true).getAttribute("CART"); if(obj instanceof Map){ ((Map<String,CartItem>)obj).clear(); }
req.setAttribute("message","Order placed successfully! (demo - no payment processed)"); req.getRequestDispatcher("/WEB-INF/jsp/checkout.jsp").forward(req, resp); } }