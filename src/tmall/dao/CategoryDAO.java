package tmall.dao;

import tmall.bean.Category;
import tmall.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {

    public void add(Category category) {
        String sql = "insert into category values (null,?)";
        try (
                Connection connection = DBUtil.getConnection();
                PreparedStatement ps = connection.prepareStatement(sql);
        ) {
            ps.setString(1, category.getName());
            ps.execute();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                int id = rs.getInt(1);
                category.setId(id);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void update(Category category) {

        String sql = "update category set name=? where id=?";
        try (
                Connection connection = DBUtil.getConnection();
                PreparedStatement ps = connection.prepareStatement(sql);
        ) {
            ps.setString(1, category.getName());
            ps.setInt(2, category.getId());
            ps.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void delete(int id) {

        String sql = "delete from category where id=" + id;
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
    public Category get(int id) {

        Category category = null;
        String sql = "select * from category where id=" + id;
        try (
                Connection connection = DBUtil.getConnection();
                Statement statement = connection.createStatement();
        ) {
            ResultSet rs = statement.executeQuery(sql);
            if (rs.next()) {
                category = new Category();
                category.setId(rs.getInt("id"));
                category.setName(rs.getString("name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return category;
    }

    //分页查询
    public List<Category> list(int start, int count) {

        List<Category> beans = new ArrayList<Category>();
        String sql = "select * from category order by id desc limit ?,?";
        try (
                Connection connection = DBUtil.getConnection();
                PreparedStatement ps = connection.prepareStatement(sql);
        ) {
            ps.setInt(1, start);
            ps.setInt(2, count);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Category category = new Category();
                category.setId(rs.getInt("id"));
                category.setName(rs.getString("name"));
                beans.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return beans;
    }

    //查询所有
    public List<Category> list() {
        return list(0, Short.MAX_VALUE);
    }

    //查询category总数目
    public int getTotal(){

        String sql = "select count(*) from category";
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
}