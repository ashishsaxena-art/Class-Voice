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
        <div class="col-lg-6 cv-entrance cv-entrance-right cv-entrance-3">
          <div class="cv-preview-stage">
            <div class="cv-preview-glow" aria-hidden="true"></div>
            <div class="cv-preview-card" aria-label="Example lecture dashboard">
              <div class="cv-preview-head d-flex align-items-center justify-content-between gap-2"><div class="d-flex align-items-center gap-2"><span class="cv-icon-soft violet"><i class="bi bi-soundwave"></i></span><div><div class="fw-bold">Lecture insights</div><div class="cv-subtext">Database Management System</div></div></div><span class="cv-live-pill"><span class="cv-pulse-dot"></span> Live</span></div>
              <div class="cv-preview-body"><div class="cv-preview-subtitle">Today's learning pulse</div><div class="row g-3 my-1"><div class="col-6"><div class="cv-preview-stat"><div class="cv-stat-icon violet"><i class="bi bi-chat-left-text"></i></div><strong>24</strong><span>Responses</span></div></div><div class="col-6"><div class="cv-preview-stat"><div class="cv-stat-icon mint"><i class="bi bi-bookmark-check"></i></div><strong>4</strong><span>Topics tracked</span></div></div></div>
                <div class="d-flex justify-content-between align-items-center mt-4 mb-3"><h2 class="h6 fw-bold mb-0">Topics needing clarity</h2><span class="cv-subtext">Illustrative example</span></div>
                <div class="cv-bar-row"><div><span>Normalization</span><strong>72%</strong></div><div class="cv-bar-track"><span style="--bar-width:72%;--bar-color:#6659eb"></span></div></div>
                <div class="cv-bar-row"><div><span>SQL Joins</span><strong>48%</strong></div><div class="cv-bar-track"><span style="--bar-width:48%;--bar-color:#19bca8"></span></div></div>
                <div class="cv-bar-row"><div><span>Transactions</span><strong>26%</strong></div><div class="cv-bar-track"><span style="--bar-width:26%;--bar-color:#f0b56e"></span></div></div>
              </div>
              <div class="cv-preview-foot"><span class="cv-foot-avatar"><i class="bi bi-chat-heart"></i></span><div><strong>“I need another example of 2NF and 3NF.”</strong><small>Feedback mapped to: Normalization</small></div><i class="bi bi-check-circle-fill ms-auto cv-accent"></i></div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>

  <section id="how-it-works" class="cv-section cv-section-white cv-slide-section">
    <div class="container">
      <div class="text-center mx-auto cv-section-heading cv-reveal cv-slide-up">
        <span class="cv-section-kicker">ONE SIMPLE FLOW</span>
        <h2>Three steps. <span class="cv-gradient-text">One better classroom.</span></h2>
        <p>Explore how a lecture becomes useful feedback — slide by slide.</p>
      </div>
      <div class="cv-flow-slider cv-reveal cv-slide-right mt-5" data-cv-slider role="region" aria-roledescription="carousel" aria-label="How ClassVoice works" tabindex="0">
        <div class="cv-flow-viewport">
          <div class="cv-flow-track" data-cv-track>
            <article class="cv-flow-slide" data-cv-slide aria-roledescription="slide" aria-label="Step 1 of 3" id="cv-flow-1">
              <div class="row g-4 g-lg-5 align-items-center">
                <div class="col-lg-5">
                  <span class="cv-flow-index">01 / SET THE STAGE</span>
                  <h3>Start with a <span class="cv-accent">clear lecture.</span></h3>
                  <p>Teachers create a session, add the important topics, and open a space for honest class feedback.</p>
                  <div class="cv-flow-takeaway"><i class="bi bi-check2-circle"></i> Set topics once. Stay focused on teaching.</div>
                </div>
                <div class="col-lg-7">
                  <div class="cv-flow-visual cv-flow-visual-violet" aria-hidden="true">
                    <div class="cv-flow-window">
                      <div class="cv-flow-window-top"><span class="cv-flow-window-icon"><i class="bi bi-journal-bookmark-fill"></i></span><span>Lecture workspace</span><span class="cv-live-pill ms-auto"><span class="cv-pulse-dot"></span> Active</span></div>
                      <div class="cv-flow-window-body"><div class="cv-flow-window-label">CURRENT SESSION</div><div class="cv-flow-window-title">Database Management System</div><div class="cv-flow-subline"><i class="bi bi-calendar3 me-1"></i> Today's lecture <span class="mx-1">·</span> 4 topics</div><div class="cv-flow-taglist"><span>Normalization</span><span>SQL Joins</span><span>Transactions</span><span>+1</span></div><div class="cv-flow-window-action"><i class="bi bi-check-circle-fill me-2"></i>Ready for student feedback</div></div>
                    </div>
                  </div>
                </div>
              </div>
            </article>
            <article class="cv-flow-slide" data-cv-slide aria-roledescription="slide" aria-label="Step 2 of 3" id="cv-flow-2">
              <div class="row g-4 g-lg-5 align-items-center">
                <div class="col-lg-5">
                  <span class="cv-flow-index">02 / BE HEARD</span>
                  <h3>Make every <span class="cv-accent">question count.</span></h3>
                  <p>Students write what they found confusing in their own words. Teacher-facing analysis keeps names out of feedback.</p>
                  <div class="cv-flow-takeaway"><i class="bi bi-check2-circle"></i> A simple, low-pressure way to speak up.</div>
                </div>
                <div class="col-lg-7">
                  <div class="cv-flow-visual cv-flow-visual-mint" aria-hidden="true">
                    <div class="cv-flow-window">
                      <div class="cv-flow-window-top"><span class="cv-flow-window-icon"><i class="bi bi-chat-left-text-fill"></i></span><span>Share feedback</span><i class="bi bi-shield-check ms-auto cv-green"></i></div>
                      <div class="cv-flow-window-body"><div class="cv-flow-window-label">WHAT WAS UNCLEAR?</div><div class="cv-flow-feedback">“I'd love another example to understand the difference between 2NF and 3NF.”<span class="cv-flow-caret"></span></div><div class="cv-flow-window-action"><i class="bi bi-shield-lock me-2"></i>Private in teacher analysis</div></div>
                    </div>
                  </div>
                </div>
              </div>
            </article>
            <article class="cv-flow-slide" data-cv-slide aria-roledescription="slide" aria-label="Step 3 of 3" id="cv-flow-3">
              <div class="row g-4 g-lg-5 align-items-center">
                <div class="col-lg-5">
                  <span class="cv-flow-index">03 / FIND THE PATTERN</span>
                  <h3>Turn feedback <span class="cv-accent">into clarity.</span></h3>
                  <p>See which topics come up most often. Use those signals to make the next explanation more effective.</p>
                  <div class="cv-flow-takeaway"><i class="bi bi-check2-circle"></i> Clear insights, not another messy spreadsheet.</div>
                </div>
                <div class="col-lg-7">
                  <div class="cv-flow-visual cv-flow-visual-blue" aria-hidden="true">
                    <div class="cv-flow-window">
                      <div class="cv-flow-window-top"><span class="cv-flow-window-icon"><i class="bi bi-bar-chart-line-fill"></i></span><span>Topic insights</span><span class="cv-flow-window-label ms-auto">EXAMPLE</span></div>
                      <div class="cv-flow-window-body"><div class="cv-flow-window-title mb-3">Where students need support</div><div class="cv-bar-row"><div><span>Normalization</span><strong>72%</strong></div><div class="cv-bar-track"><span style="--bar-width:72%;--bar-color:#6659eb"></span></div></div><div class="cv-bar-row"><div><span>SQL Joins</span><strong>48%</strong></div><div class="cv-bar-track"><span style="--bar-width:48%;--bar-color:#19bca8"></span></div></div><div class="cv-bar-row mb-0"><div><span>Transactions</span><strong>26%</strong></div><div class="cv-bar-track"><span style="--bar-width:26%;--bar-color:#f0b56e"></span></div></div></div>
                    </div>
                  </div>
                </div>
              </div>
            </article>
          </div>
        </div>
        <div class="cv-flow-controls">
          <div class="cv-flow-step-readout"><span data-cv-step>01</span><span class="cv-flow-readout-sep">/</span>03 <span class="cv-flow-readout-label">Explore the process</span></div>
          <div class="cv-flow-dots" aria-label="Choose a step">
            <button type="button" data-cv-to="0" aria-label="Show step 1" aria-controls="cv-flow-1"></button>
            <button type="button" data-cv-to="1" aria-label="Show step 2" aria-controls="cv-flow-2"></button>
            <button type="button" data-cv-to="2" aria-label="Show step 3" aria-controls="cv-flow-3"></button>
          </div>
          <div class="cv-flow-arrows"><button type="button" data-cv-prev aria-label="Previous step"><i class="bi bi-arrow-left"></i></button><button type="button" data-cv-next aria-label="Next step"><i class="bi bi-arrow-right"></i></button></div>
        </div>
      </div>
    </div>
  </section>
  <section class="cv-section cv-section-soft">
    <div class="container"><div class="row g-5 align-items-center"><div class="col-lg-6 cv-reveal cv-slide-left"><div class="cv-feature-panel"><div class="cv-feature-panel-icon"><i class="bi bi-shield-lock"></i></div><div class="cv-feature-panel-quote">A thoughtful classroom is one where everyone feels comfortable saying <em>“I didn't get that.”</em></div><div class="d-flex align-items-center gap-2 mt-4"><span class="cv-pulse-dot"></span><span class="small text-white-50">Privacy-focused feedback</span></div><div class="cv-feature-deco cv-deco-one"></div><div class="cv-feature-deco cv-deco-two"></div></div></div>
      <div class="col-lg-6 cv-reveal cv-slide-right"><span class="cv-section-kicker">MADE FOR REAL LEARNING</span><h2 class="cv-section-title mt-3">Small feedback. <span class="cv-gradient-text">Big understanding.</span></h2><p class="text-secondary mt-3">No complicated surveys. No guessing what the class needs. Just clear signals that help students and teachers move forward together.</p>
        <div class="cv-benefit"><span class="cv-benefit-icon"><i class="bi bi-incognito"></i></span><div><strong>Private by design</strong><p>Teacher-facing analysis doesn't display the student's identity alongside feedback.</p></div></div>
        <div class="cv-benefit"><span class="cv-benefit-icon"><i class="bi bi-bar-chart-line"></i></span><div><strong>See topic-level trends</strong><p>Understand common pain points with clear counts and percentages.</p></div></div>
        <div class="cv-benefit"><span class="cv-benefit-icon"><i class="bi bi-magic"></i></span><div><strong>Keep things simple</strong><p>Rule-based keyword matching makes feedback easy to organize and review.</p></div></div>
      </div></div></div>
  </section>
  <section class="cv-section cv-section-white"><div class="container"><div class="cv-cta-banner text-center cv-reveal cv-slide-up"><span class="cv-eyebrow cv-eyebrow-light"><i class="bi bi-stars me-2"></i> Build better classrooms</span><h2 class="mt-3">Great learning begins with <em>being heard.</em></h2><p>Join ClassVoice and start turning questions into clarity.</p><a class="btn btn-light btn-lg mt-3" href="${pageContext.request.contextPath}/register.jsp">Get started <i class="bi bi-arrow-up-right ms-2"></i></a></div></div></section>
</main>
<%@ include file="/WEB-INF/includes/footer.jsp" %>
</body>
</html>
