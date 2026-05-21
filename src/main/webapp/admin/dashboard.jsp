<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${empty sessionScope.user or sessionScope.user.role != 'ADMIN'}">
    <c:redirect url="../login.jsp"/>
</c:if>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <title>Admin Paneli - E-Ticaret</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body>

    <!-- Üst Menü -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-danger mb-4 shadow-sm">
        <div class="container-fluid">
            <a class="navbar-brand fw-bold" href="dashboard.jsp">⚙️ Yönetim Paneli</a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav ms-auto align-items-center">
                    <li class="nav-item me-3">
                        <a class="nav-link text-white" href="${pageContext.request.contextPath}/home" target="_blank">🌐 Siteyi Gör</a>
                    </li>
                    <li class="nav-item me-4">
                        <span class="nav-link text-white fw-bold">
                            Hoş geldin, Admin ${sessionScope.user.fullName}
                        </span>
                    </li>
                    <li class="nav-item">
                        <a class="btn btn-dark btn-sm" href="../logout">Çıkış Yap</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container-fluid">
        <div class="row">
            <!-- Sol Menü  -->
            <div class="col-md-2">
                <div class="list-group shadow-sm">
                    <a href="${pageContext.request.contextPath}/adminDashboard" class="list-group-item list-group-item-action active fw-bold bg-danger border-danger">
                        <i class="bi bi-house-door-fill me-2"></i> Dashboard
                    </a>
                    <a href="${pageContext.request.contextPath}/adminProducts" class="list-group-item list-group-item-action">
                        <i class="bi bi-box-seam me-2"></i> Ürün Yönetimi
                    </a>
                    <a href="${pageContext.request.contextPath}/adminCategories" class="list-group-item list-group-item-action">
                        <i class="bi bi-tags-fill me-2"></i> Kategori Yönetimi
                    </a>
                    <a href="${pageContext.request.contextPath}/adminOrders" class="list-group-item list-group-item-action">
                        <i class="bi bi-cart-check-fill me-2"></i> Tüm Siparişler
                    </a>
                    <a href="${pageContext.request.contextPath}/adminUsers" class="list-group-item list-group-item-action">
					    <i class="bi bi-people-fill me-2"></i> Müşteri Yönetimi
					</a>
                </div>
            </div>

            <!-- Ana İçerik Alanı -->
            <div class="col-md-10">
                <h3 class="mb-4">Dashboard</h3>
                <div class="row">
                    <!-- Toplam Ürün Kutusu -->
                    <div class="col-md-4">
                        <div class="card text-white bg-primary mb-3 shadow-sm">
                            <div class="card-body">
                                <h5 class="card-title"><i class="bi bi-box-seam"></i> Toplam Ürün</h5>
                                <p class="card-text fs-3 fw-bold">${totalProducts != null ? totalProducts : 0}</p>
                            </div>
                        </div>
                    </div>
                    <!-- Bekleyen Siparişler Kutusu -->
                    <div class="col-md-4">
                        <div class="card text-white bg-success mb-3 shadow-sm">
                            <div class="card-body">
                                <h5 class="card-title"><i class="bi bi-cart-check"></i> Bekleyen Siparişler</h5>
                                <p class="card-text fs-3 fw-bold">${pendingOrders != null ? pendingOrders : 0}</p>
                            </div>
                        </div>
                    </div>
                    <!-- Toplam Müşteri Kutusu -->
                    <div class="col-md-4">
                        <div class="card text-white bg-warning mb-3 shadow-sm text-dark">
                            <div class="card-body">
                                <h5 class="card-title"><i class="bi bi-people-fill"></i> Toplam Müşteri</h5>
                                <p class="card-text fs-3 fw-bold">${totalCustomers != null ? totalCustomers : 0}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>