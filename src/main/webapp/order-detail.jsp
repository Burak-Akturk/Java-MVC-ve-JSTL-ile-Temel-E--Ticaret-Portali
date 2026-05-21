<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <title>Sipariş Detayı - E-Ticaret</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4 py-3">
        <div class="container">
            <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/home">🛒 Benim E-Ticaret Sitem</a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav ms-auto align-items-center">
                    <li class="nav-item"><a class="nav-link text-white me-3" href="cart">Sepetim</a></li>
                    <li class="nav-item"><a class="nav-link text-white fw-bold me-3" href="my-orders">Siparişlerim</a></li>
                    <li class="nav-item me-4">
                        <span class="nav-link text-white fw-bold border border-secondary rounded px-3 py-1 bg-secondary bg-opacity-25">
                            👤 Hoş geldin, ${sessionScope.user.fullName}
                        </span>
                    </li>
                    <li class="nav-item"><a class="btn btn-outline-danger btn-sm" href="logout">Çıkış Yap</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-5">
        <!-- Geri Butonu ve Sipariş Özeti -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="m-0">Sipariş Detayı (#ORD-${order.id})</h2>
            <a href="my-orders" class="btn btn-outline-secondary">⬅ Siparişlerime Dön</a>
        </div>

        <div class="card shadow-sm border-0 mb-4">
            <div class="card-body bg-white rounded">
                <div class="row">
                    <div class="col-md-4">
                        <p class="text-muted mb-1">Sipariş Tarihi</p>
                        <h5 class="fw-bold"><fmt:formatDate value="${order.orderDate}" pattern="dd.MM.yyyy HH:mm" /></h5>
                    </div>
                    <div class="col-md-4">
                        <p class="text-muted mb-1">Durum</p>
                        <h5 class="fw-bold text-primary">${order.status}</h5>
                    </div>
                    <div class="col-md-4">
                        <p class="text-muted mb-1">Toplam Tutar</p>
                        <h5 class="fw-bold text-success">
                            <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₺"/>
                        </h5>
                    </div>
                </div>
            </div>
        </div>

        <!-- Sipariş Edilen Ürünler Tablosu -->
        <div class="card shadow-sm border-0">
            <div class="card-header bg-white py-3">
                <h5 class="m-0 fw-bold">Siparişteki Ürünler</h5>
            </div>
            <div class="card-body p-0">
                <table class="table table-hover m-0">
                    <thead class="table-light">
                        <tr>
                            <th class="ps-4">Ürün</th>
                            <th>Birim Fiyat</th>
                            <th>Adet</th>
                            <th class="pe-4 text-end">Ara Toplam</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${orderItems}">
                            <tr>
                                <td class="ps-4 align-middle">
                                    <img src="${not empty item.product.imageUrl ? item.product.imageUrl : 'https://via.placeholder.com/50'}" width="50" class="me-3 rounded">
                                    <span class="fw-bold">${item.product.name}</span>
                                </td>
                                <td class="align-middle">
                                    <fmt:formatNumber value="${item.unitPrice}" type="currency" currencySymbol="₺"/>
                                </td>
                                <td class="align-middle fw-bold">${item.quantity}</td>
                                <td class="pe-4 align-middle text-end text-success fw-bold">
                                    <fmt:formatNumber value="${item.subtotal}" type="currency" currencySymbol="₺"/>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</body>
</html>