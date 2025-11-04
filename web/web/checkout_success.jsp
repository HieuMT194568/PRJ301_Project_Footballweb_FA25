<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thanh toán thành công</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-green-50 flex items-center justify-center min-h-screen">
    <div class="bg-white p-8 rounded-xl shadow-lg text-center">
        <h1 class="text-3xl font-bold text-green-600 mb-4">✅ Thanh toán thành công!</h1>
        <p>${message}</p>
        <a href="ProductServlet?action=list" class="mt-6 inline-block bg-red-600 text-white px-4 py-2 rounded-lg">🛍️ Tiếp tục mua hàng</a>
    </div>
</body>
</html>
