package tmall.dao;

import tmall.bean.User;
import tmall.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    //查询总数目
    public int getTotal(){

        String sql = "select count(*) from user";
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
    public void add(User bean){
        String sql = "insert into user values (null,?,?)";
        try (
                Connection connection = DBUtil.getConnection();
                PreparedStatement ps = connection.prepareStatement(sql);
        ) {
            ps.setString(1, bean.getName());
            ps.setString(2, bean.getPassword());
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
    public void update(User bean) {

        String sql = "update user set name = ?, password = ? where id = ?";
        try (
                Connection connection = DBUtil.getConnection();
                PreparedStatement ps = connection.prepareStatement(sql);
        ) {
            ps.setString(1, bean.getName());
            ps.setString(2, bean.getPassword());
            ps.setInt(3, bean.getId());
            ps.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //删除一条
    public void delete(int id) {

        String sql = "delete from user where id = " + id;
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
    public User get(int id) {

        User bean = null;
        String sql = "select * from user where id = " + id;
        try (
                Connection connection = DBUtil.getConnection();
                Statement statement = connection.createStatement();
        ) {
            ResultSet rs = statement.executeQuery(sql);
            if (rs.next()) {
                bean = new User();
                bean.setId(rs.getInt("id"));
                bean.setName(rs.getString("name"));
                bean.setPassword(rs.getString("password"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bean;
    }

    //分页查询
    public List<User> list(int start, int count) {

        List<User> beans = new ArrayList<User>();
        String sql = "select * from user order by id desc limit ?,?";
        try (
                Connection connection = DBUtil.getConnection();
                PreparedStatement ps = connection.prepareStatement(sql);
        ) {
            ps.setInt(1, start);
            ps.setInt(2, count);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User bean = new User();
                bean.setId(rs.getInt("id"));
                bean.setName(rs.getString("name"));
                bean.setPassword(rs.getString("password"));
                beans.add(bean);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return beans;
    }

    //查询所有
    public List<User> list() {
        return list(0, Short.MAX_VALUE);
    }

    //查看指定name的用户是否以创建
    public boolean isExist(String name) {
        User user = get(name);
        return user!=null;
    }

    //通过name查询一条
    public User get(String name) {
        User bean = null;

        String sql = "select * from user where name = ?";
        try (Connection c = DBUtil.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, name);
            ResultSet rs =ps.executeQuery();

            if (rs.next()) {
                bean = new User();
                int id = rs.getInt("id");
                bean.setName(name);
                String password = rs.getString("password");
                bean.setPassword(password);
                bean.setId(id);
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }
        return bean;
    }
    //通过name与password查询一条
    public User get(String name, String password) {
        User bean = null;

        String sql = "select * from user where name = ? and password=?";
        try (Connection c = DBUtil.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setString(2, password);
            ResultSet rs =ps.executeQuery();

            if (rs.next()) {
                bean = new User();
                int id = rs.getInt("id");
                bean.setName(name);
                bean.setPassword(password);
                bean.setId(id);
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }
        return bean;
    }
}
