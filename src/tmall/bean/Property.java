package tmall.bean;

//分类Category与其是一对多的关系
public class Property {
    private int id;
    private Category category ; //匹配cid用
    private String name;        //产品属性名字

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }
}
