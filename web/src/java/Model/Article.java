package Model;

import java.sql.Timestamp;

public class Article {
    private int articleID;
    private String title;
    private String description;
    private String imageUrl;
    private String category;
    private String link;
    private Timestamp createdAt;

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

    // Getters and setters
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
