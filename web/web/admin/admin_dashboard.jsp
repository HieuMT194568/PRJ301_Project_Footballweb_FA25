    <%@page contentType="text/html" pageEncoding="UTF-8"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <!DOCTYPE html>
    <html>
    <head>
        <title>Admin Dashboard</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    </head>
    <body class="bg-gray-100 min-h-screen">




        <!-- Header -->
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
                            <a href="${pageContext.request.contextPath}/LogoutServlet" class="bg-white text-red-700 px-3 py-1 rounded-lg font-semibold hover:bg-gray-100">
                                Logout
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="login.jsp" class="bg-white text-red-700 px-3 py-1 rounded-lg font-semibold hover:bg-gray-100">
                                Login
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </header>

        
         <nav class="bg-white shadow-md border-b border-gray-200 sticky top-0 z-10">
        <div class="flex items-center space-x-8 h-12 px-6 md:px-8">
            <a href="${pageContext.request.contextPath}/TeamServlet?action=list" class="flex items-center text-gray-700 hover:text-red-600 font-medium transition">
                👥 <span class="ml-1">Teams</span>
            </a>

            <a href="${pageContext.request.contextPath}/MatchServlet?action=list" class="flex items-center text-gray-700 hover:text-red-600 font-medium transition">
                ⚽ <span class="ml-1">Matches</span>
            </a>

            <a href="${pageContext.request.contextPath}/articles" class="flex items-center text-gray-700 hover:text-red-600 font-medium transition">
                📰 <span class="ml-1">News</span>
            </a>

            <a href="${pageContext.request.contextPath}/shop" class="flex items-center text-gray-700 hover:text-red-600 font-medium transition">
                🛍️ <span class="ml-1">Shop</span>
            </a>

            <c:if test="${sessionScope.user != null && sessionScope.user.role == 'ADMIN'}">
                <a href="${pageContext.request.contextPath}/admin" class="flex items-center text-gray-700 hover:text-red-600 font-medium transition">
                    ⚙️ <span class="ml-1">Admin Panel</span>
                </a>
            </c:if>
        </div>
    </nav>
        <!-- Main Content -->
        <main class="p-8 space-y-10">

            <!-- Khu vực thao tác quản trị -->
            <section>
                <h2 class="text-2xl font-semibold text-gray-800 mb-4">⚙️ Quản lý nội dung</h2>

                <div class="grid grid-cols-1 sm:grid-cols-3 gap-6">
                    <!-- Thêm trận đấu -->
                    <a href="${pageContext.request.contextPath}/AdminMatchServlet" class="bg-blue-600 hover:bg-blue-700 text-white text-center py-4 rounded-xl shadow-lg transition">
                        ⚽️ Quản lý trận đấu
                    </a>

                    <!-- Thêm sản phẩm -->
                    <a href="${pageContext.request.contextPath}/ProductServlet?action=list" class="bg-green-600 hover:bg-green-700 text-white text-center py-4 rounded-xl shadow-lg transition">
                        🛍️ Quản lý sản phẩm
                    </a>

                    <!-- Thêm bài viết -->
                    <a href="${pageContext.request.contextPath}/AdminArticleServlet" class="bg-yellow-500 hover:bg-yellow-600 text-white text-center py-4 rounded-xl shadow-lg transition">
                        📰 Quản lý bài viết
                    </a>
                </div>
            </section>

            <!-- Thống kê tổng quan -->
            <section>
                <h2 class="text-3xl font-semibold text-gray-800 mb-6">📊 Thống kê tổng quan</h2>

                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6 mb-10">
                    <div class="bg-white p-6 rounded-xl shadow-md border-l-4 border-blue-500">
                        <h3 class="text-gray-500 text-sm uppercase font-semibold">Tổng số User</h3>
                        <p class="text-3xl font-bold text-gray-800 mt-2">${totalUsers}</p>
                    </div>

                    <div class="bg-white p-6 rounded-xl shadow-md border-l-4 border-green-500">
                        <h3 class="text-gray-500 text-sm uppercase font-semibold">Tổng đơn hàng tháng này</h3>
                        <p class="text-3xl font-bold text-gray-800 mt-2">${ordersThisMonth}</p>
                    </div>

                    <div class="bg-white p-6 rounded-xl shadow-md border-l-4 border-red-500">
                        <h3 class="text-gray-500 text-sm uppercase font-semibold">Tổng doanh thu</h3>
                        <p class="text-3xl font-bold text-gray-800 mt-2"><fmt:formatNumber value="${totalRevenue}" pattern="#,##0" /> ₫</p>
                    </div>

                    <div class="bg-white p-6 rounded-xl shadow-md border-l-4 border-yellow-500">
                        <h3 class="text-gray-500 text-sm uppercase font-semibold">Số lượng sản phẩm</h3>
                        <p class="text-3xl font-bold text-gray-800 mt-2">${totalProducts}</p>
                    </div>
                </div>
            </section>

           <!-- Danh sách đơn hàng -->
<section class="bg-white p-6 rounded-xl shadow-md">
    <h3 class="text-xl font-semibold mb-4 text-gray-700">🧾 Danh sách đơn hàng mới nhất</h3>

    <table class="min-w-full border border-gray-200 rounded-xl">
        <thead class="bg-gray-100">
            <tr>
                <th class="px-4 py-2 text-left">Mã đơn</th>
                <th class="px-4 py-2 text-left">Người đặt</th>
                <th class="px-4 py-2 text-left">Tổng tiền</th>
                <th class="px-4 py-2 text-left">Ngày đặt</th>
                <th class="px-4 py-2 text-left">Trạng thái</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="order" items="${orderList}">
                <tr class="border-t hover:bg-gray-50">
                    <td class="px-4 py-2">${order.orderID}</td>
                    <td class="px-4 py-2">${order.userName}</td>
                    <td class="px-4 py-2"><fmt:formatNumber value="${order.totalAmount}" pattern="#,##0"/> ₫</td>
                    <td class="px-4 py-2"><fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                    <td class="px-4 py-2">${order.status}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</section>