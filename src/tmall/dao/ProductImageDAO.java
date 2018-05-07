package tmall.dao;

import tmall.bean.Product;
import tmall.bean.ProductImage;
import tmall.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductImageDAO {

    //type有两种，两种静态属性分别表示单个图片和详情图片
    public static final String type_single = "type_single";
    public static final String type_detail = "type_detail";

    //查询总数目
    public int getTotal(){

        String sql = "select count(*) from productimage";
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
    public void add(ProductImage bean){
        String sql = "insert into productimage values (null,?,?)";
        try (
                Connection connection = DBUtil.getConnection();
                PreparedStatement ps = connection.prepareStatement(sql);
        ) {
            ps.setInt(1, bean.getProduct().getId());
            ps.setString(2, bean.getType());
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

    //修改一条
    public void update(ProductImage bean) {

        String sql = "update productimage set pid = ?, type = ? where id = ?";
        try (
                Connection connection = DBUtil.getConnection();
                PreparedStatement ps = connection.prepareStatement(sql);
        ) {
            ps.setInt(1, bean.getProduct().getId());
            ps.setString(2, bean.getType());
            ps.setInt(3, bean.getId());
            ps.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //删除一条
    public void delete(int id) {

        String sql = "delete from productimage where id = " + id;
        try (
                Connection connection = DBUtil.getConnection();
                Statement statement = connection.createStatement();
        ) {
            statement.execute(sql);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //查找一个
    public ProductImage get(int id) {

        ProductImage bean = null;
        String sql = "select * from productimage where id = " + id;
        try (
                Connection connection = DBUtil.getConnection();
                Statement statement = connection.createStatement();
        ) {
            ResultSet rs = statement.executeQuery(sql);
            if (rs.next()) {
                bean = new ProductImage();
                bean.setId(rs.getInt("id"));
                int pid = rs.getInt("pid");
                Product product = new ProductDAO().get(pid);
                bean.setProduct(product);
                bean.setType(rs.getString("type"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bean;
    }

    //根据指定pid与指定图片类型type进行分页查询
    public List<ProductImage> list(Product product, String type, int start, int count) {

        List<ProductImage> beans = new ArrayList<ProductImage>();
        String sql = "select * from productimage where pid = ? and type = ? order by id desc limit ?,?";
        try (
                Connection connection = DBUtil.getConnection();
                PreparedStatement ps = connection.prepareStatement(sql);
        ) {
            ps.setInt(1, product.getId());
            ps.setString(2, type);
            ps.setInt(3, start);
            ps.setInt(4, count);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductImage bean = new ProductImage();
                bean.setId(rs.getInt("id"));
                bean.setType(rs.getString("type"));
                bean.setProduct(product);
                beans.add(bean);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return beans;
    }

    //查询所有
    public List<ProductImage> list(Product product, String type) {
        return list(product, type, 0, Short.MAX_VALUE);
    }
}
