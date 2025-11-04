package Controller;

import Dal.ProductDAO;
import Model.Product;
import Dal.DBContext; //
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "ProductServlet", urlPatterns = {"/ProductServlet"})
public class ProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        try (Connection conn = new DBContext().getConnection()) {
            ProductDAO dao = new ProductDAO();

            switch (action) {
                case "new":
                    // 👉 Tới form thêm sản phẩm
                    request.getRequestDispatcher("admin/product_form.jsp").forward(request, response);
                    break;

                case "edit":
                    // 👉 Tới form cập nhật sản phẩm
                    int id = Integer.parseInt(request.getParameter("id"));
                    Product existing = dao.getProductById(id);
                    request.setAttribute("product", existing);
                    request.getRequestDispatcher("admin/product_form.jsp").forward(request, response);
                    break;

                case "delete":
                    // 👉 Xóa sản phẩm rồi quay lại danh sách
                    int deleteId = Integer.parseInt(request.getParameter("id"));
                    dao.deleteProduct(deleteId);
                    response.sendRedirect("ProductServlet?action=list");
                    break;

                case "list":
                default:
                    // 👉 Hiển thị danh sách sản phẩm
                    List<Product> list = dao.getAllProducts();
                    request.setAttribute("productList", list);
                    request.getRequestDispatcher("admin/product_list.jsp").forward(request, response);
                    break;
            }

        } catch (SQLException e) {
            throw new ServletException("Database error: " + e.getMessage(), e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        try (Connection conn = new DBContext().getConnection()) {
            ProductDAO dao = new ProductDAO();

            // 👉 Lấy dữ liệu từ form
            String name = request.getParameter("productName");
            String desc = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            int stock = Integer.parseInt(request.getParameter("stockQuantity"));
            String image = request.getParameter("imageUrl");
            String category = request.getParameter("category");

            if ("insert".equals(action)) {
                // ➕ Thêm mới
                Product p = new Product(0, name, desc, price, stock, image, category);
                dao.addProduct(p);

            } else if ("update".equals(action)) {
                // ✏️ Cập nhật
                int id = Integer.parseInt(request.getParameter("productID"));
                Product p = new Product(id, name, desc, price, stock, image, category);
                dao.updateProduct(p);
            }

            response.sendRedirect("ProductServlet?action=list");

        } catch (SQLException e) {
            throw new ServletException("Database error: " + e.getMessage(), e);
        }
    }
}
