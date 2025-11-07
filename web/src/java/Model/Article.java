package Model;

import jakarta.persistence.*;
import java.sql.Timestamp;
import org.hibernate.annotations.CreationTimestamp;

@Entity
@Table(name = "Articles") // Chỉ định tên bảng trong CSDL
public class Article {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // Tự động tăng ID
    @Column(name = "ArticleID")
    private int articleID;

    @Column(name = "Title")
    private String title;

    @Column(name = "Description")
    private String description;

    @Column(name = "ImageUrl")
    private String imageUrl;

    @Column(name = "Category")
    private String category;

    @Column(name = "Link")
    private String link;

    @CreationTimestamp // Tự động gán thời gian khi tạo mới
    @Column(name = "CreatedAt", updatable = false) // Không cho phép cập nhật
    private Timestamp createdAt;

    // Constructors (rỗng và đầy đủ)
    public Article() {
    }

    public Article(int articleID, String title, String description, String imageUrl, String category, String link, Timestamp createdAt) {
        this.articleID = articleID;
        this.title = title;
        this.description = description;
        this.imageUrl = imageUrl;
        this.category = category;
        this.link = link;
        this.createdAt = createdAt;
    }

    // Getters and Setters...
    // (Bắt buộc phải có để Spring/JPA/Thymeleaf hoạt động)
    
    public int getArticleID() {
        return articleID;
    }

    public void setArticleID(int articleID) {
        this.articleID = articleID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}