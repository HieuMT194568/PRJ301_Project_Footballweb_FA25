package Controller; // Giả định bạn đặt Servlet trong package 'Controller'

import Dal.ArticleDAO;
import Model.Article;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet này xử lý các yêu cầu liên quan đến bài báo,
 * ví dụ: hiển thị danh sách bài báo.
 */
@WebServlet(name = "ArticlesServlet", urlPatterns = {"/articles"})
public class ArticleServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-g");
        
        // 1. Khởi tạo DAO
        ArticleDAO dao = new ArticleDAO();
        
        // 2. Lấy dữ liệu từ DAO
        List<Article> articleList = dao.getAllArticles();
        
        // 3. Đặt dữ liệu vào request attribute để JSP có thể truy cập
        request.setAttribute("listA", articleList);
        
        // 4. Chuyển tiếp (forward) yêu cầu đến trang JSP
        request.getRequestDispatcher("layout.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet để hiển thị danh sách bài báo";
    }
}