<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<div class="bg-white p-6 rounded-xl shadow-md">
    <h1 class="text-2xl font-bold text-red-600 mb-6">📊 Thống kê toàn đội</h1>

    <div class="grid grid-cols-3 gap-6">
        <div class="p-4 bg-red-100 rounded-lg text-center">
            <p class="text-gray-600">Tổng số đội</p>
            <p class="text-3xl font-bold text-red-700">${teamCount}</p>
        </div>
        <div class="p-4 bg-blue-100 rounded-lg text-center">
            <p class="text-gray-600">Tổng số trận</p>
            <p class="text-3xl font-bold text-blue-700">${matchCount}</p>
        </div>
        <div class="p-4 bg-green-100 rounded-lg text-center">
            <p class="text-gray-600">Tỷ lệ thắng trung bình</p>
            <p class="text-3xl font-bold text-green-700">${avgWinRate}%</p>
        </div>
    </div>

    <div class="mt-8">
        <canvas id="winRateChart" height="100"></canvas>
    </div>
</div>

<script>
    const ctx = document.getElementById('winRateChart');
    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: [<c:forEach var="t" items="${teams}">'${t.teamName}',</c:forEach>],
            datasets: [{
                label: 'Tỷ lệ thắng (%)',
                data: [<c:forEach var="t" items="${teams}">${t.winRate},</c:forEach>],
                borderWidth: 1,
                backgroundColor: 'rgba(220, 38, 38, 0.7)'
            }]
        },
        options: { scales: { y: { beginAtZero: true, max: 100 } } }
    });
</script>