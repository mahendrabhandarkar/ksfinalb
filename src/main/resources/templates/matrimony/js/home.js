/* Vivaah Royal — Home page rendering */
"use strict";

(function () {
  /* Featured profiles: mix of new + premium, 8 cards */
  const featured = PROFILES.filter(function (p) { return p.isNew || p.premium; }).slice(0, 8);
  renderProfileGrid("#featured-grid", featured, true);

  /* Success stories carousel */
  const inner = document.getElementById("story-inner");
  if (inner) {
    inner.innerHTML = SUCCESS_STORIES.map(function (s, i) {
      const stars = Array.from({ length: s.rating }, function () {
        return '<i class="bi bi-star-fill text-gold-bright" role="img" aria-label="star rating"></i>';
      }).join("");
      const photo = s.img
        ? '<img class="col-md-5" src="' + s.img + '" alt="' + s.couple + " on their wedding day" + '">' 
        : '<div class="col-md-5 d-flex align-items-center justify-content-center p-4">' + avatarSVG(s.couple, i + 3) + "</div>";
      return (
        '<div class="carousel-item' + (i === 0 ? " active" : "") + '"' + (i === 0 ? ' aria-current="true"' : "") + '>' +
        '<figure class="row g-0 align-items-stretch m-0 bg-white rounded-xl overflow-hidden">' +
        photo +
        '<figcaption class="col-md-7 p-4 p-lg-5 d-flex flex-column justify-content-center">' +
        '<div class="mb-2" aria-hidden="true">' + stars + "</div>" +
        '<blockquote class="fs-5 mb-3 fst-italic" style="color:#4c2a22;">\u201C' + s.quote + "\u201D</blockquote>" +
        '<p class="mb-0 fw-bold" style="color: var(--royal-maroon);">' + s.couple + ' <span class="ink-muted fw-normal">• ' + s.city + "</span></p>" +
        '<p class="ink-muted small mb-0">' + s.married + "</p>" +
        "</figcaption></figure></div>"
      );
    }).join("");
    /* pause auto-rotation when user focuses/hovers — a11y */
    const car = document.getElementById("story-carousel");
    car.addEventListener("focusin", function () { bootstrap.Carousel.getOrCreateInstance(car).pause(); });
    car.addEventListener("focusout", function () { bootstrap.Carousel.getOrCreateInstance(car).cycle(); });
  }

  /* Plan mini cards */
  const grid = document.getElementById("plan-mini-grid");
  if (grid) {
    grid.innerHTML = PLANS.map(function (p) {
      const feat = p.feats.filter(function (f) { return f[1]; }).length;
      return (
        '<div class="col-6 col-lg-3">' +
        '<div class="stat-tile' + (p.id === "gold" ? " gold-top" : "") + '">' +
        '<i class="bi ' + (p.id === "free" ? "bi-flower1" : p.id === "silver" ? "bi-moon-stars-fill" : p.id === "gold" ? "bi-gem-fill" : "bi-crown-fill") + '" aria-hidden="true"></i>' +
        '<div class="plan-name mt-2">' + p.name + "</div>" +
        '<p class="mb-1"><span class="plan-price" style="font-size:1.4rem;">₹' + p.price + "</span></p>" +
        '<p class="ink-muted small mb-2">' + p.per + "</p>" +
        '<span class="badge badge-gold">' + feat + " features</span>" +
        "</div></div>"
      );
    }).join("");
  }
})();
