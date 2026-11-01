/** ClassVoice progressive UI enhancements. No framework or build required. */
document.addEventListener('DOMContentLoaded', () => {
  // Keep the original feedback character counter.
  const feedback = document.getElementById('feedbackText');
  const counter = document.getElementById('charCounter');
  if (feedback && counter) {
    const update = () => { counter.textContent = `${feedback.value.length}/1000`; };
    feedback.addEventListener('input', update);
    update();
  }

  // Accessible, optional password visibility toggles.
  document.querySelectorAll('[data-password-toggle]').forEach(button => {
    const target = document.getElementById(button.dataset.passwordToggle);
    if (!target) return;
    button.addEventListener('click', () => {
      const visible = target.type === 'password';
      target.type = visible ? 'text' : 'password';
      button.setAttribute('aria-label', visible ? 'Hide password' : 'Show password');
      button.setAttribute('aria-pressed', String(visible));
      const icon = button.querySelector('i');
      if (icon) icon.className = visible ? 'bi bi-eye-slash' : 'bi bi-eye';
    });
  });

  // Smooth scroll entrance; content remains visible with JS disabled.
  const reduced = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
  const revealItems = [...document.querySelectorAll('.cv-reveal')];
  if (revealItems.length && 'IntersectionObserver' in window && !reduced) {
    document.documentElement.classList.add('cv-motion');
    const observer = new IntersectionObserver((entries, watched) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          entry.target.classList.add('cv-visible');
          watched.unobserve(entry.target);
        }
      });
    }, { threshold: 0.08, rootMargin: '0px 0px 35px 0px' });
    revealItems.forEach(el => observer.observe(el));
  }

  // One slide at a time: an accessible, manual story carousel (no autoplay).
  document.querySelectorAll('[data-cv-slider]').forEach(slider => {
    const track = slider.querySelector('[data-cv-track]');
    const slides = [...slider.querySelectorAll('[data-cv-slide]')];
    const dots = [...slider.querySelectorAll('[data-cv-to]')];
    const previous = slider.querySelector('[data-cv-prev]');
    const next = slider.querySelector('[data-cv-next]');
    const stepLabel = slider.querySelector('[data-cv-step]');
    if (!track || slides.length < 2 || dots.length !== slides.length || !previous || !next) return;

    let active = 0;
    const show = index => {
      active = Math.max(0, Math.min(slides.length - 1, index));
      track.style.transform = `translate3d(-${active * 100}%, 0, 0)`;
      slides.forEach((slide, i) => {
        slide.setAttribute('aria-hidden', String(i !== active));
      });
      dots.forEach((dot, i) => {
        if (i === active) dot.setAttribute('aria-current', 'step');
        else dot.removeAttribute('aria-current');
      });
      previous.disabled = active === 0;
      next.disabled = active === slides.length - 1;
      if (stepLabel) stepLabel.textContent = String(active + 1).padStart(2, '0');
    };

    // Initialize before exposing interactive controls, keeping JS-off content readable.
    show(0);
    slider.classList.add('is-ready');
    previous.addEventListener('click', () => show(active - 1));
    next.addEventListener('click', () => show(active + 1));
    dots.forEach((dot, i) => dot.addEventListener('click', () => show(i)));
    slider.addEventListener('keydown', event => {
      if (event.key !== 'ArrowLeft' && event.key !== 'ArrowRight') return;
      // Avoid overriding arrow navigation on future text fields.
      if (event.target.closest('input, textarea, select')) return;
      event.preventDefault();
      show(active + (event.key === 'ArrowRight' ? 1 : -1));
    });

    // Basic swipe navigation on touch devices, without forced page scrolling.
    let startX = null;
    slider.addEventListener('touchstart', event => {
      if (event.touches.length === 1) startX = event.touches[0].clientX;
    }, { passive: true });
    slider.addEventListener('touchend', event => {
      if (startX === null || !event.changedTouches.length) return;
      const dx = event.changedTouches[0].clientX - startX;
      startX = null;
      if (Math.abs(dx) >= 65) show(active + (dx < 0 ? 1 : -1));
    }, { passive: true });
  });

  // Dashboard counters are progressive enhancement, never dependent on JS.
  const counters = [...document.querySelectorAll('[data-count]')];
  const startCount = node => {
    if (node.dataset.countDone) return;
    node.dataset.countDone = '1';
    const value = Number(node.dataset.count);
    if (!Number.isFinite(value) || value < 0 || !Number.isInteger(value) || reduced) return;
    if (value === 0) return;
    const duration = 850, started = performance.now();
    const tick = now => {
      const progress = Math.min((now - started) / duration, 1);
      const eased = 1 - Math.pow(1 - progress, 3);
      node.textContent = Math.round(value * eased).toLocaleString();
      if (progress < 1) requestAnimationFrame(tick);
      else node.textContent = value.toLocaleString();
    };
    requestAnimationFrame(tick);
  };
  if ('IntersectionObserver' in window && !reduced) {
    const observer = new IntersectionObserver((entries, watched) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) { startCount(entry.target); watched.unobserve(entry.target); }
      });
    }, { threshold: 0.5 });
    counters.forEach(el => observer.observe(el));
  }
});
