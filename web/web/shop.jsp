<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Shop - FC Bayern Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <style>
        .card-img-top-fixed {
            height: 200px; /* Đặt chiều cao cố định cho ảnh */
            object-fit: cover; /* Đảm bảo ảnh lấp đầy mà không bị méo */
        }

        /* CẢI TIẾN 1: Thêm hiệu ứng hover cho Card
        */
        .card {
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .card:hover {
            transform: translateY(-5px); /* Nâng card lên 5px */
            box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important; /* Thêm bóng đổ lớn hơn */
        }
    </style>
</head>
<body class="bg-light">

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

                <a href="${pageContext.request.contextPath}/CartServlet?action=view" class="btn btn-light text-danger fw-semibold position-relative">
                    🛒
                    <c:if test="${not empty sessionScope.cart}">
                        <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-warning text-dark">
                            ${sessionScope.cart.size()}
                        </span>
                    </c:if>
                </a>
            </div>
        </div>
    </header>

    <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm border-bottom sticky-top">
        <div class="container-fluid">
            <div class="navbar-nav">
                <a class="nav-link" href="${pageContext.request.contextPath}/TeamServlet?action=list">👥 Teams</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/MatchServlet?action=list">⚽ Matches</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/articles">📰 News</a>
                <a class="nav-link active fw-bold text-danger" href="${pageContext.request.contextPath}/shop">🛍️ Shop</a>
                
                <c:if test="${sessionScope.user != null && sessionScope.user.role == 'ADMIN'}">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin">⚙️ Admin Panel</a>
                </c:if>
            </div>
        </div>
    </nav>

    <main class="container my-5">
        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4">
            <c:forEach var="p" items="${productList}">
                <div class="col">
                    <div class="card h-100 shadow-sm">
                        <img src="${pageContext.request.contextPath}/assets/${p.imageUrl}" class="card-img-top card-img-top-fixed" alt="${p.productName}">
                        
                        <div class="card-body d-flex flex-column">
                            <h5 class="card-title fw-bold text-dark text-truncate" title="${p.productName}">
                                ${p.productName}
                            </h5>
                            <p class="card-text text-muted small">${p.category}</p>
                            
                            <p class="card-text fs-5 fw-semibold text-danger mb-2">
                                <fmt:formatNumber value="${p.price}" pattern="#,##0" /> ₫
                            </p>

                            <div class="mt-auto">
                                <c:choose>
                                    <c:when test="${p.stockQuantity > 0}">
                                        <p class="text-success small mb-2">Còn lại: ${p.stockQuantity}</p>
                                        <a href="${pageContext.request.contextPath}/CartServlet?action=add&id=${p.productID}"
                                           class="btn btn-danger w-100 fw-medium">
                                           🛒 Thêm vào giỏ
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <p class="text-danger small fw-semibold mb-2">❌ Hết hàng</p>
                                        <button class="btn btn-secondary w-100" disabled>
                                            Hết hàng
                                        </button>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </main>

    <footer class="text-center py-4 text-muted border-top mt-5">
        © 2025 Bayern Munich. All rights reserved.
    </footer>
    
</body>
</html>