<%@page contentType="text/html" pageEncoding="UTF-8" isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>⚽ Quản lý Trận Đấu</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen p-8">

    <div class="max-w-6xl mx-auto bg-white rounded-2xl shadow-lg p-6">
        <!-- Header -->
        <div class="flex justify-between items-center mb-6">
            <h1 class="text-3xl font-bold text-red-700">⚽ Quản lý Trận Đấu</h1>
            <a href="MatchServlet?action=new" 
               class="bg-green-600 text-white px-4 py-2 rounded-lg font-semibold hover:bg-green-700 transition">
                ➕ Thêm Trận Mới
            </a>
        </div>

        <!-- Bảng danh sách -->
        <table class="w-full border border-gray-300 rounded-lg text-left">
            <thead class="bg-red-600 text-white">
                <tr>
                    <th class="py-2 px-3">Đội Nhà</th>
                    <th class="py-2 px-3">Tỷ số</th>
                    <th class="py-2 px-3">Đội Khách</th>
                    <th class="py-2 px-3">Ngày Đấu</th>
                    <th class="py-2 px-3">Sân Vận Động</th>
                    <th class="py-2 px-3 text-center">Thao Tác</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="m" items="${matchList}">
                    <tr class="border-b hover:bg-gray-50 transition">
                        <td class="py-2 px-3 font-semibold text-gray-800">${m.homeTeamName}</td>
                        <td class="py-2 px-3 text-center text-gray-700">
                            <span class="font-semibold">${m.homeScore}</span> - <span class="font-semibold">${m.awayScore}</span>
                        </td>
                        <td class="py-2 px-3 font-semibold text-gray-800">${m.awayTeamName}</td>
                        <td class="py-2 px-3 text-gray-600">
                            <fmt:formatDate value="${m.matchDate}" pattern="dd/MM/yyyy" />
                        </td>
                        <td class="py-2 px-3 text-gray-700">${m.stadium}</td>
                        <td class="py-2 px-3 text-center space-x-3">
                            <a href="MatchServlet?action=edit&id=${m.matchID}" 
                               class="text-blue-600 hover:underline">✏️ Sửa</a>
                            <a href="MatchServlet?action=delete&id=${m.matchID}" 
                               class="text-red-600 hover:underline"
                               onclick="return confirm('Vua có chắc muốn xóa trận này không?');">🗑️ Xóa</a>
                        </td>
                    </tr>
                </c:forEach>

                <c:if test="${empty matchList}">
                    <tr><td colspan="7" class="text-center py-4 text-gray-600">Không có trận đấu nào.</td></tr>
                </c:if>
            </tbody>
        </table>

        <!-- Quay lại dashboard -->
        <div class="mt-6 text-center">
            <a href="${pageContext.request.contextPath}/admin" 
               class="text-gray-600 hover:underline">⬅ Quay lại Dashboard</a>
        </div>
    </div>

</body>
</html>
