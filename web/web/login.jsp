<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng nhập</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 flex justify-center items-center h-screen">
    <form action="LoginServlet" method="post" 
          class="bg-white p-8 rounded-lg shadow-lg w-96">
        <h1 class="text-2xl font-bold text-center text-red-600 mb-6">🔐 Đăng nhập</h1>

        <c:if test="${not empty error}">
            <div class="text-red-500 mb-4 text-center">${error}</div>
        </c:if>

        <label class="block mb-2 font-semibold">Tên đăng nhập</label>
        <input type="text" name="username" required
               class="w-full border p-2 rounded mb-4 focus:outline-none focus:ring-2 focus:ring-red-500">

        <label class="block mb-2 font-semibold">Mật khẩu</label>
        <input type="password" name="password" required
               class="w-full border p-2 rounded mb-6 focus:outline-none focus:ring-2 focus:ring-red-500">

        <button type="submit"
                class="w-full bg-red-600 text-white py-2 rounded hover:bg-red-700 transition">
            Đăng nhập
        </button>

        <p class="text-sm text-center text-gray-500 mt-4">
            Chưa có tài khoản? <a href="register.jsp" class="text-red-600 hover:underline">Đăng ký</a>
        </p>
    </form>
</body>
</html>
