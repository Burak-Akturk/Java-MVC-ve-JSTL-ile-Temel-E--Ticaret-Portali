<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kayıt Ol</title>
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
            <h3 class="text-center mb-4">Yeni Hesap Oluştur</h3>
            
            <c:if test="${not empty errorMsg}">
                <div class="alert alert-danger">${errorMsg}</div>
            </c:if>

            <form action="register" method="post">
                <div class="mb-3">
                    <input type="text" name="fullName" class="form-control" placeholder="Ad Soyad" required>
                </div>
                <div class="mb-3">
                    <input type="email" name="email" class="form-control" placeholder="E-posta" required>
                </div>
                <div class="mb-3">
                    <input type="password" name="password" class="form-control" placeholder="Şifre" required>
                </div>
                <div class="mb-3">
                    <input type="text" name="phone" class="form-control" placeholder="Telefon (İsteğe Bağlı)">
                </div>
                <div class="mb-3">
                    <textarea name="address" class="form-control" placeholder="Adres (İsteğe Bağlı)"></textarea>
                </div>
                <button type="submit" class="btn btn-primary w-100">Kayıt Ol</button>
            </form>
            
            <div class="text-center mt-3">
                <a href="login.jsp" class="text-decoration-none">Zaten hesabın var mı? Giriş yap.</a>
            </div>
        </div>
    </div>

</body>
</html>