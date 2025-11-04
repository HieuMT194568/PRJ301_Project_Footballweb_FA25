/* ================================================
   PROJECT: FC BAYERN STYLE SPORTS PORTAL
   DATABASE: SQL SERVER (SSMS)
   AUTHOR: Hieu
   ================================================ */

-- Tạo database (nếu chưa có)
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = N'BayernPortalDB')
BEGIN
    CREATE DATABASE BayernPortalDB;
END
GO

USE BayernPortalDB;
GO

/* ===============================
   1. USERS (Tài khoản người dùng)
   =============================== */
CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    Role NVARCHAR(20) NOT NULL DEFAULT 'CUSTOMER' 
        CHECK (Role IN ('ADMIN', 'CUSTOMER')),
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE()
);
GO

/* ===============================
   2. TEAMS (Đội bóng)
   =============================== */
CREATE TABLE Teams (
    TeamID INT IDENTITY(1,1) PRIMARY KEY,
    TeamName NVARCHAR(100) NOT NULL UNIQUE,
    Coach NVARCHAR(100),
    Stadium NVARCHAR(100),
    FoundedYear INT,
    Country NVARCHAR(50)
);
GO

/* ===============================
   3. PLAYERS (Cầu thủ)
   =============================== */
CREATE TABLE Players (
    PlayerID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Position NVARCHAR(50),
    Nationality NVARCHAR(50),
    BirthDate DATE,
    ShirtNumber INT,
    TeamID INT NOT NULL,
    FOREIGN KEY (TeamID) REFERENCES Teams(TeamID) ON DELETE CASCADE
);
GO

/* ===============================
   4. MATCHES (Trận đấu)
   =============================== */
CREATE TABLE Matches (
    MatchID INT IDENTITY(1,1) PRIMARY KEY,
    HomeTeamID INT NOT NULL,
    AwayTeamID INT NOT NULL,
    MatchDate DATETIME NOT NULL,
    Stadium NVARCHAR(100),
    HomeScore INT DEFAULT 0,
    AwayScore INT DEFAULT 0,
    FOREIGN KEY (HomeTeamID) REFERENCES Teams(TeamID),
    FOREIGN KEY (AwayTeamID) REFERENCES Teams(TeamID)
);
GO

/* ===============================
   5. ARTICLES (Tin tức)
   =============================== */
CREATE TABLE Articles (
    ArticleID INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(200) NOT NULL,
    Description NVARCHAR(MAX),
    ImageUrl NVARCHAR(300),
    Category NVARCHAR(100),
    Link NVARCHAR(300),
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE()
);
GO

/* ===============================
   6. PRODUCTS (Sản phẩm Shop)
   =============================== */
CREATE TABLE Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName NVARCHAR(150) NOT NULL,
    Description NVARCHAR(MAX),
    Price DECIMAL(18,2) NOT NULL,
    StockQuantity INT NOT NULL,
    ImageUrl NVARCHAR(300),
    Category NVARCHAR(100) NOT NULL
);
GO

/* ===============================
   7. ORDERS (Đơn hàng)
   =============================== */
CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    OrderDate DATETIME NOT NULL DEFAULT GETDATE(),
    TotalAmount DECIMAL(18,2) NOT NULL,
    Status NVARCHAR(50) NOT NULL DEFAULT 'PENDING' 
        CHECK (Status IN ('PENDING', 'PAID', 'SHIPPED', 'CANCELLED')),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
GO

/* ===============================
   8. ORDER DETAILS (Chi tiết đơn hàng)
   =============================== */
CREATE TABLE OrderDetails (
    OrderDetailID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(18,2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
GO

/* ===============================
   9. MEDIA (Ảnh - Video - File)
   =============================== */
CREATE TABLE Media (
    MediaID INT IDENTITY(1,1) PRIMARY KEY,
    FilePath NVARCHAR(300) NOT NULL,
    MediaType NVARCHAR(50) NOT NULL,
    UploadedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UploadedBy INT NOT NULL,
    FOREIGN KEY (UploadedBy) REFERENCES Users(UserID)
);
GO

/* ===============================
   10. AUDIT LOG (Theo dõi hoạt động)
   =============================== */
CREATE TABLE AuditLog (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    Action NVARCHAR(255) NOT NULL,
    ActionTime DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
GO

/* ===============================
   11. INDEX & OPTIMIZATION
   =============================== */
CREATE INDEX IX_Articles_Category ON Articles(Category);
CREATE INDEX IX_Products_Category ON Products(Category);
CREATE INDEX IX_Orders_UserID ON Orders(UserID);
CREATE INDEX IX_OrderDetails_OrderID ON OrderDetails(OrderID);
CREATE INDEX IX_Players_TeamID ON Players(TeamID);
GO

PRINT '✅ Database schema created successfully!';
