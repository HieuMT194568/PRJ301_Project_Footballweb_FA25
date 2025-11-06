<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Giỏ hàng - FC Bayern Portal</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>

<body class="bg-light d-flex flex-column min-vh-100">

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
        <div class="col-lg-10 col-xl-8 mx-auto bg-white p-4 p-md-5 rounded-3 shadow-sm">
            <h1 class="h2 fw-bold text-danger mb-4">🛒 Giỏ hàng của bạn</h1>

            <c:if test="${empty cartItems}">
                <div class="text-center p-4 border rounded-3">
                    <p class="fs-5 text-muted mb-0">Chưa có sản phẩm nào trong giỏ.</p>
                    <a href="${pageContext.request.contextPath}/shop" class="btn btn-danger mt-3">Quay lại cửa hàng</a>
                </div>
            </c:if>

            <c:if test="${not empty cartItems}">
                <div class="table-responsive rounded-3 border">
                    <table class="table table-striped table-hover align-middle mb-0">
                        <thead class="bg-danger text-white">
                            <tr>
                                <th class="py-3 px-4">Sản phẩm</th>
                                <th class="py-3 px-4 text-end">Giá</th>
                                <th class="py-3 px-4 text-center">Số lượng</th>
                                <th class="py-3 px-4 text-end">Tổng</th>
                                <th class="py-3 px-4 text-center">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${cartItems}">
                                <tr>
                                    <td class="py-3 px-4">${item.product.productName}</td>
                                    <td class="py-3 px-4 text-end text-nowrap">
                                        <fmt:formatNumber value="${item.product.price}" pattern="#,##0" /> ₫
                                    </td>
                                    <td class="py-3 px-4 text-center">${item.quantity}</td>
                                    <td class="py-3 px-4 text-end text-nowrap">
                                        <fmt:formatNumber value="${item.totalPrice}" pattern="#,##0" /> ₫
                                    </td>
                                    <td class="py-3 px-4 text-center">
                                        <a href="${pageContext.request.contextPath}/CartServlet?action=remove&id=${item.product.productID}" 
                                           class="btn btn-outline-danger btn-sm">🗑️ Xóa</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <div class="d-flex flex-column flex-md-row justify-content-between align-items-center mt-4">
                    <h3 class="h4 fw-bold mb-3 mb-md-0">
                        Tổng cộng: 
                        <span class="text-danger"><fmt:formatNumber value="${total}" pattern="#,##0" /> ₫</span>
                    </h3>
                    <form action="${pageContext.request.contextPath}/CheckoutServlet" method="post">
                        <button type="submit" class="btn btn-success btn-lg fw-medium">💳 Thanh toán</button>
                    </form>
                </div>
            </c:if>
        </div>
    </main>
    
    <footer class="text-center py-4 text-muted border-top mt-auto">
        © 2025 Bayern Munich. All rights reserved.
    </footer>

</body>
</html>