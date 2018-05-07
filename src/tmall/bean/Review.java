package tmall.bean;

import java.util.Date;

//用户User和它是一对多的关系
//产品Product和它是一对多的关系
public class Review {
    private int id;
    private String content; //评论内容
    private Date createDate;    //发表评论的时间
    private User user;      //匹配uid
    private Product product;    //匹配pid

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }
}
