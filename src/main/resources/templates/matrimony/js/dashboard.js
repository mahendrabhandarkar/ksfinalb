/* Vivaah Royal — Dashboard logic */
"use strict";

(function () {
  const session = getSession();
  document.getElementById("welcome-name").textContent = session && session.firstName ? session.firstName : "Member";

  /* stats */
  document.getElementById("stat-sent").textContent = getStateSet("vr-interests").size;
  document.getElementById("stat-short").textContent = getStateSet("vr-shortlist").size;

  /* completeness (demo values) */
  const pct = 80;
  const bar = document.getElementById("complete-bar");
  bar.style.setProperty("--val", pct + "%");
  bar.setAttribute("aria-valuenow", String(pct));
  document.getElementById("complete-pct").textContent = pct + "%";

  /* today's matches: 4 profiles of opposite of nothing — just top relevance */
  const todays = PROFILES.slice().sort(function (a, b) { return (b.isNew - a.isNew) || (b.premium - a.premium); }).slice(0, 4);
  renderProfileGrid("#today-grid", todays, true);

  /* pending interests */
  const pending = [PROFILES[2], PROFILES[6], PROFILES[12]];
  const list = document.getElementById("pending-list");
  list.innerHTML = pending.map(function (p) {
    return (
      '<div class="mini-row">' +
      '<span class="mini-avatar">' + avatarSVG(p.name, p.id) + "</span>" +
      '<div class="flex-grow-1 min-w-0">' +
      '<p class="mb-0 fw-semibold text-truncate">' + p.name + "</p>" +
      '<p class="ink-muted small mb-0">' + p.age + " yrs • " + p.city + "</p>" +
      "</div>" +
      '<div class="d-flex gap-1">' +
      '<button type="button" class="btn btn-sm btn-royal" data-accept="' + p.id + '" data-name="' + p.name + '" aria-label="Accept interest from ' + p.name + '"><i class="bi bi-check-lg" aria-hidden="true"></i></button>' +
      '<button type="button" class="btn btn-sm btn-outline-royal" data-decline="' + p.id + '" data-name="' + p.name + '" aria-label="Decline interest from ' + p.name + '"><i class="bi bi-x-lg" aria-hidden="true"></i></button>' +
      "</div></div>"
    );
  }).join("");

  list.addEventListener("click", function (e) {
    const acc = e.target.closest("[data-accept]");
    const dec = e.target.closest("[data-decline]");
    if (acc) {
      showToast("It's a match! You and " + acc.dataset.name + " can now chat freely. 🎊");
      acc.closest(".mini-row").remove();
    } else if (dec) {
      showToast("Interest from " + dec.dataset.name + " politely declined.");
      dec.closest(".mini-row").remove();
    }
  });

  /* visitors */
  const visitors = [PROFILES[0], PROFILES[3], PROFILES[16], PROFILES[21]];
  document.getElementById("visitor-list").innerHTML = visitors.map(function (p) {
    return (
      '<div class="mini-row">' +
      '<span class="mini-avatar">' + avatarSVG(p.name, p.id + 5) + "</span>" +
      '<div class="flex-grow-1 min-w-0">' +
      '<p class="mb-0 fw-semibold text-truncate"><a class="btn-link-royal" href="profile.html?id=' + p.id + '">' + p.name + "</a></p>" +
      '<p class="ink-muted small mb-0">Visited today, ' + (2 + (p.id % 6)) + ":1" + (p.id % 9) + " PM</p>" +
      "</div>" +
      '<a class="btn btn-sm btn-outline-royal" href="profile.html?id=' + p.id + '" aria-label="View profile of ' + p.name + '">View</a>' +
      "</div>"
    );
  }).join("");
})();
