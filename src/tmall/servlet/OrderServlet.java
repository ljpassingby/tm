package tmall.servlet;

import tmall.bean.Order;
import tmall.dao.OrderDAO;
import tmall.util.Page;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.List;

public class OrderServlet extends BaseBackServlet {
    @Override
    public String add(HttpServletRequest request, HttpServletResponse response, Page page) {
        return null;
    }

    @Override
    public String delete(HttpServletRequest request, HttpServletResponse response, Page page) {
        return null;
    }

    @Override
    public String update(HttpServletRequest request, HttpServletResponse response, Page page) {
        return null;
    }

    @Override
    public String edit(HttpServletRequest request, HttpServletResponse response, Page page) {
        return null;
    }

    public String delivery(HttpServletRequest request, HttpServletResponse response, Page page){
        int oid = Integer.parseInt(request.getParameter("id"));
        Order order = orderDAO.get(oid);
        order.setStatus(OrderDAO.waitConfirm);
        order.setDeliveryDate(new Date());
        orderDAO.update(order);
        return "%admin_order_list";
    }

    @Override
    public String list(HttpServletRequest request, HttpServletResponse response, Page page) {
        List<Order> orders = orderDAO.list(page.getStart(), page.getCount());
        orderItemDAO.fill(orders);  //计算每一个订单的总金额与订单项(商品)总数，这两个是Order的非数据库相关的属性
        int total = orderDAO.getTotal();
        page.setTotal(total);

        request.setAttribute("page", page);
        request.setAttribute("orders", orders);
        return "admin/listOrder.jsp";
    }
}
