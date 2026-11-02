<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Give Feedback"/>
<!doctype html><html lang="en"><head><%@ include file="../includes/head.jsp" %></head><body class="cv-page"><%@ include file="../includes/navbar.jsp" %>
<main class="container cv-top-shell"><div class="row justify-content-center"><div class="col-lg-8 cv-entrance"><a class="cv-back-link" href="${pageContext.request.contextPath}/student/dashboard"><i class="bi bi-arrow-left"></i> Back to lectures</a>
<div class="card cv-card"><div class="card-body p-4 p-md-5"><div class="d-flex justify-content-between align-items-start gap-3 flex-wrap"><div><span class="cv-page-tag"><i class="bi bi-chat-left-dots"></i> YOUR FEEDBACK</span><h1 class="h3 fw-bold mt-3"><c:out value="${lecture.title}"/></h1></div><c:choose><c:when test="${lecture.active}"><span class="cv-status cv-status-live">Open</span></c:when><c:otherwise><span class="cv-status cv-status-idle">Closed</span></c:otherwise></c:choose></div>
<p class="text-secondary"><c:out value="${lecture.description}"/></p><hr class="my-4">
<div class="cv-question-card mb-4"><span class="cv-overline">A QUESTION WORTH ASKING</span><h2 class="mt-2 mb-2">What did you not understand in today's lecture?</h2><p class="text-secondary small mb-0">Share what felt confusing. We'll connect it with a topic so your teacher can see what needs attention.</p></div>
<c:if test="${not empty error}"><div class="alert alert-danger" role="alert"><c:out value="${error}"/></div></c:if>
<form method="post" action="${pageContext.request.contextPath}/student/feedback"><input type="hidden" name="lectureId" value="${lecture.lectureId}">
<div class="cv-reaction-area mb-4" aria-label="Quick feedback prompts">
 <div class="cv-reaction-label"><i class="bi bi-emoji-smile me-2"></i>Express how the lecture felt <span class="cv-reaction-helper">(adds text you can edit)</span></div>
 <div class="cv-reaction-list">
   <button type="button" class="cv-reaction-choice" data-reaction-text="I need more clarity on this topic. "><span aria-hidden="true">🤔</span> Need clarity</button>
   <button type="button" class="cv-reaction-choice" data-reaction-text="Could we go through another example? "><span aria-hidden="true">💡</span> More examples</button>
   <button type="button" class="cv-reaction-choice" data-reaction-text="I understood the lecture well. "><span aria-hidden="true">🙌</span> Understood</button>
 </div>
</div>
<label for="feedbackText" class="form-label">Your feedback</label><textarea id="feedbackText" class="form-control" name="feedbackText" maxlength="1000" rows="6" placeholder="For example: Could we go through another example of 2NF and 3NF?" required><c:out value="${feedbackTextValue}"/></textarea>
<div class="d-flex justify-content-between small text-secondary mt-2"><span id="charCounter" aria-live="polite">0/1000</span><span>Keep it clear and specific.</span></div>
<div class="cv-anonymity my-4"><i class="bi bi-shield-check"></i> Your teacher sees the feedback text and topic, not your name alongside it.</div>
<button class="btn btn-primary w-100 py-3" type="submit" ${lecture.active ? '' : 'disabled'}>Submit feedback <i class="bi bi-send ms-2"></i></button></form></div></div></div></div>
</main><%@ include file="../includes/footer.jsp" %></body></html>
