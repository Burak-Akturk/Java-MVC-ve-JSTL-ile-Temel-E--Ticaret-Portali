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
import dao.UserDAO;
import model.Order;
import model.User;

@WebServlet("/adminUserDetail")
public class AdminUserDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;
    private OrderDAO orderDAO;

    public void init() {
        userDAO = new UserDAO();
        orderDAO = new OrderDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        String idStr = request.getParameter("id");
        if (idStr != null) {
            int userId = Integer.parseInt(idStr);
            
            User customer = userDAO.getUserById(userId);
            
            List<Order> customerOrders = orderDAO.getOrdersByUserId(userId);
            
            if (customer != null) {
                request.setAttribute("customer", customer);
                request.setAttribute("customerOrders", customerOrders);
                request.getRequestDispatcher("/admin/user-detail.jsp").forward(request, response);
                return;
            }
        }
        response.sendRedirect("adminUsers");
    }
}