<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

    <body class="bg-neutral-100 min-h-screen flex flex-col">

        <header class="bg-red-700 text-white shadow-lg z-20">
            <div class="flex justify-between items-center h-16 px-6 md:px-8">

                <div class="flex items-center space-x-3">
                    <a href="articles" class="flex items-center space-x-2">
                        <img src="assets/images/bayern-logo.png" class="h-10 w-10 rounded-full shadow-md bg-white p-1">
                        <h1 class="text-2xl font-bold truncate">FC Bayern Munich</h1>
                    </a>
                </div>

                <div class="flex items-center space-x-4">
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <span class="hidden md:block font-medium">
                                Welcome, ${sessionScope.user.fullName}!
                            </span>
                            <a href="LogoutServlet" class="bg-white text-red-700 px-3 py-1 rounded-lg font-semibold hover:bg-gray-100">
                                Logout
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="login.jsp" class="bg-white text-red-700 px-3 py-1 rounded-lg font-semibold hover:bg-gray-100">
                                Login
                            </a>
                        </c:otherwise>
                    </c:choose>

                    <a href="CartServlet?action=view" class="relative bg-white text-red-700 px-3 py-1 rounded-lg font-semibold hover:bg-gray-100">
                        🛒
                        <c:if test="${not empty sessionScope.cart}">
                            <span class="absolute -top-2 -right-2 bg-yellow-400 text-xs text-black px-2 rounded-full">
                                ${sessionScope.cart.size()}
                            </span>
                        </c:if>
                    </a>
                </div>
            </div>
        </header>


        <nav class="bg-white shadow-md border-b border-gray-200 sticky top-0 z-10">
            <div class="flex items-center space-x-8 h-12 px-6 md:px-8">
                <a href="TeamServlet?action=list" class="flex items-center text-gray-700 hover:text-red-600 font-medium transition">
                    👥 <span class="ml-1">Teams</span>
                </a>

                <a href="MatchServlet?action=list" class="flex items-center text-gray-700 hover:text-red-600 font-medium transition">
                    ⚽ <span class="ml-1">Matches</span>
                </a>

                <a href="articles" class="flex items-center text-gray-700 hover:text-red-600 font-medium transition">
                    📰 <span class="ml-1">News</span>
                </a>

                <a href="shop" class="flex items-center text-gray-700 hover:text-red-600 font-medium transition">
                    🛍️ <span class="ml-1">Shop</span>
                </a>

                <c:if test="${sessionScope.user != null && sessionScope.user.role == 'ADMIN'}">
                    <a href="admin" class="flex items-center text-gray-700 hover:text-red-600 font-medium transition">
                        ⚙️ <span class="ml-1">Admin Panel</span>
                    </a>
                </c:if>
            </div>
        </nav>


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
            <%  for (Team t : teamList) { %>
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
