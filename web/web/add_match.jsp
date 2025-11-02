<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm trận đấu</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 p-8">
    <div class="max-w-xl mx-auto bg-white p-8 rounded-xl shadow-md">
        <h1 class="text-2xl font-bold text-red-600 mb-6 text-center">⚽ Thêm Trận Đấu Mới</h1>

        <form action="MatchServlet" method="post" class="space-y-4">
            <div>
                <label class="block font-medium">Đội chủ nhà</label>
                <select name="homeTeamID" class="w-full border rounded-md p-2" required>
                    <c:forEach var="team" items="${teamList}">
                        <option value="${team.teamID}">${team.teamName}</option>
                    </c:forEach>
                </select>
            </div>

            <div>
                <label class="block font-medium">Đội khách</label>
                <select name="awayTeamID" class="w-full border rounded-md p-2" required>
                    <c:forEach var="team" items="${teamList}">
                        <option value="${team.teamID}">${team.teamName}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="grid grid-cols-2 gap-4">
                <div>
                    <label class="block font-medium">Bàn thắng đội nhà</label>
                    <input type="number" name="homeScore" class="w-full border rounded-md p-2" required>
                </div>

                <div>
                    <label class="block font-medium">Bàn thắng đội khách</label>
                    <input type="number" name="awayScore" class="w-full border rounded-md p-2" required>
                </div>
            </div>

            <div>
                <label class="block font-medium">Ngày thi đấu</label>
                <input type="date" name="matchDate" class="w-full border rounded-md p-2" required>
            </div>

            <div>
                <label class="block font-medium">Địa điểm</label>
                <input type="text" name="stadium" class="w-full border rounded-md p-2" required>
            </div>

            <button type="submit"
                    class="bg-red-600 hover:bg-red-700 text-white font-semibold py-2 px-4 rounded-lg w-full">
                ➕ Thêm trận đấu
            </button>
        </form>
    </div>
</body>
</html>
