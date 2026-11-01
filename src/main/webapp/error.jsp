<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Something went wrong"/>
<!doctype html><html lang="en"><head><%@ include file="/WEB-INF/includes/head.jsp" %></head><body class="cv-page"><%@ include file="/WEB-INF/includes/navbar.jsp" %>
<main class="container cv-top-shell d-flex align-items-center"><div class="row justify-content-center w-100"><div class="col-lg-7 text-center cv-entrance"><div class="cv-icon-soft violet mx-auto mb-3" style="width:78px;height:78px;font-size:2rem"><i class="bi bi-exclamation-circle"></i></div><span class="cv-overline">UNEXPECTED ERROR</span><h1 class="display-6 fw-bold mt-2">Well, that wasn't supposed to happen.</h1><p class="text-secondary mt-3">We couldn't complete your request. Please go back or try again.</p><a class="btn btn-primary mt-2" href="${pageContext.request.contextPath}/index.jsp"><i class="bi bi-house-door me-2"></i> Back to ClassVoice</a></div></div></main>
<%@ include file="/WEB-INF/includes/footer.jsp" %></body></html>
