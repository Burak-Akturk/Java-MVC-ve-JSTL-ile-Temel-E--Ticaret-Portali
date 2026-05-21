package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ProductDAO;
import dao.CategoryDAO; 
import model.Product;
import model.Category;  

@WebServlet("/products")
public class ProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private ProductDAO productDAO;
    private CategoryDAO categoryDAO; 

    @Override
    public void init() {
        productDAO = new ProductDAO();
        categoryDAO = new CategoryDAO(); 
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String categoryIdStr = request.getParameter("categoryId");
        
        if (categoryIdStr != null) {
            int categoryId = Integer.parseInt(categoryIdStr);
            
            List<Product> products = productDAO.getProductsByCategory(categoryId);
            
            List<Category> categories = categoryDAO.getAllActiveCategories();
            
            request.setAttribute("activeCategoryId", categoryId);
            
            request.setAttribute("productList", products);
            request.setAttribute("categoryList", categories); 
            
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        } else {
            response.sendRedirect("home");
        }
    }
}