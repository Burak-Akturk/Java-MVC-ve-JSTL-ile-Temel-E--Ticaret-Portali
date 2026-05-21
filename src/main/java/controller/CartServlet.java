package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.ProductDAO;
import model.CartItem;
import model.Product;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductDAO productDAO;

    public void init() {
        productDAO = new ProductDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/cart.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String productIdStr = request.getParameter("productId");

        if (action == null) {
            action = "add";
        }

        if (productIdStr != null) {
            int productId = Integer.parseInt(productIdStr);
            HttpSession session = request.getSession();
            
            @SuppressWarnings("unchecked")
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
            if (cart == null) {
                cart = new ArrayList<>();
            }

            if ("add".equals(action)) {
                // EKLEME İŞLEMİ
                String quantityStr = request.getParameter("quantity");
                int quantity = quantityStr != null ? Integer.parseInt(quantityStr) : 1;
                Product product = productDAO.getProductById(productId);

                if (product != null) {
                    boolean exists = false;
                    for (CartItem item : cart) {
                        if (item.getProduct().getId() == productId) {
                            if (item.getQuantity() + quantity <= item.getProduct().getStock()) {
                                item.setQuantity(item.getQuantity() + quantity);
                            }
                            exists = true;
                            break;
                        }
                    }
                    if (!exists) {
                        cart.add(new CartItem(product, quantity));
                    }
                }
            } else if ("update".equals(action)) {
                // ADET GÜNCELLEME İŞLEMİ
                String quantityStr = request.getParameter("quantity");
                int quantity = quantityStr != null ? Integer.parseInt(quantityStr) : 1;
                
                for (CartItem item : cart) {
                    if (item.getProduct().getId() == productId) {
                        if (quantity > 0 && quantity <= item.getProduct().getStock()) {
                            item.setQuantity(quantity);
                        }
                        break;
                    }
                }
            } else if ("remove".equals(action)) {
                // SİLME İŞLEMİ
                cart.removeIf(item -> item.getProduct().getId() == productId);
            }

            session.setAttribute("cart", cart);
        }
        
        response.sendRedirect("cart");
    }
}