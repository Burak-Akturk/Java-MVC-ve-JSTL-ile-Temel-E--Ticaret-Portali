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
    <title>Müşteri Detayı - Admin</title>
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
                    <li class="nav-item"><a class="btn btn-dark btn-sm" href="${pageContext.request.contextPath}/logout">Çıkış Yap</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <!-- Geri Butonu ve Başlık -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Müşteri Profili</h2>
            <a href="${pageContext.request.contextPath}/adminUsers" class="btn btn-outline-secondary">⬅ Müşteri Listesine Dön</a>
        </div>

        <div class="row">
            <!-- Müşteri Bilgi Kartı -->
            <div class="col-md-4 mb-4">
                <div class="card shadow-sm border-0 h-100">
                    <div class="card-header bg-primary text-white fw-bold">
                        <i class="bi bi-person-vcard me-2"></i> Kişisel Bilgiler
                    </div>
                    <div class="card-body">
                        <h5 class="fw-bold mb-3">${customer.fullName}</h5>
                        <p class="mb-2"><strong>ID:</strong> #${customer.id}</p>
                        <p class="mb-2"><strong><i class="bi bi-envelope"></i> E-Posta:</strong> ${customer.email}</p>
                        <p class="mb-2"><strong><i class="bi bi-telephone"></i> Telefon:</strong> ${not empty customer.phone ? customer.phone : '<span class="text-muted">Belirtilmemiş</span>'}</p>
                        <hr>
                        <p class="mb-2"><strong><i class="bi bi-geo-alt"></i> Adres:</strong></p>
                        <p class="text-muted">${not empty customer.address ? customer.address : 'Adres bilgisi bulunmuyor.'}</p>
                        <hr>
                        <p class="mb-0 text-muted small"><i class="bi bi-calendar-check"></i> Kayıt Tarihi: 
                            <fmt:formatDate value="${customer.createdAt}" pattern="dd.MM.yyyy" />
                        </p>
                    </div>
                </div>
            </div>

            <!-- Sipariş Geçmişi Tablosu -->
            <div class="col-md-8 mb-4">
                <div class="card shadow-sm border-0 h-100">
                    <div class="card-header bg-success text-white fw-bold">
                        <i class="bi bi-bag-check me-2"></i> Müşterinin Sipariş Geçmişi
                    </div>
                    <div class="card-body p-0">
                        <table class="table table-hover m-0">
                            <thead class="table-light">
                                <tr>
                                    <th class="ps-3">Sipariş No</th>
                                    <th>Tarih</th>
                                    <th>Tutar</th>
                                    <th>Durum</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="order" items="${customerOrders}">
                                    <tr>
                                        <td class="ps-3 fw-bold">#ORD-${order.id}</td>
                                        <td><fmt:formatDate value="${order.orderDate}" pattern="dd.MM.yyyy HH:mm" /></td>
                                        <td class="fw-bold text-success">
                                            <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₺"/>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${order.status == 'Beklemede'}"><span class="badge bg-warning text-dark">${order.status}</span></c:when>
                                                <c:when test="${order.status == 'Tamamlandı'}"><span class="badge bg-success">${order.status}</span></c:when>
                                                <c:otherwise><span class="badge bg-secondary">${order.status}</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty customerOrders}">
                                    <tr>
                                        <td colspan="4" class="text-center py-4 text-muted">Müşterinin henüz siparişi bulunmamaktadır.</td>
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