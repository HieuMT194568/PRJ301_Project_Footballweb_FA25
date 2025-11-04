<%@page contentType="text/html" pageEncoding="UTF-8" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Thêm/Sửa Trận Đấu</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 p-10">
    <div class="max-w-2xl mx-auto bg-white p-8 rounded-xl shadow-lg">
        <h2 class="text-2xl font-semibold text-red-600 mb-6">
            <c:if test="${empty match}">➕ Thêm Trận Mới</c:if>
            <c:if test="${not empty match}">✏️ Sửa Trận Đấu</c:if>
        </h2>

        <form action="MatchServlet" method="post" class="space-y-5">
            <input type="hidden" name="matchID" value="${match.matchID}">
            <input type="hidden" name="action" value="${empty match ? 'insert' : 'update'}">

            <!-- Chọn đội nhà -->
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Đội Nhà</label>
                <select name="homeTeamID" required class="border p-2 w-full rounded-lg">
                    <option value="">-- Chọn đội --</option>
                    <c:forEach var="t" items="${teamList}">
                        <option value="${t.teamID}" 
                            <c:if test="${not empty match && match.homeTeamID == t.teamID}">selected</c:if>>
                            ${t.teamName}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <!-- Chọn đội khách -->
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Đội Khách</label>
                <select name="awayTeamID" required class="border p-2 w-full rounded-lg">
                    <option value="">-- Chọn đội --</option>
                    <c:forEach var="t" items="${teamList}">
                        <option value="${t.teamID}" 
                            <c:if test="${not empty match && match.awayTeamID == t.teamID}">selected</c:if>>
                            ${t.teamName}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <div class="flex space-x-2">
                <div class="w-1/2">
                    <label>Tỷ số đội nhà</label>
                    <input type="number" name="homeScore" value="${match.homeScore}" min="0" class="border p-2 w-full rounded-lg">
                </div>
                <div class="w-1/2">
                    <label>Tỷ số đội khách</label>
                    <input type="number" name="awayScore" value="${match.awayScore}" min="0" class="border p-2 w-full rounded-lg">
                </div>
            </div>

            <div>
                <label>Ngày thi đấu</label>
                <input type="date" name="matchDate" value="${match.matchDate}" required class="border p-2 w-full rounded-lg">
            </div>

            <div>
                <label>Sân vận động</label>
                <input type="text" name="stadium" value="${match.stadium}" class="border p-2 w-full rounded-lg">
            </div>

            <div class="flex justify-end space-x-4">
                <a href="MatchServlet?action=list" class="bg-gray-300 px-4 py-2 rounded-lg hover:bg-gray-400">Hủy</a>
                <button type="submit" class="bg-red-600 text-white px-6 py-2 rounded-lg hover:bg-red-700">Lưu</button>
            </div>
        </form>
    </div>
</body>
</html>
