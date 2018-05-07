package tmall.dao;

import tmall.bean.Product;
import tmall.bean.Property;
import tmall.bean.PropertyValue;
import tmall.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PropertyValueDAO {

    //查询总数目
    public int getTotal(){

        String sql = "select count(*) from propertyvalue";
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
    public void add(PropertyValue bean){
        String sql = "insert into propertyvalue values (null,?,?,?)";
        try (
                Connection connection = DBUtil.getConnection();
                PreparedStatement ps = connection.prepareStatement(sql);
        ) {
            ps.setInt(1, bean.getProduct().getId());
            ps.setInt(2, bean.getProperty().getId());
            ps.setString(3, bean.getValue());
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
    public void update(PropertyValue bean) {

        String sql = "update propertyvalue set pid = ?, ptid = ? ,value = ? where id = ?";
        try (
                Connection connection = DBUtil.getConnection();
                PreparedStatement ps = connection.prepareStatement(sql);
        ) {
            ps.setInt(1, bean.getProduct().getId());
            ps.setInt(2, bean.getProperty().getId());
            ps.setString(3, bean.getValue());
            ps.setInt(4, bean.getId());
            ps.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //删除一条
    //但是对于PropertyValue来说，delete没有数目意义，增加该删除功能反而会有危险
    public void delete(int id) {

        String sql = "delete from propertyvalue where id = " + id;
        try (
                Connection connection = DBUtil.getConnection();
                Statement statement = connection.createStatement();
        ) {
            statement.execute(sql);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //查找一个，这种查找应用中用不到
    public PropertyValue get(int id) {

        PropertyValue bean = null;
        String sql = "select * from propertyvalue where id = " + id;
        try (
                Connection connection = DBUtil.getConnection();
                Statement statement = connection.createStatement();
        ) {
            ResultSet rs = statement.executeQuery(sql);
            if (rs.next()) {
                bean = new PropertyValue();
                bean.setId(rs.getInt("id"));
                bean.setValue(rs.getString("value"));

                int pid = rs.getInt("pid");
                int ptid = rs.getInt("ptid");
                Product product = new ProductDAO().get(pid);
                Property property = new PropertyDAO().get(ptid);
                bean.setProduct(product);
                bean.setProperty(property);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bean;
    }

    //查找一个，实际应用中根据pid与ptid查询指定的属性值
    public PropertyValue get(int pid, int ptid) {

        PropertyValue bean = null;
        String sql = "select * from propertyvalue where ptid = " + ptid + " and pid = " + pid;
        try (
                Connection connection = DBUtil.getConnection();
                Statement statement = connection.createStatement();
        ) {
            ResultSet rs = statement.executeQuery(sql);
            if (rs.next()) {
                bean = new PropertyValue();
                bean.setId(rs.getInt("id"));
                bean.setValue(rs.getString("value"));

                Product product = new ProductDAO().get(pid);
                Property property = new PropertyDAO().get(ptid);
                bean.setProduct(product);
                bean.setProperty(property);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bean;
    }

    //根据指定pid查询该产品下所有的属性值ptid，因为在数据表PropertyValue下，同一个pid有对应多个ptid
    //即产品Product与属性Property是多对多的关系
    public List<PropertyValue> list(int pid) {
        List<PropertyValue> beans = new ArrayList<PropertyValue>();

        String sql = "select * from propertyvalue where pid = ? order by ptid desc";

        try (Connection c = DBUtil.getConnection(); PreparedStatement ps = c.prepareStatement(sql);) {

            ps.setInt(1, pid);
            ResultSet rs = ps.executeQuery();
            Product product = new ProductDAO().get(pid);
            while (rs.next()) {
                PropertyValue bean = new PropertyValue();
                bean.setId(rs.getInt(1));
                bean.setValue(rs.getString("value"));
                bean.setProduct(product);

                int ptid = rs.getInt("ptid");
                Property property = new PropertyDAO().get(ptid);
                bean.setProperty(property);
                beans.add(bean);
            }
        } catch (SQLException e) {

            e.printStackTrace();
        }
        return beans;
    }

    /*
    初始化，将指定Product对应的category的所有property都遍历出来并查找对应的propertvalue，若product在某个property没有
    对应的propertyvalue在数据表中存在，则创建
    */
    public void init(Product product){
        List<Property> pts = new PropertyDAO().list(product.getCategory().getId());
        for (Property property : pts) {
            PropertyValue pv = this.get(product.getId(), property.getId());
            if(null == pv){
                pv = new PropertyValue();
                pv.setProduct(product);
                pv.setProperty(property);
                this.add(pv);
            }
        }
    }

    //以下两种方法是分页与全部查询函数，实际应用中用不到，测试中才用到
    public List<PropertyValue> list() {
        return list(0, Short.MAX_VALUE);
    }
    public List<PropertyValue> list(int start, int count) {
        List<PropertyValue> beans = new ArrayList<PropertyValue>();

        String sql = "select * from propertyvalue order by id desc limit ?,? ";

        try (Connection c = DBUtil.getConnection(); PreparedStatement ps = c.prepareStatement(sql);) {

            ps.setInt(1, start);
            ps.setInt(2, count);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                PropertyValue bean = new PropertyValue();
                int id = rs.getInt(1);

                int pid = rs.getInt("pid");
                int ptid = rs.getInt("ptid");
                String value = rs.getString("value");

                Product product = new ProductDAO().get(pid);
                Property property = new PropertyDAO().get(ptid);
                bean.setProduct(product);
                bean.setProperty(property);
                bean.setValue(value);
                bean.setId(id);
                beans.add(bean);
            }
        } catch (SQLException e) {

            e.printStackTrace();
        }
        return beans;
    }
}
