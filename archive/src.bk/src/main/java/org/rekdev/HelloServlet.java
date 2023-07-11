package org.rekdev;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class HelloServlet extends HttpServlet {
  public static final Logger LOG = LoggerFactory.getLogger(HelloServlet.class);

  private String fakeObjectToString(Object o) {
    return o.getClass().getName() + "@" + Integer.toHexString(o.hashCode());
  }

  @Override
  public void init() throws ServletException {
    super.init();
    LOG.info("{} initialized!", this.getClass().getName());
  }

  public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
    PrintWriter out = res.getWriter();
    LOG.trace("doGet(req: {}, res: {})", req, fakeObjectToString(res));
    LOG.info("ROBERT!  This is a message from logback");
    System.out.println("ROBERT!  This is a message from System.out");
    System.err.println("ROBERT!  This is a message from System.err");

    LOG.trace("A message at TRACE");
    LOG.debug("A message at DEBUG");
    LOG.info("A message at INFO");
    LOG.warn("A message at WARN");
    LOG.error("A message at ERROR");

    String x_robert = req.getHeader("x-robert");
    String msg = String.format("req.getHeader(\"x-robert\"): %s", x_robert);

    LOG.info(msg);

    out.println("Hello, world!");
    out.println(msg);
    out.close();
  }
}
