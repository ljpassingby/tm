package tmall.servlet;

import org.springframework.web.util.HtmlUtils;
import tmall.bean.Category;
import tmall.bean.User;
import tmall.util.Page;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

public class ForeServlet extends BaseForeServlet {
    public String home(HttpServletRequest request, HttpServletResponse response, Page page){
        List<Category> categoryList = categoryDAO.list();
        productDAO.fill(categoryList);
        productDAO.fillByRow(categoryList);
        request.setAttribute("categoryList", categoryList);
        return "home.jsp";
    }
    public String register(HttpServletRequest request, HttpServletResponse response, Page page){
        String name = request.getParameter("name");
        String password = request.getParameter("password");
//        通过HtmlUtils.htmlEscape(name);把账号里的特殊符号进行转义
//        如<会被转义成&lt;
//        这个做法目的是防止注册一些恶意ID，如 <script>alert('papapa')</script> 这样的名称，会导致网页打开就弹出一个对话框。
        name = HtmlUtils.htmlEscape(name);
        System.out.println(name);
        Boolean exist = userDAO.isExist(name);
        if (exist){
            String msg = "用户名已经被使用,不能使用";
            request.setAttribute("msg", msg);
            return "register.jsp";
        }
        User user = new User();
        user.setName(name);
        user.setPassword(password);
        userDAO.add(user);
        return "@registerSuccess.jsp";
    }
}
