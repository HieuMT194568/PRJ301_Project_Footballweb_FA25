<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Danh sách trận đấu - FC Bayern Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <style>
        /* Bạn có thể giữ lại nếu muốn, nhưng nó không được dùng ở trang này */
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
                <a class="nav-link active fw-bold text-danger" href="${pageContext.request.contextPath}/MatchServlet?action=list">⚽ Matches</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/articles">📰 News</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/shop">🛍️ Shop</a>
                <c:if test="${sessionScope.user != null && sessionScope.user.role == 'ADMIN'}">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin">⚙️ Admin Panel</a>
                </c:if>
            </div>
        </div>
    </nav>

    <main class="container my-5">
        <div class="bg-white p-4 p-md-5 rounded-3 shadow-sm">
            <div class="mb-4">
                <h2 class="fw-bold text-danger">Danh sách trận đấu</h2>
            </div>

            <div class="table-responsive rounded-3 border">
                <table class="table table-striped table-hover table-bordered text-center align-middle mb-0">
                    <thead class="bg-danger text-white">
                        <tr>
                            <th class="py-3">Đội nhà</th>
                            <th class="py-3">Đội khách</th>
                            <th class="py-3">Tỷ số</th>
                            <th class="py-3">Ngày thi đấu</th>
                            <th class="py-3">Sân</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="m" items="${matchList}">
                            <tr>
                                <td class="py-3">${m.homeTeamName}</td>
                                <td class="py-3">${m.awayTeamName}</td>
                                <td class="py-3 fw-bold">${m.homeScore} - ${m.awayScore}</td>
                                <td class="py-3">
                                    <fmt:formatDate value="${m.matchDate}" pattern="HH:mm, dd/MM/yyyy"/>
                                </td>
                                <td class="py-3">${m.stadium}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <div class="text-center mt-4">
                <a href="${pageContext.request.contextPath}/articles" class="text-secondary">⬅ Quay lại</a>
            </div>
        </div>
    </main>
    
</body>
</html>