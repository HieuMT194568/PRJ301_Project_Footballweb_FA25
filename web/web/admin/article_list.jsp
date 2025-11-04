<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý bài viết</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen p-8">

    <div class="max-w-6xl mx-auto bg-white rounded-2xl shadow-lg p-6">
        <div class="flex justify-between items-center mb-6">
            <h1 class="text-3xl font-bold text-red-700">📰 Quản lý bài viết</h1>
            <a href="AdminArticleServlet?action=new" 
               class="bg-green-600 text-white px-4 py-2 rounded-lg font-semibold hover:bg-green-700 transition">
                ➕ Thêm bài viết
            </a>
        </div>

        <table class="w-full border border-gray-300 rounded-lg text-left">
            <thead class="bg-red-600 text-white">
                <tr>
                    <th class="py-2 px-3">ID</th>
                    <th class="py-2 px-3">Tiêu đề</th>
                    <th class="py-2 px-3">Danh mục</th>
                    <th class="py-2 px-3">Ngày tạo</th>
                    <th class="py-2 px-3">Ảnh</th>
                    <th class="py-2 px-3">Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="a" items="${articleList}">
                    <tr class="border-b hover:bg-gray-50 transition">
                        <td class="py-2 px-3">${a.articleID}</td>
                        <td class="py-2 px-3 font-semibold text-gray-800">${a.title}</td>
                        <td class="py-2 px-3 text-gray-700">${a.category}</td>
                        <td class="py-2 px-3 text-gray-600">
                            <fmt:formatDate value="${a.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                        </td>
                        <td class="py-2 px-3">
                            <img src="${a.imageUrl}" alt="${a.title}" class="h-12 w-12 object-cover rounded-md border">
                        </td>
                        <td class="py-2 px-3 space-x-3">
                            <a href="AdminArticleServlet?action=edit&id=${a.articleID}" 
                               class="text-blue-600 hover:underline">✏️ Sửa</a>
                            <a href="AdminArticleServlet?action=delete&id=${a.articleID}" 
                               class="text-red-600 hover:underline"
                               onclick="return confirm('Xóa bài viết này?');">🗑️ Xóa</a>
                        </td>
                    </tr>
                </c:forEach>

                <c:if test="${empty articleList}">
                    <tr><td colspan="6" class="text-center py-4 text-gray-600">Không có bài viết nào.</td></tr>
                </c:if>
            </tbody>
        </table>

        <div class="mt-6 text-center">
            <a href="${pageContext.request.contextPath}/admin" class="text-gray-600 hover:underline">⬅ Quay lại Dashboard</a>
        </div>
    </div>

</body>
</html>
