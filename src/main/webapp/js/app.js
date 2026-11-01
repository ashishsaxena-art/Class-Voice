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
