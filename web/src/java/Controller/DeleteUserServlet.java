package Controller;

import Dal.DBContext;
import Dal.UserDAO;
import java.sql.Connection;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
@WebServlet(name = "DeleteUserServlet", urlPatterns = {"/DeleteUserServlet"})
public class DeleteUserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int userID = Integer.parseInt(request.getParameter("id"));
            Connection conn = new DBContext().getConnection(); 
            UserDAO dao = new UserDAO(conn);
            boolean success = dao.deleteUser(userID);

            if (success) {
                // Quay lại danh sách người dùng sau khi xóa
                response.sendRedirect("adminUser");
            } else {
                request.setAttribute("errorMessage", "Không thể xóa người dùng (có thể user này liên quan đến dữ liệu khác).");
                request.getRequestDispatcher("adminUser").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Có lỗi xảy ra khi xóa người dùng.");
            request.getRequestDispatcher("adminUser").forward(request, response);
        }
    }
}
