<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${empty sessionScope.user or sessionScope.user.role != 'ADMIN'}">
    <c:redirect url="../login.jsp"/>
</c:if>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <title>Müşteri Yönetimi - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body class="bg-light">

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-danger mb-4 shadow-sm">
        <div class="container-fluid">
            <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/adminDashboard">⚙️ Yönetim Paneli</a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav ms-auto align-items-center">
                    <li class="nav-item me-3"><a class="nav-link text-white" href="${pageContext.request.contextPath}/home" target="_blank">🌐 Siteyi Gör</a></li>
                    <li class="nav-item me-4"><span class="nav-link text-white fw-bold">Hoş geldin, ${sessionScope.user.fullName}</span></li>
                    <li class="nav-item"><a class="btn btn-dark btn-sm" href="${pageContext.request.contextPath}/logout">Çıkış Yap</a></li>
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
                    <a href="${pageContext.request.contextPath}/adminProducts" class="list-group-item list-group-item-action">
                        <i class="bi bi-box-seam me-2"></i> Ürün Yönetimi
                    </a>
                    <a href="${pageContext.request.contextPath}/adminCategories" class="list-group-item list-group-item-action">
                        <i class="bi bi-tags-fill me-2"></i> Kategori Yönetimi
                    </a>
                    <a href="${pageContext.request.contextPath}/adminOrders" class="list-group-item list-group-item-action">
                        <i class="bi bi-cart-check-fill me-2"></i> Tüm Siparişler
                    </a>
                    <a href="${pageContext.request.contextPath}/adminUsers" class="list-group-item list-group-item-action active fw-bold bg-danger border-danger">
                        <i class="bi bi-people-fill me-2"></i> Müşteri Yönetimi
                    </a>
                </div>
            </div>

            <!-- Ana İçerik: Müşteri Tablosu -->
            <div class="col-md-10">
                <h3 class="mb-4">Kayıtlı Müşteriler</h3>

                <div class="card shadow-sm border-0">
                    <div class="card-body p-0">
                        <table class="table table-hover table-striped m-0">
                            <thead class="table-dark">
                                <tr>
                                    <th class="ps-4">ID</th>
                                    <th>Ad Soyad</th>
                                    <th>E-Posta Adresi</th>
                                    <th>Durum</th>
                                    <th class="pe-4 text-end">İşlem</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="customer" items="${customerList}">
                                    <tr>
                                        <td class="ps-4 align-middle fw-bold">${customer.id}</td>
                                        <td class="align-middle">
                                            <i class="bi bi-person-circle me-2 text-secondary"></i>
                                            ${customer.fullName}
                                        </td>
                                        <td class="align-middle">${customer.email}</td>
                                        <td class="align-middle">
                                            <c:choose>
                                                <c:when test="${customer.active}">
                                                    <span class="badge bg-success">Aktif</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-danger">Askıya Alındı</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="pe-4 align-middle text-end">
                                            <a href="${pageContext.request.contextPath}/adminUserDetail?id=${customer.id}" class="btn btn-sm btn-primary">Detay</a>
                                            
                                            <c:choose>
                                                <c:when test="${customer.active}">
                                                    <a href="${pageContext.request.contextPath}/adminUserStatus?id=${customer.id}&action=suspend" 
                                                       class="btn btn-sm btn-outline-danger ms-1" 
                                                       onclick="return confirm('Bu müşterinin hesabını askıya almak istediğinize emin misiniz?');">
                                                        <i class="bi bi-slash-circle"></i> Banla
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="${pageContext.request.contextPath}/adminUserStatus?id=${customer.id}&action=activate" 
                                                       class="btn btn-sm btn-outline-success ms-1">
                                                        <i class="bi bi-check-circle"></i> Kilidi Aç
                                                    </a>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty customerList}">
                                    <tr>
                                        <td colspan="5" class="text-center py-4 text-muted">Sistemde henüz kayıtlı müşteri bulunmamaktadır.</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>