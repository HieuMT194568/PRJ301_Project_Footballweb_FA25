package Controller; // Thay đổi package cho đúng với dự án của bạn

import Dal.DBContext;

import Dal.UserDAO; // Import UserDAO của bạn

import Model.User; // Import model User của bạn

import java.io.IOException;

import jakarta.servlet.ServletException;

import jakarta.servlet.annotation.WebServlet;

import jakarta.servlet.http.HttpServlet;

import jakarta.servlet.http.HttpServletRequest;

import jakarta.servlet.http.HttpServletResponse;

import jakarta.servlet.http.HttpSession;

import java.sql.Connection;

@WebServlet("/UpdateUserRoleServlet")

public class UpdateUserRoleServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();

        User adminUser = (User) session.getAttribute("user");

// Lấy tham số
        String userIDStr = request.getParameter("userID");

        String newRole = request.getParameter("newRole");

// 1. Kiểm tra cơ bản
        if (userIDStr == null || newRole == null || !("CUSTOMER".equals(newRole) || "ADMIN".equals(newRole))) {

            response.sendRedirect("adminUser?error=invalidParams");

            return;

        }

        try {

            int userID = Integer.parseInt(userIDStr);

// 2. Kiểm tra an toàn: Admin không thể tự thay đổi vai trò của mình
            if (adminUser != null && adminUser.getUserID() == userID) {

// Không được phép tự thay đổi vai trò
                response.sendRedirect("adminUser?error=selfChange");

                return;

            }

// 3. Gọi DAO để cập nhật
            Connection conn = new DBContext().getConnection();

            UserDAO userDAO = new UserDAO(conn);

            boolean updateSuccess = userDAO.updateUserRole(userID, newRole);

            if (updateSuccess) {

// Cập nhật thành công
            } else {

// Cập nhật thất bại (có thể log lỗi ở đây)
            }

// 4. Chuyển hướng trở lại trang quản lý
            response.sendRedirect("adminUser");

        } catch (NumberFormatException e) {

// Lỗi nếu userID không phải là số
            response.sendRedirect("adminUser?error=invalidID");

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect("adminUser?error=db");

        }

    }

    @Override

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

// Không cho phép truy cập GET, chỉ chấp nhận POST
        response.sendRedirect("adminUser");

    }

}
