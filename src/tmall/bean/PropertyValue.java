package tmall.bean;

//产品Product与它是一对多关系
//属性Property与它是一对多的关系
public class PropertyValue {
    private int id;
    private String value;       //产品属性值
    private Product product;    //匹配pid
    private Property property;  //匹配ptid

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public Property getProperty() {
        return property;
    }

    public void setProperty(Property property) {
        this.property = property;
    }
}
