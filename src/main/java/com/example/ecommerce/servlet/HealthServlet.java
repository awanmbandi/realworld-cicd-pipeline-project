package com.example.ecommerce.servlet;
import javax.servlet.annotation.WebServlet; import javax.servlet.http.*; import java.io.IOException;
@WebServlet(name="HealthServlet", urlPatterns={"/health"})
public class HealthServlet extends HttpServlet { protected void doGet(HttpServletRequest req,HttpServletResponse resp) throws IOException { resp.setContentType("text/plain"); resp.getWriter().println("OK"); } }