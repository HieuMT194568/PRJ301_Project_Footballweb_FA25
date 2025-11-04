<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>
        <c:choose>
            <c:when test="${not empty article}">Chỉnh sửa bài viết</c:when>
            <c:otherwise>Thêm bài viết mới</c:otherwise>
        </c:choose>
    </title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen flex justify-center py-10">

    <div class="bg-white shadow-lg rounded-2xl p-8 w-full max-w-2xl">
        <h2 class="text-2xl font-semibold text-red-700 mb-6">
            <c:choose>
                <c:when test="${not empty article}">✏️ Chỉnh sửa bài viết</c:when>
                <c:otherwise>➕ Thêm bài viết mới</c:otherwise>
            </c:choose>
        </h2>

        <form action="AdminArticleServlet" method="post" class="space-y-6">
            <c:if test="${not empty article}">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="articleID" value="${article.articleID}">
            </c:if>
            <c:if test="${empty article}">
                <input type="hidden" name="action" value="add">
            </c:if>

            <div>
                <label class="block text-gray-700 font-medium mb-1">Tiêu đề</label>
                <input type="text" name="title" value="${article.title}" required
                       class="w-full border border-gray-300 rounded-lg px-4 py-2 focus:ring-2 focus:ring-red-500">
            </div>

            <div>
                <label class="block text-gray-700 font-medium mb-1">Mô tả</label>
                <textarea name="description" rows="4" required
                          class="w-full border border-gray-300 rounded-lg px-4 py-2 focus:ring-2 focus:ring-red-500">${article.description}</textarea>
            </div>

            <div>
                <label class="block text-gray-700 font-medium mb-1">Đường dẫn ảnh</label>
                <input type="text" name="imageUrl" value="${article.imageUrl}" required
                       class="w-full border border-gray-300 rounded-lg px-4 py-2 focus:ring-2 focus:ring-red-500">
            </div>

            <div>
                <label class="block text-gray-700 font-medium mb-1">Danh mục</label>
                <input type="text" name="category" value="${article.category}" required
                       class="w-full border border-gray-300 rounded-lg px-4 py-2 focus:ring-2 focus:ring-red-500">
            </div>

            <div>
                <label class="block text-gray-700 font-medium mb-1">Liên kết bài viết</label>
                <input type="text" name="link" value="${article.link}" required
                       class="w-full border border-gray-300 rounded-lg px-4 py-2 focus:ring-2 focus:ring-red-500">
            </div>

            <div class="flex justify-end space-x-4">
                <a href="AdminArticleServlet?action=list"
                   class="bg-gray-300 hover:bg-gray-400 text-gray-800 font-semibold px-4 py-2 rounded-lg">
                    Hủy
                </a>
                <button type="submit" 
                        class="bg-red-600 hover:bg-red-700 text-white font-semibold px-6 py-2 rounded-lg">
                    💾 Lưu bài viết
                </button>
            </div>
        </form>
    </div>

</body>
</html>
