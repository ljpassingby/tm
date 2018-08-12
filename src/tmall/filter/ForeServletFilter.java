package tmall.filter;

import org.apache.commons.lang.StringUtils;
import tmall.bean.Category;
import tmall.dao.CategoryDAO;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class ForeServletFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;

        String contextPath = request.getServletContext().getContextPath();
        request.setAttribute("contextPath", contextPath);   //将/tmall传给前端

//       还有个关于用户登陆判断的代码

//      关于简易搜索栏simpleSearch的代码,categoryList在foreServlet的list函数中给request域存进去了，
//      这段是保证用户首先访问注册页面时依旧能有category数据
        List<Category> categoryList = (List<Category>) request.getAttribute("categoryList");
        if (null == categoryList){
            categoryList = new CategoryDAO().list();
            request.setAttribute("categoryList", categoryList);
        }

        String uri = request.getRequestURI();
        uri = StringUtils.remove(uri, contextPath);
        if (uri.startsWith("/fore") && !uri.startsWith("/foreServlet")){
            String method = StringUtils.remove(uri, "/fore");
            request.setAttribute("method", method);
            request.getRequestDispatcher("/foreServlet").forward(request, response);
            return;
        }
        filterChain.doFilter(request, response);
    }

    @Override
    public void destroy() {

    }
}
