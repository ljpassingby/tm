package tmall.bean;

//产品Product和它是一对多关系
public class ProductImage {
    private int id;
    private String type;
    private Product product;    //匹配pid相关

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }
}
