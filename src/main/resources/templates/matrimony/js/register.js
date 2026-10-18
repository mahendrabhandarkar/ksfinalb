/* Vivaah Royal — Registration wizard */
"use strict";

(function () {
  const TOTAL = 4;
  let current = 1;
  const form = document.getElementById("reg-form");

  /* ---- populate DOB selects ---- */
  const daySel = document.getElementById("reg-dob-day");
  const monSel = document.getElementById("reg-dob-month");
  const yearSel = document.getElementById("reg-dob-year");
  for (let d = 1; d <= 31; d++) daySel.add(new Option(String(d), String(d)));
  ["January","February","March","April","May","June","July","August","September","October","November","December"]
    .forEach(function (m, i) { monSel.add(new Option(m, String(i + 1))); });
  const nowY = new Date().getFullYear();
  for (let y = nowY - 60; y <= nowY - 18; y++) yearSel.add(new Option(String(y), String(y)));

  /* ---- helpers ---- */
  function showFieldError(input, errId, show) {
    const err = document.getElementById(errId);
    if (err) err.classList.toggle("show", show);
    if (input) {
      input.classList.toggle("is-invalid", show);
      input.setAttribute("aria-invalid", String(show));
    }
  }

  function validateStep(step) {
    let ok = true;
    const firstBad = { v: null };

    function check(input, errId, test) {
      const pass = test();
      showFieldError(input, errId, !pass);
      if (!pass && ok) { ok = false; firstBad.v = input; }
      if (!pass) ok = false;
    }

    if (step === 1) {
      const gender = document.getElementById("reg-gender");
      const fname = document.getElementById("reg-fname");
      const lname = document.getElementById("reg-lname");
      const nameRe = /^[A-Za-z][A-Za-z .'-]{1,29}$/;
      check(gender, "err-gender", function () { return gender.value !== ""; });
      check(fname, "err-fname", function () { return nameRe.test(fname.value.trim()); });
      check(lname, "err-lname", function () { return nameRe.test(lname.value.trim()); });
      check(yearSel, "err-dob", function () { return validDob(); });
    }
    if (step === 2) {
      const ids = [["reg-religion","err-religion"],["reg-community","err-community"],["reg-tongue","err-tongue"],["reg-marital","err-marital"],["reg-height","err-height"],["reg-diet","err-diet"]];
      ids.forEach(function (p) {
        const el = document.getElementById(p[0]);
        check(el, p[1], function () { return el.value.trim() !== ""; });
      });
    }
    if (step === 3) {
      const edu = document.getElementById("reg-edu");
      const job = document.getElementById("reg-job");
      const country = document.getElementById("reg-country");
      const city = document.getElementById("reg-city");
      const about = document.getElementById("reg-about");
      check(edu, "err-edu", function () { return edu.value.trim() !== ""; });
      check(job, "err-job", function () { return job.value.trim() !== ""; });
      check(country, "err-country", function () { return country.value !== ""; });
      check(city, "err-city", function () { return city.value.trim() !== ""; });
      check(about, "err-about", function () { return about.value.trim().length >= 30; });
    }
    if (step === 4) {
      const email = document.getElementById("reg-email");
      const mobile = document.getElementById("reg-mobile");
      const pw = document.getElementById("reg-pw");
      const pw2 = document.getElementById("reg-pw2");
      const terms = document.getElementById("reg-terms");
      check(email, "err-email", function () { return /^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/.test(email.value.trim()); });
      check(mobile, "err-mobile", function () { return /^[6-9]\d{9}$/.test(mobile.value.replace(/\s+/g, "")); });
      check(pw, "pw-err", function () { return pwScore(pw.value) >= 4; });
      check(pw2, "err-pw2", function () { return pw2.value !== "" && pw2.value === pw.value; });
      check(terms, "err-terms", function () { return terms.checked; });
    }

    if (!ok && firstBad.v) firstBad.v.focus();
    return ok;
  }

  function validDob() {
    if (!daySel.value || !monSel.value || !yearSel.value) return false;
    const dt = new Date(Number(yearSel.value), Number(monSel.value) - 1, Number(daySel.value));
    if (dt.getDate() !== Number(daySel.value) || dt.getMonth() !== Number(monSel.value) - 1) return false;
    const age = (Date.now() - dt.getTime()) / (365.25 * 24 * 3600 * 1000);
    return age >= 21 && age <= 60;
  }

  /* ---- password meter ---- */
  const pwBar = document.getElementById("pw-bar");
  const pwErr = document.getElementById("pw-err");
  function pwScore(v) {
    let s = 0;
    if (v.length >= 8) s++;
    if (/[A-Z]/.test(v)) s++;
    if (/[a-z]/.test(v) && /\d/.test(v)) s++;
    if (/[^A-Za-z0-9]/.test(v)) s++;
    return s;
  }
  document.getElementById("reg-pw").addEventListener("input", function () {
    const s = pwScore(this.value);
    const pct = [0, 25, 50, 75, 100][s];
    pwBar.style.width = pct + "%";
    pwBar.style.background = s <= 1 ? "#b3261e" : s <= 2 ? "#c89b2c" : s <= 3 ? "#5d8a4f" : "#2f6b3f";
    pwErr.textContent = this.value === "" ? "" : s >= 4 ? "Password strength: strong" : "Password needs work: " + (4 - s) + " more requirement(s)";
  });

  /* ---- about character counter ---- */
  document.getElementById("reg-about").addEventListener("input", function () {
    document.getElementById("count-about").textContent = this.value.trim().length + " / 30 characters minimum";
  });

  /* ---- step navigation ---- */
  const btnPrev = document.getElementById("btn-prev");
  const btnNext = document.getElementById("btn-next");
  const btnSubmit = document.getElementById("btn-submit");
  const alertSlot = document.getElementById("form-alert-slot");

  function goTo(step) {
    current = step;
    document.querySelectorAll(".reg-step").forEach(function (fs) {
      fs.classList.toggle("d-none", Number(fs.dataset.step) !== step);
    });
    for (let i = 1; i <= TOTAL; i++) {
      const li = document.getElementById("wstep-" + i);
      li.classList.toggle("done", i < step);
      if (i === step) li.setAttribute("aria-current", "step"); else li.removeAttribute("aria-current");
      const dot = li.querySelector(".dot");
      dot.innerHTML = i < step ? '<i class="bi bi-check-lg" aria-hidden="true"></i>' : String(i);
    }
    btnPrev.disabled = step === 1;
    btnNext.classList.toggle("d-none", step === TOTAL);
    btnSubmit.classList.toggle("d-none", step !== TOTAL);
    const heading = document.querySelector('.reg-step[data-step="' + step + '"] legend');
    if (heading) { heading.setAttribute("tabindex", "-1"); heading.focus({ preventScroll: false }); }
    window.scrollTo({ top: 0, behavior: "smooth" });
  }

  btnNext.addEventListener("click", function () {
    alertSlot.innerHTML = "";
    if (validateStep(current)) goTo(current + 1);
    else alertSlot.innerHTML = '<div class="alert alert-danger py-2" role="alert"><i class="bi bi-exclamation-triangle-fill me-2" aria-hidden="true"></i>Please correct the highlighted fields before continuing.</div>';
  });
  btnPrev.addEventListener("click", function () { if (current > 1) goTo(current - 1); });

  form.addEventListener("submit", function (e) {
    e.preventDefault();
    if (!validateStep(4)) {
      alertSlot.innerHTML = '<div class="alert alert-danger py-2" role="alert"><i class="bi bi-exclamation-triangle-fill me-2" aria-hidden="true"></i>Please correct the highlighted fields to create your profile.</div>';
      return;
    }
    const first = document.getElementById("reg-fname").value.trim();
    setSession({
      firstName: first,
      fullName: (first + " " + document.getElementById("reg-lname").value.trim()).trim(),
      gender: document.getElementById("reg-gender").value,
      city: document.getElementById("reg-city").value.trim(),
      religion: document.getElementById("reg-religion").value,
      community: document.getElementById("reg-community").value.trim(),
      tongue: document.getElementById("reg-tongue").value,
      joined: new Date().toISOString()
    });
    form.classList.add("d-none");
    document.querySelector(".wizard-steps").classList.add("d-none");
    const success = document.getElementById("reg-success");
    success.classList.remove("d-none");
    document.getElementById("success-name").textContent = first;
    success.focus();
    showToast("Profile created successfully. Welcome aboard!");
  });

  goTo(1);
})();
