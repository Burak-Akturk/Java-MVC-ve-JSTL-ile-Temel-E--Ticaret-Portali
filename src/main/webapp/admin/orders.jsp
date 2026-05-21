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
    <title>Sipariş Yönetimi - Admin</title>
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
                    <a href="${pageContext.request.contextPath}/adminCategories" class="list-group-item list-group-item-action">
                        <i class="bi bi-tags-fill me-2"></i> Kategori Yönetimi
                    </a>
                    <a href="${pageContext.request.contextPath}/adminOrders" class="list-group-item list-group-item-action active fw-bold bg-danger border-danger">
                        <i class="bi bi-cart-check-fill me-2"></i> Tüm Siparişler
                    </a>
                    <a href="${pageContext.request.contextPath}/adminUsers" class="list-group-item list-group-item-action">
					    <i class="bi bi-people-fill me-2"></i> Müşteri Yönetimi
					</a>
                </div>
            </div>

            <!-- Sipariş Tablosu -->
            <div class="col-md-10">
                <h3 class="mb-4">Tüm Siparişler</h3>

                <div class="card shadow-sm border-0">
                    <div class="card-body p-0">
                        <table class="table table-hover m-0">
                            <thead class="table-dark">
                                <tr>
                                    <th class="ps-3">Sipariş No</th>
                                    <th>Kullanıcı ID</th>
                                    <th>Tarih</th>
                                    <th>Toplam Tutar</th>
                                    <th>Mevcut Durum</th>
                                    <th class="pe-3 w-25">Durum Güncelle</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="order" items="${orderList}">
                                    <tr>
                                        <td class="ps-3 align-middle fw-bold">#ORD-${order.id}</td>
                                        <td class="align-middle">Kullanıcı: ${order.userId}</td>
                                        <td class="align-middle">
                                            <fmt:formatDate value="${order.orderDate}" pattern="dd.MM.yyyy HH:mm" />
                                        </td>
                                        <td class="align-middle fw-bold text-success">
                                            <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₺"/>
                                        </td>
                                        <td class="align-middle">
                                            <c:choose>
                                                <c:when test="${order.status == 'Beklemede'}"><span class="badge bg-warning text-dark px-2 py-1">${order.status}</span></c:when>
                                                <c:when test="${order.status == 'Onaylandı'}"><span class="badge bg-info text-dark px-2 py-1">${order.status}</span></c:when>
                                                <c:when test="${order.status == 'Kargolandı'}"><span class="badge bg-primary px-2 py-1">${order.status}</span></c:when>
                                                <c:when test="${order.status == 'Tamamlandı'}"><span class="badge bg-success px-2 py-1">${order.status}</span></c:when>
                                                <c:when test="${order.status == 'İptal Edildi'}"><span class="badge bg-danger px-2 py-1">${order.status}</span></c:when>
                                                <c:otherwise><span class="badge bg-secondary px-2 py-1">${order.status}</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="pe-3 align-middle">
                                            <!-- Durum Değiştirme Formu -->
                                            <form action="${pageContext.request.contextPath}/adminOrders" method="post" class="d-flex m-0">
                                                <input type="hidden" name="orderId" value="${order.id}">
                                                <select name="status" class="form-select form-select-sm me-2">
                                                    <option value="Beklemede" ${order.status == 'Beklemede' ? 'selected' : ''}>Beklemede</option>
                                                    <option value="Onaylandı" ${order.status == 'Onaylandı' ? 'selected' : ''}>Onaylandı</option>
                                                    <option value="Kargolandı" ${order.status == 'Kargolandı' ? 'selected' : ''}>Kargolandı</option>
                                                    <option value="Tamamlandı" ${order.status == 'Tamamlandı' ? 'selected' : ''}>Tamamlandı</option>
                                                    <option value="İptal Edildi" ${order.status == 'İptal Edildi' ? 'selected' : ''}>İptal</option>
                                                </select>
                                                <button type="submit" class="btn btn-sm btn-success">Uygula</button>
                                            </form>
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