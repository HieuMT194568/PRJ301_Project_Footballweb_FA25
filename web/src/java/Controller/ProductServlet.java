package Controller;

import Model.Product;
import Dal.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "ProductServlet", urlPatterns = {"/ProductServlet"})
public class ProductServlet extends HttpServlet {

    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "new":
                    showNewForm(request, response);
                    break;

                case "edit":
                    showEditForm(request, response);
                    break;

                case "delete":
                    deleteProduct(request, response);
                    break;

                case "list":
                default:
                    listProducts(request, response);
                    break;
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi khi xử lý yêu cầu: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    // 🟢 Thêm sản phẩm mới
    private void insertProduct(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        Product p = new Product();
        p.setProductName(request.getParameter("productName"));
        p.setDescription(request.getParameter("description"));
        p.setPrice(Double.parseDouble(request.getParameter("price")));
        p.setStockQuantity(Integer.parseInt(request.getParameter("stockQuantity")));
        p.setCategory(request.getParameter("category"));
        p.setImageUrl(request.getParameter("imageUrl"));

        productDAO.insert(p);
        response.sendRedirect("ProductServlet?action=list");
    }

    // 🟠 Cập nhật sản phẩm
    private void updateProduct(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        Product p = new Product();
        p.setProductID(Integer.parseInt(request.getParameter("productID")));
        p.setProductName(request.getParameter("productName"));
        p.setDescription(request.getParameter("description"));
        p.setPrice(Double.parseDouble(request.getParameter("price")));
        p.setStockQuantity(Integer.parseInt(request.getParameter("stockQuantity")));
        p.setCategory(request.getParameter("category"));
        p.setImageUrl(request.getParameter("imageUrl"));

        productDAO.update(p);
        response.sendRedirect("ProductServlet?action=list");
    }

    // 🔴 Xóa sản phẩm
    private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        int id = Integer.parseInt(request.getParameter("id"));
        productDAO.delete(id);
        response.sendRedirect("ProductServlet?action=list");
    }

    private void listProducts(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        var productList = productDAO.getAllProducts();
        request.setAttribute("productList", productList);
        request.getRequestDispatcher("admin/product_list.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("admin/product_list.jsp").forward(request, response);
    }

// 🔵 Hiển thị form chỉnh sửa
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        int id = Integer.parseInt(request.getParameter("id"));
        var product = productDAO.getById(id);
        request.setAttribute("product", product);
        request.getRequestDispatcher("admin/product_list.jsp").forward(request, response);
    }
}
