package Dal; // Giả định bạn đặt DAO trong package 'dal'

import static Dal.DBContext.getConnection;
import Model.Article;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.sql.Date;

/**
 * Lớp này xử lý tất cả các thao tác cơ sở dữ liệu cho bảng Articles.
 * Kế thừa DBContext để có kết nối 'connection'.
 */
public class ArticleDAO extends DBContext {

    /**
     * Lấy tất cả các bài báo từ CSDL, sắp xếp theo ngày tạo mới nhất.
     * @return Danh sách các đối tượng Article
     */
    public List<Article> getAllArticles() {
        List<Article> list = new ArrayList<>();
        String sql = "SELECT * FROM Articles ORDER BY CreatedAt DESC";

        try (Connection conn = getConnection();
             PreparedStatement st = conn.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {

            while (rs.next()) {
                Article article = new Article(
                        rs.getInt("ArticleID"),
                        rs.getString("Title"),
                        rs.getString("Description"),
                        rs.getString("ImageUrl"),
                        rs.getString("Category"),
                        rs.getString("Link"),
                        rs.getTimestamp("CreatedAt")
                );
                list.add(article);
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi lấy danh sách bài báo: " + e.getMessage());
        }
        return list;
    }

    /**
     * Lấy một bài báo cụ thể bằng ID.
     * @param id ID của bài báo
     * @return Đối tượng Article hoặc null nếu không tìm thấy
     */
    public Article getArticleById(int id) {
        String sql = "SELECT * FROM Articles WHERE ArticleID = ?";

        try (Connection conn = getConnection();
             PreparedStatement st = conn.prepareStatement(sql)) {
            st.setInt(1, id);
            
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
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
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi tìm bài báo bằng ID: " + e.getMessage());
        }
        return null;
    }

    /**
     * Thêm một bài báo mới vào CSDL.
     * (Giả định ArticleID là tự động tăng - IDENTITY)
     * @param article Đối tượng Article chứa thông tin cần thêm
     */
    public void insertArticle(Article article) {
        String sql = "INSERT INTO Articles (Title, Description, ImageUrl, Category, Link, CreatedAt) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = getConnection();
             PreparedStatement st = conn.prepareStatement(sql)) {
            st.setString(1, article.getTitle());
            st.setString(2, article.getDescription());
            st.setString(3, article.getImageUrl());
            st.setString(4, article.getCategory());
            st.setString(5, article.getLink());
            st.setTimestamp(6, article.getCreatedAt());
            
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Lỗi khi thêm bài báo: " + e.getMessage());
        }
    }

    /**
     * Cập nhật thông tin một bài báo đã có.
     * @param article Đối tượng Article chứa thông tin cần cập nhật
     */
    public void updateArticle(Article article) {
        String sql = "UPDATE Articles SET " +
                     "Title = ?, " +
                     "Description = ?, " +
                     "ImageUrl = ?, " +
                     "Category = ?, " +
                     "Link = ?, " +
                     "CreatedAt = ? " +
                     "WHERE ArticleID = ?";

        try (Connection conn = getConnection();
             PreparedStatement st = conn.prepareStatement(sql)) {
            st.setString(1, article.getTitle());
            st.setString(2, article.getDescription());
            st.setString(3, article.getImageUrl());
            st.setString(4, article.getCategory());
            st.setString(5, article.getLink());
            st.setTimestamp(6, article.getCreatedAt());
            st.setInt(7, article.getArticleID());
            
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Lỗi khi cập nhật bài báo: " + e.getMessage());
        }
    }

    /**
     * Xóa một bài báo khỏi CSDL bằng ID.
     * @param id ID của bài báo cần xóa
     */
    public void deleteArticle(int id) {
        String sql = "DELETE FROM Articles WHERE ArticleID = ?";

        try (Connection conn = getConnection();
             PreparedStatement st = conn.prepareStatement(sql)) {
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Lỗi khi xóa bài báo: " + e.getMessage());
        }
    }

    // --- Các phương thức bổ sung (ví dụ) ---

    /**
     * Lấy các bài báo theo thể loại (Category).
     * @param category Tên thể loại
     * @return Danh sách các bài báo thuộc thể loại đó
     */
    public List<Article> getArticlesByCategory(String category) {
        List<Article> list = new ArrayList<>();
        String sql = "SELECT * FROM Articles WHERE Category = ? ORDER BY CreatedAt DESC";

        try (Connection conn = getConnection();
             PreparedStatement st = conn.prepareStatement(sql)) {
            st.setString(1, category);
            
            try (ResultSet rs = st.executeQuery()) {
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
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi lấy bài báo theo thể loại: " + e.getMessage());
        }
        return list;
    }
}