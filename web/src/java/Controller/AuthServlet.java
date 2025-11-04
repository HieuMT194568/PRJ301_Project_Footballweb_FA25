package Controller;

import Dal.UserDAO;
import Model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "AuthServlet", urlPatterns = {"/AuthServlet"})
public class AuthServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("login".equals(action)) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            User user = userDAO.login(username, password);

            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                response.sendRedirect("DashboardServlet");
            } else {
                request.setAttribute("error", "Sai tài khoản hoặc mật khẩu!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }

        } else if ("register".equals(action)) {
            User newUser = new User();
            newUser.setUsername(request.getParameter("username"));
            newUser.setFullName(request.getParameter("fullname"));
            newUser.setEmail(request.getParameter("email"));
            newUser.setPasswordHash(request.getParameter("password")); // tạm thời chưa hash
            newUser.setRole("CUSTOMER");

            userDAO.register(newUser);
            response.sendRedirect("login.jsp");
        }
    }
}
