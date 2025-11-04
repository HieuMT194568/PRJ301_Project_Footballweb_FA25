<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thêm / Sửa sản phẩm</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 p-8">
    <div class="max-w-lg mx-auto bg-white p-6 rounded-xl shadow-md">
        <h1 class="text-2xl font-bold text-center text-red-600 mb-6">
            🛒 ${product != null ? "Chỉnh sửa sản phẩm" : "Thêm sản phẩm mới"}
        </h1>

        <form action="${pageContext.request.contextPath}/ProductServlet" method="post" class="space-y-4">
            <input type="hidden" name="action" value="${product != null ? 'update' : 'insert'}" />
            <c:if test="${product != null}">
                <input type="hidden" name="id" value="${product.productID}" />
            </c:if>

            <div>
                <label class="block font-semibold mb-1">Tên sản phẩm</label>
                <input type="text" name="productName" value="${product.productName}"
                       class="w-full border px-3 py-2 rounded-lg" required />
            </div>

            <div>
                <label class="block font-semibold mb-1">Mô tả</label>
                <textarea name="description" class="w-full border px-3 py-2 rounded-lg" rows="3">${product.description}</textarea>
            </div>

            <div>
                <label class="block font-semibold mb-1">Giá (VNĐ)</label>
                <input type="number" step="0.01" name="price" value="${product.price}"
                       class="w-full border px-3 py-2 rounded-lg" required />
            </div>

            <div>
                <label class="block font-semibold mb-1">Số lượng tồn</label>
                <input type="number" name="stockQuantity" value="${product.stockQuantity}"
                       class="w-full border px-3 py-2 rounded-lg" required />
            </div>

            <div>
                <label class="block font-semibold mb-1">Danh mục</label>
                <input type="text" name="category" value="${product.category}"
                       class="w-full border px-3 py-2 rounded-lg" />
            </div>

            <div>
                <label class="block font-semibold mb-1">Ảnh sản phẩm (URL)</label>
                <input type="text" name="imageUrl" value="${product.imageUrl}"
                       class="w-full border px-3 py-2 rounded-lg" />
            </div>

            <div class="flex justify-center space-x-4 mt-6">
                <button type="submit"
                        class="bg-red-600 text-white px-6 py-2 rounded-lg hover:bg-red-700 transition">
                    💾 Lưu
                </button>
                <a href="${pageContext.request.contextPath}/ProductServlet?action=list"
                   class="bg-gray-400 text-white px-6 py-2 rounded-lg hover:bg-gray-500 transition">
                    ↩ Hủy
                </a>
            </div>
        </form>
    </div>
</body>
</html>
