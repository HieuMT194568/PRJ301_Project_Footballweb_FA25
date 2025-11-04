<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="layout.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Shop - FC Bayern Portal</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">
<header class="bg-red-600 text-white py-4 text-center text-2xl font-bold shadow-lg">
    🛍️ FC BAYERN SHOP
</header>

<main class="max-w-6xl mx-auto py-10 px-6">
    <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-8">
        <c:forEach var="p" items="${productList}">
            <div class="bg-white rounded-xl shadow hover:shadow-lg transform hover:-translate-y-1 transition p-4">
                <img src="${p.imageUrl}" alt="${p.productName}" class="h-48 w-full object-cover rounded-md mb-4">
                <h2 class="font-bold text-lg text-gray-800">${p.productName}</h2>
                <p class="text-gray-500 text-sm mb-2">${p.category}</p>
                <p class="text-red-600 font-semibold text-lg">${p.price} ₫</p>
                <a href="CartServlet?action=add&id=${p.productID}"
                   class="block text-center mt-4 bg-red-600 text-white py-2 rounded-lg hover:bg-red-700 transition">
                   🛒 Thêm vào giỏ
                </a>
            </div>
        </c:forEach>
    </div>
</main>

<footer class="text-center py-4 text-gray-600 border-t">
    © 2025 Bayern Munich. All rights reserved.
</footer>
</body>
</html>
