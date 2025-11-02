<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>${match != null ? "Chỉnh sửa trận đấu" : "Thêm trận đấu mới"}</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 p-8">

<div class="max-w-3xl mx-auto bg-white p-6 rounded-xl shadow-md">
    <h1 class="text-2xl font-bold text-red-600 mb-6 text-center">
        ${match != null ? "✏️ Chỉnh sửa trận đấu" : "➕ Thêm trận đấu mới"}
    </h1>

    <form action="MatchServlet" method="post" class="space-y-4">
        <c:if test="${match != null}">
            <input type="hidden" name="action" value="update" />
            <input type="hidden" name="matchID" value="${match.matchID}" />
        </c:if>
        <c:if test="${match == null}">
            <input type="hidden" name="action" value="insert" />
        </c:if>

        <div>
            <label class="block font-semibold mb-1">Đội nhà:</label>
            <select name="homeTeamID" class="w-full border rounded p-2" required>
                <option value="">-- Chọn đội nhà --</option>
                <c:forEach var="t" items="${teams}">
                    <option value="${t.teamID}" 
                        ${match != null && match.homeTeamID == t.teamID ? "selected" : ""}>
                        ${t.teamName}
                    </option>
                </c:forEach>
            </select>
        </div>

        <div>
            <label class="block font-semibold mb-1">Đội khách:</label>
            <select name="awayTeamID" class="w-full border rounded p-2" required>
                <option value="">-- Chọn đội khách --</option>
                <c:forEach var="t" items="${teams}">
                    <option value="${t.teamID}" 
                        ${match != null && match.awayTeamID == t.teamID ? "selected" : ""}>
                        ${t.teamName}
                    </option>
                </c:forEach>
            </select>
        </div>

        <div class="grid grid-cols-2 gap-4">
            <div>
                <label class="block font-semibold mb-1">Tỉ số đội nhà:</label>
                <input type="number" name="homeScore" value="${match != null ? match.homeScore : 0}"
                       class="w-full border rounded p-2" required />
            </div>

            <div>
                <label class="block font-semibold mb-1">Tỉ số đội khách:</label>
                <input type="number" name="awayScore" value="${match != null ? match.awayScore : 0}"
                       class="w-full border rounded p-2" required />
            </div>
        </div>

        <div>
            <label class="block font-semibold mb-1">Ngày giờ thi đấu:</label>
            <input type="datetime-local" name="matchDate"
                   value="${match != null ? match.matchDate : ''}" 
                   class="w-full border rounded p-2" required />
        </div>

        <div>
            <label class="block font-semibold mb-1">Sân vận động:</label>
            <input type="text" name="stadium" value="${match != null ? match.stadium : ''}"
                   class="w-full border rounded p-2" required />
        </div>

        <div class="text-center">
            <button type="submit"
                    class="bg-red-600 text-white px-6 py-2 rounded-lg font-semibold hover:bg-red-700 transition">
                💾 Lưu
            </button>
            <a href="MatchServlet?action=list" 
               class="ml-4 text-gray-600 hover:underline">⬅ Quay lại</a>
        </div>
    </form>
</div>

</body>
</html>
