<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${pageTitle}</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <style>
        /* CSS tùy chỉnh cho card và carousel */
        .card-img-top-fixed {
            height: 200px;
            object-fit: cover;
        }
        
        .carousel-item img {
            height: 500px; /* Chiều cao cố định cho slider */
            object-fit: cover;
            filter: brightness(0.7); /* Thêm lớp phủ tối để chữ nổi bật */
        }

        /* Hiệu ứng hover cho card (Giống trang Shop) */
        .card {
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important;
        }
    </style>
</head>

<body class="bg-light d-flex flex-column min-vh-100">

    <header class="navbar navbar-expand-lg navbar-dark bg-danger shadow-sm">
        <div class="container-fluid">
            <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/articles">
                <img src="${pageContext.request.contextPath}/assets/images/bayern-logo.png" alt="Logo" style="height: 40px; width: 40px;" class="rounded-circle bg-white p-1 me-2">
                <span class="fw-bold fs-5">FC Bayern Munich</span>
            </a>
            <div class="d-flex align-items-center ms-auto">
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <span class="navbar-text me-3 d-none d-md-block">
                            Welcome, ${sessionScope.user.fullName}!
                        </span>
                        <a href="${pageContext.request.contextPath}/LogoutServlet" class="btn btn-light text-danger fw-semibold me-2">
                            Logout
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-light text-danger fw-semibold me-2">
                            Login
                        </a>
                    </c:otherwise>
                </c:choose>
                <a href="${pageContext.request.contextPath}/CartServlet?action=view" class="btn btn-light text-danger fw-semibold position-relative">
                    🛒
                    <c:if test="${not empty sessionScope.cart}">
                        <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-warning text-dark">
                            ${sessionScope.cart.size()}
                        </span>
                    </c:if>
                </a>
            </div>
        </div>
    </header>

    <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm border-bottom sticky-top">
        <div class="container-fluid">
            <div class="navbar-nav">
                <a class="nav-link" href="${pageContext.request.contextPath}/TeamServlet?action=list">👥 Teams</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/MatchServlet?action=list">⚽ Matches</a>
                <a class="nav-link active fw-bold text-danger" href="${pageContext.request.contextPath}/articles">📰 News</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/shop">🛍️ Shop</a>
                <c:if test="${sessionScope.user != null && sessionScope.user.role == 'ADMIN'}">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin">⚙️ Admin Panel</a>
                </c:if>
            </div>
        </div>
    </nav>

    <c:if test="${not empty hotNewsList}">
        <div id="hotNewsCarousel" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-indicators">
                <c:forEach items="${hotNewsList}" varStatus="loop">
                    <button type="button" data-bs-target="#hotNewsCarousel" data-bs-slide-to="${loop.index}" 
                            class="${loop.first ? 'active' : ''}" 
                            aria-current="${loop.first ? 'true' : 'false'}" 
                            aria-label="Slide ${loop.count}">
                    </button>
                </c:forEach>
            </div>
            
            <div class="carousel-inner">
                <c:forEach items="${hotNewsList}" var="hotArticle" varStatus="loop">
                    <div class="carousel-item ${loop.first ? 'active' : ''}" data-bs-interval="5000">
                        <img src="${pageContext.request.contextPath}/assets/${hotArticle.imageUrl}" class="d-block w-100" alt="${hotArticle.title}">
                        <div class="carousel-caption d-none d-md-block text-start mb-4">
                            <h5><span class="badge bg-danger">${hotArticle.category}</span></h5>
                            <h2 class="fw-bold">${hotArticle.title}</h2>
                            <a href="${hotArticle.link}" target="_blank" class="btn btn-light text-danger fw-semibold">
                                Đọc ngay
                            </a>
                        </div>
                    </div>
                </c:forEach>
            </div>
            
            <button class="carousel-control-prev" type="button" data-bs-target="#hotNewsCarousel" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#hotNewsCarousel" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>
    </c:if>

    <main class="container my-5">
        <h2 class="mb-4 fw-bold">Tin Tức Mới Nhất</h2>
        
        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4">
            <c:if test="${empty listA}">
                <div class="col-12">
                    <p class="text-muted">Không có bài báo nào để hiển thị.</p>
                </div>
            </c:if>

            <c:forEach var="article" items="${listA}">
                <div class="col">
                    <div class="card h-100 shadow-sm">
                        <img src="${pageContext.request.contextPath}/assets/${article.imageUrl}" class="card-img-top card-img-top-fixed" alt="${article.title}">
                        <div class="card-body d-flex flex-column">
                            <div class="mb-2">
                                <strong class="text-danger small">${article.category}</strong> | 
                                <span class="text-muted small"><fmt:formatDate value="${article.createdAt}" pattern="dd/MM/yyyy" /></span>
                            </div>
                            <h5 class="card-title fw-bold text-dark text-truncate" title="${article.title}">
                                ${article.title}
                            </h5>
                            <p class="card-text text-muted small flex-grow-1">${article.description}</p>
                            
                            <a href="${article.link}" target="_blank"
                               class="btn btn-dark w-100 fw-medium mt-auto">
                                Đọc thêm
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </main>

    <c:if test="${totalPages > 1}">
        <nav aria-label="Page navigation" class="mt-4 mb-5">
            <ul class="pagination justify-content-center">
                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                    <a class="page-link" href="articles?page=${currentPage - 1}" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </a>
                </li>
                
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                        <a class="page-link" href="articles?page=${i}">${i}</a>
                    </li>
                </c:forEach>
                
                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                    <a class="page-link" href="articles?page=${currentPage + 1}" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>
            </ul>
        </nav>
    </c:if>

    <footer class="text-center py-4 text-muted border-top mt-auto">
        © 2025 Bayern Munich. All rights reserved.
    </footer>

    </body>
</html>