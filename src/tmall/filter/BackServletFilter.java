package tmall.filter;

import org.apache.commons.lang.StringUtils;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter(filterName = "BackServletFilter")
public class BackServletFilter implements Filter {
    public void destroy() {
    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;

        //以访问http://localhost:8080/tmall/admin_category_list为例：
        String contextPath = request.getServletContext().getContextPath();  //返回/tmall
        String uri = request.getRequestURI();       //返回/tmall/admin_category_list
        uri = StringUtils.remove(uri, contextPath); //为了去掉/tmall获取/admin_category_list
        if (uri.startsWith("/admin_")){
            String servletPath = StringUtils.substringBetween(uri, "_", "_") + "Servlet";   //获取category，并合并为categoryServlet
            String method = StringUtils.substringAfterLast(uri, "_");   //获取list
            request.setAttribute("method", method);
            request.getRequestDispatcher("/" + servletPath).forward(request, response);
            return;
        }

        chain.doFilter(request, response);
    }

    public void init(FilterConfig config) throws ServletException {

    }
}
