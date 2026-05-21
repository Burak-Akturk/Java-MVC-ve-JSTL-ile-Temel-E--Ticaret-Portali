package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.ProductDAO;
import model.Product;
import model.User;

@WebServlet("/adminProductEdit")
public class AdminProductEditServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductDAO productDAO;

    public void init() {
        productDAO = new ProductDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        String idStr = request.getParameter("id");
        if (idStr != null) {
            int id = Integer.parseInt(idStr);
            Product product = productDAO.getProductById(id);
            
            if (product != null) {
                request.setAttribute("product", product);
                request.getRequestDispatcher("/admin/product-edit.jsp").forward(request, response);
                return;
            }
        }
        response.sendRedirect("adminProducts");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        try {
            Product product = new Product();
            product.setId(Integer.parseInt(request.getParameter("id")));
            product.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));
            product.setName(request.getParameter("name"));
            product.setDescription(request.getParameter("description"));
            product.setPrice(Double.parseDouble(request.getParameter("price")));
            product.setStock(Integer.parseInt(request.getParameter("stock")));
            product.setImageUrl(request.getParameter("imageUrl"));
            product.setActive(request.getParameter("isActive") != null);

            if (productDAO.updateProduct(product)) {
                response.sendRedirect("adminProducts");
            } else {
                request.setAttribute("errorMsg", "Güncelleme sırasında bir hata oluştu.");
                request.setAttribute("product", product);
                request.getRequestDispatcher("/admin/product-edit.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminProducts");
        }
    }
}