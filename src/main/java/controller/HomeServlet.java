package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// Kendi paketlerini buraya ekle:
import dao.ProductDAO;
import dao.CategoryDAO;
import model.Product;
import model.Category;

@WebServlet({"", "/home", "/index"}) 
public class HomeServlet extends HttpServlet {
    

	private static final long serialVersionUID = -5858924701170652294L;
	private ProductDAO productDAO;
    private CategoryDAO categoryDAO;

    public void init() throws ServletException {
        productDAO = new ProductDAO();
        categoryDAO = new CategoryDAO();
    }
 
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Product> products = productDAO.getAllActiveProducts();
        List<Category> categories = categoryDAO.getAllActiveCategories();

        request.setAttribute("productList", products);
        request.setAttribute("categoryList", categories);

        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
}