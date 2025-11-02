<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng nhập - Bayern Munich website</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        /* Tùy chỉnh nhỏ cho focus input */
        .form-checkbox:checked {
            background-color: #DC2626; /* red-600 */
            border-color: #DC2626;
        }
    </style>
</head>
<body class="bg-gradient-to-r from-red-700 to-red-500 flex justify-center items-center h-screen p-4">
    
    <div class="bg-white p-8 rounded-2xl shadow-xl w-full max-w-md">
        
        <div class="text-center mb-6">
            <span class="text-6xl">⚽</span>
            <h1 class="text-2xl font-bold text-gray-800 mt-2">Bayern Munich</h1>
            <p class="text-gray-500">Chào mừng trở lại!</p>
        </div>

        <c:if test="${not empty error}">
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded-lg relative mb-4" role="alert">
                <span class="block sm:inline">${error}</span>
            </div>
        </c:if>

        <form action="AuthServlet?action=login" method="post" class="space-y-5">
            
            <div class="relative">
                <span class="absolute inset-y-0 left-0 flex items-center pl-3">
                    <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path></svg>
                </span>
                <input type="text" name="username" placeholder="Tên đăng nhập" required 
                       class="w-full border border-gray-300 rounded-lg p-3 pl-10 focus:outline-none focus:ring-2 focus:ring-red-500 focus:border-transparent transition"/>
            </div>

            <div class="relative">
                <span class="absolute inset-y-0 left-0 flex items-center pl-3">
                    <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"></path></svg>
                </span>
                <input type="password" name="password" placeholder="Mật khẩu" required 
                       class="w-full border border-gray-300 rounded-lg p-3 pl-10 focus:outline-none focus:ring-2 focus:ring-red-500 focus:border-transparent transition"/>
            </div>
            
            <div class="flex justify-between items-center text-sm">
                <label class="flex items-center text-gray-600 cursor-pointer">
                    <input type="checkbox" name="remember" class="form-checkbox h-4 w-4 text-red-600 border-gray-300 rounded focus:ring-red-500">
                    <span class="ml-2">Ghi nhớ tôi</span>
                </label>
                <a href="#" class="text-red-600 hover:underline">Quên mật khẩu?</a>
            </div>

            <button type="submit" 
                    class="w-full bg-red-600 text-white py-3 rounded-lg font-semibold hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500 transition-all duration-200 shadow-md hover:shadow-lg">
                Đăng nhập
            </button>
        </form>

        <p class="text-sm text-gray-600 text-center mt-6">
            Chưa có tài khoản? 
            <a href="register.jsp" class="text-red-600 font-semibold hover:underline">Đăng ký ngay</a>
        </p>
    </div>
</body>
</html>