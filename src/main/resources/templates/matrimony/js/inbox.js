/* Vivaah Royal — Inbox logic */
"use strict";

(function () {
  /* ---------- Received interests ---------- */
  const received = [PROFILES[2], PROFILES[6], PROFILES[12]];
  const receivedEl = document.getElementById("received-list");
  function renderReceived() {
    if (!received.length) {
      receivedEl.innerHTML = '<div class="text-center py-5"><i class="bi bi-inbox fs-1 text-gold" aria-hidden="true"></i><h2 class="h5 mt-3">No pending interests</h2><p class="ink-muted">New interests will appear here the moment they arrive.</p></div>';
      return;
    }
    receivedEl.innerHTML = received.map(function (p) {
      return (
        '<div class="interest-item d-flex flex-wrap flex-md-nowrap align-items-center gap-3">' +
        '<span class="mini-avatar">' + avatarSVG(p.name, p.id) + "</span>" +
        '<div class="flex-grow-1">' +
        '<p class="mb-0 fw-bold"><a class="btn-link-royal" href="profile.html?id=' + p.id + '">' + p.name + "</a>" +
        (p.verified ? ' <i class="bi bi-patch-check-fill verified-badge" role="img" aria-label="Verified"></i>' : "") + "</p>" +
        '<p class="ink-muted small mb-1">' + p.age + " yrs • " + p.height + " • " + p.community + " • " + p.city + "</p>" +
        '<p class="small mb-0 fst-italic">"Namaste! Your profile resonated with our family. Would love to connect."</p>' +
        "</div>" +
        '<div class="d-flex gap-2">' +
        '<button type="button" class="btn btn-royal" data-accept="r" data-i="' + received.indexOf(p) + '" data-name="' + p.name + '"><i class="bi bi-heart-fill me-1" aria-hidden="true"></i>Accept</button>' +
        '<button type="button" class="btn btn-outline-royal" data-decline="r" data-i="' + received.indexOf(p) + '" data-name="' + p.name + '">Decline</button>' +
        "</div></div>"
      );
    }).join("");
  }
  renderReceived();

  receivedEl.addEventListener("click", function (e) {
    const acc = e.target.closest("[data-accept]");
    const dec = e.target.closest("[data-decline]");
    if (!acc && !dec) return;
    const idx = Number((acc || dec).dataset.i);
    const p = received[idx];
    if (acc) {
      accepted.push(p);
      showToast("It's a match! You and " + p.name + " can now chat. 🎊");
      renderAccepted();
    } else {
      showToast("Interest from " + p.name + " politely declined.");
    }
    received.splice(idx, 1);
    renderReceived();
  });

  /* ---------- Sent interests ---------- */
  const sentIds = Array.from(getStateSet("vr-interests"));
  const sent = sentIds.length ? sentIds.map(getProfile).filter(Boolean) : [PROFILES[4], PROFILES[9]];
  document.getElementById("sent-list").innerHTML = sent.length ? sent.map(function (p) {
    return (
      '<div class="interest-item d-flex flex-wrap flex-md-nowrap align-items-center gap-3">' +
      '<span class="mini-avatar">' + avatarSVG(p.name, p.id + 2) + "</span>" +
      '<div class="flex-grow-1">' +
      '<p class="mb-0 fw-bold"><a class="btn-link-royal" href="profile.html?id=' + p.id + '">' + p.name + "</a></p>" +
      '<p class="ink-muted small mb-0">' + p.age + " yrs • " + p.community + " • " + p.city + "</p>" +
      "</div>" +
      '<span class="badge bg-warning-subtle text-warning-emphasis border p-2"><i class="bi bi-hourglass-split me-1" aria-hidden="true"></i>Awaiting response</span>' +
      "</div>"
    );
  }).join("") : '<div class="text-center py-5"><h2 class="h5">No interests sent yet</h2><p class="ink-muted">Find someone special on the matches page.</p><a class="btn btn-royal" href="matches.html">Browse matches</a></div>';

  /* ---------- Accepted ---------- */
  let accepted = [PROFILES[0], PROFILES[8]];
  function renderAccepted() {
    document.getElementById("accepted-grid").innerHTML = accepted.map(function (p) {
      return (
        '<div class="col-md-6">' + profileCardHTML(p, p.id + 7) + "</div>"
      );
    }).join("");
  }
  renderAccepted();

  /* ---------- Chat ---------- */
  const convos = [PROFILES[0], PROFILES[8], PROFILES[19]];
  const REPLIES = [
    "Namaste! So nice to hear from you 😊",
    "That sounds lovely — tell me more?",
    "My family is equally excited to connect!",
    "Haha, you have great taste. Same here!",
    "Would love to continue this over a call this weekend?"
  ];
  const chatList = document.getElementById("chat-list");
  const thread = document.getElementById("chat-thread");
  const input = document.getElementById("chat-input");
  const sendBtn = document.querySelector("#chat-form button[type=submit]");
  let activeChat = -1;

  chatList.innerHTML = convos.map(function (p, i) {
    return (
      '<button type="button" class="mini-row w-100 border-0 bg-transparent text-start" data-chat="' + i + '" aria-label="Open chat with ' + p.name + '">' +
      '<span class="mini-avatar">' + avatarSVG(p.name, p.id + 3) + "</span>" +
      '<span class="flex-grow-1 min-w-0">' +
      '<span class="d-block fw-semibold text-truncate">' + p.name + "</span>" +
      '<span class="d-block ink-muted small text-truncate">Accepted • ' + p.city + "</span>" +
      "</span></button>"
    );
  }).join("");

  function bubbleHTML(who, text) {
    return '<div class="chat-bubble ' + who + '">' + text + "</div>";
  }

  chatList.addEventListener("click", function (e) {
    const btn = e.target.closest("[data-chat]");
    if (!btn) return;
    activeChat = Number(btn.dataset.chat);
    const p = convos[activeChat];
    document.getElementById("chat-peer-name").textContent = p.name;
    document.getElementById("chat-peer-status").textContent = p.lastSeen;
    document.getElementById("chat-peer-avatar").innerHTML = avatarSVG(p.name, p.id + 3);
    thread.innerHTML =
      '<p class="chat-day">Today</p>' +
      bubbleHTML("them", "Namaste! Thank you for accepting my interest 🙏") +
      bubbleHTML("me", "Namaste " + p.name.split(" ")[0] + "! Happy to connect.") +
      bubbleHTML("them", "How was your weekend? Anything fun?");
    input.disabled = false;
    sendBtn.disabled = false;
    input.placeholder = "Message " + p.name.split(" ")[0] + "…";
    chatList.querySelectorAll("[data-chat]").forEach(function (b) {
      b.style.background = b === btn ? "#fdf3dd" : "transparent";
      b.style.borderRadius = "0.6rem";
      b.setAttribute("aria-current", b === btn ? "true" : "false");
    });
    input.focus();
  });

  document.getElementById("chat-form").addEventListener("submit", function (e) {
    e.preventDefault();
    const text = input.value.trim();
    if (!text || activeChat < 0) return;
    thread.insertAdjacentHTML("beforeend", bubbleHTML("me", text.replace(/</g, "&lt;")));
    input.value = "";
    thread.scrollTop = thread.scrollHeight;
    setTimeout(function () {
      thread.insertAdjacentHTML("beforeend", bubbleHTML("them", REPLIES[Math.floor(Math.random() * REPLIES.length)]));
      thread.scrollTop = thread.scrollHeight;
    }, 1200);
  });
})();
