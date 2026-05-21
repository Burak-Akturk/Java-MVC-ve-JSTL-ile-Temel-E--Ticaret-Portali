<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sepetim - E-Ticaret</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4 py-3">
        <div class="container">
            <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/home">🛒 Benim E-Ticaret Sitem</a>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto align-items-center">	                
                    <li class="nav-item">
                        <a class="nav-link text-white me-3 active fw-bold" href="cart">Sepetim</a>
                    </li>
                    <li class="nav-item">
					    <a class="nav-link text-white me-3" href="my-orders">Siparişlerim</a>
					</li>
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <li class="nav-item me-4">
                                <span class="nav-link text-white fw-bold border border-secondary rounded px-3 py-1 bg-secondary bg-opacity-25">
                                    👤 Hoş geldin, ${sessionScope.user.fullName}
                                </span>
                            </li>
                            <li class="nav-item">
                                <a class="btn btn-outline-danger btn-sm" href="logout">Çıkış Yap</a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item"><a class="nav-link text-white" href="login.jsp">Giriş Yap</a></li>
                            <li class="nav-item ms-2"><a class="btn btn-primary btn-sm mt-1" href="register.jsp">Kayıt Ol</a></li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Sepet İçeriği -->
    <div class="container mt-5">
        <h2 class="mb-4">Alışveriş Sepetim</h2>
        <c:if test="${param.success == 'checkout'}">
            <div class="alert alert-success text-center fw-bold shadow-sm">
                🎉 Siparişiniz başarıyla oluşturuldu! Teşekkür ederiz.
            </div>
        </c:if>
        <c:if test="${param.error == 'checkout'}">
            <div class="alert alert-danger text-center fw-bold shadow-sm">
                Sipariş oluşturulurken bir hata meydana geldi.
            </div>
        </c:if>

        <c:choose>
            <c:when test="${empty sessionScope.cart}">
                <div class="alert alert-warning text-center py-4">
                    <h4>Sepetiniz şu an boş.</h4>
                    <a href="home" class="btn btn-primary mt-3">Alışverişe Başla</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="row">
                    <div class="col-md-8">
                        <table class="table table-hover bg-white shadow-sm rounded">
                            <thead class="table-light">
                                <tr>
                                    <th>Ürün</th>
                                    <th>Fiyat</th>
                                    <th>Adet</th>
                                    <th>Ara Toplam</th>
                                    <th>İşlem</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:set var="totalAmount" value="0" />
                                <c:forEach var="item" items="${sessionScope.cart}">
                                    <tr>
                                        <!-- Ürün Adı ve Resmi -->
                                        <td class="align-middle">
                                            <img src="${not empty item.product.imageUrl ? item.product.imageUrl : 'https://via.placeholder.com/50'}" width="50" class="me-2 rounded">
                                            ${item.product.name}
                                        </td>
                                        
                                        <!-- Fiyat -->
                                        <td class="align-middle"><fmt:formatNumber value="${item.product.price}" type="currency" currencySymbol="₺"/></td>
                                        
                                        <!-- Adet Güncelleme Formu -->
                                        <td class="align-middle">
                                            <form action="cart" method="post" class="d-flex align-items-center m-0">
                                                <input type="hidden" name="action" value="update">
                                                <input type="hidden" name="productId" value="${item.product.id}">
                                                
                                                <input type="number" name="quantity" value="${item.quantity}" min="1" max="${item.product.stock}" class="form-control form-control-sm text-center me-2" style="width: 70px;">
                                                <button type="submit" class="btn btn-sm btn-outline-secondary">Güncelle</button>
                                            </form>
                                        </td>
                                        
                                        <!-- Ara Toplam -->
                                        <td class="align-middle fw-bold text-success">
                                            <fmt:formatNumber value="${item.subtotal}" type="currency" currencySymbol="₺"/>
                                        </td>
                                        
                                        <!-- Silme Formu -->
                                        <td class="align-middle">
                                            <form action="cart" method="post" class="m-0">
                                                <input type="hidden" name="action" value="remove">
                                                <input type="hidden" name="productId" value="${item.product.id}">
                                                <button type="submit" class="btn btn-sm btn-danger">Sil</button>
                                            </form>
                                        </td>
                                    </tr>
                                    <c:set var="totalAmount" value="${totalAmount + item.subtotal}" />
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    
                    <div class="col-md-4">
                        <div class="card shadow-sm border-0">
                            <div class="card-body">
                                <h4 class="card-title mb-4">Sipariş Özeti</h4>
                                <div class="d-flex justify-content-between mb-3">
                                    <span>Toplam Tutar:</span>
                                    <span class="fw-bold fs-5 text-primary">
                                        <fmt:formatNumber value="${totalAmount}" type="currency" currencySymbol="₺"/>
                                    </span>
                                </div>
                                <hr>
                                <c:choose>
								    <c:when test="${not empty sessionScope.user}">
								        <form action="checkout" method="post" class="m-0">
								            <button type="submit" class="btn btn-success w-100 fw-bold py-2 shadow-sm">Siparişi Tamamla</button>
								        </form>
								    </c:when>
								    <c:otherwise>
								        <a href="login.jsp" class="btn btn-warning w-100 fw-bold py-2 shadow-sm">Sipariş İçin Giriş Yap</a>
								    </c:otherwise>
								</c:choose>
                            </div>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

</body>
</html>