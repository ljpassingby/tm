package tmall.servlet;

import tmall.bean.Category;
import tmall.util.ImageUtil;
import tmall.util.Page;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CategoryServlet extends BaseBackServlet {
    @Override
    public String add(HttpServletRequest request, HttpServletResponse response, Page page) {
        Map<String, String> params = new HashMap<>();
        InputStream is = super.parseUpLoad(request, params);
        //获取提交的新category的name，这里也证明了一点，这个params是地址传递，是指针类型的参数修改
        String name = params.get("name");
        Category category = new Category();
        category.setName(name);
        categoryDAO.add(category);

        File imageFolder = new File(request.getSession().getServletContext().getRealPath("img/category"));
        File file = new File(imageFolder, category.getId() + ".jpg");   //第一个参数是目录，第二个参数是文件名
        file.getParentFile().mkdirs();  //确保文件目录生成
        try(FileOutputStream fos = new FileOutputStream(file)) {
            if (null != is && 0 != is.available()){
                byte[] buffer = new byte[1024 * 1024];
                int length = 0;
                while (-1 != (length = is.read(buffer))){
                    fos.write(buffer, 0 , length);
                }
                fos.flush();
                //这里是进行一次复写，保证存入的图片为jpg格式，方便后面调用，因为上传的图片可能格式很多。
                BufferedImage bufferedImage = ImageUtil.change2jpg(file);
                ImageIO.write(bufferedImage, "jpg", file);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return "@admin_category_list";
    }

    @Override
    public String delete(HttpServletRequest request, HttpServletResponse response, Page page) {
        int id = Integer.parseInt(request.getParameter("id"));
        //这里在删除的时候最好能加上删除对应的category的图片，代码还没写这一块
        File imageFolder = new File(request.getServletContext().getRealPath("img/category"));
        File file = new File(imageFolder, id + ".jpg");   //第一个参数是目录，第二个参数是文件名
        file.delete();
        categoryDAO.delete(id);
        return "@admin_category_list";
    }

    @Override
    public String update(HttpServletRequest request, HttpServletResponse response, Page page) {
        Map<String, String> params = new HashMap<>();
        InputStream is = super.parseUpLoad(request, params);    //若无修改图片，则这里的is为空
        //获取提交的新category的name，这里也证明了一点，这个params是地址传递，是指针类型的参数修改
        System.out.println(params);
        String name = params.get("name");
        String id = params.get("id");
        Category category = new Category();
        category.setId(Integer.parseInt(id));
        category.setName(name);
        categoryDAO.update(category);

        File imageFolder = new File(request.getSession().getServletContext().getRealPath("img/category"));
        File file = new File(imageFolder, category.getId() + ".jpg");   //第一个参数是目录，第二个参数是文件名
        file.getParentFile().mkdirs();
        try(FileOutputStream fos = new FileOutputStream(file)) {
//            判断是否有修改图片的操作，若无修改图片就跳过这一步
            if (null != is && 0 != is.available()){
                byte[] buffer = new byte[1024 * 1024];
                int length = 0;
                while (-1 != (length = is.read(buffer))){
                    fos.write(buffer, 0 , length);
                }
                fos.flush();
                //这里是进行一次复写，保证存入的图片为jpg格式，方便后面调用，因为上传的图片可能格式很多。
                BufferedImage bufferedImage = ImageUtil.change2jpg(file);
                ImageIO.write(bufferedImage, "jpg", file);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return "@admin_category_list";
    }

    @Override
    public String edit(HttpServletRequest request, HttpServletResponse response, Page page) {
        int id = Integer.parseInt(request.getParameter("id"));
        Category category = categoryDAO.get(id);
        request.setAttribute("c", category);
        //这个jsp页面是被请求转发跳转的
        return "admin/editCategory.jsp";
    }

    @Override
    //取出Category数据，并且交由listCategory.jsp显示
    public String list(HttpServletRequest request, HttpServletResponse response, Page page) {
        List<Category> cs = categoryDAO.list(page.getStart(), page.getCount());
        int total = categoryDAO.getTotal(); //获取该category总数，用于确定分几页
        page.setTotal(total);

        request.setAttribute("thecs", cs);  //此时传过去的是当前页显示的category数目
        request.setAttribute("page", page);
        return "admin/listCategory.jsp";
    }
}
