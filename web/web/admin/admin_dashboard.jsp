<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Admin Dashboard - FC Bayern Portal</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
    <style>
        /* CSS tùy chỉnh cho các thẻ thống kê */
        .card-border-left-primary { border-left: .25rem solid var(--bs-primary); }
        .card-border-left-success { border-left: .25rem solid var(--bs-success); }
        .card-border-left-danger  { border-left: .25rem solid var(--bs-danger); }
        .card-border-left-warning { border-left: .25rem solid var(--bs-warning); }
        
        .card-admin-link {
            text-decoration: none;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .card-admin-link:hover {
            transform: translateY(-5px);
            box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important;
        }
    </style>
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
                </div>
        </div>
    </header>

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

    <main class="container my-5">
        <div class="row g-4">
            
            <div class="col-12">
                <h2 class="h4 fw-bold text-dark mb-3">⚙️ Quản lý nội dung</h2>
                <%-- 
                  ĐÃ SỬA: Thay đổi 'row-cols-md-3' thành 'row-cols-sm-2 row-cols-lg-4' 
                  để hiển thị 4 cột trên màn hình lớn (lg) và 2 cột trên màn hình nhỏ (sm)
                --%>
                <div class="row row-cols-1 row-cols-sm-2 row-cols-lg-4 g-4">
                    <div class="col">
                        <a href="${pageContext.request.contextPath}/MatchServlet?action=admin" class="card card-admin-link bg-primary text-white text-center shadow-sm">
                            <div class="card-body p-4">
                                <h5 class="card-title fw-semibold">⚽️ Quản lý trận đấu</h5>
                            </div>
                        </a>
                    </div>
                    <div class="col">
                        <a href="${pageContext.request.contextPath}/ProductServlet?action=list" class="card card-admin-link bg-success text-white text-center shadow-sm">
                            <div class="card-body p-4">
                                <h5 class="card-title fw-semibold">🛍️ Quản lý sản phẩm</h5>
                            </div>
                        </a>
                    </div>
                    <div class="col">
                        <a href="${pageContext.request.contextPath}/AdminArticleServlet" class="card card-admin-link bg-warning text-dark text-center shadow-sm">
                            <div class="card-body p-4">
                                <h5 class="card-title fw-semibold">📰 Quản lý bài viết</h5>
                            </div>
                        </a>
                    </div>
                    <div class="col">
                        <a href="${pageContext.request.contextPath}/adminUser" class="card card-admin-link bg-warning text-dark text-center shadow-sm">
                            <div class="card-body p-4">
                                <h5 class="card-title fw-semibold">📰 Quản lý người dùng</h5>
                            </div>
                        </a>
                    </div>        
                            
                </div>
            </div>

            <div class="col-12">
                <h2 class="h4 fw-bold text-dark mb-3 mt-4">📊 Thống kê tổng quan</h2>
                <div class="row row-cols-1 row-cols-sm-2 row-cols-lg-4 g-4">
                    <div class="col">
                        <div class="card card-border-left-primary shadow-sm h-100">
                            <div class="card-body">
                                <div class="text-xs fw-bold text-primary text-uppercase mb-1">Tổng số User</div>
                                <div class="h3 fw-bold text-dark mt-2 mb-0">${totalUsers}</div>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="card card-border-left-success shadow-sm h-100">
                            <div class="card-body">
                                <div class="text-xs fw-bold text-success text-uppercase mb-1">Đơn hàng tháng này</div>
                                <div class="h3 fw-bold text-dark mt-2 mb-0">${ordersThisMonth}</div>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="card card-border-left-danger shadow-sm h-100">
                            <div class="card-body">
                                <div class="text-xs fw-bold text-danger text-uppercase mb-1">Tổng doanh thu</div>
                                <div class="h3 fw-bold text-dark mt-2 mb-0"><fmt:formatNumber value="${totalRevenue}" pattern="#,##0" /> ₫</div>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="card card-border-left-warning shadow-sm h-100">
                            <div class="card-body">
                                <div class="text-xs fw-bold text-warning text-uppercase mb-1">Số lượng sản phẩm</div>
                                <div class="h3 fw-bold text-dark mt-2 mb-0">${totalProducts}</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-12">
                <div class="card shadow-sm">
                    <div class="card-header bg-light py-3">
                        <h6 class="m-0 fw-bold text-dark">📈 Doanh thu 7 ngày qua</h6>
                    </div>
                    <div class="card-body">
                        <canvas id="revenueChart"></canvas>
                    </div>
                </div>
            </div>

            <div class="col-12">
                <div class="card shadow-sm">
                    <div class="card-header bg-light py-3">
                        <h6 class="m-0 fw-bold text-dark">🧾 Danh sách đơn hàng mới nhất</h6>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive rounded-3 border">
                            <table class="table table-striped table-hover align-middle mb-0">
                                <thead class="bg-light">
                                    <tr>
                                        <th class="px-3 py-3 text-start">Mã đơn</th>
                                        <th class="px-3 py-3 text-start">Người đặt</th>
                                        <th class="px-3 py-3 text-start">Tổng tiền</th>
                                        <th class="px-3 py-3 text-start">Ngày đặt</th>
                                        <th class="px-3 py-3 text-start">Trạng thái</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="order" items="${orderList}">
                                        <tr>
                                            <td class="px-3 py-3">${order.orderID}</td>
                                            <td class="px-3 py-3 text-nowrap">${order.userName}</td>
                                            <td class="px-3 py-3 text-nowrap"><fmt:formatNumber value="${order.totalAmount}" pattern="#,##0"/> ₫</td>
                                            <td class="px-3 py-3 text-nowrap"><fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                                            <td class="px-3 py-3">
                                                <c:choose>
                                                    <c:when test="${order.status == 'Pending'}">
                                                        <span class="badge bg-warning-subtle text-warning-emphasis rounded-pill">
                                                            ${order.status}
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${order.status == 'Completed'}">
                                                        <span class="badge bg-success-subtle text-success-emphasis rounded-pill">
                                                            ${order.status}
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary-subtle text-secondary-emphasis rounded-pill">
                                                            ${order.status}
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            
        </div> </main>
    
    <footer class="text-center py-4 text-muted border-top mt-auto">
        © 2025 Bayern Munich. All rights reserved.
    </footer>

    <script>
        // === KHỞI TẠO BIỂU ĐỒ ===
        const jstlLabels = [
            <c:forEach var="label" items="${chartLabels}" varStatus="loop">
                "${label}"<c:if test="${!loop.last}">,</c:if>
            </c:forEach>
        ];
        
        const jstlData = [
            <c:forEach var="dataPoint" items="${chartData}" varStatus="loop">
                ${dataPoint}<c:if test="${!loop.last}">,</c:if>
            </c:forEach>
        ];
        
        const finalLabels = jstlLabels.length > 0 ? jstlLabels : ['1/11', '2/11', '3/11', '4/11', '5/11', '6/11', '7/11'];
        const finalData = jstlData.length > 0 ? jstlData : [120000, 190000, 300000, 500000, 230000, 780000, 450000];

        const ctx = document.getElementById('revenueChart').getContext('2d');
        const revenueChart = new Chart(ctx, {
            type: 'bar', 
            data: {
                labels: finalLabels,
                datasets: [{
                    label: 'Doanh thu (₫)',
                    data: finalData,
                    backgroundColor: 'rgba(220, 38, 38, 0.6)', 
                    borderColor: 'rgba(220, 38, 38, 1)',
                    borderWidth: 1,
                    borderRadius: 5
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                },
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'top',
                    },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                let label = context.dataset.label || '';
                                if (label) {
                                    label += ': ';
                                }
                                if (context.parsed.y !== null) {
                                    label += new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(context.parsed.y);
                                }
                                return label;
                            }
                        }
                    }
                }
            }
        });
    </script>
</body>
</html>