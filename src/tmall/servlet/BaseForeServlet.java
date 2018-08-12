package tmall.servlet;

import tmall.dao.*;
import tmall.util.Page;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.Method;

public class BaseForeServlet extends HttpServlet {

    protected CategoryDAO categoryDAO = new CategoryDAO();
    protected OrderDAO orderDAO = new OrderDAO();
    protected OrderItemDAO orderItemDAO = new OrderItemDAO();
    protected ProductDAO productDAO = new ProductDAO();
    protected ProductImageDAO productImageDAO = new ProductImageDAO();
    protected PropertyDAO propertyDAO = new PropertyDAO();
    protected PropertyValueDAO propertyValueDAO = new PropertyValueDAO();
    protected ReviewDAO reviewDAO = new ReviewDAO();
    protected UserDAO userDAO = new UserDAO();

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) {
        try {
            int start = 0;
            int count = 10;
            try {
                start = Integer.parseInt(request.getParameter("page.start"));
            }catch (Exception e){}
            try {
                count = Integer.parseInt(request.getParameter("page.count"));
            }catch (Exception e){}
            Page page = new Page(start, count);

            String method = (String) request.getAttribute("method");
            Method m = this.getClass().getMethod(method, javax.servlet.http.HttpServletRequest.class,
                    javax.servlet.http.HttpServletResponse.class, tmall.util.Page.class);
            String redirect = m.invoke(this, request, response, page).toString();
            if (redirect.startsWith("@")){
                response.sendRedirect(redirect.substring(1));   //用于重新调用servlet的函数
            }else if (redirect.startsWith("%")){
                response.getWriter().print(redirect.substring(1));  //配合ajax的回调函数
            }else {
                request.getRequestDispatcher(redirect).forward(request, response);  //跳转到jsp页面进行显示
            }
        }catch (Exception e){
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }
}
