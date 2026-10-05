<nav class="navbar navbar-expand-lg bg-white border-bottom sticky-top">
 <div class="container"><a class="navbar-brand fw-bold cv-brand" href="${pageContext.request.contextPath}/index.jsp">ClassVoice</a>
 <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#nav"><span class="navbar-toggler-icon"></span></button>
 <div class="collapse navbar-collapse" id="nav"><ul class="navbar-nav ms-auto align-items-lg-center gap-lg-2">
  <c:if test="${not empty sessionScope.user}"><li class="nav-item"><span class="nav-link text-secondary">Hi, ${sessionScope.user.name}</span></li><li class="nav-item"><a class="btn btn-sm btn-outline-dark" href="${pageContext.request.contextPath}/logout">Logout</a></li></c:if>
  <c:if test="${empty sessionScope.user}"><li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/login.jsp">Login</a></li><li class="nav-item"><a class="btn btn-sm btn-dark" href="${pageContext.request.contextPath}/register.jsp">Register</a></li></c:if>
 </ul></div></div>
</nav>
