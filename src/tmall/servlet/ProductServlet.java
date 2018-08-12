package tmall.servlet;

import tmall.bean.Category;
import tmall.bean.Product;
import tmall.bean.Property;
import tmall.bean.PropertyValue;
import tmall.util.Page;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.List;

public class ProductServlet extends BaseBackServlet {
    @Override
    public String add(HttpServletRequest request, HttpServletResponse response, Page page) {
        int cid = Integer.parseInt(request.getParameter("cid"));
        Product product = new Product();
        Category category = categoryDAO.get(cid);

        String name = request.getParameter("name");
        String subTitle = request.getParameter("subTitle");
        float originalPrice = Float.parseFloat(request.getParameter("originalPrice"));
        float promotePrice = Float.parseFloat(request.getParameter("promotePrice"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        java.util.Date createDate = new Date();

        product.setName(name);
        product.setSubTitle(subTitle);
        product.setOriginalPrice(originalPrice);
        product.setPromotePrice(promotePrice);
        product.setStock(stock);
        product.setCategory(category);
        product.setCreateDate(createDate);
        productDAO.add(product);
        return "@admin_product_list?cid=" + cid;
    }

    @Override
    public String delete(HttpServletRequest request, HttpServletResponse response, Page page) {
        int id = Integer.parseInt(request.getParameter("id"));
        Category category = productDAO.get(id).getCategory();
        productDAO.delete(id);
        return "@admin_product_list?cid=" + category.getId();
    }

    @Override
    public String update(HttpServletRequest request, HttpServletResponse response, Page page) {
        int cid = Integer.parseInt(request.getParameter("cid"));
        Category category = categoryDAO.get(cid);
        int id = Integer.parseInt(request.getParameter("id"));
        Product product = productDAO.get(id);

        String name = request.getParameter("name");
        String subTitle = request.getParameter("subTitle");
        float originalPrice = Float.parseFloat(request.getParameter("originalPrice"));
        float promotePrice = Float.parseFloat(request.getParameter("promotePrice"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        product.setName(name);
        product.setSubTitle(subTitle);
        product.setOriginalPrice(originalPrice);
        product.setPromotePrice(promotePrice);
        product.setStock(stock);
        product.setCategory(category);
        productDAO.update(product);
        return "@admin_product_list?cid=" + cid;
    }

    public String updatePropertyValue(HttpServletRequest request, HttpServletResponse response, Page page) {
        int id = Integer.parseInt(request.getParameter("pvid"));
        String value = request.getParameter("value");
        PropertyValue propertyValue = propertyValueDAO.get(id);
        propertyValue.setValue(value);
        propertyValueDAO.update(propertyValue);
        return "%success";  //靠打印一个success到web页面上来给ajax的回调函数的result赋值
    }

    @Override
    public String edit(HttpServletRequest request, HttpServletResponse response, Page page) {
        int id = Integer.parseInt(request.getParameter("id"));
        Product product = productDAO.get(id);
        Category category = product.getCategory();

        request.setAttribute("c", category);
        request.setAttribute("p", product);
        return "admin/editProduct.jsp";
    }

    public String editPropertyValue(HttpServletRequest request, HttpServletResponse response, Page page) {
        int pid = Integer.parseInt(request.getParameter("id"));
        Product product = productDAO.get(pid);
        propertyValueDAO.init(product); //如果是第一次访问，初始化这些属性值

        List<PropertyValue> pvs = propertyValueDAO.list(pid);
        request.setAttribute("product", product); //只传一个一个product，通过${product.category.id}就能获取到cid
        request.setAttribute("propertyValues", pvs);
        return "admin/editPropertyValue.jsp";
    }

    @Override
    public String list(HttpServletRequest request, HttpServletResponse response, Page page) {
        int cid = Integer.parseInt(request.getParameter("cid"));
        Category category = categoryDAO.get(cid);
        List<Product> products = productDAO.list(cid, page.getStart(), page.getCount());
        int total = productDAO.getTotal(cid);
        page.setTotal(total);
        page.setParam("&cid=" + cid);

        request.setAttribute("c", category);
        request.setAttribute("products", products);
        request.setAttribute("page", page);
        return "admin/listProduct.jsp";
    }
}
