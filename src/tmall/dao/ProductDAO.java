package tmall.dao;

import tmall.bean.Category;
import tmall.bean.Product;
import tmall.bean.ProductImage;
import tmall.util.DBUtil;
import tmall.util.DateUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.ConcurrentModificationException;
import java.util.Date;
import java.util.List;

public class ProductDAO {

    //根据cid查询总数目
    public int getTotal(int cid){

        String sql = "select count(*) from product where cid = " + cid;
        int total = 0;
        try (
                Connection connection = DBUtil.getConnection();
                Statement statement = connection.createStatement();
        ){
            ResultSet rs = statement.executeQuery(sql);
            if (rs.next()){
                total = rs.getInt(1);
            }
        }catch (SQLException e){
            e.printStackTrace();
        }
        return total;
    }

    //增加一条
    public void add(Product bean){
        String sql = "insert into product values (null,?,?,?,?,?,?,?)";
        try (
                Connection connection = DBUtil.getConnection();
                PreparedStatement ps = connection.prepareStatement(sql);
        ) {
            ps.setString(1, bean.getName());
            ps.setString(2, bean.getSubTitle());
            ps.setFloat(3, bean.getOriginalPrice());
            ps.setFloat(4, bean.getPromotePrice());
            ps.setInt(5, bean.getStock());
            ps.setInt(6, bean.getCategory().getId());
            ps.setTimestamp(7, DateUtil.d2t(bean.getCreateDate()));
            ps.execute();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                int id = rs.getInt(1);
                bean.setId(id);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //更新一条
    public void update(Product bean){
        String sql = "update product set name= ?, subTitle=?, orignalPrice=?,promotePrice=?,stock=?, cid = ?, createDate=? where id = ?";
        try (
                Connection connection = DBUtil.getConnection();
                PreparedStatement ps = connection.prepareStatement(sql);
                ){
            ps.setString(1, bean.getName());
            ps.setString(2, bean.getSubTitle());
            ps.setFloat(3, bean.getOriginalPrice());
            ps.setFloat(4, bean.getPromotePrice());
            ps.setInt(5, bean.getStock());
            ps.setInt(6, bean.getCategory().getId());
            ps.setTimestamp(7, DateUtil.d2t(bean.getCreateDate()));
            ps.setInt(8, bean.getId());

            ps.execute();
        }catch (SQLException e){
            e.printStackTrace();
        }
    }

    //删除一条
    public void delete(int id){
        String sql = "delete from product where id = " + id;
        try(
                Connection connection = DBUtil.getConnection();
                Statement statement = connection.createStatement();
                ){
            statement.execute(sql);
        }catch (SQLException e){
            e.printStackTrace();
        }
    }

    //获取一条
    public Product get(int id){
        Product bean = null;
        String sql = "select * from product where id = " + id;
        try (
                Connection connection = DBUtil.getConnection();
                Statement statement = connection.createStatement();
                ){
            ResultSet rs = statement.executeQuery(sql);
            if (rs.next()){
                bean = new Product();
                bean.setId(id);
                bean.setName(rs.getString("name"));
                bean.setSubTitle(rs.getString("subTitle"));
                bean.setOriginalPrice(rs.getFloat("orignalPrice"));
                bean.setPromotePrice(rs.getFloat("promotePrice"));
                bean.setStock(rs.getInt("stock"));
                bean.setCreateDate(DateUtil.t2d(rs.getTimestamp("createDate")));

                Category category = new CategoryDAO().get(rs.getInt("cid"));
                bean.setCategory(category);
                setFirstProductImage(bean);
            }
        }catch (SQLException e){
            e.printStackTrace();
        }
        return bean;
    }

    //一个产品有多个图片，但是只有一个主图片，把第一个图片设置为主图片
    public void setFirstProductImage(Product product) {
        List<ProductImage> pis = new ProductImageDAO().list(product, ProductImageDAO.type_single);
        if(!pis.isEmpty()){
            product.setFirstProductImage(pis.get(0));
        }
    }

    //获取全部产品
    public List<Product> list() {
        return list(0,Short.MAX_VALUE);
    }
    //不分产品类别进行分页查询
    public List<Product> list(int start, int count) {
        List<Product> beans = new ArrayList<Product>();

        String sql = "select * from Product limit ?,? ";

        try (Connection c = DBUtil.getConnection(); PreparedStatement ps = c.prepareStatement(sql);) {

            ps.setInt(1, start);
            ps.setInt(2, count);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product bean = new Product();
                int id = rs.getInt(1);
                int cid = rs.getInt("cid");
                String name = rs.getString("name");
                String subTitle = rs.getString("subTitle");
                float orignalPrice = rs.getFloat("orignalPrice");
                float promotePrice = rs.getFloat("promotePrice");
                int stock = rs.getInt("stock");
                Date createDate = DateUtil.t2d( rs.getTimestamp("createDate"));

                bean.setName(name);
                bean.setSubTitle(subTitle);
                bean.setOriginalPrice(orignalPrice);
                bean.setPromotePrice(promotePrice);
                bean.setStock(stock);
                bean.setCreateDate(createDate);
                bean.setId(id);

                Category category = new CategoryDAO().get(cid);
                bean.setCategory(category);
                beans.add(bean);
            }
        } catch (SQLException e) {

            e.printStackTrace();
        }
        return beans;
    }

    //按产品类别获取全部产品
    public List<Product> list(int cid) {
        return list(cid,0, Short.MAX_VALUE);
    }
    //按产品类别进行分页查询
    public List<Product> list(int cid, int start, int count) {
        List<Product> beans = new ArrayList<Product>();
        Category category = new CategoryDAO().get(cid);
        String sql = "select * from Product where cid = ? order by id desc limit ?,? ";

        try (Connection c = DBUtil.getConnection(); PreparedStatement ps = c.prepareStatement(sql);) {
            ps.setInt(1, cid);
            ps.setInt(2, start);
            ps.setInt(3, count);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product bean = new Product();
                int id = rs.getInt(1);
                String name = rs.getString("name");
                String subTitle = rs.getString("subTitle");
                float orignalPrice = rs.getFloat("orignalPrice");
                float promotePrice = rs.getFloat("promotePrice");
                int stock = rs.getInt("stock");
                Date createDate = DateUtil.t2d( rs.getTimestamp("createDate"));

                bean.setName(name);
                bean.setSubTitle(subTitle);
                bean.setOriginalPrice(orignalPrice);
                bean.setPromotePrice(promotePrice);
                bean.setStock(stock);
                bean.setCreateDate(createDate);
                bean.setId(id);
                bean.setCategory(category);
                setFirstProductImage(bean);
                beans.add(bean);
            }
        } catch (SQLException e) {

            e.printStackTrace();
        }
        return beans;
    }

    //给指定分类的category填充产品，因为category类内有个products属性,封装了指定类的所有产品
    public void fill(Category category){
        List<Product> products = this.list(category.getId());
        category.setProducts(products);
    }
    public void fill(List<Category> cs){
        for (Category category : cs) {
            fill(category);
        }
    }
    //给category的属性productsByRow填充值,前提是这个category的products属性已经被填充了
    public void fillByRow(List<Category> cs){
        int productNumberEachRow = 8;   //意思是分类栏的每一类的产品分行显示，每行显示8个
        for (Category category : cs){
            List<List<Product>> productsByRow = new ArrayList<>();
            List<Product> products = category.getProducts();    //返回category类的所有产品
            //针对这个所有产品，计算其数量以便进行分行显示，最后存入productsByRow
            for(int i = 0; i < products.size(); i += productNumberEachRow){
                int size = i + productNumberEachRow;
                size = size > products.size() ? products.size() : size;
                List<Product> productsOfEachRow = products.subList(i, size);    //截取list集合，含头不含尾
                productsByRow.add(productsOfEachRow);
            }
            category.setProductsByRow(productsByRow);
        }
    }

    //给product的属性销售量saleCount和评价数量reviewCount赋值
    public void setSaleAndReviewNumber(Product product){
        int saleCount = new OrderItemDAO().getSaleCount(product.getId());
        int reviewCount = new ReviewDAO().getCount(product.getId());
        product.setSaleCount(saleCount);
        product.setReviewCount(reviewCount);
    }
    public void setSaleAndReviewNumber(List<Product> products){
        for (Product product: products) {
            this.setSaleAndReviewNumber(product);
        }
    }

    //根据关键字分页查询产品（用到sql语法的模糊查询）
    public List<Product> search(String keyword, int start, int end){
        List<Product> beans = new ArrayList<Product>();
        if (null == keyword || 0 == keyword.trim().length())
            return beans;

        String sql = "select * from product where name like ? limit ?,?";
        try (
                Connection connection = DBUtil.getConnection();
                PreparedStatement ps = connection.prepareStatement(sql);
                ){
            ps.setString(1, keyword);
            ps.setInt(2, start);
            ps.setInt(3, end);

            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                Product bean = new Product();
                int id = rs.getInt(1);
                int cid = rs.getInt("cid");
                String name = rs.getString("name");
                String subTitle = rs.getString("subTitle");
                float orignalPrice = rs.getFloat("orignalPrice");
                float promotePrice = rs.getFloat("promotePrice");
                int stock = rs.getInt("stock");
                Date createDate = DateUtil.t2d( rs.getTimestamp("createDate"));

                bean.setName(name);
                bean.setSubTitle(subTitle);
                bean.setOriginalPrice(orignalPrice);
                bean.setPromotePrice(promotePrice);
                bean.setStock(stock);
                bean.setCreateDate(createDate);
                bean.setId(id);
                Category category = new CategoryDAO().get(cid);
                bean.setCategory(category);

                setFirstProductImage(bean);
                beans.add(bean);
            }
        }catch (SQLException e){
            e.printStackTrace();
        }

        return  beans;
    }
}
