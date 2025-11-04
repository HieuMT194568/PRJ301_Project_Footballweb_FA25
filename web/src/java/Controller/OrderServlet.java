package Controller;

import Dal.OrderDAO;
import Dal.OrderDetailDAO;
import Model.Order;
import Model.OrderDetail;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "OrderServlet", urlPatterns = {"/OrderServlet"})
public class OrderServlet extends HttpServlet {

    private OrderDAO orderDAO = new OrderDAO();
    private OrderDetailDAO orderDetailDAO = new OrderDetailDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "detail":
                showOrderDetail(request, response);
                break;
            case "update":
                 int orderID = Integer.parseInt(request.getParameter("id"));
                String status = request.getParameter("status");
                orderDAO.updateOrderStatus(orderID, status);
                response.sendRedirect("OrderServlet?action=list");
                break;
            case "list":
            default:
                listOrders(request, response);
                break;
        }
    }

    private void listOrders(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Order> list = orderDAO.getAllOrders();
        request.setAttribute("orders", list);
        request.getRequestDispatcher("admin/order_list.jsp").forward(request, response);
    }

    private void showOrderDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Order order = orderDAO.getOrderById(id);
        List<OrderDetail> details = orderDetailDAO.getOrderDetailsByOrderId(id);
        request.setAttribute("order", order);
        request.setAttribute("details", details);
        request.getRequestDispatcher("admin/order_detail.jsp").forward(request, response);  
    }
}
