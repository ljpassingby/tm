package tmall.servlet;

import tmall.bean.Product;
import tmall.bean.ProductImage;
import tmall.dao.ProductImageDAO;
import tmall.util.ImageUtil;
import tmall.util.Page;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProductImageServlet extends BaseBackServlet {
    @Override
    public String add(HttpServletRequest request, HttpServletResponse response, Page page) {
        Map<String, String> params = new HashMap<>();
        InputStream is = super.parseUpLoad(request, params);
        int pid = Integer.parseInt(params.get("pid"));
        String type = params.get("type");
        ProductImage productImage = new ProductImage();
        productImage.setType(type);
        productImage.setProduct(productDAO.get(pid));
        productImageDAO.add(productImage);  //数据库中存入新的图片信息

        //上传图片文件到本地
        String fileName = productImage.getId() + ".jpg";
        String imageFolder;
        String imageFolder_small = null;
        String imageFolder_middle = null;
        if (ProductImageDAO.type_single.equals(type)){
            imageFolder = request.getSession().getServletContext().getRealPath("img/productSingle");
            imageFolder_small = request.getSession().getServletContext().getRealPath("img/productSingle_small");
            imageFolder_middle = request.getSession().getServletContext().getRealPath("img/productSingle_middle");
        }
        else
            imageFolder = request.getSession().getServletContext().getRealPath("img/productDetail");
        File file = new File(imageFolder, fileName);
        file.getParentFile().mkdirs();  //确保文件目录生成

        try {
            if (null != is && 0 != is.available()){
                try(FileOutputStream fos = new FileOutputStream(file)){
                    byte[] buffer = new byte[1024 * 1024];
                    int length = 0;
                    while(-1 != (length = is.read(buffer))){
                        fos.write(buffer, 0, length);   //这个0很奇怪，不知道是不是这样
                    }
                    fos.flush();
                    //复写，将文件转为jpg格式
                    BufferedImage image = ImageUtil.change2jpg(file);
                    ImageIO.write(image, "jpg", file);

                    if(ProductImageDAO.type_single.equals(productImage.getType())){
                        File file_small = new File(imageFolder_small, fileName);
                        File file_middle = new File(imageFolder_middle, fileName);
                        file_small.getParentFile().mkdirs();
                        file_middle.getParentFile().mkdirs();

                        ImageUtil.resizeImage(file, 56, 56, file_small);
                        ImageUtil.resizeImage(file, 217, 190, file_middle);
                    }
                }catch (Exception e){
                    e.printStackTrace();
                }
            }
        }catch (IOException e){
            e.printStackTrace();
        }
        return "@admin_productImage_list?pid=" + pid;
    }

    @Override
    public String delete(HttpServletRequest request, HttpServletResponse response, Page page) {
        int id = Integer.parseInt(request.getParameter("id"));
        ProductImage productImage = productImageDAO.get(id);
        productImageDAO.delete(id);
        if (ProductImageDAO.type_single.equals(productImage.getType())){
            String singleImage = request.getSession().getServletContext().getRealPath("img/productSingle");
            String singleImage_small = request.getSession().getServletContext().getRealPath("img/productSingle_small");
            String singleImage_middle = request.getSession().getServletContext().getRealPath("img/productSingle_middle");
            String fileName = id + ".jpg";
            File file = new File(singleImage, fileName);
            File file_small = new File(singleImage_small, fileName);
            File file_middle = new File(singleImage_middle, fileName);
            file.delete();
            file_small.delete();
            file_middle.delete();
        }
        else{
            String detailImage = request.getSession().getServletContext().getRealPath("img/productDetail");
            String fileName = id + ".jpg";
            File file = new File(detailImage, fileName);
            file.delete();
        }
        return "@admin_productImage_list?pid=" + productImage.getProduct().getId();
    }

    @Override
    public String update(HttpServletRequest request, HttpServletResponse response, Page page) {
        return null;
    }

    @Override
    public String edit(HttpServletRequest request, HttpServletResponse response, Page page) {
        return null;
    }

    @Override
    public String list(HttpServletRequest request, HttpServletResponse response, Page page) {
        int pid = Integer.parseInt(request.getParameter("pid"));
        Product product = productDAO.get(pid);
        List<ProductImage> productImages_single = productImageDAO.list(product, ProductImageDAO.type_single);
        List<ProductImage> productImages_detail = productImageDAO.list(product, ProductImageDAO.type_detail);

        request.setAttribute("singles", productImages_single);
        request.setAttribute("details", productImages_detail);
        request.setAttribute("product", product);
        return "admin/listProductImage.jsp";
    }
}
