package Controller;

import Dal.ProductDAO;
import Model.Product;
import Model.CartItem;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.*;

@WebServlet(name = "CartServlet", urlPatterns = {"/CartServlet"})
public class CartServlet extends HttpServlet {

    private ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) {
            action = "view";
        }

        HttpSession session = request.getSession();
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new HashMap<>();
        }

        switch (action) {
            case "add":
                int productId = Integer.parseInt(request.getParameter("id"));
                Product p = productDAO.getById(productId);
                if (p != null) {
                    CartItem item = cart.getOrDefault(productId, new CartItem(p, 0));
                    item.setQuantity(item.getQuantity() + 1);
                    cart.put(productId, item);
                }
                session.setAttribute("cart", cart);
                response.sendRedirect("CartServlet?action=view");
                break;

            case "remove":
                int removeId = Integer.parseInt(request.getParameter("id"));
                cart.remove(removeId);
                session.setAttribute("cart", cart);
                response.sendRedirect("CartServlet?action=view");
                break;

            case "clear":
                session.removeAttribute("cart");
                response.sendRedirect("CartServlet?action=view");
                break;

            case "view":
            default:
                request.setAttribute("cartItems", cart.values());
                double total = cart.values().stream().mapToDouble(CartItem::getTotalPrice).sum();
                request.setAttribute("total", total);
                RequestDispatcher rd = request.getRequestDispatcher("cart.jsp");
                rd.forward(request, response);
                break;
        }
    }
}
