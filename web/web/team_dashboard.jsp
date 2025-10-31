<%-- 
    Document   : team_dashboard
    Created on : Oct 31, 2025, 10:47:57 AM
    Author     : HGC
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thống kê đội bóng</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body class="bg-gray-100 p-8">

    <h1 class="text-3xl font-bold mb-8 text-center text-red-700">📊 Thống kê tỷ lệ thắng của các đội</h1>

    <div class="overflow-x-auto bg-white shadow-md rounded-lg p-4 mb-8">
        <table class="min-w-full border text-sm text-center">
            <thead class="bg-red-600 text-white">
                <tr>
                    <th class="py-2 px-4">Đội bóng</th>
                    <th class="py-2 px-4">Thắng</th>
                    <th class="py-2 px-4">Hòa</th>
                    <th class="py-2 px-4">Thua</th>
                    <th class="py-2 px-4">Tỷ lệ thắng (%)</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="s" items="${teamStats}">
                    <tr class="border-b hover:bg-gray-50">
                        <td class="py-2 px-4 font-semibold">${s.teamName}</td>
                        <td class="py-2 px-4 text-green-600">${s.wins}</td>
                        <td class="py-2 px-4 text-yellow-600">${s.draws}</td>
                        <td class="py-2 px-4 text-red-600">${s.losses}</td>
                        <td class="py-2 px-4 font-bold">${s.winRate}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <div class="max-w-4xl mx-auto bg-white p-6 rounded-lg shadow-lg">
        <canvas id="winChart"></canvas>
    </div>

    <script>
        const labels = [
            <c:forEach var="s" items="${teamStats}" varStatus="loop">
                "${s.teamName}"${!loop.last ? ',' : ''}
            </c:forEach>
        ];
        const winRates = [
            <c:forEach var="s" items="${teamStats}" varStatus="loop">
                ${s.winRate}${!loop.last ? ',' : ''}
            </c:forEach>
        ];

        new Chart(document.getElementById('winChart'), {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [{
                    label: 'Tỷ lệ thắng (%)',
                    data: winRates,
                    backgroundColor: 'rgba(220, 5, 45, 0.7)'
                }]
            },
            options: {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true,
                        title: { display: true, text: 'Tỷ lệ (%)' }
                    }
                }
            }
        });
    </script>

</body>
</html>
