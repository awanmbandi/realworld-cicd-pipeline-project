package com.example.ecommerce.servlet;
import com.example.ecommerce.model.CartItem; import com.example.ecommerce.store.ProductRepository; import javax.servlet.*; import javax.servlet.annotation.WebServlet; import javax.servlet.http.*; import java.io.IOException; import java.util.*;
@WebServlet(name="CartServlet", urlPatterns={"/cart"})
public class CartServlet extends HttpServlet {
@SuppressWarnings("unchecked") private Map<String,CartItem> getCart(HttpSession s){ Object o=s.getAttribute("CART"); if(o==null){Map<String,CartItem> m=new LinkedHashMap<>(); s.setAttribute("CART",m); return m;} return (Map<String,CartItem>)o; }
protected void doGet(HttpServletRequest req,HttpServletResponse resp) throws ServletException,IOException { Map<String,CartItem> cart=getCart(req.getSession(true)); req.setAttribute("cart",cart); req.getRequestDispatcher("/WEB-INF/jsp/cart.jsp").forward(req, resp); }
protected void doPost(HttpServletRequest req,HttpServletResponse resp) throws ServletException,IOException {
Map<String,CartItem> cart=getCart(req.getSession(true)); String action=java.util.Optional.ofNullable(req.getParameter("action")).orElse("add"); String id=req.getParameter("id");
if("add".equalsIgnoreCase(action)&&id!=null){ ProductRepository.findById(id).ifPresent(p->{ CartItem it=cart.get(id); if(it==null){cart.put(id,new CartItem(p,1));} else {it.setQuantity(it.getQuantity()+1);} }); }
else if("update".equalsIgnoreCase(action)&&id!=null){ CartItem it=cart.get(id); if(it!=null){ try{ int qty=Integer.parseInt(req.getParameter("qty")); it.setQuantity(qty);}catch(NumberFormatException ignored){} } }
else if("remove".equalsIgnoreCase(action)&&id!=null){ cart.remove(id);} else if("clear".equalsIgnoreCase(action)){ cart.clear(); }
resp.sendRedirect(req.getContextPath()+"/cart"); } }