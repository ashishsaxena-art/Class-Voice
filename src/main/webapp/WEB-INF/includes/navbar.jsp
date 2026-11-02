<nav class="navbar navbar-dark navbar-expand-lg cv-navbar sticky-top" aria-label="Main navigation">
  <div class="container cv-nav-inner">
    <a class="navbar-brand cv-brand d-inline-flex align-items-center gap-2" href="${pageContext.request.contextPath}/index.jsp">
      <span class="cv-brand-icon" aria-hidden="true"><i class="bi bi-soundwave"></i></span>
      <span>Class<span class="cv-accent">Voice</span></span>
    </a>
    <button class="navbar-toggler cv-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#cvNav" aria-controls="cvNav" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
    <div class="collapse navbar-collapse" id="cvNav">
      <ul class="navbar-nav ms-auto align-items-lg-center gap-lg-2 py-2 py-lg-0">
        <c:choose>
          <c:when test="${not empty sessionScope.user}">
            <c:choose>
              <c:when test="${sessionScope.user.role == 'teacher'}">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/teacher/dashboard"><i class="bi bi-grid-1x2 me-1"></i> Dashboard</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/teacher/create"><i class="bi bi-plus-circle me-1"></i> New lecture</a></li>
              </c:when>
              <c:otherwise>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/student/dashboard"><i class="bi bi-grid-1x2 me-1"></i> Dashboard</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/student/history"><i class="bi bi-clock-history me-1"></i> My history</a></li>
              </c:otherwise>
            </c:choose>
            <li class="nav-item"><span class="cv-user-chip"><i class="bi bi-person-circle me-1"></i> <c:out value="${sessionScope.user.name}"/></span></li>
            <li class="nav-item"><a class="btn btn-outline-dark btn-sm cv-nav-action" href="${pageContext.request.contextPath}/logout">Sign out <i class="bi bi-box-arrow-right ms-1"></i></a></li>
          </c:when>
          <c:otherwise>
            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/index.jsp#how-it-works">How it works</a></li>
            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/login.jsp">Sign in</a></li>
            <li class="nav-item"><a class="btn btn-primary btn-sm cv-nav-action" href="${pageContext.request.contextPath}/register.jsp">Get started <i class="bi bi-arrow-up-right ms-1"></i></a></li>
          </c:otherwise>
        </c:choose>
      </ul>
    </div>
  </div>
</nav>
