<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${empty sessionScope.user or sessionScope.user.role != 'ADMIN'}">
    <c:redirect url="../login.jsp"/>
</c:if>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <title>Yeni Ürün Ekle - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

    <div class="container mt-5">
        <div class="card shadow-sm mx-auto" style="max-width: 600px;">
            <div class="card-header bg-success text-white">
                <h4 class="mb-0">Yeni Ürün Ekle</h4>
            </div>
            <div class="card-body p-4">
                
                <c:if test="${not empty errorMsg}">
                    <div class="alert alert-danger">${errorMsg}</div>
                </c:if>

                <form action="adminProductAdd" method="post">
                    <div class="mb-3">
                        <label class="form-label fw-bold">Ürün Adı</label>
                        <input type="text" name="name" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-bold">Kategori</label>
                        <select name="categoryId" class="form-select" required>
                            <option value="">Lütfen Bir Kategori Seçin</option>
                            <c:forEach var="category" items="${categoryList}">
                                <option value="${category.id}">${category.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-bold">Fiyat (₺)</label>
                        <input type="number" step="0.01" name="price" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-bold">Stok Adedi</label>
                        <input type="number" name="stock" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-bold">Görsel URL (İsteğe Bağlı)</label>
                        <input type="text" name="imageUrl" class="form-control">
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-bold">Açıklama</label>
                        <textarea name="description" class="form-control" rows="3" required></textarea>
                    </div>
                    <div class="form-check mb-4">
                        <input class="form-check-input" type="checkbox" name="isActive" id="isActive" checked>
                        <label class="form-check-label fw-bold" for="isActive">
                            Ürün Aktif (Sitede Görünsün)
                        </label>
                    </div>
                    
                    <div class="d-flex justify-content-between">
                        <a href="adminProducts" class="btn btn-secondary">İptal ve Geri Dön</a>
                        <button type="submit" class="btn btn-success">Ürünü Kaydet</button>
                    </div>
                </form>

            </div>
        </div>
    </div>

</body>
</html>