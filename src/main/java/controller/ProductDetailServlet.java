package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CategoryDAO;
import dao.ProductDAO;
import model.Category;
import model.Product;

@WebServlet("/productDetail")
public class ProductDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductDAO productDAO;

    public void init() {
        productDAO = new ProductDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("id");
        
        if (idStr != null) {
            int productId = Integer.parseInt(idStr);
            Product product = productDAO.getProductById(productId);
            
            if (product != null) {
                CategoryDAO categoryDAO = new CategoryDAO();
                Category category = categoryDAO.getCategoryById(product.getCategoryId());
                
                request.setAttribute("product", product);
                request.setAttribute("category", category);
                
                request.getRequestDispatcher("product-detail.jsp").forward(request, response);
                return;
            }
        }
        response.sendRedirect("home");
    }
}