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
import model.User;

@WebServlet("/adminOrders")
public class AdminOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private OrderDAO orderDAO;

    public void init() {
        orderDAO = new OrderDAO();
    }

    // Tüm siparişleri listele
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<Order> orderList = orderDAO.getAllOrders();
        request.setAttribute("orderList", orderList);
        
        request.getRequestDispatcher("/admin/orders.jsp").forward(request, response);
    }

    // Sipariş durumunu güncelle
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        String idStr = request.getParameter("orderId");
        String newStatus = request.getParameter("status");

        if (idStr != null && newStatus != null) {
            int orderId = Integer.parseInt(idStr);
            orderDAO.updateOrderStatus(orderId, newStatus);
        }
        
        response.sendRedirect("adminOrders");
    }
}