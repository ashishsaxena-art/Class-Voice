<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Speak up. Learn better."/>
<!doctype html>
<html lang="en">
<head><%@ include file="/WEB-INF/includes/head.jsp" %></head>
<body class="cv-page cv-home">
<%@ include file="/WEB-INF/includes/navbar.jsp" %>
<main>
  <section class="cv-hero position-relative overflow-hidden">
    <div class="cv-orb cv-orb-one" aria-hidden="true"></div><div class="cv-orb cv-orb-two" aria-hidden="true"></div>
    <div class="container position-relative py-5 py-lg-6">
      <div class="row align-items-center g-5">
        <div class="col-lg-6">
          <div class="cv-entrance"><span class="cv-eyebrow"><span class="cv-pulse-dot"></span> A smarter classroom starts here</span></div>
          <h1 class="cv-hero-title cv-entrance cv-entrance-2 mt-4">Every student has a <span class="cv-gradient-text">voice.</span><br>Every voice can <span class="cv-gradient-text">matter.</span></h1>
          <p class="cv-hero-copy cv-entrance cv-entrance-3 mt-4">Turn the moments you didn't understand into meaningful feedback. ClassVoice helps students speak freely and teachers discover what needs a second look.</p>
          <div class="d-flex flex-wrap align-items-center gap-3 mt-4 cv-entrance cv-entrance-4">
            <a class="btn btn-primary btn-lg cv-btn-glow" href="${pageContext.request.contextPath}/register.jsp">Start for free <i class="bi bi-arrow-up-right ms-2"></i></a>
            <a class="btn btn-light btn-lg cv-btn-outline" href="${pageContext.request.contextPath}/login.jsp"><i class="bi bi-box-arrow-in-right me-2"></i> Sign in</a>
          </div>
          <div class="d-flex flex-wrap gap-4 cv-hero-details cv-entrance cv-entrance-4 mt-4 pt-2"><span><i class="bi bi-shield-check me-2"></i>Identity not shown to teachers</span><span><i class="bi bi-lightning-charge me-2"></i>Instant topic insights</span></div>
        </div>
        <div class="col-lg-6 cv-entrance cv-entrance-3">
          <div class="cv-preview-stage">
            <div class="cv-preview-glow" aria-hidden="true"></div>
            <div class="cv-floating-tag cv-tag-top"><span class="cv-icon-soft mint"><i class="bi bi-stars"></i></span> Clarity, one topic at a time</div>
            <div class="cv-preview-card">
              <div class="cv-preview-head d-flex align-items-center justify-content-between gap-2"><div class="d-flex align-items-center gap-2"><span class="cv-icon-soft violet"><i class="bi bi-soundwave"></i></span><div><div class="fw-bold">Lecture insights</div><div class="cv-subtext">Database Management System</div></div></div><span class="cv-live-pill"><span class="cv-pulse-dot"></span> Live</span></div>
              <div class="cv-preview-body"><div class="cv-preview-subtitle">Today's learning pulse</div><div class="row g-3 my-1"><div class="col-6"><div class="cv-preview-stat"><div class="cv-stat-icon violet"><i class="bi bi-chat-left-text"></i></div><strong>24</strong><span>Responses</span></div></div><div class="col-6"><div class="cv-preview-stat"><div class="cv-stat-icon mint"><i class="bi bi-bookmark-check"></i></div><strong>4</strong><span>Topics tracked</span></div></div></div>
                <div class="d-flex justify-content-between align-items-center mt-4 mb-3"><h2 class="h6 fw-bold mb-0">Topics needing clarity</h2><span class="cv-subtext">Illustrative example</span></div>
                <div class="cv-bar-row"><div><span>Normalization</span><strong>72%</strong></div><div class="cv-bar-track"><span style="--bar-width:72%;--bar-color:#6659eb"></span></div></div>
                <div class="cv-bar-row"><div><span>SQL Joins</span><strong>48%</strong></div><div class="cv-bar-track"><span style="--bar-width:48%;--bar-color:#19bca8"></span></div></div>
                <div class="cv-bar-row"><div><span>Transactions</span><strong>26%</strong></div><div class="cv-bar-track"><span style="--bar-width:26%;--bar-color:#f0b56e"></span></div></div>
              </div>
              <div class="cv-preview-foot"><span class="cv-foot-avatar"><i class="bi bi-chat-heart"></i></span><div><strong>“I need another example of 2NF and 3NF.”</strong><small>Feedback mapped to: Normalization</small></div><i class="bi bi-check-circle-fill ms-auto cv-accent"></i></div>
            </div>
            <div class="cv-floating-tag cv-tag-bottom"><i class="bi bi-check-circle-fill cv-green me-2"></i> Feedback received!</div>
          </div>
        </div>
      </div>
    </div>
  </section>

  <section id="how-it-works" class="cv-section cv-section-white">
    <div class="container">
      <div class="text-center mx-auto cv-section-heading cv-reveal"><span class="cv-section-kicker">SIMPLE BY DESIGN</span><h2>Feedback that's actually <span class="cv-gradient-text">useful.</span></h2><p>Three easy steps to make every lecture a little better.</p></div>
      <div class="row g-4 mt-3">
        <div class="col-md-4 cv-reveal"><div class="cv-step-card h-100"><div class="cv-step-top"><span class="cv-step-number">01</span><span class="cv-feature-icon violet"><i class="bi bi-journal-plus"></i></span></div><h3>Teacher creates a lecture</h3><p>Add the topics and keywords that matter for the session. Ready to hear from your class.</p><div class="cv-step-bottom"><span>Set the context</span><i class="bi bi-arrow-right"></i></div></div></div>
        <div class="col-md-4 cv-reveal"><div class="cv-step-card h-100"><div class="cv-step-top"><span class="cv-step-number">02</span><span class="cv-feature-icon mint"><i class="bi bi-chat-left-dots"></i></span></div><h3>Students share what's unclear</h3><p>Write honest feedback in your own words. No pressure, just a better way to be heard.</p><div class="cv-step-bottom"><span>Share your thoughts</span><i class="bi bi-arrow-right"></i></div></div></div>
        <div class="col-md-4 cv-reveal"><div class="cv-step-card h-100"><div class="cv-step-top"><span class="cv-step-number">03</span><span class="cv-feature-icon peach"><i class="bi bi-graph-up-arrow"></i></span></div><h3>Turn feedback into action</h3><p>See which topics need attention, then make the next explanation even clearer.</p><div class="cv-step-bottom"><span>See the insights</span><i class="bi bi-arrow-right"></i></div></div></div>
      </div>
    </div>
  </section>
  <section class="cv-section cv-section-soft">
    <div class="container"><div class="row g-5 align-items-center"><div class="col-lg-6 cv-reveal"><div class="cv-feature-panel"><div class="cv-feature-panel-icon"><i class="bi bi-shield-lock"></i></div><div class="cv-feature-panel-quote">A thoughtful classroom is one where everyone feels comfortable saying <em>“I didn't get that.”</em></div><div class="d-flex align-items-center gap-2 mt-4"><span class="cv-pulse-dot"></span><span class="small text-white-50">Privacy-focused feedback</span></div><div class="cv-feature-deco cv-deco-one"></div><div class="cv-feature-deco cv-deco-two"></div></div></div>
      <div class="col-lg-6 cv-reveal"><span class="cv-section-kicker">MADE FOR REAL LEARNING</span><h2 class="cv-section-title mt-3">Small feedback. <span class="cv-gradient-text">Big understanding.</span></h2><p class="text-secondary mt-3">No complicated surveys. No guessing what the class needs. Just clear signals that help students and teachers move forward together.</p>
        <div class="cv-benefit"><span class="cv-benefit-icon"><i class="bi bi-incognito"></i></span><div><strong>Private by design</strong><p>Teacher-facing analysis doesn't display the student's identity alongside feedback.</p></div></div>
        <div class="cv-benefit"><span class="cv-benefit-icon"><i class="bi bi-bar-chart-line"></i></span><div><strong>See topic-level trends</strong><p>Understand common pain points with clear counts and percentages.</p></div></div>
        <div class="cv-benefit"><span class="cv-benefit-icon"><i class="bi bi-magic"></i></span><div><strong>Keep things simple</strong><p>Rule-based keyword matching makes feedback easy to organize and review.</p></div></div>
      </div></div></div>
  </section>
  <section class="cv-section cv-section-white"><div class="container"><div class="cv-cta-banner text-center cv-reveal"><span class="cv-eyebrow cv-eyebrow-light"><i class="bi bi-stars me-2"></i> Build better classrooms</span><h2 class="mt-3">Great learning begins with <em>being heard.</em></h2><p>Join ClassVoice and start turning questions into clarity.</p><a class="btn btn-light btn-lg mt-3" href="${pageContext.request.contextPath}/register.jsp">Get started <i class="bi bi-arrow-up-right ms-2"></i></a></div></div></section>
</main>
<%@ include file="/WEB-INF/includes/footer.jsp" %>
</body>
</html>
