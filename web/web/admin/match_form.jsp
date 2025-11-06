<%@page contentType="text/html" pageEncoding="UTF-8" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>
        <c:if test="${empty match}">➕ Thêm Trận Mới</c:if>
        <c:if test="${not empty match}">✏️ Sửa Trận Đấu</c:if>
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
                            <c:if test="${empty match}">➕ Thêm Trận Mới</c:if>
                            <c:if test="${not empty match}">✏️ Cập Nhật Trận Đấu</c:if>
                        </h2>
                        
                        <%-- <p class="text-muted small">Debug: match = ${match}</p> --%>

                        <form action="MatchServlet" method="post">
                            <input type="hidden" name="matchID" value="${match.matchID}">
                            <input type="hidden" name="action" value="${empty match ? 'insert' : 'update'}">

                            <div class="mb-3">
                                <label for="homeTeamID" class="form-label fw-semibold">🏠 Đội Nhà</label>
                                <select name="homeTeamID" id="homeTeamID" required class="form-select">
                                    <option value="">-- Chọn đội --</option>
                                    <c:forEach var="t" items="${teamList}">
                                        <option value="${t.teamID}"
                                            <c:if test="${not empty match && match.homeTeamID == t.teamID}">selected</c:if>>
                                            ${t.teamName}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label for="awayTeamID" class="form-label fw-semibold">🚩 Đội Khách</label>
                                <select name="awayTeamID" id="awayTeamID" required class="form-select">
                                    <option value="">-- Chọn đội --</option>
                                    <c:forEach var="t" items="${teamList}">
                                        <option value="${t.teamID}"
                                            <c:if test="${not empty match && match.awayTeamID == t.teamID}">selected</c:if>>
                                            ${t.teamName}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="homeScore" class="form-label fw-semibold">⚽ Tỷ số đội nhà</label>
                                    <input type="number" name="homeScore" id="homeScore" min="0" value="${match.homeScore}" class="form-control">
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="awayScore" class="form-label fw-semibold">⚽ Tỷ số đội khách</label>
                                    <input type="number" name="awayScore" id="awayScore" min="0" value="${match.awayScore}" class="form-control">
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="matchDate" class="form-label fw-semibold">📅 Ngày thi đấu</label>
                                <fmt:formatDate value="${match.matchDate}" pattern="yyyy-MM-dd" var="formattedDate" />
                                <input type="date" name="matchDate" id="matchDate" value="${formattedDate}" required class="form-control">
                            </div>

                            <div class="mb-3">
                                <label for="stadium" class="form-label fw-semibold">🏟️ Sân vận động</label>
                                <input type="text" name="stadium" id="stadium" value="${match.stadium}" class="form-control" placeholder="Nhập tên sân vận động...">
                            </div>

                            <div class="d-flex justify-content-between pt-3">
                                <a href="MatchServlet?action=admin" class="btn btn-secondary">
                                    ⬅ Quay lại
                                </a>
                                <button type="submit" class="btn btn-danger fw-semibold px-4">
                                    💾 Lưu
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