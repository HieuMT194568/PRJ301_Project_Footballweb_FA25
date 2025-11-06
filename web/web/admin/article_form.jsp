<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>
        <c:choose>
            <c:when test="${not empty article}">✏️ Chỉnh sửa bài viết</c:when>
            <c:otherwise>➕ Thêm bài viết mới</c:otherwise>
        </c:choose>
    </title>
    
    <%-- Thêm CSS và JS của Bootstrap 5 --%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="bg-light d-flex flex-column min-vh-100">

    <%-- Header (Giữ nguyên code của bạn, đã chuyển vào body) --%>
    <header class="navbar navbar-expand-lg navbar-dark bg-danger shadow-sm">
        <div class="container-fluid">
            <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/articles">
                <img src="${pageContext.request.contextPath}/assets/images/bayern-logo.png" alt="Logo" style="height: 40px; width: 40px;" class="rounded-circle bg-white p-1 me-2">
                <span class="fw-bold fs-5">FC Bayern Munich</span>
            </a>
            <div class="d-flex align-items-center ms-auto">
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <span class="navbar-text me-3 d-none d-md-block">
                            Welcome, ${sessionScope.user.fullName}!
                        </span>
                        <a href="${pageContext.request.contextPath}/LogoutServlet" class="btn btn-light text-danger fw-semibold me-2">
                            Logout
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-light text-danger fw-semibold me-2">
                            Login
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </header>

    <%-- Nav (Giữ nguyên code của bạn, đã chuyển vào body) --%>
    <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm border-bottom sticky-top">
        <div class="container-fluid">
            <div class="navbar-nav">
                <a class="nav-link" href="${pageContext.request.contextPath}/TeamServlet?action=list">👥 Teams</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/MatchServlet?action=list">⚽ Matches</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/articles">📰 News</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/shop">🛍️ Shop</a>
                <c:if test="${sessionScope.user != null && sessionScope.user.role == 'ADMIN'}">
                    <a class="nav-link active fw-bold text-danger" href="${pageContext.request.contextPath}/admin">⚙️ Admin Panel</a>
                </c:if>
            </div>
        </div>
    </nav>

    <%-- === NỘI DUNG CHÍNH (Đã chuyển sang Bootstrap) === --%>
    <main class="container my-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card shadow-sm border-0">
                    <div class="card-body p-4 p-md-5">
                        
                        <h2 class="h4 fw-bold text-dark mb-4">
                            <c:choose>
                                <c:when test="${not empty article}">✏️ Chỉnh sửa bài viết</c:when>
                                <c:otherwise>➕ Thêm bài viết mới</c:otherwise>
                            </c:choose>
                        </h2>

                        <form action="AdminArticleServlet" method="post">
                            <%-- Hidden fields cho action (add/update) --%>
                            <c:if test="${not empty article}">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="articleID" value="${article.articleID}">
                            </c:if>
                            <c:if test="${empty article}">
                                <input type="hidden" name="action" value="add">
                            </c:if>

                            <%-- Field: Tiêu đề --%>
                            <div class="mb-3">
                                <label for="title" class="form-label fw-semibold">Tiêu đề</label>
                                <input type="text" name="title" id="title" value="${article.title}" class="form-control" required>
                            </div>

                            <%-- Field: Mô tả --%>
                            <div class="mb-3">
                                <label for="description" class="form-label fw-semibold">Mô tả</label>
                                <textarea name="description" id="description" rows="4" class="form-control" required>${article.description}</textarea>
                            </div>

                            <%-- Field: Đường dẫn ảnh --%>
                            <div class="mb-3">
                                <label for="imageUrl" class="form-label fw-semibold">Đường dẫn ảnh</label>
                                <input type="text" name="imageUrl" id="imageUrl" value="${article.imageUrl}" class="form-control" required>
                            </div>

                            <%-- Field: Danh mục --%>
                            <div class="mb-3">
                                <label for="category" class="form-label fw-semibold">Danh mục</label>
                                <input type="text" name="category" id="category" value="${article.category}" class="form-control" required>
                            </div>

                            <%-- Field: Liên kết bài viết --%>
                            <div class="mb-3">
                                <label for="link" class="form-label fw-semibold">Liên kết bài viết</label>
                                <input type="text" name="link" id="link" value="${article.link}" class="form-control" required>
                            </div>

                            <%-- Buttons: Hủy và Lưu --%>
                            <div class="d-flex justify-content-end pt-3">
                                <a href="AdminArticleServlet?action=list" class="btn btn-secondary me-2">
                                    Hủy
                                </a>
                                <button type="submit" class="btn btn-danger fw-semibold px-4">
                                    💾 Lưu bài viết
                                </button>
                            </div>
                        </form>
                        
                    </div>
                </div>
            </div>
        </div>
    </main>

    <%-- Footer (Thêm vào cho đồng bộ) --%>
    <footer class="text-center py-4 text-muted border-top mt-auto bg-white">
        © 2025 Bayern Munich. All rights reserved.
    </footer>

</body>
</html>