<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Product</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen flex items-center justify-center p-6">

    <div class="bg-white p-8 rounded-xl shadow-lg w-full max-w-2xl">
        <h1 class="text-2xl font-bold text-red-700 mb-6 text-center">🛠️ Edit Product</h1>

        <form action="ProductServlet?action=update" method="post" class="space-y-5">
            
            <input type="hidden" name="productID" value="${product.productID}"/>

            <div>
                <label class="block font-medium text-gray-700 mb-1">Product Name</label>
                <input type="text" name="productName" value="${product.productName}"
                       required class="w-full border rounded-lg px-3 py-2 focus:ring-2 focus:ring-red-500 outline-none">
            </div>

            <div>
                <label class="block font-medium text-gray-700 mb-1">Category</label>
                <input type="text" name="category" value="${product.category}"
                       required class="w-full border rounded-lg px-3 py-2 focus:ring-2 focus:ring-red-500 outline-none">
            </div>

            <div>
                <label class="block font-medium text-gray-700 mb-1">Price</label>
                <input type="number" name="price" step="0.01" value="${product.price}"
                       required class="w-full border rounded-lg px-3 py-2 focus:ring-2 focus:ring-red-500 outline-none">
            </div>

            <div>
                <label class="block font-medium text-gray-700 mb-1">Stock Quantity</label>
                <input type="number" name="stockQuantity" value="${product.stockQuantity}"
                       required class="w-full border rounded-lg px-3 py-2 focus:ring-2 focus:ring-red-500 outline-none">
            </div>

            <div>
                <label class="block font-medium text-gray-700 mb-1">Image URL</label>
                <input type="text" name="imageUrl" value="${product.imageUrl}"
                       class="w-full border rounded-lg px-3 py-2 focus:ring-2 focus:ring-red-500 outline-none">
            </div>

            <div class="flex justify-between items-center mt-6">
                <a href="ProductServlet?action=list"
                   class="text-gray-600 hover:text-gray-800 font-medium">← Back to List</a>

                <button type="submit"
                        class="bg-red-600 hover:bg-red-700 text-white font-semibold px-6 py-2 rounded-lg transition">
                    💾 Save Changes
                </button>
            </div>
        </form>
    </div>

</body>
</html>
 