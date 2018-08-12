package test;

import tmall.bean.Category;
import tmall.dao.CategoryDAO;
import tmall.dao.ProductDAO;

import java.util.List;

public class TestJava {
    public static void main(String[] args){
        ProductDAO productDAO = new ProductDAO();
        CategoryDAO categoryDAO = new CategoryDAO();
        List<Category> categoryList = categoryDAO.list();
        productDAO.fill(categoryList);
        productDAO.fillByRow(categoryList);
        System.out.println(categoryList.get(0).getProductsByRow());
    }
}
