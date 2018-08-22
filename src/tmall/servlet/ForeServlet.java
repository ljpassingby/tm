package tmall.servlet;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.RandomUtils;
import org.springframework.web.util.HtmlUtils;
import tmall.bean.*;
import tmall.dao.OrderDAO;
import tmall.dao.ProductImageDAO;
import tmall.util.Page;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class ForeServlet extends BaseForeServlet {
//    主页显示
    public String home(HttpServletRequest request, HttpServletResponse response, Page page){
        List<Category> categoryList = categoryDAO.list();
        productDAO.fill(categoryList);
        productDAO.fillByRow(categoryList);
        request.setAttribute("categoryList", categoryList);
        return "home.jsp";
    }
//    注册操作
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
//    登录判断操作
    public String login(HttpServletRequest request, HttpServletResponse response, Page page){
        String name = request.getParameter("name");
        name = HtmlUtils.htmlEscape(name);
        String password = request.getParameter("password");
        User user = userDAO.get(name, password);
        if (null == user){
            String msg = "输入用户名或密码错误";
            request.setAttribute("msg", msg);
            return "login.jsp";
        }
        //登录后在最上面显示当前用户的购物车内的数量
        int cartTotalItemNumber = 0;
        List<OrderItem> orderItemList = orderItemDAO.listByUser(user.getId());
        for (OrderItem orderItem : orderItemList) {
            cartTotalItemNumber += orderItem.getNumber();
        }
        request.getSession().setAttribute("cartTotalItemNumber", cartTotalItemNumber);
        request.getSession().setAttribute("user", user);    //要在session域中存储用户信息
        return "@forehome";
    }
//    退出登录操作
    public String logout(HttpServletRequest request, HttpServletResponse response, Page page){
        request.getSession().removeAttribute("user");
        return "@forehome";
    }
//    显示指定产品信息的页面操作
    public String product(HttpServletRequest request, HttpServletResponse response, Page page){
        int pid = Integer.parseInt(request.getParameter("pid"));
        Product product = productDAO.get(pid);  //get方法内部调用了setFirstProductImage方法，而setFirstProductImage方法自己读取了
        List<ProductImage> productSingleImages = productImageDAO.list(product, ProductImageDAO.type_single);
        List<ProductImage> productDetailImages = productImageDAO.list(product, ProductImageDAO.type_detail);
        product.setProductSingleImages(productSingleImages);    //用于显示产品页所有小图片
        product.setProductDetailImages(productDetailImages);    //用于显示产品页所有详情图片的大图片

        productDAO.setFirstProductImage(product);   //设置product的第一张图片信息
        productDAO.setSaleAndReviewNumber(product); // 设置product的历史销量与评价量信息

        List<Review> reviewList = reviewDAO.list(product.getId());
        List<PropertyValue> propertyValueList = propertyValueDAO.list(product.getId());
        request.setAttribute("reviewList", reviewList); //将对应产品的所有评论内容传送过去
        request.setAttribute("propertyValueList", propertyValueList);   //将对应产品的所有属性值传送过去
        request.setAttribute("product", product);
        return "product.jsp";
    }
//    模态登录窗口弹出判断，给ajax反馈
    public String checkLogin(HttpServletRequest request, HttpServletResponse response, Page page){
        User user = (User) request.getSession().getAttribute("user");   //判断若当前用户为登录，则创建模态登录
        if (null != user)
            return "%success";
        return "%fail";
    }
//    模态登录提交登录请求判断，给ajax反馈
    public String loginAjax(HttpServletRequest request, HttpServletResponse response, Page page) {
        String name = request.getParameter("name");
        String password = request.getParameter("password");
        User user = userDAO.get(name, password);
        if (null == user)
            return "%fail";
        request.getSession().setAttribute("user", user);
        return "%success";
    }
//    显示指定类别下所有产品的页面
    public String category(HttpServletRequest request, HttpServletResponse response, Page page) {
        int cid = Integer.parseInt(request.getParameter("cid"));
        Category category = categoryDAO.get(cid);
        productDAO.fill(category);
        productDAO.setSaleAndReviewNumber(category.getProducts());

        List<Product> productList = category.getProducts();
        String sort = request.getParameter("sort"); //根据页面点击的排序方式进行排序
        if (null != sort){
            switch (sort){
                case "review":
                    productList.sort((p1, p2) -> p2.getReviewCount() - p1.getReviewCount());
                    break;
                case "date":
                    productList.sort((p1, p2) -> p2.getCreateDate().compareTo(p1.getCreateDate()));
                    break;
                case "saleCount":
                    productList.sort((p1, p2) -> p2.getSaleCount() - p1.getSaleCount());
                    break;
                case "price":
                    productList.sort((p1, p2) -> (int)(p1.getPromotePrice() - p2.getPromotePrice()));
                    break;
                case "all":
                    productList.sort((p1, p2) -> p2.getReviewCount() * p2.getSaleCount() - p1.getReviewCount() * p1.getSaleCount());
                    break;
                default:
                    break;
            }
        }

        request.setAttribute("category", category);
        return "category.jsp";
    }
//    搜索栏功能
    public String search(HttpServletRequest request, HttpServletResponse response, Page page) {
        String keyword = request.getParameter("keyword");
        List<Product> productList = productDAO.search(keyword, page.getStart(), page.getCount());
        productDAO.setSaleAndReviewNumber(productList);
        request.setAttribute("productList", productList);
        return "searchResult.jsp";
    }
//    产品页点击立即购买功能
    public String buyone(HttpServletRequest request, HttpServletResponse response, Page page) {
        int pid = Integer.parseInt(request.getParameter("pid"));
        int num = Integer.parseInt(request.getParameter("num"));
        Product product = productDAO.get(pid);
        User user = (User) request.getSession().getAttribute("user");
        int oiid = 0 ;
        boolean found = false;
        List<OrderItem> orderItemList = orderItemDAO.listByUser(user.getId());
        //如果已经存在这个产品对应的OrderItem，并且还没有生成订单，即还在购物车中。 那么就应该在对应的OrderItem基础上，调整数量
        for (OrderItem oi : orderItemList){
            if (oi.getProduct().getId() == product.getId()){
                oi.setNumber(oi.getNumber() + num);
                orderItemDAO.update(oi);
                oiid = oi.getId();
                found = true;
                break;
            }
        }
        //如果不存在对应的OrderItem,那么就新增一个订单项OrderItem
        if (!found){
            OrderItem orderItem = new OrderItem();
            orderItem.setNumber(num);
            orderItem.setProduct(product);
            orderItem.setUser(user);
            orderItemDAO.add(orderItem);
            oiid = orderItem.getId();
        }

        return "@forebuy?oiid=" + oiid; //基于这个订单项id客户端跳转到结算页面/forebuy
    }
//    购物车的结算按键功能，结算完成跳转到结算完成页面buy.jsp
    public String buy(HttpServletRequest request, HttpServletResponse response, Page page) {
        String[] oiids = request.getParameterValues("oiid");
        List<OrderItem> orderItemList = new ArrayList<>();
        float total = 0;
        for (String oiid : oiids){
            OrderItem orderItem = orderItemDAO.get(Integer.parseInt(oiid));
            total += orderItem.getNumber() * orderItem.getProduct().getPromotePrice();  //计算所有订单项的总价格
            orderItemList.add(orderItem);
        }
        request.getSession().setAttribute("orderItemList", orderItemList);  //提交的订单的所有订单项集合要存入session域中
        request.setAttribute("total", total);
        return "buy.jsp";
    }
//    点击加入购物车选项的功能，给前端ajax响应
    public String addCart(HttpServletRequest request, HttpServletResponse response, Page page) {
        int pid = Integer.parseInt(request.getParameter("pid"));
        int num = Integer.parseInt(request.getParameter("num"));
        Product product = productDAO.get(pid);
        User user = (User) request.getSession().getAttribute("user");
        int cartTotalItemNumber = (int) request.getSession().getAttribute("cartTotalItemNumber");
        boolean found = false;
        //如果已经存在这个产品对应的OrderItem，并且还没有生成订单，即还在购物车中。 那么就应该在对应的OrderItem基础上，调整数量
        List<OrderItem> orderItemList = orderItemDAO.listByUser(user.getId());
        for (OrderItem orderItem : orderItemList){
            if (orderItem.getProduct().getId() == pid){
                orderItem.setNumber(orderItem.getNumber() + num);
                orderItemDAO.update(orderItem);
                found = true;

                cartTotalItemNumber += num;
                request.getSession().setAttribute("cartTotalItemNumber", cartTotalItemNumber);  //设置最上方购物车数量
                break;
            }
        }
        //如果不存在对应的OrderItem,那么就新增一个订单项OrderItem
        if (!found){
            OrderItem orderItem = new OrderItem();
            orderItem.setNumber(num);
            orderItem.setUser(user);
            orderItem.setProduct(product);
            orderItemDAO.add(orderItem);
        }
        return "%success";
    }
//    查看购物车页面功能
    public String cart(HttpServletRequest request, HttpServletResponse response, Page page) {
        User user = (User) request.getSession().getAttribute("user");
        List<OrderItem> orderItemList = orderItemDAO.listByUser(user.getId());
        request.setAttribute("orderItemList", orderItemList);
        return "cart.jsp";
    }
//    购物车调整订单项数量，给前端cartPage.jsp的ajax响应
    public String changeOrderItem(HttpServletRequest request, HttpServletResponse response, Page page) {
        User user = (User) request.getSession().getAttribute("user");
        if (null == user)
            return "%fail";
        int pid = Integer.parseInt(request.getParameter("pid"));
        int num = Integer.parseInt(request.getParameter("num"));
        int cartTotalItemNumber = (int) request.getSession().getAttribute("cartTotalItemNumber");

        List<OrderItem> orderItemList = orderItemDAO.listByUser(user.getId());
        for (OrderItem orderItem : orderItemList){
            if (orderItem.getProduct().getId() == pid){
                cartTotalItemNumber -= orderItem.getNumber();
                cartTotalItemNumber += num;
                request.getSession().setAttribute("cartTotalItemNumber", cartTotalItemNumber);  //修改订单项时，购物车数量跟着改

                orderItem.setNumber(num);
                orderItemDAO.update(orderItem);
                break;
            }
        }
        return "%success";
    }
//    删除订单项，给前端cartPage.jsp的ajax响应
    public String deleteOrderItem(HttpServletRequest request, HttpServletResponse response, Page page) {
        User user = (User) request.getSession().getAttribute("user");
        if (null == user)
            return "%fail";
        int oiid = Integer.parseInt(request.getParameter("oiid"));
        int cartTotalItemNumber = (int) request.getSession().getAttribute("cartTotalItemNumber");
        cartTotalItemNumber -= orderItemDAO.get(oiid).getNumber();
        request.getSession().setAttribute("cartTotalItemNumber", cartTotalItemNumber);  //删除订单项时，购物车数量跟着改

        orderItemDAO.delete(oiid);
        return "%success";
    }
//    查看我的订单功能
    public String order(HttpServletRequest request, HttpServletResponse response, Page page) {
        User user = (User) request.getSession().getAttribute("user");
        if (null == user)
            return "@login.jsp";    //预防登录超时
        List<Order> orderList = orderDAO.list(user.getId(), OrderDAO.delete);   //这是指去掉delete状态其他所有订单
        orderItemDAO.fill(orderList);   //计算每个订单的订单项总数与总金额
        request.setAttribute("orderList", orderList);
        return "order.jsp";
    }
//    结算完成页面的“生成订单”按键功能，点击正式生成订单order，并跳转到支付页面
    public String createOrder(HttpServletRequest request, HttpServletResponse response, Page page) {
        List<OrderItem> orderItemList = (List<OrderItem>) request.getSession().getAttribute("orderItemList");
        if (orderItemList.isEmpty())
            return "@login.jsp";
        User user = (User) request.getSession().getAttribute("user");
        Date createDate = new Date();
        String address = request.getParameter("address");
        String post = request.getParameter("post");
        String receiver = request.getParameter("receiver");
        String mobile = request.getParameter("mobile");
        String userMessage = request.getParameter("userMessage");
        String orderCode = new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date()) + RandomUtils.nextInt(10000);

        Order order = new Order();
        order.setOrderCode(orderCode);
        order.setAddress(address);
        order.setPost(post);
        order.setReceiver(receiver);
        order.setMobile(mobile);
        order.setUserMessage(userMessage);
        order.setUser(user);
        order.setCreateDate(createDate);
        order.setStatus("waitPay"); //设置订单状态为待付款，很重要！这样设置后购物车就会没有该产品，该产品转而在我的订单页面显示为待付款状态
        orderDAO.add(order);

        float total = 0;
        int num = 0;
        int cartTotalItemNumber = (int) request.getSession().getAttribute("cartTotalItemNumber");
        for (OrderItem orderItem : orderItemList){
            orderItem.setOrder(order);  //这样数据库中的orderItem表中各项的oid就不会是-1了
            orderItemDAO.update(orderItem); //当生成订单后，更新订单项表中的oid字段
            total += orderItem.getNumber() * orderItem.getProduct().getPromotePrice();  //获得总价格
            num += orderItem.getNumber();
        }
        cartTotalItemNumber -= num;
        request.getSession().setAttribute("cartTotalItemNumber", cartTotalItemNumber);  //提交订单后，购车车显示数量去掉生成订单的这几项
        return "@forealipay?oid=" + order.getId() + "&total=" + total;
    }
//    支付页面处理支付信息，跳转到支付页面
    public String alipay(HttpServletRequest request, HttpServletResponse response, Page page) {
        return "alipay.jsp";
    }
//    支付成功页面跳转请求处理，并跳转到支付成功页面
    public String payed(HttpServletRequest request, HttpServletResponse response, Page page) {
        int oid = Integer.parseInt(request.getParameter("oid"));
        Order order = orderDAO.get(oid);
        order.setStatus(OrderDAO.waitDelivery); //支付成功后修改订单状态status
        order.setPayDate(new Date());   //新增支付时间
        orderDAO.update(order);
        request.setAttribute("order", order);
        return "payed.jsp";
    }
//    "确认收货页面"跳转请求处理,处理成功后跳转到“确认收货页面”confirmPay.jsp
    public String confirmPay(HttpServletRequest request, HttpServletResponse response, Page page) {
        int oid = Integer.parseInt(request.getParameter("oid"));
        Order order = orderDAO.get(oid);
        orderItemDAO.fill(order);   //计算订单中商品总价，这不是数据库数据，因此要单独调用
        request.setAttribute("order", order);
        return "confirmPay.jsp";
    }
//    "确认收货页面"点击“确认支付”后跳转请求处理页面，处理成功后跳转到"确认收货成功页面"
    public String orderConfirmed(HttpServletRequest request, HttpServletResponse response, Page page) {
        int oid = Integer.parseInt(request.getParameter("oid"));
        Order order = orderDAO.get(oid);
        order.setConfirmDate(new Date());
        order.setStatus(OrderDAO.waitReview);
        orderDAO.update(order);
        return "orderConfirmed.jsp";
    }
//    在我的订单页面点击删除按键触发，给前端orderPage.jsp的ajax回应
    public String deleteOrder(HttpServletRequest request, HttpServletResponse response, Page page) {
        int oid = Integer.parseInt(request.getParameter("oid"));
        Order order = orderDAO.get(oid);
        order.setStatus(OrderDAO.delete);   //设置状态为用户删除状态，但是订单在数据库中不会删除
        orderDAO.update(order);
        return "%success";
    }
//    评价页面跳转请求，处理成功后跳转到评价产品页面
    public String review(HttpServletRequest request, HttpServletResponse response, Page page){
        int oid = Integer.parseInt(request.getParameter("oid"));
        Order order = orderDAO.get(oid);
        orderItemDAO.fill(order);
        Product product = order.getOrderItems().get(0).getProduct();
        productDAO.setSaleAndReviewNumber(product);
        List<Review> reviewList = reviewDAO.list(product.getId());
        request.setAttribute("order", order);
        request.setAttribute("product", product);
        request.setAttribute("reviewList", reviewList);
        return "review.jsp";
    }
//    获得用户提交的评价内容
    public String doreview(HttpServletRequest request, HttpServletResponse response, Page page) {
        User user = (User) request.getSession().getAttribute("user");
        int pid = Integer.parseInt(request.getParameter("pid"));
        Product product = productDAO.get(pid);
        String content = request.getParameter("content");
        content = HtmlUtils.htmlEscape(content);    //content转义

        int oid = Integer.parseInt(request.getParameter("oid"));
        Order order = orderDAO.get(oid);
        order.setStatus(OrderDAO.finish);   //修改订单状态
        orderDAO.update(order);

        Review review = new Review();
        review.setContent(content);
        review.setCreateDate(new Date());
        review.setProduct(product);
        review.setUser(user);
        reviewDAO.add(review);
        return "@forereview?oid=" + oid + "&showonly=true";  //true表示已评价，若是false则表示未评价
    }
}
