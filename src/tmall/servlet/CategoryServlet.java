package tmall.servlet;

import tmall.bean.Category;
import tmall.util.Page;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class CategoryServlet extends BaseBackServlet {
    @Override
    public String add(HttpServletRequest request, HttpServletResponse response, Page page) {
        System.out.println("add");
        return "add";
    }

    @Override
    public String delete(HttpServletRequest request, HttpServletResponse response, Page page) {
        System.out.println("delete");
        return "delete";
    }

    @Override
    public String update(HttpServletRequest request, HttpServletResponse response, Page page) {
        System.out.println("update");
        return "update";
    }

    @Override
    public String edit(HttpServletRequest request, HttpServletResponse response, Page page) {
        System.out.println("edit");
        return "edit";
    }

    @Override
    //取出Category数据，并且交由listCategory.jsp显示
    public String list(HttpServletRequest request, HttpServletResponse response, Page page) {
        List<Category> cs = categoryDAO.list(page.getStart(), page.getCount());
        int total = categoryDAO.getTotal();
        page.setTotal(total);

        request.setAttribute("thecs", cs);
        request.setAttribute("page", page);
        return "admin/listCategory.jsp";
    }
}
