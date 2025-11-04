<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thêm/Sửa Sản phẩm</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 py-10">

<div class="max-w-3xl mx-auto bg-white p-8 rounded-2xl shadow-lg">
    <h1 class="text-2xl font-bold text-red-700 mb-6">
        <c:choose>
            <c:when test="${product != null}">✏️ Cập nhật sản phẩm</c:when>
            <c:otherwise>➕ Thêm sản phẩm mới</c:otherwise>
        </c:choose>
    </h1>

    <form action="${pageContext.request.contextPath}/ProductServlet" method="post" class="space-y-5">
        <c:if test="${product != null}">
            <input type="hidden" name="productID" value="${product.productID}">
            <input type="hidden" name="action" value="update">
        </c:if>
        <c:if test="${product == null}">
            <input type="hidden" name="action" value="insert">
        </c:if>

        <div>
            <label class="block mb-1 font-semibold text-gray-700">Tên sản phẩm</label>
            <input type="text" name="productName" value="${product.productName}" required
                   class="w-full border rounded-lg px-4 py-2 focus:ring-2 focus:ring-red-500">
        </div>

        <div>
            <label class="block mb-1 font-semibold text-gray-700">Mô tả</label>
            <textarea name="description" rows="3" required
                      class="w-full border rounded-lg px-4 py-2 focus:ring-2 focus:ring-red-500">${product.description}</textarea>
        </div>

        <div class="grid grid-cols-2 gap-4">
            <div>
                <label class="block mb-1 font-semibold text-gray-700">Giá</label>
                <input type="number" step="0.01" name="price" value="${product.price}" required
                       class="w-full border rounded-lg px-4 py-2 focus:ring-2 focus:ring-red-500">
            </div>
            <div>
                <label class="block mb-1 font-semibold text-gray-700">Tồn kho</label>
                <input type="number" name="stockQuantity" value="${product.stockQuantity}" required
                       class="w-full border rounded-lg px-4 py-2 focus:ring-2 focus:ring-red-500">
            </div>
        </div>

        <div>
            <label class="block mb-1 font-semibold text-gray-700">Ảnh (URL)</label>
            <input type="text" name="imageUrl" value="${product.imageUrl}"
                   class="w-full border rounded-lg px-4 py-2 focus:ring-2 focus:ring-red-500">
        </div>

        <div>
            <label class="block mb-1 font-semibold text-gray-700">Danh mục</label>
            <input type="text" name="category" value="${product.category}"
                   class="w-full border rounded-lg px-4 py-2 focus:ring-2 focus:ring-red-500">
        </div>

        <div class="flex justify-end space-x-4 mt-6">
            <a href="${pageContext.request.contextPath}/ProductServlet?action=list"
               class="bg-gray-300 px-5 py-2 rounded-lg hover:bg-gray-400">Hủy</a>
            <button type="submit" class="bg-red-600 text-white px-5 py-2 rounded-lg hover:bg-red-700 font-semibold">
                Lưu lại
            </button>
        </div>
    </form>
</div>

</body>
</html>
