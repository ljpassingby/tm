package tmall.bean;

//订单Order和它是一对多关系
//用户User和它是一对多关系
//产品Product和它是一对多关系
public class OrderItem {
    private int id;
    private int number;
    private Product product;    //匹配pid
    private Order order;    //匹配oid
    private User user;  //匹配uid

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
