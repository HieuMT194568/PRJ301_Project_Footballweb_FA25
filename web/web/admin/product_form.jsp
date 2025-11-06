<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>
        <c:choose>
            <c:when test="${product != null}">✏️ Cập nhật sản phẩm</c:when>
            <c:otherwise>➕ Thêm sản phẩm mới</c:otherwise>
        </c:choose>
    </title>
    
    <%-- Thêm CSS và JS của Bootstrap 5 --%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="bg-light d-flex flex-column min-vh-100">

    <%-- Header (Thêm vào) --%>
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

    <%-- Nav (Thêm vào) --%>
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
                                <c:when test="${product != null}">✏️ Cập nhật sản phẩm</c:when>
                                <c:otherwise>➕ Thêm sản phẩm mới</c:otherwise>
                            </c:choose>
                        </h2>

                        <form action="${pageContext.request.contextPath}/ProductServlet" method="post">
                            <%-- Hidden fields cho action (insert/update) --%>
                            <c:if test="${product != null}">
                                <input type="hidden" name="productID" value="${product.productID}">
                                <input type="hidden" name="action" value="update">
                            </c:if>
                            <c:if test="${product == null}">
                                <input type="hidden" name="action" value="insert">
                            </c:if>

                            <%-- Field: Tên sản phẩm --%>
                            <div class="mb-3">
                                <label for="productName" class="form-label fw-semibold">Tên sản phẩm</label>
                                <input type="text" name="productName" id="productName" value="${product.productName}" class="form-control" required>
                            </div>

                            <%-- Field: Mô tả --%>
                            <div class="mb-3">
                                <label for="description" class="form-label fw-semibold">Mô tả</label>
                                <textarea name="description" id="description" rows="3" class="form-control" required>${product.description}</textarea>
                            </div>

                            <%-- Grid: Giá và Tồn kho --%>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="price" class="form-label fw-semibold">Giá</label>
                                        <input type="number" step="1000" name="price" id="price" value="${product.price}" class="form-control" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="stockQuantity" class="form-label fw-semibold">Tồn kho</label>
                                        <input type="number" name="stockQuantity" id="stockQuantity" value="${product.stockQuantity}" class="form-control" required>
                                    </div>
                                </div>
                            </div>

                            <%-- Field: Ảnh (URL) --%>
                            <div class="mb-3">
                                <label for="imageUrl" class="form-label fw-semibold">Ảnh (URL)</label>
                                <input type="text" name="imageUrl" id="imageUrl" value="${product.imageUrl}" class="form-control">
                            </div>

                            <%-- Field: Danh mục --%>
                            <div class="mb-3">
                                <label for="category" class="form-label fw-semibold">Danh mục</label>
                                <input type="text" name="category" id="category" value="${product.category}" class="form-control">
                            </div>

                            <%-- Buttons: Hủy và Lưu --%>
                            <div class="d-flex justify-content-end pt-3">
                                <a href="${pageContext.request.contextPath}/ProductServlet?action=list" class="btn btn-secondary me-2">
                                    Hủy
                                </a>
                                <button type="submit" class="btn btn-danger fw-semibold px-4">
                                    Lưu lại
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