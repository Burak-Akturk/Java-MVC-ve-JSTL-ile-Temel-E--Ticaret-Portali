<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giriş Yap - E-Ticaret</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/home">🛒 Benim E-Ticaret Sitem</a>
        </div>
    </nav>

    <div class="container mt-5">
        <div class="card shadow p-4 mx-auto" style="max-width: 500px;">
            <h3 class="text-center mb-4">Sisteme Giriş Yap</h3>
            
            <c:if test="${not empty param.success}">
                <div class="alert alert-success text-center">
                    Kayıt işleminiz başarıyla tamamlandı! Şimdi giriş yapabilirsiniz.
                </div>
            </c:if>

            <c:if test="${not empty errorMsg}">
                <div class="alert alert-danger text-center">${errorMsg}</div>
            </c:if>

            <!-- Giriş Formu -->
            <form action="login" method="post">
                <div class="mb-3">
                    <label class="form-label text-muted small fw-bold">E-posta Adresi</label>
                    <input type="email" name="email" class="form-control" placeholder="E-posta adresinizi giriniz" required>
                </div>
                <div class="mb-3">
                    <label class="form-label text-muted small fw-bold">Şifre</label>
                    <input type="password" name="password" class="form-control" placeholder="Şifrenizi giriniz" required>
                </div>
                <button type="submit" class="btn btn-primary w-100 py-2 mt-2">Giriş Yap</button>
            </form>
            
            <div class="text-center mt-4">
                <a href="register.jsp" class="text-decoration-none">Henüz hesabın yok mu? Hemen kayıt ol.</a>
            </div>
        </div>
    </div>

</body>
</html>