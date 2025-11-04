<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý đơn hàng</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 p-8">
<div class="max-w-6xl mx-auto bg-white p-6 rounded-xl shadow-md">
    <h1 class="text-2xl font-bold text-red-600 mb-4">📦 Danh sách đơn hàng</h1>
    <table class="w-full text-center border border-gray-300">
        <thead class="bg-red-600 text-white">
            <tr>
                <th>ID</th>
                <th>Người dùng</th>
                <th>Ngày đặt</th>
                <th>Tổng tiền</th>
                <th>Trạng thái</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="o" items="${orderList}">
                <tr class="border-b hover:bg-gray-50">
                    <td>${o.orderID}</td>
                    <td>${o.userID}</td>
                    <td>${o.orderDate}</td>
                    <td>${o.totalAmount} ₫</td>
                    <td>${o.status}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>
