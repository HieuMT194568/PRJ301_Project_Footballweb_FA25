<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>${pageTitle}</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body {
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }
    </style>    
</head>
<body class="bg-neutral-100 min-h-screen flex flex-col">
    
    <header class="bg-red-700 text-white shadow-lg z-20">
        <div class="flex justify-between items-center h-16 px-6 md:px-8">

            <div class="flex items-center space-x-3">
                <a href="DashboardServlet" class="flex items-center space-x-2">
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


    <nav class="bg-white shadow-md border-b border-gray-200 sticky top-0 z-10">
        <div class="flex items-center space-x-8 h-12 px-6 md:px-8">

            <a href="TeamServlet?action=list" class="flex items-center text-gray-700 hover:text-red-600 font-medium transition-colors duration-200">
                <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"></path></svg>
                <span>Teams </span>
            </a>
            
            <a href="MatchServlet?action=list" class="flex items-center text-gray-700 hover:text-red-600 font-medium transition-colors duration-200">
                <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path></svg>
                <span>Matches</span>
            </a>

            <a href="articles" class="flex items-center text-gray-700 hover:text-red-600 font-medium transition-colors duration-200">
                 <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 20H5a2 2 0 01-2-2V6a2 2 0 012-2h10a2 2 0 012 2v1m2 13a2 2 0 01-2-2V7m2 13a2 2 0 002-2V9a2 2 0 00-2-2h-2m-4-3H9M7 16h6M7 12h6m-3-4h3"></path></svg>
                <span>News</span>
            </a>

            <c:if test="${sessionScope.user != null && sessionScope.user.role == 'ADMIN'}">
                <a href="AdminDashboardServlet" class="flex items-center text-gray-700 hover:text-red-600 font-medium transition-colors duration-200">
                    <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                              d="M3 3h18v18H3V3zm9 3v12m6-6H9"></path></svg>
                    <span>Admin Panel</span>
                </a>
            </c:if>
            
        </div>
    </nav>

    <main class="flex-1 p-6 md:p-8">
        <h2 class="text-3xl font-semibold text-gray-800 mb-6">${pageTitle}</h2>

        <div class="bg-white p-6 rounded-xl shadow-lg">
            <%-- Nội dung trang con (vd: dashboard.jsp) sẽ được tải vào đây --%>
            <jsp:include page="${contentPage}" />
        </div>

        <footer class="mt-8 text-center text-gray-500 text-sm">
            
        </footer>
    </main>

    
    <div class="px-6 md:px-8 mb-8">
        <div class="flex justify-between items-center mb-6">
            <h2 class="text-3xl font-semibold text-gray-800">Tin Tức Mới Nhất</h2>
            <a href="articles" class="text-red-600 hover:text-red-800 font-medium">
                Xem tất cả &rarr;
            </a>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
            
            <%-- Kiểm tra xem listA có rỗng hay không --%>
            <c:if test="${empty listA}">
                <p class="text-gray-600 col-span-4">Không có bài báo nào để hiển thị.</p>
            </c:if>

            <%-- Lặp qua danh sách 'listA' (phải được tải từ DashboardServlet) --%>
            <c:forEach items="${listA}" var="article">
                <div class="bg-white rounded-xl shadow p-4 hover:shadow-lg transition flex flex-col">
                    
                    <img src="${article.imageUrl}" alt="${article.title}" class="h-48 w-full object-cover rounded-md mb-3">
                    
                    <div class="text-sm text-gray-500 mb-2">
                        <strong class="text-red-700">${article.category}</strong> | 
                        <span>
                            <fmt:formatDate value="${article.createdAt}" pattern="dd/MM/yyyy" />
                        </span>
                    </div>
                    
                    <h3 class="text-lg font-semibold text-gray-900 leading-tight">${article.title}</h3>
                    
                    <p class="text-sm text-gray-600 mt-2 mb-3 flex-1">${article.description}</p>
                    
                    <a href="${article.link}" target="_blank" 
                       class="block bg-gray-800 text-white text-center mt-auto py-2 rounded-lg hover:bg-gray-900 transition font-medium">
                        Đọc thêm
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
    <div class="grid grid-cols-4 gap-6 px-6 pb-8">
        <c:forEach var="p" items="${productList}">
            <div class="bg-white rounded-xl shadow p-4 hover:shadow-lg transition">
                <img src="${p.imageUrl}" class="h-48 w-full object-cover rounded-md mb-3">
                <h3 class="text-lg font-semibold">${p.productName}</h3>
                <p class="text-gray-600">${p.category}</p>
                <p class="text-red-600 font-bold mt-2">${p.price} đ</p>
                <a href="CartServlet?action=add&id=${p.productID}" 
                   class="block bg-red-600 text-white text-center mt-3 py-2 rounded-lg hover:bg-red-700 transition">
                    🛒 Thêm vào giỏ
                </a>
            </div>
        </c:forEach>
    </div>
</body>
</html>