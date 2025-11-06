<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%-- Thêm taglib fmt để format tiền --%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>🛍️ Quản lý sản phẩm</title>
    
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
        <div class="row">
            <div class="col-12">

                <%-- Hàng tiêu đề và nút Thêm mới --%>
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2 class="h4 fw-bold text-dark mb-0">🛍️ Quản lý sản phẩm</h2>
                    <div>
                        <a href="${pageContext.request.contextPath}/ProductServlet?action=new" class="btn btn-success fw-semibold">
                            ➕ Thêm sản phẩm
                        </a>
                         <a href="${pageContext.request.contextPath}/admin" class="btn btn-outline-danger ms-2">
                            ⬅ Quay lại
                        </a>
                    </div>
                </div>
                
                <c:choose>
                    <c:when test="${empty productList}">
                        <div class="alert alert-info text-center" role="alert">
                            Không có sản phẩm nào trong danh sách.
                        </div>
                    </c:when>
                    <c:otherwise>
                        <%-- Bảng quản lý --%>
                        <div class="card shadow-sm border-0">
                            <div class="card-body p-0">
                                <div class="table-responsive rounded-3">
                                    <table class="table table-striped table-hover align-middle mb-0">
                                        <thead class="bg-danger text-white">
                                            <tr>
                                                <th class="px-3 py-3">Tên sản phẩm</th>
                                                <th class="px-3 py-3">Giá</th>
                                                <th class="px-3 py-3">Tồn kho</th>
                                                <th class="px-3 py-3">Danh mục</th>
                                                <th class="px-3 py-3 text-end">Thao tác</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="p" items="${productList}">
                                                <tr>
                                                    <td class="px-3 py-3 fw-semibold">${p.productName}</td>
                                                    <td class="px-3 py-3 text-danger fw-semibold">
                                                        <%-- Format lại giá tiền cho dễ đọc --%>
                                                        <fmt:formatNumber value="${p.price}" pattern="#,##0" /> ₫
                                                    </td>
                                                    <td class="px-3 py-3">${p.stockQuantity}</td>
                                                    <td class="px-3 py-3">${p.category}</td>
                                                    <td class="px-3 py-3 text-end">
                                                        <a href="${pageContext.request.contextPath}/ProductServlet?action=edit&id=${p.productID}"
                                                           class="btn btn-sm btn-outline-primary me-2">✏️ Sửa</a>
                                                        <a href="${pageContext.request.contextPath}/ProductServlet?action=delete&id=${p.productID}"
                                                           class="btn btn-sm btn-outline-danger"
                                                           onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này?');">🗑️ Xóa</a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>

            </div>
        </div>
    </main>
    
    <%-- Footer (Thêm vào cho đồng bộ) --%>
    <footer class="text-center py-4 text-muted border-top mt-auto bg-white">
        © 2025 Bayern Munich. All rights reserved.
    </footer>

</body>
</html>