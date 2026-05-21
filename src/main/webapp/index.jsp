<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>E-Ticaret Portalı</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .product-img { height: 200px; object-fit: cover; }
        
        .secili-kategori {
            background-color: #e2e3e5 !important;
            font-weight: bold;
            border-left: 4px solid #0d6efd !important;
        }
    </style>
</head>
<body class="bg-light">

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4 py-3">
        <div class="container">
            <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/home">🛒 Benim E-Ticaret Sitem</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto align-items-center">
                    
                    <li class="nav-item">
                        <a class="nav-link text-white me-3" href="cart.jsp">
                            Sepetim
                        </a>
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

    <!-- Ana İçerik -->
    <div class="container">
        <div class="row">
            
            <!-- Kategoriler -->
            <div class="col-md-3 mb-4">
                <div class="card shadow-sm">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0">Kategoriler</h5>
                    </div>
                    <ul class="list-group list-group-flush">
                        
                        <!-- Tüm Ürünler Linki -->
                        <li class="list-group-item ${empty activeCategoryId ? 'secili-kategori' : ''}">
                            <a href="home" class="text-decoration-none text-dark d-block">Tüm Ürünler</a>
                        </li>
                        
                        <c:forEach var="category" items="${categoryList}">
                            <li class="list-group-item ${category.id == activeCategoryId ? 'secili-kategori' : ''}">
                                <a href="products?categoryId=${category.id}" class="text-decoration-none text-dark d-block">
                                    ${category.name}
                                </a>
                            </li>
                        </c:forEach>
                        
                    </ul>
                </div>
            </div>

            <!-- Ürünler -->
            <div class="col-md-9">
                <h2 class="mb-4">Öne Çıkan Ürünler</h2>
                <div class="row">
                    
                    <c:forEach var="product" items="${productList}">
                        <div class="col-md-4 mb-4">
                            <div class="card h-100 shadow-sm">
                                <!-- Ürün Görseli -->
                                <img src="${not empty product.imageUrl ? product.imageUrl : 'https://via.placeholder.com/300x200?text=Gorsel+Yok'}" 
                                     class="card-img-top product-img" alt="${product.name}">
                                
                                <div class="card-body d-flex flex-column">
                                    <h5 class="card-title">${product.name}</h5>
                                    
                                    <h4 class="text-success mb-3">
                                        <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₺"/>
                                    </h4>
                                    
                                    <c:choose>
                                        <c:when test="${product.stock > 0}">
                                            <p class="text-muted small mb-3">Stokta: ${product.stock} adet</p>
                                        </c:when>
                                        <c:otherwise>
                                            <p class="text-danger small fw-bold mb-3">Stokta Yok</p>
                                        </c:otherwise>
                                    </c:choose>       
                                    
                                    <!-- Butonlar -->
									<div class="mt-auto d-flex justify-content-between gap-2">
									    <!-- Detay Butonu -->
									    <a href="productDetail?id=${product.id}" class="btn btn-outline-secondary btn-sm w-100">Detay</a>
									    
									    <!-- Sepete Ekle Butonu ve Formu -->
									    <c:if test="${product.stock > 0}">
									        <form action="cart" method="post" class="w-100 m-0">
									            <input type="hidden" name="productId" value="${product.id}">
									            <input type="hidden" name="quantity" value="1">
									            
									            <button type="submit" class="btn btn-primary btn-sm w-100">Sepete Ekle</button>
									        </form>
									    </c:if>
									</div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    
                    <!-- Eğer veritabanında hiç ürün yoksa bilgi mesajı -->
                    <c:if test="${empty productList}">
                        <div class="alert alert-warning" role="alert">
                            Şu an için bu kategoride listelenecek ürün bulunmamaktadır.
                        </div>
                    </c:if>

                </div>
            </div>
            
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>