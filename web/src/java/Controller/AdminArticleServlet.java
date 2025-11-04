package Controller;

import Dal.DBContext;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;
import Model.Article;

@WebServlet(name = "AdminArticleServlet", urlPatterns = {"/AdminArticleServlet"})
public class AdminArticleServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "new":
                request.getRequestDispatcher("admin/article_form.jsp").forward(request, response);
                break;
            case "edit":
                editArticle(request, response);
                break;
            case "delete":
                deleteArticle(request, response);
                break;
            default:
                listArticles(request, response);
                break;
        }
    }

    private void listArticles(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Article> list = new ArrayList<>();
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT * FROM Articles ORDER BY CreatedAt DESC");
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Article(
                        rs.getInt("ArticleID"),
                        rs.getString("Title"),
                        rs.getString("Description"),
                        rs.getString("ImageUrl"),
                        rs.getString("Category"),
                        rs.getString("Link"),
                        rs.getTimestamp("CreatedAt")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.setAttribute("articleList", list);
        request.getRequestDispatcher("admin/article_list.jsp").forward(request, response);
    }

    private void editArticle(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT * FROM Articles WHERE ArticleID = ?")) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Article a = new Article(
                        rs.getInt("ArticleID"),
                        rs.getString("Title"),
                        rs.getString("Description"),
                        rs.getString("ImageUrl"),
                        rs.getString("Category"),
                        rs.getString("Link"),
                        rs.getTimestamp("CreatedAt")
                );
                request.setAttribute("article", a);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.getRequestDispatcher("admin/article_form.jsp").forward(request, response);
    }

    private void deleteArticle(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement("DELETE FROM Articles WHERE ArticleID = ?")) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("AdminArticleServlet?action=list");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("add".equals(action)) {
            addArticle(request, response);
        } else if ("update".equals(action)) {
            updateArticle(request, response);
        } else {
            listArticles(request, response);
        }
    }

    private void addArticle(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                     "INSERT INTO Articles (Title, Description, ImageUrl, Category, Link, CreatedAt) VALUES (?, ?, ?, ?, ?, GETDATE())")) {
            ps.setString(1, request.getParameter("title"));
            ps.setString(2, request.getParameter("description"));
            ps.setString(3, request.getParameter("imageUrl"));
            ps.setString(4, request.getParameter("category"));
            ps.setString(5, request.getParameter("link"));
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("AdminArticleServlet?action=list");
    }

    private void updateArticle(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try (var conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(
                     "UPDATE Articles SET Title=?, Description=?, ImageUrl=?, Category=?, Link=? WHERE ArticleID=?")) {
            ps.setString(1, request.getParameter("title"));
            ps.setString(2, request.getParameter("description"));
            ps.setString(3, request.getParameter("imageUrl"));
            ps.setString(4, request.getParameter("category"));
            ps.setString(5, request.getParameter("link"));
            ps.setInt(6, Integer.parseInt(request.getParameter("articleID")));
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("AdminArticleServlet?action=list");
    }
}
