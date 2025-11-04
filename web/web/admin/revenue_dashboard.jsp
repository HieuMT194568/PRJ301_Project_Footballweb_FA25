<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Revenue Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body class="bg-gray-100 p-8">
<div class="max-w-6xl mx-auto bg-white p-6 rounded-xl shadow-lg">
    <h1 class="text-2xl font-bold text-red-600 mb-6">📊 Thống kê doanh thu</h1>

    <div class="grid grid-cols-2 gap-6 mb-6">
        <div class="bg-green-100 p-4 rounded-lg text-center">
            <h2 class="text-lg font-semibold">Tổng doanh thu</h2>
            <p class="text-3xl font-bold text-green-600">${totalRevenue} ₫</p>
        </div>
        <div class="bg-blue-100 p-4 rounded-lg text-center">
            <h2 class="text-lg font-semibold">Đơn hàng tháng này</h2>
            <p class="text-3xl font-bold text-blue-600">${ordersThisMonth}</p>
        </div>
    </div>

    <canvas id="revenueChart" height="100"></canvas>

    <h2 class="text-xl font-bold mt-10 mb-4">🏆 Top 5 sản phẩm bán chạy</h2>
    <ul class="list-disc pl-8">
        <c:forEach var="entry" items="${topProducts}">
            <li>${entry.key} — <span class="font-semibold">${entry.value}</span> lượt bán</li>
        </c:forEach>
    </ul>
</div>

<script>
    const months = [<c:forEach var="entry" items="${monthlyRevenue}">"${entry.key}",</c:forEach>];
    const revenues = [<c:forEach var="entry" items="${monthlyRevenue}">${entry.value},</c:forEach>];

    new Chart(document.getElementById('revenueChart'), {
        type: 'line',
        data: {
            labels: months,
            datasets: [{
                label: 'Doanh thu (VND)',
                data: revenues,
                borderColor: 'rgb(255, 99, 132)',
                tension: 0.3,
                fill: true
            }]
        }
    });
</script>
</body>
</html>
