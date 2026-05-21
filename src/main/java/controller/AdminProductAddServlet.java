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
import dao.ProductDAO;
import model.Category;
import model.Product;
import model.User;

@WebServlet("/adminProductAdd")
public class AdminProductAddServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductDAO productDAO;
    private CategoryDAO categoryDAO;

    public void init() {
        productDAO = new ProductDAO();
        categoryDAO = new CategoryDAO();
    }

    // Form sayfasını gösterir
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<Category> categoryList = categoryDAO.getAllCategories();
        request.setAttribute("categoryList", categoryList);

        request.getRequestDispatcher("/admin/product-add.jsp").forward(request, response);
    }

    // Formdan gelen verileri veritabanına kaydeder
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        try {
            Product product = new Product();
            product.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));
            product.setName(request.getParameter("name"));
            product.setDescription(request.getParameter("description"));
            product.setPrice(Double.parseDouble(request.getParameter("price")));
            product.setStock(Integer.parseInt(request.getParameter("stock")));
            product.setImageUrl(request.getParameter("imageUrl"));
            product.setActive(request.getParameter("isActive") != null);

            if (productDAO.addProduct(product)) {
                response.sendRedirect("adminProducts");
            } else {
                request.setAttribute("errorMsg", "Veritabanına kayıt sırasında hata oluştu.");
                request.getRequestDispatcher("/admin/product-add.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "Lütfen tüm alanları doğru formatta doldurun.");
            request.getRequestDispatcher("/admin/product-add.jsp").forward(request, response);
        }
    }
}