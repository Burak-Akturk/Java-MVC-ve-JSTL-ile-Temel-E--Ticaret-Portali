package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.CategoryDAO;
import model.Category;
import model.User;

@WebServlet("/adminCategories")
public class AdminCategoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CategoryDAO categoryDAO;

    public void init() {
        categoryDAO = new CategoryDAO();
    }

    // Listeleme İşlemi
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<Category> categoryList = categoryDAO.getAllCategories();
        request.setAttribute("categoryList", categoryList);
        
        request.getRequestDispatcher("/admin/categories.jsp").forward(request, response);
    }

    // Yeni Kategori Ekleme İşlemi
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            String categoryName = request.getParameter("name");
            if (categoryName != null && !categoryName.trim().isEmpty()) {
                categoryDAO.addCategory(categoryName);
            }
        } 
        else if ("delete".equals(action)) {
            String idStr = request.getParameter("id");
            if (idStr != null) {
                categoryDAO.deleteCategory(Integer.parseInt(idStr));
            }
        }
        
        response.sendRedirect("adminCategories");
    }
}