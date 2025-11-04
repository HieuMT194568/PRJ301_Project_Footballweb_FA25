<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   
<!DOCTYPE html>
<html>
    <head>
        <title>Giỏ hàng</title>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body class="bg-gray-100 p-8">

        <div class="max-w-4xl mx-auto bg-white p-6 rounded-xl shadow-md">
            <h1 class="text-2xl font-bold text-red-600 mb-4">🛒 Giỏ hàng của bạn</h1>

            <c:if test="${empty cartItems}">
                <p>Chưa có sản phẩm nào trong giỏ.</p>
            </c:if>

            <c:if test="${not empty cartItems}">
                <table class="w-full border border-gray-300 rounded-lg text-center">
                    <thead class="bg-red-600 text-white">
                        <tr>
                            <th>Sản phẩm</th>
                            <th>Giá</th>
                            <th>Số lượng</th>
                            <th>Tổng</th>
                            <th>Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${cartItems}">
                            <tr class="border-b hover:bg-gray-50">
                                <td>${item.product.productName}</td>
                                <td class="whitespace-nowrap">
                                    <fmt:formatNumber value="${item.product.price}" pattern="#,##0" /> ₫
                                </td>
                                <td>${item.quantity}</td>
                                <td class="whitespace-nowrap">
                                    <fmt:formatNumber value="${item.totalPrice}" pattern="#,##0" /> ₫
                                </td>
                                <td>
                                    <a href="CartServlet?action=remove&id=${item.product.productID}" class="text-red-600">🗑️ Xóa</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <div class="flex justify-between mt-6">
                    <h3 class="text-xl font-bold">Tổng cộng: <fmt:formatNumber value="${total}" pattern="#,##0" /> ₫</h3>
                    <form action="CheckoutServlet" method="post">
                        <button type="submit" class="bg-green-600 text-white px-4 py-2 rounded-lg">💳 Thanh toán</button>
                    </form>
                </div>
            </c:if>
        </div>

    </body>
</html>
