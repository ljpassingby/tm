package tmall.dao;

import tmall.bean.Category;
import tmall.bean.Property;
import tmall.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PropertyDAO {

    //根据cid查询对应category下的property总数目
    public int getTotal(int cid){

        String sql = "select count(*) from property where cid = " + cid;
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
    public void add(Property bean){
        String sql = "insert into property values (null,?,?)";
        try (
                Connection connection = DBUtil.getConnection();
                PreparedStatement ps = connection.prepareStatement(sql);
        ) {
            ps.setInt(1, bean.getCategory().getId());
            ps.setString(2, bean.getName());
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
    public void update(Property bean) {

        String sql = "update property set cid = ?, name = ? where id = ?";
        try (
                Connection connection = DBUtil.getConnection();
                PreparedStatement ps = connection.prepareStatement(sql);
        ) {
            ps.setInt(1, bean.getCategory().getId());
            ps.setString(2, bean.getName());
            ps.setInt(3, bean.getId());
            ps.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //删除一条
    public void delete(int id) {

        String sql = "delete from property where id = " + id;
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
    public Property get(int id) {

        Property bean = null;
        String sql = "select * from property where id = " + id;
        try (
                Connection connection = DBUtil.getConnection();
                Statement statement = connection.createStatement();
        ) {
            ResultSet rs = statement.executeQuery(sql);
            if (rs.next()) {
                bean = new Property();
                bean.setId(rs.getInt("id"));
                int cid = rs.getInt("cid");
                Category category = new CategoryDAO().get(cid);
                bean.setCategory(category);
                bean.setName(rs.getString("name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bean;
    }

    //根据指定cid进行分页查询
    public List<Property> list(int cid, int start, int count) {

        List<Property> beans = new ArrayList<Property>();
        String sql = "select * from property where cid = ? order by id desc limit ?,?";
        try (
                Connection connection = DBUtil.getConnection();
                PreparedStatement ps = connection.prepareStatement(sql);
        ) {
            ps.setInt(1, cid);
            ps.setInt(2, start);
            ps.setInt(3, count);

            ResultSet rs = ps.executeQuery();
            Category category = new CategoryDAO().get(cid);

            while (rs.next()) {
                Property bean = new Property();
                bean.setId(rs.getInt("id"));
                bean.setName(rs.getString("name"));
                bean.setCategory(category);
                beans.add(bean);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return beans;
    }

    //查询所有
    public List<Property> list(int cid) {
        return list(cid, 0, Short.MAX_VALUE);
    }
}
