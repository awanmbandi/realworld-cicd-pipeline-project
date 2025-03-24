package com.example.myecommerce.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;

public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public HomeServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
        
        // You can do any dynamic processing here, e.g., retrieve data from a model
        // For now, we'll just forward to index.jsp
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}
