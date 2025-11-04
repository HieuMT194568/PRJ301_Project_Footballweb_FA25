<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Bài Viết - Admin</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen">

    <!-- Header -->
    <header class="bg-red-700 text-white shadow-lg">
        <div class="flex justify-between items-center h-16 px-6 md:px-8">
            <div class="flex items-center space-x-3">
                <a href="admin_dashboard.jsp" class="flex items-center space-x-2">
                    <img src="../assets/images/bayern-logo.png" class="h-10 w-10 rounded-full shadow-md bg-white p-1">
                    <h1 class="text-2xl font-bold truncate">FC Bayern Munich</h1>
                </a>
            </div>

            <div class="flex items-center space-x-4">
                <a href="admin_dashboard.jsp" class="bg-white text-red-700 px-3 py-1 rounded-lg font-semibold hover:bg-gray-100">
                    ⬅ Dashboard
                </a>

                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <span class="hidden md:block font-medium">${sessionScope.user.fullName}</span>
                        <a href="../LogoutServlet" class="bg-white text-red-700 px-3 py-1 rounded-lg font-semibold hover:bg-gray-100">
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

    <!-- Main -->
    <main class="p-8 space-y-12">

        <!-- Form thêm bài viết -->
        <section class="bg-white shadow-lg rounded-2xl p-8 max-w-3xl mx-auto">
            <h2 class="text-2xl font-semibold text-gray-800 mb-6">📰 Thêm Bài Viết Mới</h2>

            <form action="../articles?action=add" method="post" enctype="multipart/form-data" class="space-y-6">

                <!-- Tiêu đề -->
                <div>
                    <label for="title" class="block text-sm font-medium text-gray-700 mb-1">Tiêu đề</label>
                    <input type="text" id="title" name="title" required
                           class="w-full border border-gray-300 rounded-lg px-4 py-2 focus:ring-2 focus:ring-red-500 focus:border-red-500">
                </div>

                <!-- Mô tả -->
                <div>
                    <label for="description" class="block text-sm font-medium text-gray-700 mb-1">Mô tả ngắn</label>
                    <textarea id="description" name="description" rows="3" required
                              class="w-full border border-gray-300 rounded-lg px-4 py-2 focus:ring-2 focus:ring-red-500 focus:border-red-500"></textarea>
                </div>

                <!-- Ảnh -->
                <div>
                    <label for="image" class="block text-sm font-medium text-gray-700 mb-1">Ảnh bài viết (URL hoặc upload)</label>
                    <input type="text" id="image" name="imageUrl"
                           placeholder="https://example.com/image.jpg"
                           class="w-full border border-gray-300 rounded-lg px-4 py-2 focus:ring-2 focus:ring-red-500 focus:border-red-500">
                </div>

                <!-- Danh mục -->
                <div>
                    <label for="category" class="block text-sm font-medium text-gray-700 mb-1">Danh mục</label>
                    <input type="text" id="category" name="category" placeholder="Tin CLB, Cầu thủ, Giải đấu..."
                           class="w-full border border-gray-300 rounded-lg px-4 py-2 focus:ring-2 focus:ring-red-500 focus:border-red-500">
                </div>

                <!-- Link -->
                <div>
                    <label for="link" class="block text-sm font-medium text-gray-700 mb-1">Link gốc (nếu có)</label>
                    <input type="text" id="link" name="link"
                           class="w-full border border-gray-300 rounded-lg px-4 py-2 focus:ring-2 focus:ring-red-500 focus:border-red-500">
                </div>

                <div class="flex justify-end space-x-4">
                    <button type="reset" class="bg-gray-300 hover:bg-gray-400 text-gray-800 font-semibold px-4 py-2 rounded-lg">Hủy</button>
                    <button type="submit" class="bg-red-600 hover:bg-red-700 text-white font-semibold px-6 py-2 rounded-lg">➕ Thêm</button>
                </div>
            </form>
        </section>

        <!-- Danh sách bài viết -->
        <section class="bg-white shadow-lg rounded-2xl p-8">
            <h2 class="text-2xl font-semibold text-gray-800 mb-6">📋 Danh Sách Bài Viết</h2>

            <div class="overflow-x-auto">
                <table class="min-w-full border border-gray-200 text-sm text-left">
                    <thead class="bg-gray-100 text-gray-700">
                        <tr>
                            <th class="p-3 border">#</th>
                            <th class="p-3 border">Tiêu đề</th>
                            <th class="p-3 border">Danh mục</th>
                            <th class="p-3 border">Ngày tạo</th>
                            <th class="p-3 border">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="a" items="${articles}">
                            <tr class="hover:bg-gray-50">
                                <td class="p-3 border">${a.articleID}</td>
                                <td class="p-3 border font-semibold text-red-700">${a.title}</td>
                                <td class="p-3 border">${a.category}</td>
                                <td class="p-3 border">${a.createdAt}</td>
                                <td class="p-3 border flex space-x-2">
                                    <a href="../articles?action=edit&id=${a.articleID}" 
                                       class="bg-blue-500 text-white px-3 py-1 rounded hover:bg-blue-600">✏️ Sửa</a>
                                    <a href="../articles?action=delete&id=${a.articleID}" 
                                       class="bg-red-500 text-white px-3 py-1 rounded hover:bg-red-600"
                                       onclick="return confirm('Bạn có chắc muốn xóa bài viết này?')">🗑 Xóa</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <c:if test="${empty articles}">
                    <p class="text-gray-500 text-center py-4">Chưa có bài viết nào.</p>
                </c:if>
            </div>
        </section>
    </main>

</body>
</html>
