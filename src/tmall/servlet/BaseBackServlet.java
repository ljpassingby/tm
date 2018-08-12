package tmall.servlet;

import jdk.internal.util.xml.impl.Input;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import tmall.dao.*;
import tmall.util.Page;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Method;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

@WebServlet(name = "BaseBackServlet")
public abstract class BaseBackServlet extends HttpServlet {

    public abstract String add(HttpServletRequest request, HttpServletResponse response, Page page);
    public abstract String delete(HttpServletRequest request, HttpServletResponse response, Page page);
    public abstract String update(HttpServletRequest request, HttpServletResponse response, Page page);
    public abstract String edit(HttpServletRequest request, HttpServletResponse response, Page page);
    public abstract String list(HttpServletRequest request, HttpServletResponse response, Page page);

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
    protected void service(HttpServletRequest request, HttpServletResponse response){
        try {
            //获取分页信息
            int start = 0;
            int count = 5;  //表示每页显示5条
            //用于获取请求头中的request参数，若没有则取默认的start与count值
            try {
                start = Integer.parseInt(request.getParameter("page.start"));
            }catch (Exception e){}
            try {
                count = Integer.parseInt(request.getParameter("page.count"));
            }catch (Exception e){}
            Page page = new Page(start, count);

            //使用反射，获取request域传来的函数名字参数method，使用这个名字去调用对应的同名方法
            String method = (String) request.getAttribute("method");
            Method m = this.getClass().getMethod(method, javax.servlet.http.HttpServletRequest.class,
                    javax.servlet.http.HttpServletResponse.class, tmall.util.Page.class);
            //这个invoke不能返回null，因为后面还有个.toString()，若返回null这里会报错
            String redirect = m.invoke(this, request, response, page).toString();

            //根据方法的返回值redirect，产生不同的页面跳转
            if (redirect.startsWith("@"))
                response.sendRedirect(redirect.substring(1));   //用于重新跳转到list函数
            else if (redirect.startsWith("%"))
                response.getWriter().print(redirect.substring(1));  //配合ajax的回调函数的result
            else
                request.getRequestDispatcher(redirect).forward(request, response);  //跳转到jsp页面用于显示
        }catch (Exception e){
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    public InputStream parseUpLoad(HttpServletRequest request, Map<String, String> params){
        InputStream is = null;
        try {
            DiskFileItemFactory factory = new DiskFileItemFactory();
            //设置文件上传大小限制为10MB
            factory.setSizeThreshold(1024 * 10240);
            ServletFileUpload upload = new ServletFileUpload(factory);

            List items = upload.parseRequest(request);
            Iterator iterator = items.iterator();
            while (iterator.hasNext()){
                FileItem item = (FileItem) iterator.next();
                //来判断是否是常规字段还是提交的文件。 当item.isFormField返回true的时候，就表示是常规字段，若是非常规字段，如file类型，则返回false。
                //而且因为浏览器指定了以二进制的形式提交数据，那么就不能通过常规的手段获取非File字段，即通过request.getParameter("参数名")
                if(!item.isFormField()){
                    is = item.getInputStream();
                }else {
                    //这里读的是其他普通request里的参数，如图片名字name
                    String paramName = item.getFieldName();
                    String paramValue = item.getString();
                    //这里可能是从tomcat里读的，会有编码问题
                    paramValue = new String(paramValue.getBytes("iso-8859-1"), "UTF-8");
                    params.put(paramName, paramValue);
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return is;
    }
}
