<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <title>Siparişlerim - E-Ticaret</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

    <!--Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4 py-3">
        <div class="container">
            <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/home">🛒 Benim E-Ticaret Sitem</a>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto align-items-center">
                    <li class="nav-item">
                        <a class="nav-link text-white me-3" href="cart">Sepetim</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white active fw-bold me-3" href="my-orders">Siparişlerim</a>
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
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Siparişler Tablosu -->
    <div class="container mt-5">
        <h2 class="mb-4">Geçmiş Siparişlerim</h2>

        <c:choose>
            <c:when test="${empty myOrders}">
                <div class="alert alert-info text-center py-4 shadow-sm">
                    <h4>Henüz bir siparişiniz bulunmamaktadır.</h4>
                    <a href="home" class="btn btn-primary mt-3">Alışverişe Başla</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="card shadow-sm border-0">
                    <div class="card-body p-0">
                        <table class="table table-hover m-0">
                            <thead class="table-light">
                                <tr>
                                    <th class="ps-4">Sipariş No</th>
                                    <th>Tarih</th>
                                    <th>Toplam Tutar</th>
                                    <th>Durum</th>
                                    <th class="pe-4 text-end">İşlem</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="order" items="${myOrders}">
                                    <tr>
                                        <td class="ps-4 align-middle fw-bold">#ORD-${order.id}</td>
                                        <td class="align-middle">
                                            <fmt:formatDate value="${order.orderDate}" pattern="dd.MM.yyyy HH:mm" />
                                        </td>
                                        <td class="align-middle text-success fw-bold">
                                            <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₺"/>
                                        </td>
                                        <td class="align-middle">                                          
                                            <c:choose>
                                                <c:when test="${order.status == 'Beklemede'}">
                                                    <span class="badge bg-warning text-dark px-2 py-1">${order.status}</span>
                                                </c:when>
                                                <c:when test="${order.status == 'Tamamlandı'}">
                                                    <span class="badge bg-success px-2 py-1">${order.status}</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary px-2 py-1">${order.status}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="pe-4 align-middle text-end">
                                            <a href="orderDetail?id=${order.id}" class="btn btn-sm btn-outline-primary">Detay</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

</body>
</html>