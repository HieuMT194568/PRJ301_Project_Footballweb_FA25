// Đặt tên file này là ShopServlet.java (trong package 'controller' hoặc 'servlet')
package Controller; // Hoặc package servlet của bạn

import Dal.ProductDAO; // Import DAO của bạn
import Model.Product; // Import Model của bạn
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

// Đây là phần quan trọng: 
// Nó báo cho máy chủ rằng Servlet này sẽ xử lý URL "/shop"
@WebServlet(name = "ShopServlet", urlPatterns = {"/shop"})
public class ShopServlet extends HttpServlet {

    private ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String query = request.getParameter("query");

        List<Product> productList = new ArrayList<>();

        try {
            if ("search".equalsIgnoreCase(action) && query != null && !query.trim().isEmpty()) {
                String keyword = query.trim().toLowerCase();
                List<Product> allProducts = productDAO.getAllProducts();

                for (Product p : allProducts) {
                    if (p.getProductName() != null
                            && p.getProductName().toLowerCase().contains(keyword)) {
                        productList.add(p);
                    }
                }

                request.setAttribute("query", query); // giữ lại text trong ô input
            } else {           
                productList = productDAO.getAllProducts();
    
            }

            request.setAttribute("productList", productList);
            request.getRequestDispatcher("shop.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi khi tải danh sách sản phẩm: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ProductDAO dao = new ProductDAO();

    }
}
