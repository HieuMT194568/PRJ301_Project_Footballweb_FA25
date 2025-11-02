<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Danh sách trận đấu</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 p-8">
    <div class="max-w-5xl mx-auto bg-white p-6 rounded-xl shadow-md">
        <div class="flex justify-between items-center mb-4">
            <h1 class="text-2xl font-bold text-red-600">🏟️ Danh sách trận đấu</h1>
            <a href="MatchServlet?action=new" class="bg-green-600 text-white px-4 py-2 rounded-lg">➕ Thêm mới</a>
        </div>

        <table class="w-full border border-gray-300 rounded-lg text-center">
            <thead class="bg-red-600 text-white">
                <tr>
                    <th>ID</th>
                    <th>Đội nhà</th>
                    <th>Tỉ số</th>
                    <th>Đội khách</th>
                    <th>Ngày</th>
                    <th>Sân</th>
                    <th>Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="m" items="${matchList}">
                    <tr class="border-b hover:bg-gray-50">
                        <td>${m.matchID}</td>
                        <td>${m.homeTeamName}</td>
                        <td>${m.homeScore} - ${m.awayScore}</td>
                        <td>${m.awayTeamName}</td>
                        <td>${m.matchDate}</td>
                        <td>${m.stadium}</td>
                        <td>
                            <a href="MatchServlet?action=edit&id=${m.matchID}" class="text-blue-600 hover:underline">✏️</a>
                            <a href="MatchServlet?action=delete&id=${m.matchID}" class="text-red-600 hover:underline"
                               onclick="return confirm('Xóa trận này?');">🗑️</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>
