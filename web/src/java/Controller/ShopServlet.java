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
import java.util.logging.Level;
import java.util.logging.Logger;

// Đây là phần quan trọng: 
// Nó báo cho máy chủ rằng Servlet này sẽ xử lý URL "/shop"
@WebServlet(name = "ShopServlet", urlPatterns = {"/shop"}) 
public class ShopServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        
        // 1. Khởi tạo DAO
        ProductDAO dao = new ProductDAO();
        
        // 2. Gọi hàm getAllProducts() từ DAO của bạn
        List<Product> list = dao.getAllProducts();
        
        // 3. Đặt danh sách sản phẩm vào request
        // Tên "productList" PHẢI TRÙNG với 'items' trong <c:forEach> của JSP
        request.setAttribute("productList", list);
        
        // 4. Chuyển tiếp yêu cầu đến trang JSP để hiển thị
        // (Thay "shop.jsp" bằng tên file JSP của bạn nếu khác)
        request.getRequestDispatcher("shop.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ShopServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ShopServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}