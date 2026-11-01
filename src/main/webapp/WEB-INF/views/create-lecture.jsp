<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Create Lecture"/>
<!doctype html><html lang="en"><head><%@ include file="../includes/head.jsp" %></head><body class="cv-page"><%@ include file="../includes/navbar.jsp" %>
<main class="container cv-top-shell"><div class="row justify-content-center"><div class="col-lg-8 col-xl-7 cv-entrance">
<a class="cv-back-link" href="${pageContext.request.contextPath}/teacher/dashboard"><i class="bi bi-arrow-left"></i> Back to dashboard</a>
<div class="card cv-card"><div class="card-body p-4 p-md-5"><div class="cv-icon-soft violet mb-3"><i class="bi bi-journal-plus"></i></div><span class="cv-overline">NEW LECTURE</span><h1 class="h3 fw-bold mt-2">Create a learning session</h1><p class="text-secondary mb-4">Add the details first. You'll set up topics and keywords in the next step.</p>
<c:if test="${not empty error}"><div class="alert alert-danger" role="alert"><c:out value="${error}"/></div></c:if>
<form method="post" action="${pageContext.request.contextPath}/teacher/lecture/create"><div class="mb-3"><label for="lectureTitle" class="form-label">Lecture title</label><input id="lectureTitle" class="form-control" name="title" maxlength="180" placeholder="e.g. Database Management Systems" required></div>
<div class="mb-3"><label for="lectureDate" class="form-label">Lecture date</label><input id="lectureDate" class="form-control" type="date" name="lectureDate" value="<c:out value='${param.lectureDate}'/>" required></div>
<div class="mb-4"><label for="lectureDescription" class="form-label">Description <span class="fw-normal text-secondary">(optional)</span></label><textarea id="lectureDescription" class="form-control" name="description" maxlength="500" rows="4" placeholder="What will students learn in this lecture?"></textarea></div>
<button class="btn btn-primary w-100 py-3" type="submit">Create and add topics <i class="bi bi-arrow-right ms-2"></i></button>
</form></div></div></div></div></main><%@ include file="../includes/footer.jsp" %></body></html>
