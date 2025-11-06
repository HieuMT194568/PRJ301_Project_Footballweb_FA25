<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>👤 Quản lý người dùng</title>
    
    <%-- Thêm CSS và JS của Bootstrap 5 --%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="bg-light d-flex flex-column min-vh-100">

    <%-- Header (Giữ nguyên) --%>
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

    <%-- Nav (Giữ nguyên) --%>
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

    <%-- Nội dung chính (Đã chuyển sang Bootstrap) --%>
    <main class="container my-5">
        <div class="row">
            <div class="col-12">
                
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h2 class="h4 fw-bold text-dark mb-0">👤 Quản lý người dùng</h2>
                    <a href="${pageContext.request.contextPath}/admin" class="btn btn-outline-danger btn-sm">
                        ⬅ Quay lại Dashboard
                    </a>
                </div>

                <div class="card shadow-sm border-0">
                    <div class="card-body p-0">
                        <div class="table-responsive rounded-3">
                            <table class="table table-striped table-hover align-middle mb-0">
                                <thead class="bg-danger text-white">
                                    <tr>
                                        <th class="px-3 py-3">ID</th>
                                        <th class="px-3 py-3">User Name</th>
                                        <th class="px-3 py-3">Họ tên</th>
                                        <th class="px-3 py-3">Email</th>
                                        <th class="px-3 py-3">Vai trò</th>
                                        <th class="px-3 py-3 text-end">Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="u" items="${userList}">
                                        <tr class="border-b">                                           
                                            <td class="px-3 py-3">${u.userID}</td>
                                            <td class="px-3 py-3">${u.username}</td>
                                            <td class="px-3 py-3">${u.fullName}</td>
                                            <td class="px-3 py-3">${u.email}</td>
                                            
                                            <%-- CỘT VAI TRÒ (Bootstrap) --%>
                                            <td class="px-3 py-3">
                                                <c:if test="${sessionScope.user.userID == u.userID}">
                                                    <span class="fw-semibold text-danger">${u.role}</span>
                                                    <span class="text-muted small">(Bạn)</span>
                                                </c:if>
                                                
                                                <c:if test="${sessionScope.user.userID != u.userID}">
                                                    <form action="UpdateUserRoleServlet" method="POST" class="m-0" style="min-width: 120px;">
                                                        <input type="hidden" name="userID" value="${u.userID}">
                                                        <select name="newRole" 
                                                                class="form-select form-select-sm"
                                                                onchange="this.form.submit()">
                                                            <option value="CUSTOMER" <c:if test="${u.role == 'CUSTOMER'}">selected</c:if>>
                                                                CUSTOMER
                                                            </option>
                                                            <option value="ADMIN" <c:if test="${u.role == 'ADMIN'}">selected</c:if>>
                                                                ADMIN
                                                            </option>
                                                        </select>
                                                    </form>
                                                </c:if>
                                            </td>
                                            
                                            <%-- CỘT THAO TÁC (Bootstrap) --%>
                                            <td class="px-3 py-3 text-end">
                                                <c:if test="${sessionScope.user.userID != u.userID}">
                                                    <a href="DeleteUserServlet?id=${u.userID}" 
                                                       class="btn btn-outline-danger btn-sm"
                                                       onclick="return confirm('Xác nhận xóa người dùng này?')">🗑️ Xóa</a>
                                                </c:if>
                                                
                                                <c:if test="${sessionScope.user.userID == u.userID}">
                                                    <span class="text-muted small">(Không thể xóa)</span>
                                                </c:if>
                                                
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
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