<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*, Model.Team" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh sách đội - FC Bayern Portal</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
                <a class="nav-link active fw-bold text-danger" href="${pageContext.request.contextPath}/TeamServlet?action=list">👥 Teams</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/MatchServlet?action=list">⚽ Matches</a>
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
            <h2 class="fw-bold text-danger">Danh sách đội bóng</h2>

            <div class="table-responsive rounded-3 border">
                <table class="table table-striped table-hover table-bordered align-middle mb-0">
                    <thead class="bg-danger text-white">
                        <tr>
                            <th class="py-3 px-4 text-center">#</th>
                            <th class="py-3 px-4 text-start">Tên đội</th>
                            <th class="py-3 px-4 text-start">HLV</th>
                            <th class="py-3 px-4 text-start">Quốc gia</th>
                            <th class="py-3 px-4 text-center">Tỷ lệ thắng (%)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<Team> teamList = (List<Team>) request.getAttribute("teamList");
                            if (teamList != null && !teamList.isEmpty()) {
                                int index = 1;
                                for (Team t : teamList) {
                        %>
                        <tr>
                            <td class="py-3 px-4 text-center"><%= index++ %></td>
                            <td class="py-3 px-4 text-start"><%= t.getTeamName() %></td>
                            <td class="py-3 px-4 text-start"><%= t.getCoach() %></td>
                            <td class="py-3 px-4 text-start"><%= t.getCountry() %></td>
                            <td class="py-3 px-4 text-center fw-semibold text-danger">
                                <%= String.format("%.2f", t.getWinRate()) %>%
                            </td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="5" class="text-center py-4 text-muted">Không có dữ liệu đội bóng.</td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>

            <div class="mt-5">
                <h2 class="h3 fw-bold text-dark mb-4 text-center">📈 Biểu đồ tỷ lệ thắng</h2>
                <canvas id="winRateChart"></canvas>
            </div>
        </div>
    </main>

    <footer class="text-center py-4 text-muted border-top mt-auto">
        © 2025 Bayern Munich. All rights reserved.
    </footer>

    <script>
        // Lấy dữ liệu từ JSP để truyền vào Chart.js
        const teamNames = [
        <%-- SỬA: Thêm kiểm tra null để tránh lỗi --%>
        <%  if (teamList != null) {
                for (Team t : teamList) { 
        %>
            "<%= t.getTeamName() %>",
        <% 
                } 
            }
        %>
        ];
        
        const winRates = [
        <%-- SỬA: Thêm kiểm tra null để tránh lỗi --%>
        <%  if (teamList != null) {
                for (Team t : teamList) { 
        %>
            <%= t.getWinRate() %>,
        <% 
                } 
            }
        %>
        ];

        // Tạo biểu đồ (Giữ nguyên)
        const ctx = document.getElementById('winRateChart').getContext('2d');
        new Chart(ctx, {
            type: 'bar',
            data: {
                labels: teamNames,
                datasets: [{
                    label: 'Tỷ lệ thắng (%)',
                    data: winRates,
                    borderWidth: 2,
                    backgroundColor: '#DC052D'
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true,
                        title: {
                            display: true,
                            text: 'Tỷ lệ thắng (%)'
                        }
                    }
                },
                plugins: {
                    legend: {
                        display: false
                    }
                }
            }
        });
    </script>

</body>
</html>