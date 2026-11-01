<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Sign in"/>
<!doctype html>
<html lang="en"><head><%@ include file="/WEB-INF/includes/head.jsp" %></head>
<body class="cv-page"><%@ include file="/WEB-INF/includes/navbar.jsp" %>
<main class="cv-auth-section"><div class="container"><div class="row align-items-center justify-content-center g-5">
  <div class="col-lg-5 d-none d-lg-block cv-entrance">
    <div class="cv-auth-aside"><div class="cv-auth-mark mb-4"><i class="bi bi-soundwave"></i></div>
    <h2>Your classroom.<br>Your voice.<br><span style="color:#a8ffee">Your space.</span></h2>
    <p class="mt-3">Good questions make great classrooms. Pick up right where you left off.</p>
    <div class="cv-auth-check"><i class="bi bi-check-circle-fill"></i> Thoughtful feedback, made simple</div>
    <div class="cv-auth-check"><i class="bi bi-check-circle-fill"></i> Secure account-based access</div>
    <div class="cv-auth-check"><i class="bi bi-check-circle-fill"></i> Insights that lead to understanding</div>
    </div>
  </div>
  <div class="col-md-8 col-lg-6 col-xl-5 cv-entrance cv-entrance-2"><div class="cv-auth-card"><div class="cv-auth-body p-md-5">
    <div class="cv-auth-icon"><i class="bi bi-box-arrow-in-right"></i></div>
    <span class="cv-overline">WELCOME BACK</span><h1 class="mt-2 mb-2">Good to see you again.</h1>
    <p class="cv-auth-subtitle mb-4">Sign in to your teacher or student space.</p>
    <c:if test="${param.registered == '1'}"><div class="alert alert-success" role="status"><i class="bi bi-check-circle me-2"></i>Registration complete. You can sign in now.</div></c:if>
    <c:if test="${param.error == 'login-required'}"><div class="alert alert-warning" role="alert"><i class="bi bi-info-circle me-2"></i>Please sign in to access that page.</div></c:if>
    <c:if test="${not empty error}"><div class="alert alert-danger" role="alert"><i class="bi bi-exclamation-triangle me-2"></i><c:out value="${error}"/></div></c:if>
    <form method="post" action="${pageContext.request.contextPath}/login">
      <div class="mb-3"><label class="form-label" for="loginEmail">Email address</label><div class="input-group"><span class="input-group-text cv-input-icon"><i class="bi bi-envelope"></i></span><input id="loginEmail" class="form-control" type="email" name="email" placeholder="you@example.com" required maxlength="190" autocomplete="email"></div></div>
      <div class="mb-4"><label class="form-label" for="loginPassword">Password</label><div class="input-group"><span class="input-group-text cv-input-icon"><i class="bi bi-lock"></i></span><input id="loginPassword" class="form-control" type="password" name="password" placeholder="Enter your password" required maxlength="100" autocomplete="current-password"><button type="button" class="input-group-text cv-password-toggle" data-password-toggle="loginPassword" aria-label="Show password" aria-pressed="false"><i class="bi bi-eye"></i></button></div></div>
      <button type="submit" class="btn btn-primary w-100 py-3">Sign in <i class="bi bi-arrow-right ms-2"></i></button>
    </form>
    <p class="text-center text-secondary small mt-4 mb-3">New to ClassVoice? <a class="fw-bold text-decoration-none" href="${pageContext.request.contextPath}/register.jsp">Create an account</a></p>
    <div class="cv-auth-note"><i class="bi bi-lightbulb me-2 cv-accent"></i>Trying the demo? Sample login details are in <strong>docs/DEMO_ACCOUNTS.md</strong> of your project.</div>
  </div></div></div>
</div></div></main><%@ include file="/WEB-INF/includes/footer.jsp" %></body></html>
