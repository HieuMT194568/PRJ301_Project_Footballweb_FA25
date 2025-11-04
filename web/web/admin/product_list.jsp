<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý sản phẩm</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 py-10">

    <div class="max-w-6xl mx-auto bg-white p-8 rounded-2xl shadow-lg">
        <!-- Header -->
        <div class="flex justify-between items-center mb-6 border-b pb-3">
            <h1 class="text-3xl font-bold text-red-700 flex items-center space-x-2">
                <span>🛍️</span>
                <span>Quản lý sản phẩm</span>
            </h1>
            <a href="${pageContext.request.contextPath}/ProductServlet?action=new"
               class="bg-green-600 hover:bg-green-700 text-white px-5 py-2 rounded-lg font-semibold shadow">
                ➕ Thêm sản phẩm
            </a>
        </div>

        <!-- Table -->
        <c:choose>
            <c:when test="${empty productList}">
                <p class="text-gray-600 text-center py-8 text-lg">Không có sản phẩm nào trong danh sách.</p>
            </c:when>
            <c:otherwise>
                <div class="overflow-x-auto">
                    <table class="w-full border border-gray-300 rounded-lg overflow-hidden text-center">
                        <thead class="bg-red-600 text-white">
                            <tr>
                                <th class="py-3 px-2">ID</th>
                                <th class="py-3 px-2">Tên sản phẩm</th>
                                <th class="py-3 px-2">Giá</th>
                                <th class="py-3 px-2">Tồn kho</th>
                                <th class="py-3 px-2">Danh mục</th>
                                <th class="py-3 px-2">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="p" items="${productList}">
                                <tr class="border-b hover:bg-gray-50 transition">
                                    <td class="py-2">${p.productID}</td>
                                    <td class="py-2 font-medium text-gray-800">${p.productName}</td>
                                    <td class="py-2 text-red-600 font-semibold">${p.price} đ</td>
                                    <td class="py-2">${p.stockQuantity}</td>
                                    <td class="py-2">${p.category}</td>
                                    <td class="py-2 space-x-3">
                                        <a href="${pageContext.request.contextPath}/ProductServlet?action=edit&id=${p.productID}"
                                           class="text-blue-600 hover:text-blue-800">✏️ Sửa</a>
                                        <a href="${pageContext.request.contextPath}/ProductServlet?action=delete&id=${p.productID}"
                                           class="text-red-600 hover:text-red-800"
                                           onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này?');">
                                           🗑️ Xóa
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>

        <!-- Footer -->
        <div class="text-center mt-6">
            <a href="${pageContext.request.contextPath}/admin/admin_dashboard.jsp"
               class="text-gray-600 hover:text-red-700 font-medium transition">
               ⬅ Quay lại Dashboard
            </a>
        </div>
    </div>

</body>
</html>
