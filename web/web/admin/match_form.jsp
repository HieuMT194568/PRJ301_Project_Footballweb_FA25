<%@page contentType="text/html" pageEncoding="UTF-8" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>
        <c:if test="${empty match}">➕ Thêm Trận Mới</c:if>
        <c:if test="${not empty match}">✏️ Sửa Trận Đấu</c:if>
    </title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 p-10">

    <div class="max-w-2xl mx-auto bg-white p-8 rounded-2xl shadow-xl border border-gray-200">
        <h2 class="text-3xl font-bold text-red-600 mb-8 text-center">
            <c:if test="${empty match}">➕ Thêm Trận Mới</c:if>
            <c:if test="${not empty match}">✏️ Cập Nhật Trận Đấu</c:if>
        </h2>
<p class="text-sm text-gray-500">Debug: match = ${match}</p>
        <form action="MatchServlet" method="post" class="space-y-6">
            <!-- Hidden Fields -->
            <input type="hidden" name="matchID" value="${match.matchID}">
            <input type="hidden" name="action" value="${empty match ? 'insert' : 'update'}">

            <!-- Đội nhà -->
            <div>
                <label class="block text-gray-700 font-medium mb-1">🏠 Đội Nhà</label>
                <select name="homeTeamID" required class="border border-gray-300 p-3 w-full rounded-lg focus:ring-2 focus:ring-red-400">
                    <option value="">-- Chọn đội --</option>
                    <c:forEach var="t" items="${teamList}">
                        <option value="${t.teamID}"
                            <c:if test="${not empty match && match.homeTeamID == t.teamID}">selected</c:if>>
                            ${t.teamName}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <!-- Đội khách -->
            <div>
                <label class="block text-gray-700 font-medium mb-1">🚩 Đội Khách</label>
                <select name="awayTeamID" required class="border border-gray-300 p-3 w-full rounded-lg focus:ring-2 focus:ring-red-400">
                    <option value="">-- Chọn đội --</option>
                    <c:forEach var="t" items="${teamList}">
                        <option value="${t.teamID}"
                            <c:if test="${not empty match && match.awayTeamID == t.teamID}">selected</c:if>>
                            ${t.teamName}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <!-- Tỷ số -->
            <div class="flex space-x-4">
                <div class="w-1/2">
                    <label class="block text-gray-700 font-medium mb-1">⚽ Tỷ số đội nhà</label>
                    <input type="number" name="homeScore" min="0" value="${match.homeScore}" 
                           class="border border-gray-300 p-3 w-full rounded-lg focus:ring-2 focus:ring-red-400">
                </div>
                <div class="w-1/2">
                    <label class="block text-gray-700 font-medium mb-1">⚽ Tỷ số đội khách</label>
                    <input type="number" name="awayScore" min="0" value="${match.awayScore}" 
                           class="border border-gray-300 p-3 w-full rounded-lg focus:ring-2 focus:ring-red-400">
                </div>
            </div>

            <!-- Ngày thi đấu -->
            <div>
                <label class="block text-gray-700 font-medium mb-1">📅 Ngày thi đấu</label>
                <fmt:formatDate value="${match.matchDate}" pattern="yyyy-MM-dd" var="formattedDate" />
                <input type="date" name="matchDate" value="${formattedDate}" required 
                       class="border border-gray-300 p-3 w-full rounded-lg focus:ring-2 focus:ring-red-400">
            </div>

            <!-- Sân vận động -->
            <div>
                <label class="block text-gray-700 font-medium mb-1">🏟️ Sân vận động</label>
                <input type="text" name="stadium" value="${match.stadium}" 
                       class="border border-gray-300 p-3 w-full rounded-lg focus:ring-2 focus:ring-red-400" 
                       placeholder="Nhập tên sân vận động...">
            </div>

            <!-- Nút hành động -->
            <div class="flex justify-between mt-8">
                <a href="MatchServlet?action=list" 
                   class="bg-gray-300 text-gray-800 px-5 py-2 rounded-lg hover:bg-gray-400 transition">
                    ⬅ Quay lại
                </a>
                <button type="submit" 
                        class="bg-red-600 text-white px-6 py-2 rounded-lg hover:bg-red-700 transition font-semibold">
                    💾 Lưu
                </button>
            </div>
        </form>
    </div>

</body>
</html>
