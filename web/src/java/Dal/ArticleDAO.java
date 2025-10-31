package Dal;

import Model.Article;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ArticleDAO {

    private final Connection connection;

    public ArticleDAO(Connection connection) {
        this.connection = connection;
    }

    // ============== MAP RESULTSET -> ARTICLE ==============
    private Article mapResultSetToArticle(ResultSet rs) throws SQLException {
        return new Article(
            rs.getInt("ArticleID"),
            rs.getString("Title"),
            rs.getString("Description"),
            rs.getString("ImageUrl"),
            rs.getString("Category"),
            rs.getString("Link"),
            rs.getTimestamp("CreatedAt")
        );
    }

    // ============== CRUD ==============

    // Lấy tất cả bài viết
    public List<Article> getAllArticles() {
        List<Article> list = new ArrayList<>();
        String sql = "SELECT * FROM Articles ORDER BY CreatedAt DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapResultSetToArticle(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy bài viết theo ID
    public Article getArticleById(int id) {
        String sql = "SELECT * FROM Articles WHERE ArticleID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToArticle(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Thêm bài viết
    public boolean addArticle(Article a) {
        String sql = "INSERT INTO Articles (Title, Description, ImageUrl, Category, Link) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, a.getTitle());
            ps.setString(2, a.getDescription());
            ps.setString(3, a.getImageUrl());
            ps.setString(4, a.getCategory());
            ps.setString(5, a.getLink());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Cập nhật bài viết
    public boolean updateArticle(Article a) {
        String sql = "UPDATE Articles SET Title=?, Description=?, ImageUrl=?, Category=?, Link=? WHERE ArticleID=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, a.getTitle());
            ps.setString(2, a.getDescription());
            ps.setString(3, a.getImageUrl());
            ps.setString(4, a.getCategory());
            ps.setString(5, a.getLink());
            ps.setInt(6, a.getArticleID());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xóa bài viết
    public boolean deleteArticle(int id) {
        String sql = "DELETE FROM Articles WHERE ArticleID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
