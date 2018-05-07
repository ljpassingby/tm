package tmall.bean;

import java.util.Date;
import java.util.List;

//用户User和它是一对多的关系
public class Order {
    //数据库相关
    private int id;
    private String orderCode;   //订单编号
    private String address;     //订单地址
    private String post;        //
    private String receiver;
    private String mobile;      //用户手机号
    private String userMessage;
    private Date createDate;    //创建订单时间
    private Date payDate;       //支付时间
    private Date deliveryDate;  //发货时间
    private Date confirmDate;   //确认收货时间
    private String status;      //商品状态：待付款、待发货、待确认收货
    private User user;          //匹配uid

    //非数据库相关
    private List<OrderItem> orderItems;
    private float total;        //订单总金额
    private float totalNumber;  //订单项总数量

    //数据库相关
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getOrderCode() {
        return orderCode;
    }

    public void setOrderCode(String orderCode) {
        this.orderCode = orderCode;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPost() {
        return post;
    }

    public void setPost(String post) {
        this.post = post;
    }

    public String getReceiver() {
        return receiver;
    }

    public void setReceiver(String receiver) {
        this.receiver = receiver;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getUserMessage() {
        return userMessage;
    }

    public void setUserMessage(String userMessage) {
        this.userMessage = userMessage;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Date getPayDate() {
        return payDate;
    }

    public void setPayDate(Date payDate) {
        this.payDate = payDate;
    }

    public Date getDeliveryDate() {
        return deliveryDate;
    }

    public void setDeliveryDate(Date deliveryDate) {
        this.deliveryDate = deliveryDate;
    }

    public Date getConfirmDate() {
        return confirmDate;
    }

    public void setConfirmDate(Date confirmDate) {
        this.confirmDate = confirmDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    //非数据库相关
    public List<OrderItem> getOrderItems() {
        return orderItems;
    }

    public void setOrderItems(List<OrderItem> orderItems) {
        this.orderItems = orderItems;
    }

    public float getTotal() {
        return total;
    }

    public void setTotal(float total) {
        this.total = total;
    }

    public float getTotalNumber() {
        return totalNumber;
    }

    public void setTotalNumber(float totalNumber) {
        this.totalNumber = totalNumber;
    }

    public String getStatusDesc(){
        String desc ="未知";
        switch(status){
//          case OrderDAO.waitPay:
//              desc="待付款";
//              break;
//          case OrderDAO.waitDelivery:
//              desc="待发货";
//              break;
//          case OrderDAO.waitConfirm:
//              desc="待收货";
//              break;
//          case OrderDAO.waitReview:
//              desc="等评价";
//              break;
//          case OrderDAO.finish:
//              desc="完成";
//              break;
//          case OrderDAO.delete:
//              desc="刪除";
//              break;
//          default:
//              desc="未知";
        }
        return desc;
    }
}
