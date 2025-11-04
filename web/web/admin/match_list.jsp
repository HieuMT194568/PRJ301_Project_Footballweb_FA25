<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <title>⚽ Quản lý trận đấu</title>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body class="bg-gray-100 p-8">
        <div class="max-w-6xl mx-auto bg-white p-6 rounded-xl shadow-md">
            <div class="flex justify-between items-center mb-4">
                <h1 class="text-2xl font-bold text-red-600">⚽ Quản lý trận đấu</h1>
                <a href="MatchServlet?action=new" class="bg-green-600 text-white px-4 py-2 rounded-lg hover:bg-green-700 transition">➕ Thêm mới</a>
            </div>

            <table class="w-full border border-gray-300 rounded-lg text-center">
                <thead class="bg-red-600 text-white">
                    <tr>
                        <th>ID</th>
                        <th>Đội nhà</th>
                        <th>Đội khách</th>
                        <th>Tỷ số</th>
                        <th>Ngày thi đấu</th>
                        <th>Sân</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="m" items="${matchList}">
                        <tr class="border-b hover:bg-gray-50">
                            <td>${m.matchID}</td>
                            <td>${m.homeTeamName}</td>
                            <td>${m.awayTeamName}</td>
                            <td>${m.homeScore} - ${m.awayScore}</td>
                            <td>${m.matchDate}</td>
                            <td>${m.stadium}</td>
                            <c:if test="${sessionScope.user != null && sessionScope.user.role == 'ADMIN'}">
                                <td >
                                    <a href="MatchServlet?action=edit&id=${m.matchID}" class="text-blue-600 hover:underline">✏️</a>
                                    <a href="MatchServlet?action=delete&id=${m.matchID}" class="text-red-600 hover:underline" onclick="return confirm('Xóa trận này?');">🗑️</a>
                                </td>
                            </c:if>

                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <div class="text-center mt-6">
                <a href="admin_dashboard.jsp" class="text-gray-600 hover:underline">⬅ Quay lại Dashboard</a>
            </div>
        </div>
    </body>
</html>
