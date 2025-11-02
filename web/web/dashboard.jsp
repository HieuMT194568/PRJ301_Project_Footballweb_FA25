<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, Model.Team" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Dashboard - FC Bayern Stats</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>

<body class="bg-gray-100">

<header class="bg-[#DC052D] text-white p-4 text-center shadow-lg">
    <h1 class="text-2xl font-bold">📊 FC BAYERN TEAM DASHBOARD</h1>
</header>

<main class="max-w-6xl mx-auto mt-10 bg-white shadow-md rounded-lg p-6">
    <h2 class="text-xl font-bold text-gray-800 mb-4">Danh sách đội bóng</h2>

    <table class="min-w-full border border-gray-300">
        <thead class="bg-[#DC052D] text-white">
            <tr>
                <th class="py-2 px-4">#</th>
                <th class="py-2 px-4 text-left">Tên đội</th>
                <th class="py-2 px-4 text-left">HLV</th>
                <th class="py-2 px-4 text-left">Quốc gia</th>
                <th class="py-2 px-4 text-center">Tỷ lệ thắng (%)</th>
            </tr>
        </thead>
        <tbody>
        <%
            List<Team> teamList = (List<Team>) request.getAttribute("teamList");
            if (teamList != null && !teamList.isEmpty()) {
                int index = 1;
                for (Team t : teamList) {
        %>
            <tr class="border-b hover:bg-gray-100">
                <td class="py-2 px-4 text-center"><%= index++ %></td>
                <td class="py-2 px-4"><%= t.getTeamName() %></td>
                <td class="py-2 px-4"><%= t.getCoach() %></td>
                <td class="py-2 px-4"><%= t.getCountry() %></td>
                <td class="py-2 px-4 text-center font-semibold text-[#DC052D]">
                    <%= String.format("%.2f", t.getWinRate()) %>%
                </td>
            </tr>
        <%
                }
            } else {
        %>
            <tr>
                <td colspan="5" class="text-center py-4 text-gray-500">Không có dữ liệu đội bóng.</td>
            </tr>
        <%
            }
        %>
        </tbody>
    </table>

    <div class="mt-10">
        <h2 class="text-xl font-bold text-gray-800 mb-4 text-center">📈 Biểu đồ tỷ lệ thắng</h2>
        <canvas id="winRateChart"></canvas>
    </div>
</main>

<script>
    // Lấy dữ liệu từ JSP để truyền vào Chart.js
    const teamNames = [
        <% for (Team t : teamList) { %>
            "<%= t.getTeamName() %>",
        <% } %>
    ];
    const winRates = [
        <% for (Team t : teamList) { %>
            <%= t.getWinRate() %>,
        <% } %>
    ];

    // Tạo biểu đồ
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
