package tmall.dao;

import tmall.bean.Product;
import tmall.util.DBUtil;

import java.sql.*;

public class ProductDAO {

    //查询总数目
    public int getTotal(){

        String sql = "select count(*) from product";
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
//    public void add(Product bean){
//        String sql = "insert into product values (null,?,?,?,?,?,?,?)";
//        try (
//                Connection connection = DBUtil.getConnection();
//                PreparedStatement ps = connection.prepareStatement(sql);
//        ) {
//            ps.setString(1, bean.getName());
//            ps.setString(2, bean.getPassword());
//            ps.execute();
//            ResultSet rs = ps.getGeneratedKeys();
//            if (rs.next()) {
//                int id = rs.getInt(1);
//                bean.setId(id);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//    }

    public Product get(int id){
        Product product = null;
        return product;
    }
}
