package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.OrderDAO;
import model.Order;
import model.OrderItem;
import model.User;

@WebServlet("/orderDetail")
public class OrderDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private OrderDAO orderDAO;

    public void init() {
        orderDAO = new OrderDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String idStr = request.getParameter("id");
        if (idStr != null) {
            int orderId = Integer.parseInt(idStr);
            
            Order order = orderDAO.getOrderById(orderId);
            
            if (order != null && order.getUserId() == user.getId()) {
                List<OrderItem> orderItems = orderDAO.getOrderItemsByOrderId(orderId);
                
                request.setAttribute("order", order);
                request.setAttribute("orderItems", orderItems);
                
                request.getRequestDispatcher("/order-detail.jsp").forward(request, response);
                return;
            }
        }
        response.sendRedirect("my-orders");
    }
}