<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   
<%-- XÓA DÒNG <%@ include file="layout.jsp" %> KHỎI ĐÂY --%>
<!DOCTYPE html>
<html>
    <head>
        <title>Shop - FC Bayern Portal</title>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
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
    <body class="bg-gray-100">
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


        <main class="max-w-6xl mx-auto py-10 px-6">
            <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-8">
                <c:forEach var="p" items="${productList}">
                    <div class="bg-white rounded-xl shadow hover:shadow-lg transform hover:-translate-y-1 transition p-4">
                        <img src="assets/${p.imageUrl}" alt="${p.productName}" class="h-48 w-full object-cover rounded-md mb-4">
                        <h2 class="font-bold text-lg text-gray-800">${p.productName}</h2>
                        <p class="text-gray-500 text-sm mb-2">${p.category}</p>
                        <p class="text-red-600 font-semibold text-lg">
                            <fmt:formatNumber value="${p.price}" pattern="#,##0" /> ₫
                        </p>
                        <a href="CartServlet?action=add&id=${p.productID}"
                           class="block text-center mt-4 bg-red-600 text-white py-2 rounded-lg hover:bg-red-700 transition">
                            🛒 Thêm vào giỏ
                        </a>
                    </div>
                </c:forEach>
            </div>
        </main>

        <footer class="text-center py-4 text-gray-600 border-t">
            © 2025 Bayern Munich. All rights reserved.
        </footer>
    </body>
</html>