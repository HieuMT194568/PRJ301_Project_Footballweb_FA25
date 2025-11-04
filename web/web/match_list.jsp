<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>⚽ Danh sách trận đấu</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>


<body>
    
 <header class="bg-red-700 text-white shadow-lg z-20">
        <div class="flex justify-between items-center h-16 px-6 md:px-8">
            <div class="flex items-center space-x-3">
                <a href="articles" class="flex items-center space-x-2">
                    <img src="assets/images/bayern-logo.png" class="h-10 w-10 rounded-full shadow-md bg-white p-1" alt="logo">
                    <h1 class="text-2xl font-bold truncate">FC Bayern Munich</h1>
                </a>
            </div>

            <div class="flex items-center space-x-4">
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <span class="hidden md:block font-medium">Welcome, ${sessionScope.user.fullName}!</span>
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
    <div class="max-w-6xl mx-auto bg-white p-6 rounded-xl shadow-md">
        <div class="flex justify-between items-center mb-4">
            <h1 class="text-2xl font-bold text-red-600">⚽ Danh sách trận đấu</h1>
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
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <div class="text-center mt-6">
            <a href="../" class="text-gray-600 hover:underline">⬅ Quay lại</a>
        </div>
    </div>
</body>
</html>
