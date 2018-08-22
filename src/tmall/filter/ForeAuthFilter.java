package tmall.filter;

import org.apache.commons.lang.StringUtils;
import tmall.bean.User;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;

public class ForeAuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        String servletContext = request.getServletContext().getContextPath();
        String uri = request.getRequestURI();
        uri = StringUtils.remove(uri, servletContext);
        //只要页面跳转不是以下几个跳转地址就返回登录页面，这样也能避免因长时间登录造成session过期而出现错误请求的情况
        String[] noNeedAuthPage = new String[]{ "home",
                "checkLogin",
                "register",
                "loginAjax",
                "login",
                "product",
                "category",
                "search"};
        if (uri.startsWith("/fore") && !uri.startsWith("/foreServlet")){
            String method = StringUtils.remove(uri, "/fore");
            if (!Arrays.asList(noNeedAuthPage).contains(method)){
                User user = (User) request.getSession().getAttribute("user");
                if (null == user){
                    response.sendRedirect("login.jsp");
                    return;
                }
            }
        }
        filterChain.doFilter(request, response);
    }

    @Override
    public void destroy() {

    }
}
