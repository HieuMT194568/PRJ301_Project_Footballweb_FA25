<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thanh toán - FC Bayern Shop</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">
<header class="bg-red-600 text-white text-center py-4 text-2xl font-bold shadow-md">
    💳 Thanh toán đơn hàng
</header>

<main class="max-w-xl mx-auto bg-white mt-8 p-8 rounded-xl shadow-md">
    <form action="OrderServlet" method="post" class="space-y-4">
        <input type="text" name="name" placeholder="Họ và tên" required class="w-full border p-2 rounded">
        <input type="email" name="email" placeholder="Email" required class="w-full border p-2 rounded">
        <input type="text" name="address" placeholder="Địa chỉ giao hàng" required class="w-full border p-2 rounded">
        <input type="text" name="phone" placeholder="Số điện thoại" required class="w-full border p-2 rounded">

        <div class="mt-4">
            <button type="submit" class="w-full bg-green-600 text-white py-2 rounded-lg hover:bg-green-700">
                ✅ Xác nhận thanh toán
            </button>
        </div>
    </form>
</main>

<footer class="text-center py-4 text-gray-600 border-t mt-8">
    © 2025 Bayern Portal. All rights reserved.
</footer>
</body>
</html>
