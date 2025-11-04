<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Danh sách sản phẩm</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 p-8">
    <div class="max-w-5xl mx-auto bg-white p-6 rounded-xl shadow-md">
        <div class="flex justify-between items-center mb-4">
            <h1 class="text-2xl font-bold text-red-600">🛍️ Quản lý sản phẩm</h1>
            <a href="${pageContext.request.contextPath}/ProductServlet?action=new"
               class="bg-green-600 text-white px-4 py-2 rounded-lg hover:bg-green-700 transition">
                ➕ Thêm mới
            </a>
        </div>

        <table class="w-full border border-gray-300 rounded-lg text-center">
            <thead class="bg-red-600 text-white">
                <tr>
                    <th>ID</th>
                    <th>Tên sản phẩm</th>
                    <th>Giá</th>
                    <th>Tồn kho</th>
                    <th>Danh mục</th>
                    <th>Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="p" items="${productList}">
                    <tr class="border-b hover:bg-gray-50">
                        <td>${p.productID}</td>
                        <td>${p.productName}</td>
                        <td>${p.price}</td>
                        <td>${p.stockQuantity}</td>
                        <td>${p.category}</td>
                        <td class="space-x-3">
                            <a href="${pageContext.request.contextPath}/ProductServlet?action=edit&id=${p.productID}"
                               class="text-blue-600 hover:underline">✏️</a>
                            <a href="${pageContext.request.contextPath}/ProductServlet?action=delete&id=${p.productID}"
                               class="text-red-600 hover:underline"
                               onclick="return confirm('Xóa sản phẩm này?');">🗑️</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <div class="text-center mt-6">
            <a href="${pageContext.request.contextPath}/admin/dashboard.jsp"
               class="text-gray-600 hover:underline">⬅ Quay lại Dashboard</a>
        </div>
    </div>
</body>
</html>
