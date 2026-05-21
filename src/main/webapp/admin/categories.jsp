<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${empty sessionScope.user or sessionScope.user.role != 'ADMIN'}">
    <c:redirect url="../login.jsp"/>
</c:if>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <title>Kategori Yönetimi - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body class="bg-light">

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-danger mb-4 shadow-sm">
        <div class="container-fluid">
            <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/admin/dashboard.jsp">⚙️ Yönetim Paneli</a>
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
                    <a href="${pageContext.request.contextPath}/adminCategories" class="list-group-item list-group-item-action active fw-bold bg-danger border-danger">
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

            <!-- Kategori Formu ve Tablosu -->
            <div class="col-md-10">
                <h3 class="mb-4">Kategori Yönetimi</h3>
                
                <div class="row">
                    <!-- Yeni Kategori Ekleme Formu -->
                    <div class="col-md-4">
                        <div class="card shadow-sm border-0">
                            <div class="card-header bg-success text-white fw-bold">
                                ➕ Yeni Kategori Ekle
                            </div>
                            <div class="card-body">
                                <form action="${pageContext.request.contextPath}/adminCategories" method="post">
                                    <input type="hidden" name="action" value="add">
                                    <div class="mb-3">
                                        <label class="form-label">Kategori Adı</label>
                                        <input type="text" name="name" class="form-control" required placeholder="Örn: Akıllı Telefonlar">
                                    </div>
                                    <button type="submit" class="btn btn-success w-100 fw-bold">Kaydet</button>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- Kategori Listesi Tablosu -->
                    <div class="col-md-8">
                        <div class="card shadow-sm border-0">
                            <div class="card-body p-0">
                                <table class="table table-hover table-striped m-0">
                                    <thead class="table-dark">
                                        <tr>
                                            <th class="ps-3 w-25">ID</th>
                                            <th>Kategori Adı</th>
                                            <th class="text-end pe-3 w-25">İşlem</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="category" items="${categoryList}">
                                            <tr>
                                                <td class="ps-3 align-middle fw-bold">${category.id}</td>
                                                <td class="align-middle">${category.name}</td>
                                                <td class="text-end pe-3 align-middle">
                                                    <!-- Silme Formu -->
                                                    <form action="${pageContext.request.contextPath}/adminCategories" method="post" class="d-inline" onsubmit="return confirm('Bu kategoriyi silmek istediğinize emin misiniz?');">
                                                        <input type="hidden" name="action" value="delete">
                                                        <input type="hidden" name="id" value="${category.id}">
                                                        <button type="submit" class="btn btn-sm btn-danger"><i class="bi bi-trash"></i> Sil</button>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        <c:if test="${empty categoryList}">
                                            <tr>
                                                <td colspan="3" class="text-center py-3 text-muted">Henüz bir kategori eklenmemiş.</td>
                                            </tr>
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                
            </div>
        </div>
    </div>

</body>
</html>