<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:if test="${empty sessionScope.user or sessionScope.user.role != 'ADMIN'}">
    <c:redirect url="../login.jsp"/>
</c:if>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <title>Ürün Yönetimi - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body class="bg-light">

    <!-- Üst Menü -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-danger mb-4 shadow-sm">
        <div class="container-fluid">
            <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/admin/dashboard.jsp">⚙️ Yönetim Paneli</a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav ms-auto align-items-center">
                    <li class="nav-item me-3">
                        <a class="nav-link text-white" href="${pageContext.request.contextPath}/home" target="_blank">🌐 Siteyi Gör</a>
                    </li>
                    <li class="nav-item me-4">
                        <span class="nav-link text-white fw-bold">Hoş geldin, ${sessionScope.user.fullName}</span>
                    </li>
                    <li class="nav-item">
                        <a class="btn btn-dark btn-sm" href="${pageContext.request.contextPath}/logout">Çıkış Yap</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <div class="container-fluid">
        <div class="row">
            <!-- Sol Menü -->
            <div class="col-md-2">
                <div class="list-group shadow-sm">
                    <a href="${pageContext.request.contextPath}/adminDashboard" class="list-group-item list-group-item-action">
                        <i class="bi bi-house-door-fill me-2"></i> Dashboard
                    </a>
                    <a href="${pageContext.request.contextPath}/adminProducts" class="list-group-item list-group-item-action active fw-bold bg-danger border-danger">
                        <i class="bi bi-box-seam me-2"></i> Ürün Yönetimi
                    </a>
                    <a href="${pageContext.request.contextPath}/adminCategories" class="list-group-item list-group-item-action">                        <i class="bi bi-tags-fill me-2"></i> Kategori Yönetimi
                    </a>
                    <a href="${pageContext.request.contextPath}/adminOrders" class="list-group-item list-group-item-action">
                        <i class="bi bi-cart-check-fill me-2"></i> Tüm Siparişler
                    </a>
                    <a href="${pageContext.request.contextPath}/adminUsers" class="list-group-item list-group-item-action">
					    <i class="bi bi-people-fill me-2"></i> Müşteri Yönetimi
					</a>
                </div>
            </div>

            <!-- Ürün Tablosu -->
            <div class="col-md-10">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h3>Ürün Listesi</h3>
                    <a href="${pageContext.request.contextPath}/adminProductAdd" class="btn btn-success fw-bold"><i class="bi bi-plus-circle me-2"></i> Yeni Ürün Ekle</a>
                </div>

                <div class="card shadow-sm border-0">
                    <div class="card-body p-0">
                        <table class="table table-hover table-striped m-0">
                            <thead class="table-dark">
                                <tr>
                                    <th class="ps-3">ID</th>
                                    <th>Görsel</th>
                                    <th>Ürün Adı</th>
                                    <th>Fiyat</th>
                                    <th>Stok</th>
                                    <th>Durum</th>
                                    <th class="text-end pe-3">İşlemler</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="product" items="${productList}">
                                    <tr>
                                        <td class="ps-3 align-middle fw-bold">${product.id}</td>
                                        <td class="align-middle">
                                            <img src="${not empty product.imageUrl ? product.imageUrl : 'https://via.placeholder.com/40'}" width="40" height="40" class="rounded" style="object-fit: cover;">
                                        </td>
                                        <td class="align-middle">${product.name}</td>
                                        <td class="align-middle fw-bold text-success">
                                            <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₺"/>
                                        </td>
                                        <td class="align-middle">
                                            <span class="badge ${product.stock > 10 ? 'bg-info' : 'bg-danger'} text-dark">${product.stock}</span>
                                        </td>
                                        <td class="align-middle">
                                            <c:choose>
                                                <c:when test="${product.active}">
                                                    <span class="badge bg-success">Aktif</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary">Pasif</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-end pe-3 align-middle">
                                            <a href="${pageContext.request.contextPath}/adminProductEdit?id=${product.id}" class="btn btn-sm btn-primary"> <i class="bi bi-pencil-square"></i> </a>
                                            <a href="${pageContext.request.contextPath}/adminProductDelete?id=${product.id}" 
											   class="btn btn-sm btn-danger" 
											   onclick="return confirm('Bu ürünü silmek istediğinize emin misiniz?');">
											    <i class="bi bi-trash"></i>
											</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>