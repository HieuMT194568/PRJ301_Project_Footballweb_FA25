<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body class="bg-gray-100 min-h-screen">
    <div class="flex">

        <!-- Sidebar -->
        <div class="w-64 bg-gray-900 text-white min-h-screen p-6">
            <h2 class="text-2xl font-bold mb-6 text-center text-red-400">ADMIN PANEL</h2>
            <ul class="space-y-3">
                <li><a href="AdminDashboard" class="block hover:text-red-400">📊 Dashboard</a></li>
                <li><a href="ManageProducts" class="block hover:text-red-400">📦 Products</a></li>
                <li><a href="ManageOrders" class="block hover:text-red-400">🧾 Orders</a></li>
                <li><a href="ManageUsers" class="block hover:text-red-400">👥 Users</a></li>
                <li><a href="LogoutServlet" class="block text-red-400">🚪 Logout</a></li>
            </ul>
        </div>

        <!-- Main Content -->
        <div class="flex-1 p-10">
            <h1 class="text-3xl font-bold mb-8 text-gray-800">📊 Thống kê tổng quan</h1>

            <div class="grid grid-cols-3 gap-6 mb-10">
                <div class="bg-white p-6 rounded-xl shadow text-center">
                    <p class="text-gray-500">Người dùng</p>
                    <h2 class="text-3xl font-bold text-blue-500">${totalUsers}</h2>
                </div>
                <div class="bg-white p-6 rounded-xl shadow text-center">
                    <p class="text-gray-500">Đơn hàng</p>
                    <h2 class="text-3xl font-bold text-green-500">${totalOrders}</h2>
                </div>
                <div class="bg-white p-6 rounded-xl shadow text-center">
                    <p class="text-gray-500">Doanh thu (VNĐ)</p>
                    <h2 class="text-3xl font-bold text-red-500">
                        <fmt:formatNumber value="${totalRevenue}" type="number" groupingUsed="true"/>
                    </h2>
                </div>
            </div>

            <div class="bg-white p-8 rounded-xl shadow">
                <h2 class="text-xl font-semibold mb-4">🔥 Top sản phẩm bán chạy</h2>
                <canvas id="topProductsChart" height="120"></canvas>
            </div>
        </div>
    </div>
  <div class="max-w-6xl mx-auto bg-white p-6 rounded-xl shadow-md">
        <h1 class="text-3xl font-bold text-red-600 mb-6">⚙️ Bảng điều khiển quản trị</h1>

        <div class="grid grid-cols-2 md:grid-cols-3 gap-6">
            <!-- Quản lý sản phẩm -->
            <a href="${pageContext.request.contextPath}/ProductServlet?action=list"
               class="bg-red-500 hover:bg-red-600 text-white p-6 rounded-xl shadow text-center font-semibold">
                🛍️ Quản lý sản phẩm
            </a>

            <!-- Quản lý đơn hàng -->
            <a href="${pageContext.request.contextPath}/OrderServlet?action=list"
               class="bg-blue-500 hover:bg-blue-600 text-white p-6 rounded-xl shadow text-center font-semibold">
                📦 Quản lý đơn hàng
            </a>

            <!-- Quản lý người dùng -->
            <a href="${pageContext.request.contextPath}/UserServlet?action=list"
               class="bg-green-500 hover:bg-green-600 text-white p-6 rounded-xl shadow text-center font-semibold">
                👥 Quản lý người dùng
            </a>

            <!-- Dashboard doanh thu -->
            <a href="${pageContext.request.contextPath}/admin/revenue"
               class="bg-yellow-500 hover:bg-yellow-600 text-white p-6 rounded-xl shadow text-center font-semibold">
                📈 Doanh thu & Thống kê
            </a>
        </div>
    </div>
    <script>
        const ctx = document.getElementById('topProductsChart').getContext('2d');
        const chart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: [<c:forEach var="p" items="${topProducts}">"${p.name}",</c:forEach>],
                datasets: [{
                    label: 'Số lượng bán',
                    data: [<c:forEach var="p" items="${topProducts}">${p.sold},</c:forEach>],
                    borderWidth: 1,
                    backgroundColor: 'rgba(255, 99, 132, 0.5)'
                }]
            },
            options: { scales: { y: { beginAtZero: true } } }
        });
    </script>
    
</body>
</html>
