<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chi tiết đơn hàng</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 p-6">

<div class="max-w-4xl mx-auto bg-white p-6 rounded-xl shadow-lg">
    <h1 class="text-2xl font-bold text-red-600 mb-4">📄 Chi tiết đơn hàng #${order.orderID}</h1>

    <p><b>User ID:</b> ${order.userID}</p>
    <p><b>Ngày đặt:</b> ${order.orderDate}</p>
    <p><b>Trạng thái:</b> ${order.status}</p>
    <hr class="my-4">

    <table class="w-full border border-gray-300 text-center">
        <thead class="bg-red-600 text-white">
            <tr>
                <th>Sản phẩm</th>
                <th>Giá</th>
                <th>Số lượng</th>
                <th>Tổng</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="d" items="${details}">
                <tr class="border-b hover:bg-gray-50">
                    <td>${d.product.productName}</td>
                    <td>${d.unitPrice}</td>
                    <td>${d.quantity}</td>
                    <td>${d.quantity * d.unitPrice}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <div class="flex justify-between mt-6">
        <h3 class="text-xl font-bold">Tổng cộng: ${order.totalAmount}</h3>
        <a href="OrderServlet?action=list" class="bg-gray-600 text-white px-4 py-2 rounded-lg">⬅️ Quay lại</a>
    </div>
</div>

</body>
</html>
