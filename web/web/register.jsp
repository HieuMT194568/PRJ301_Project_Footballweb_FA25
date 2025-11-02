<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng ký - Bayern Portal</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-r from-red-700 to-red-500 flex justify-center items-center h-screen">
    <div class="bg-white p-8 rounded-2xl shadow-lg w-96">
        <h1 class="text-2xl font-bold text-center text-red-600 mb-6">Đăng ký tài khoản</h1>

        <form action="AuthServlet?action=register" method="post" class="space-y-4">
            <input type="text" name="username" placeholder="Tên đăng nhập" required class="w-full border rounded-lg p-3"/>
            <input type="text" name="fullname" placeholder="Họ và tên" required class="w-full border rounded-lg p-3"/>
            <input type="email" name="email" placeholder="Email" required class="w-full border rounded-lg p-3"/>
            <input type="password" name="password" placeholder="Mật khẩu" required class="w-full border rounded-lg p-3"/>
            
            <button type="submit" class="w-full bg-red-600 text-white py-2 rounded-lg hover:bg-red-700 transition">
                Tạo tài khoản
            </button>
        </form>

        <p class="text-sm text-gray-600 text-center mt-4">
            Đã có tài khoản? 
            <a href="login.jsp" class="text-red-600 hover:underline">Đăng nhập</a>
        </p>
    </div>
</body>
</html>