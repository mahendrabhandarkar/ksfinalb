/* ============================================================
   Vivaah Royal Matrimony — shared behaviours
   (accessibility toolbar, toasts, avatars, profile cards,
    interests / shortlist state, session)
   ============================================================ */
"use strict";

/* ---------------- Accessibility toolbar ---------------- */
(function initA11y() {
  if (window.__vrA11yBound) return; // idempotent — never attach twice
  window.__vrA11yBound = true;
  const root = document.documentElement;
  const fs = localStorage.getItem("vr-fs") || "md";
  const contrast = localStorage.getItem("vr-contrast") || "normal";
  root.setAttribute("data-fs", fs);
  root.setAttribute("data-contrast", contrast);
  syncPressed();

  function syncPressed() {
    const curFs = root.getAttribute("data-fs") || "md";
    document.querySelectorAll("[data-fs-btn]").forEach(function (b) {
      b.setAttribute("aria-pressed", String(b.dataset.fsBtn === curFs));
    });
    document.querySelectorAll("[data-contrast-btn]").forEach(function (b) {
      b.setAttribute("aria-pressed", String(root.getAttribute("data-contrast") === "high"));
    });
  }

  document.addEventListener("click", function (e) {
    const fsBtn = e.target.closest("[data-fs-btn]");
    if (fsBtn) {
      root.setAttribute("data-fs", fsBtn.dataset.fsBtn);
      localStorage.setItem("vr-fs", fsBtn.dataset.fsBtn);
      syncPressed();
      showToast(fsBtn.dataset.fsBtn === "md" ? "Text size: normal" : fsBtn.dataset.fsBtn === "lg" ? "Text size: extra large" : "Text size: large", "text-size");
      return;
    }
    const cBtn = e.target.closest("[data-contrast-btn]");
    if (cBtn) {
      const next = root.getAttribute("data-contrast") === "high" ? "normal" : "high"; // read live state
      root.setAttribute("data-contrast", next);
      localStorage.setItem("vr-contrast", next);
      syncPressed();
      showToast(next === "high" ? "High contrast mode on" : "High contrast mode off", "contrast");
    }
  });
})();

/* ---------------- Toast (aria-live) ---------------- */
let toastRegion = null;
function ensureToast() {
  if (toastRegion) return toastRegion;
  toastRegion = document.createElement("div");
  toastRegion.className = "app-toast";
  toastRegion.setAttribute("role", "status");
  toastRegion.setAttribute("aria-live", "polite");
  toastRegion.innerHTML = '<i class="bi bi-check-circle-fill" aria-hidden="true"></i><span class="msg"></span>';
  document.body.appendChild(toastRegion);
  return toastRegion;
}
let toastTimer = null;
function showToast(msg) {
  const t = ensureToast();
  t.querySelector(".msg").textContent = msg;
  t.classList.add("show");
  clearTimeout(toastTimer);
  toastTimer = setTimeout(function () { t.classList.remove("show"); }, 3200);
}

/* ---------------- Avatar SVG (privacy-safe placeholder) ---------------- */
const AVATAR_PALETTES = [
  ["#8f1d22", "#c8532b"], ["#5c1013", "#a03028"], ["#2c4a9a", "#4d6cc0"],
  ["#b3762b", "#e0a94f"], ["#7a1f3d", "#b04a72"], ["#315c2b", "#5d8a4f"],
  ["#6d3b8f", "#9a68c0"], ["#8a4b0f", "#c07a30"]
];
function avatarSVG(name, idx, opts) {
  opts = opts || {};
  const ini = initialsOf(name);
  const pal = AVATAR_PALETTES[idx % AVATAR_PALETTES.length];
  const cls = opts.cls || "";
  const svg =
    '<svg class="' + cls + '" viewBox="0 0 200 220" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Profile photo placeholder for ' + name.replace(/"/g, "&quot;") + '">' +
    '<defs><radialGradient id="g' + idx + '" cx="30%" cy="25%" r="90%">' +
    '<stop offset="0%" stop-color="' + pal[1] + '"/><stop offset="100%" stop-color="' + pal[0] + '"/>' +
    '</radialGradient></defs>' +
    '<rect width="200" height="220" fill="url(#g' + idx + ')"/>' +
    '<circle cx="100" cy="110" r="86" fill="none" stroke="#e9c46a" stroke-width="2.5" opacity="0.9"/>' +
    '<circle cx="100" cy="110" r="78" fill="none" stroke="#e9c46a" stroke-width="1" opacity="0.6"/>' +
    '<text x="100" y="108" text-anchor="middle" font-family="Georgia, serif" font-size="58" font-weight="700" fill="#f5e6c4">' + ini + '</text>' +
    '<path d="M100 150 l6 8 10 1 -7 7 2 10 -11 -6 -11 6 2 -10 -7 -7 10 -1 z" fill="#e9c46a" opacity="0.85"/>' +
    '<text x="100" y="196" text-anchor="middle" font-family="Arial, sans-serif" font-size="11" letter-spacing="2" fill="#f5e6c4" opacity="0.85">VIVAAH ROYAL</text>' +
    '</svg>';
  return svg;
}

/* ---------------- Session (demo auth) ---------------- */
function getSession() {
  try { return JSON.parse(localStorage.getItem("vr-session") || "null"); } catch (e) { return null; }
}
function setSession(obj) { localStorage.setItem("vr-session", JSON.stringify(obj)); }
function clearSession() { localStorage.removeItem("vr-session"); }
function personaliseNavbar() {
  const s = getSession();
  const slot = document.getElementById("nav-user-slot");
  if (!slot || !s) return;
  slot.innerHTML =
    '<div class="dropdown">' +
    '<button class="btn btn-gold btn-sm dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">' +
    '<i class="bi bi-person-circle me-1" aria-hidden="true"></i>' + s.firstName + "</button>" +
    '<ul class="dropdown-menu dropdown-menu-end">' +
    '<li><a class="dropdown-item" href="dashboard.html"><i class="bi bi-speedometer2 me-2" aria-hidden="true"></i>My Dashboard</a></li>' +
    '<li><a class="dropdown-item" href="inbox.html"><i class="bi bi-envelope-heart me-2" aria-hidden="true"></i>Inbox</a></li>' +
    '<li><a class="dropdown-item" href="membership.html"><i class="bi bi-gem me-2" aria-hidden="true"></i>Membership</a></li>' +
    '<li><hr class="dropdown-divider"></li>' +
    '<li><button class="dropdown-item" type="button" id="nav-logout"><i class="bi bi-box-arrow-right me-2" aria-hidden="true"></i>Log Out</button></li>' +
    "</ul></div>";
  const logout = document.getElementById("nav-logout");
  if (logout) logout.addEventListener("click", function () {
    clearSession();
    showToast("You have been logged out.");
    setTimeout(function () { window.location.href = "index.html"; }, 800);
  });
}

/* ---------------- Interests & shortlists ---------------- */
function getStateSet(key) {
  try { return new Set(JSON.parse(localStorage.getItem(key) || "[]")); } catch (e) { return new Set(); }
}
function saveStateSet(key, set) { localStorage.setItem(key, JSON.stringify(Array.from(set))); }
function isInterested(id) { return getStateSet("vr-interests").has(Number(id)); }
function isShortlisted(id) { return getStateSet("vr-shortlist").has(Number(id)); }

function toggleInterest(id, name) {
  const s = getStateSet("vr-interests");
  id = Number(id);
  if (s.has(id)) { s.delete(id); saveStateSet("vr-interests", s); showToast("Interest withdrawn from " + name); return false; }
  s.add(id); saveStateSet("vr-interests", s);
  showToast("Interest sent to " + name + " \u2728 They will be notified.");
  return true;
}
function toggleShortlist(id, name) {
  const s = getStateSet("vr-shortlist");
  id = Number(id);
  if (s.has(id)) { s.delete(id); saveStateSet("vr-shortlist", s); showToast(name + " removed from shortlist."); return false; }
  s.add(id); saveStateSet("vr-shortlist", s);
  showToast(name + " added to your shortlist.");
  return true;
}

/* Global delegated handlers for profile action buttons */
document.addEventListener("click", function (e) {
  const intBtn = e.target.closest("[data-act-interest]");
  if (intBtn) {
    const on = toggleInterest(intBtn.dataset.actInterest, intBtn.dataset.name || "member");
    intBtn.classList.toggle("is-active", on);
    intBtn.setAttribute("aria-pressed", String(on));
    const label = intBtn.querySelector(".act-label");
    if (label) label.textContent = on ? "Sent" : "Interest";
    return;
  }
  const shortBtn = e.target.closest("[data-act-shortlist]");
  if (shortBtn) {
    const on = toggleShortlist(shortBtn.dataset.actShortlist, shortBtn.dataset.name || "member");
    shortBtn.classList.toggle("is-active", on);
    shortBtn.setAttribute("aria-pressed", String(on));
    return;
  }
  const chatBtn = e.target.closest("[data-act-chat]");
  if (chatBtn) {
    showToast("Chat opens once " + (chatBtn.dataset.name || "the member") + " accepts your interest. (Demo)");
  }
});

/* ---------------- Profile card renderer ---------------- */
function profileCardHTML(p, idx) {
  const flags =
    (p.isNew ? '<span class="profile-flag flag-new"><i class="bi bi-stars" aria-hidden="true"></i>New</span>' :
      (p.premium ? '<span class="profile-flag flag-premium"><i class="bi bi-gem" aria-hidden="true"></i>Premium</span>' : "")) ;
  const verified = p.verified
    ? ' <i class="bi bi-patch-check-fill verified-badge" role="img" aria-label="Verified profile"></i>'
    : "";
  const interested = isInterested(p.id);
  const shortlisted = isShortlisted(p.id);
  return (
    '<article class="profile-card" aria-label="Profile of ' + p.name + ', ' + p.age + ' years, ' + p.city + '">' +
    '<div class="profile-photo">' +
    avatarSVG(p.name, idx, { cls: "avatar-svg" }) + flags +
    '<span class="photo-protected"><i class="bi bi-shield-lock-fill" aria-hidden="true"></i>Photo protected</span>' +
    "</div>" +
    '<div class="profile-body">' +
    '<h3 class="profile-name"><a href="profile.html?id=' + p.id + '" aria-label="View full profile of ' + p.name + '">' + p.name + "</a>" + verified + "</h3>" +
    '<p class="profile-meta">' + p.age + " yrs \u2022 " + p.height + " \u2022 " + p.community + "</p>" +
    '<p class="profile-meta mb-2"><i class="bi bi-geo-alt-fill text-gold" aria-hidden="true"></i> ' + p.city + ", " + p.country + "</p>" +
    '<div class="profile-tags">' +
    '<span class="chip">' + p.edu + "</span>" +
    '<span class="chip">' + p.tongue + "</span>" +
    '<span class="chip">' + p.religion + "</span>" +
    "</div>" +
    '<div class="profile-actions">' +
    '<button type="button" class="btn btn-outline-royal' + (interested ? " is-active" : "") + '" data-act-interest="' + p.id + '" data-name="' + p.name + '" aria-pressed="' + interested + '"><i class="bi bi-heart-fill" aria-hidden="true"></i><span class="act-label">' + (interested ? "Sent" : "Interest") + "</span></button>" +
    '<button type="button" class="btn btn-outline-royal' + (shortlisted ? " is-active gold-accent" : "") + '" data-act-shortlist="' + p.id + '" data-name="' + p.name + '" aria-pressed="' + shortlisted + '" aria-label="Shortlist ' + p.name + '"><i class="bi bi-bookmark-star-fill" aria-hidden="true"></i><span class="act-label">Save</span></button>' +
    '<button type="button" class="btn btn-outline-royal" data-act-chat="' + p.id + '" data-name="' + p.name + '"><i class="bi bi-chat-dots-fill" aria-hidden="true"></i><span class="act-label">Chat</span></button>' +
    "</div></div></article>"
  );
}

function renderProfileGrid(containerSel, list, gridView) {
  const el = document.querySelector(containerSel);
  if (!el) return;
  if (!list.length) {
    el.innerHTML =
      '<div class="col-12 text-center py-5"><i class="bi bi-search-heart" style="font-size:2.6rem;color:#c89b2c" aria-hidden="true"></i>' +
      '<h3 class="mt-3">No matches found</h3><p class="ink-muted">Try widening your filters — your special someone may be just one filter away.</p></div>';
    return;
  }
  el.innerHTML = list.map(function (p, i) {
    return '<div class="' + (gridView ? "col-6 col-md-4 col-xl-3" : "col-12") + '">' + profileCardHTML(p, p.id) + "</div>";
  }).join("");
}

/* ---------------- Footer year ---------------- */
document.addEventListener("DOMContentLoaded", function () {
  const y = document.getElementById("footer-year");
  if (y) y.textContent = new Date().getFullYear();
  personaliseNavbar();
});
