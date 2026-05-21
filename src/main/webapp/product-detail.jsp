<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${product.name} - Detay</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

    <!--Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4 py-3">
        <div class="container">
            <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/home">🛒 Benim E-Ticaret Sitem</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto align-items-center">
                    <li class="nav-item">
                        <a class="nav-link text-white me-3" href="cart.jsp">Sepetim</a>
                    </li>
                    <li class="nav-item">
					    <a class="nav-link text-white me-3" href="my-orders">Siparişlerim</a>
					</li>
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <li class="nav-item me-4">
                                <span class="nav-link text-white fw-bold border border-secondary rounded px-3 py-1 bg-secondary bg-opacity-25" style="letter-spacing: 0.5px;">
                                    👤 Hoş geldin, ${sessionScope.user.fullName}
                                </span>
                            </li>
                            <li class="nav-item">
                                <a class="btn btn-outline-danger btn-sm" href="logout">Çıkış Yap</a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item">
                                <a class="nav-link text-white" href="login.jsp">Giriş Yap</a>
                            </li>
                            <li class="nav-item ms-2">
                                <a class="btn btn-primary btn-sm mt-1" href="register.jsp">Kayıt Ol</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Ürün Detay İçeriği -->
    <div class="container mt-5">
        <div class="card shadow-lg border-0">
            <div class="row g-0">
                
                <!-- Görsel -->
                <div class="col-md-6 d-flex align-items-center bg-white p-4">
                    <img src="${not empty product.imageUrl ? product.imageUrl : 'https://via.placeholder.com/500x500?text=Gorsel+Yok'}" 
                         class="img-fluid rounded" alt="${product.name}" style="object-fit: contain; width: 100%; max-height: 500px;">
                </div>
                
                <!-- Ürün Bilgileri -->
                <div class="col-md-6">
                    <div class="card-body p-5">
                        <h2 class="fw-bold mb-3">${product.name}</h2>
                        <p class="text-muted mb-2">
						    <strong><i class="bi bi-tag"></i> Kategori:</strong> ${category.name}
						</p>
                        
                        <h3 class="text-success fw-bold mb-4">
                            <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₺"/>
                        </h3>
                        
                        <h5 class="fw-bold">Ürün Açıklaması:</h5>
                        <p class="card-text text-muted mb-4" style="line-height: 1.8;">
                            ${product.description}
                        </p>
                        
                        <hr class="mb-4">
                        
                        <!-- Stok ve Sepete Ekle Formu -->
                        <c:choose>
                            <c:when test="${product.stock > 0}">
                                <p class="text-muted mb-3">Stok Durumu: <span class="badge bg-success">${product.stock} adet mevcut</span></p>
                                                           
                                <form action="cart" method="post" class="d-flex align-items-center mt-4">
                                    <input type="hidden" name="productId" value="${product.id}">
                                    
                                    <label class="me-2 fw-bold">Adet:</label>
                                    <input type="number" name="quantity" value="1" min="1" max="${product.stock}" class="form-control text-center me-3" style="width: 80px;">
                                    
                                    <button type="submit" class="btn btn-primary btn-lg w-100 fw-bold shadow-sm">
                                        🛒 Sepete Ekle
                                    </button>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <div class="alert alert-danger fw-bold text-center">
                                    ⚠️ Bu ürün şu an stokta bulunmamaktadır.
                                </div>
                            </c:otherwise>
                        </c:choose>
                        
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>