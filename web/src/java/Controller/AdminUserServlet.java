package Controller;

import Dal.DBContext;
import Dal.UserDAO;
import Model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "adminUser", urlPatterns = {"/adminUser"})
public class AdminUserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection conn = null;
        try {
            conn = new DBContext().getConnection();
        } catch (SQLException ex) {
            Logger.getLogger(AdminUserServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        UserDAO userDAO = new UserDAO(conn);
        List<User> userList = userDAO.getAllUsers();

        request.setAttribute("userList", userList);
        request.getRequestDispatcher("admin/admin_users.jsp").forward(request, response);
    }
}
