/* Vivaah Royal — Profile detail rendering */
"use strict";

(function () {
  const params = new URLSearchParams(window.location.search);
  const id = Number(params.get("id")) || 1;
  const p = getProfile(id);

  if (!p) {
    document.getElementById("main").innerHTML =
      '<div class="container text-center py-5"><h1 class="h3">Profile not found</h1>' +
      '<p class="ink-muted">The member you are looking for may have paused their profile.</p>' +
      '<a class="btn btn-royal" href="matches.html">Browse other matches</a></div>';
    return;
  }

  const firstName = p.name.split(" ")[0];
  const interested = isInterested(p.id);
  const shortlisted = isShortlisted(p.id);

  /* header */
  document.title = p.name + " — Profile | Vivaah Royal Matrimony";
  document.getElementById("p-name").textContent = p.name;
  document.getElementById("p-tagline").textContent =
    p.age + " yrs \u2022 " + p.height + " \u2022 " + p.community + " \u2022 " + p.city;
  document.getElementById("p-firstname").textContent = firstName;
  document.getElementById("p-about").textContent = p.about;

  /* badges */
  const badges = [];
  if (p.verified) badges.push('<span class="badge badge-blue p-2"><i class="bi bi-patch-check-fill me-1" aria-hidden="true"></i>Verified member</span>');
  if (p.premium) badges.push('<span class="badge badge-gold p-2"><i class="bi bi-gem me-1" aria-hidden="true"></i>Premium</span>');
  if (p.isNew) badges.push('<span class="badge badge-royal p-2"><i class="bi bi-stars me-1" aria-hidden="true"></i>New member</span>');
  badges.push('<span class="badge bg-success-subtle text-success p-2 border"><i class="bi bi-dot me-n1" aria-hidden="true"></i>' + p.lastSeen + "</span>");
  document.getElementById("p-badges").innerHTML = badges.join("");

  /* gallery — 4 "photos" (privacy placeholders) */
  const captions = ["Main photo", "Festive look", "Travel diaries", "Family function"];
  document.getElementById("gallery-inner").innerHTML = captions.map(function (cap, i) {
    return (
      '<div class="carousel-item' + (i === 0 ? " active" : "") + '">' +
      '<div class="p-3 pb-1">' + avatarSVG(p.name, p.id + i) + "</div>" +
      '<p class="text-center small ink-muted pb-2 mb-0">' + cap + " • visible on connection</p>" +
      "</div>"
    );
  }).join("");

  /* action buttons reflect state */
  const interestBtn = document.getElementById("p-interest");
  const shortBtn = document.getElementById("p-shortlist");
  syncButtons();
  interestBtn.addEventListener("click", function () {
    toggleInterest(p.id, p.name);
    syncButtons();
  });
  shortBtn.addEventListener("click", function () {
    toggleShortlist(p.id, p.name);
    syncButtons();
  });
  document.getElementById("p-chat").addEventListener("click", function () {
    showToast("Chat unlocks once " + firstName + " accepts your interest. (Demo)");
  });
  document.getElementById("p-report").addEventListener("click", function () {
    showToast("Thank you. Our trust & safety team will review this profile within 24 hours.");
  });
  document.getElementById("p-block").addEventListener("click", function () {
    showToast(firstName + " has been blocked. They can no longer see your profile. (Demo)");
  });

  function syncButtons() {
    const iOn = isInterested(p.id);
    const sOn = isShortlisted(p.id);
    interestBtn.classList.toggle("btn-gold", iOn);
    interestBtn.classList.toggle("btn-royal", !iOn);
    interestBtn.innerHTML = iOn
      ? '<i class="bi bi-heart-fill me-1" aria-hidden="true"></i>Interest Sent ✓'
      : '<i class="bi bi-heart-fill me-1" aria-hidden="true"></i>Send Interest';
    interestBtn.setAttribute("aria-pressed", String(iOn));
    shortBtn.classList.toggle("is-active", sOn);
    shortBtn.setAttribute("aria-pressed", String(sOn));
    shortBtn.innerHTML = sOn
      ? '<i class="bi bi-bookmark-star-fill me-1" aria-hidden="true"></i>Shortlisted'
      : '<i class="bi bi-bookmark-star-fill me-1" aria-hidden="true"></i>Shortlist';
  }

  /* info lists */
  function row(k, v) { return '<li><span class="k">' + k + '</span><span class="v">' + v + "</span></li>"; }

  document.getElementById("list-basic").innerHTML =
    row("Name", p.name) +
    row("Age", p.age + " years") +
    row("Height", p.height) +
    row("Gender", p.gender === "F" ? "Female (Bride)" : "Male (Groom)") +
    row("Marital status", p.marital) +
    row("Mother tongue", p.tongue) +
    row("Diet", p.diet) +
    row("Lives in", p.city + ", " + p.state + ", " + p.country);

  document.getElementById("list-family").innerHTML =
    row("Religion", p.religion) +
    row("Community / Caste", p.community) +
    row("Family values", "Traditional with modern outlook") +
    row("Family type", "Nuclear family") +
    row("Family status", "Middle class") +
    row("Father", "Businessman") +
    row("Mother", "Homemaker") +
    row("Siblings", "1 elder brother (married), 1 younger sister") +
    row("Horoscope \u2013 Rashi (Moon sign)", ["Mesha (Aries)", "Vrishabha (Taurus)", "Mithuna (Gemini)", "Karka (Cancer)", "Simha (Leo)", "Kanya (Virgo)", "Tula (Libra)", "Vrishchika (Scorpio)", "Dhanu (Sagittarius)", "Makara (Capricorn)", "Kumbha (Aquarius)", "Meena (Pisces)"][p.id % 12]) +
    row("Gotra", "Kashyap") +
    row("Manglik", p.id % 3 === 0 ? "Yes" : "No");

  document.getElementById("list-career").innerHTML =
    row("Highest education", p.edu) +
    row("College / University", p.college) +
    row("Occupation", p.job) +
    row("Annual income", p.income) +
    row("Work mode", "Hybrid") +
    row("Employed in", p.country === "India" ? "Private sector" : "Multi-national company");

  document.getElementById("p-pref").textContent =
    "Here is what " + firstName + " is looking for in a life partner:";
  document.getElementById("list-pref").innerHTML =
    row("Age range", Math.max(21, p.age - 5) + " – " + (p.age + 4) + " years") +
    row("Height range", p.gender === "F" ? "5 ft 6 in and above" : "5 ft 0 in and above") +
    row("Religion / Community", p.religion + ", " + p.community + " preferred") +
    row("Mother tongue", p.tongue + " preferred, open to others") +
    row("Education", "Graduate or above") +
    row("Location", "Same city preferred; open to " + (p.country === "India" ? "metros in India" : p.country)) +
    row("Diet", "Any") +
    row("Other thoughts", "Kindness, humour and family values matter more than anything else.");

  /* similar profiles */
  const similar = PROFILES.filter(function (x) {
    return x.id !== p.id && (x.religion === p.religion || x.tongue === p.tongue || x.city === p.city);
  }).slice(0, 4);
  renderProfileGrid("#similar-grid", similar, true);
})();
