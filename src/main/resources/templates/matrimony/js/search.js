/* Vivaah Royal — Search page engine */
"use strict";

(function () {
  const PAGE_SIZE = 8;
  let state = { kw: "", gender: "", ageMin: "", ageMax: "", marital: "", diet: "", religion: "", community: "", tongue: "", country: "", city: "", edu: "", verifiedOnly: false, premiumOnly: false };
  let sortBy = "rel";
  let view = "grid";
  let page = 1;

  /* ---- URL param prefill (from hero quick-search) ---- */
  (function prefill() {
    const q = new URLSearchParams(window.location.search);
    const map = { gender: "f-gender", ageMin: "f-age-min", ageMax: "f-age-max", religion: "f-religion", country: "f-country" };
    Object.keys(map).forEach(function (k) {
      const v = q.get(k);
      if (v) {
        const el = document.getElementById(map[k]);
        if (el) {
          // match by exact option text/value
          let matched = false;
          Array.prototype.forEach.call(el.options, function (o) {
            if (!matched && (o.value === v || o.text === v)) { el.value = o.value; matched = true; }
          });
        }
        if (k !== "gender") state[k] = v; else state.gender = v;
      }
    });
    if (q.get("kw")) { state.kw = q.get("kw"); document.getElementById("f-keyword").value = state.kw; }
  })();

  /* ---- read filters from the form ---- */
  function readFilters() {
    state.kw = val("f-keyword");
    state.gender = val("f-gender");
    state.ageMin = val("f-age-min");
    state.ageMax = val("f-age-max");
    state.marital = val("f-marital");
    state.diet = val("f-diet");
    state.religion = val("f-religion");
    state.community = val("f-community");
    state.tongue = val("f-tongue");
    state.country = val("f-country");
    state.city = val("f-city");
    state.edu = val("f-edu");
    state.verifiedOnly = document.getElementById("f-verified").checked;
    state.premiumOnly = document.getElementById("f-premium").checked;
  }
  function val(id) { const el = document.getElementById(id); return el ? el.value.trim() : ""; }

  /* ---- sort + filter ---- */
  function currentResults() {
    const f = {};
    Object.keys(state).forEach(function (k) { if (state[k] !== "" && state[k] !== false) f[k] = state[k]; });
    if (f.city) {
      f.kw = f.kw ? f.kw + " " + f.city : f.city;   // city folded into keyword search
      delete f.city;
    }
    let list = filterProfiles(f);
    if (sortBy === "age-asc") list = list.slice().sort(function (a, b) { return a.age - b.age; });
    if (sortBy === "age-desc") list = list.slice().sort(function (a, b) { return b.age - a.age; });
    if (sortBy === "online") list = list.slice().sort(function (a, b) { return (b.lastSeen === "Online now") - (a.lastSeen === "Online now"); });
    if (sortBy === "premium") list = list.slice().sort(function (a, b) { return (b.premium === true) - (a.premium === true); });
    return list;
  }

  /* ---- render ---- */
  const resultsEl = document.getElementById("search-results");
  const countEl = document.getElementById("result-count");
  const paginationEl = document.getElementById("search-pagination");

  function render() {
    const list = currentResults();
    const pages = Math.max(1, Math.ceil(list.length / PAGE_SIZE));
    if (page > pages) page = pages;
    const slice = list.slice((page - 1) * PAGE_SIZE, page * PAGE_SIZE);

    renderProfileGrid("#search-results", slice, view === "grid");
    resultsEl.classList.toggle("list-view", view === "list");

    const noun = slice.length === 1 ? "profile" : "profiles";
    countEl.textContent = list.length
      ? "Showing " + ((page - 1) * PAGE_SIZE + 1) + "–" + ((page - 1) * PAGE_SIZE + slice.length) + " of " + list.length + " " + noun
      : "0 profiles match your filters";

    /* pagination */
    if (pages <= 1) { paginationEl.innerHTML = ""; return; }
    let html = '<li class="page-item' + (page === 1 ? " disabled" : "") + '"><button class="page-link" data-page="prev" ' + (page === 1 ? 'aria-disabled="true" tabindex="-1"' : "") + '><span aria-hidden="true">&laquo;</span><span class="visually-hidden">Previous page</span></button></li>';
    for (let i = 1; i <= pages; i++) {
      html += '<li class="page-item' + (i === page ? " active" : "") + '"' + (i === page ? ' aria-current="page"' : "") + '><button class="page-link" data-page="' + i + '">' + i + '<span class="visually-hidden">' + (i === page ? ", current page" : "") + "</span></button></li>";
    }
    html += '<li class="page-item' + (page === pages ? " disabled" : "") + '"><button class="page-link" data-page="next" ' + (page === pages ? 'aria-disabled="true" tabindex="-1"' : "") + '><span aria-hidden="true">&raquo;</span><span class="visually-hidden">Next page</span></button></li>';
    paginationEl.innerHTML = html;
  }

  paginationEl.addEventListener("click", function (e) {
    const btn = e.target.closest("[data-page]");
    if (!btn || btn.parentElement.classList.contains("disabled")) return;
    const p = btn.dataset.page;
    const pages = Math.max(1, Math.ceil(currentResults().length / PAGE_SIZE));
    if (p === "prev") page = Math.max(1, page - 1);
    else if (p === "next") page = Math.min(pages, page + 1);
    else page = Number(p);
    render();
    document.getElementById("results-region").scrollIntoView({ behavior: "smooth", block: "start" });
  });

  /* ---- events ---- */
  const form = document.getElementById("search-form");
  form.addEventListener("submit", function (e) { e.preventDefault(); readFilters(); page = 1; render(); });
  form.addEventListener("reset", function () {
    setTimeout(function () {
      readFilters();
      sortBy = "rel"; document.getElementById("sort-by").value = "rel";
      page = 1; render();
      showToast("All filters cleared.");
    }, 0);
  });

  /* live keyword search (debounced) */
  let kwTimer = null;
  document.getElementById("f-keyword").addEventListener("input", function () {
    clearTimeout(kwTimer);
    kwTimer = setTimeout(function () { readFilters(); page = 1; render(); }, 350);
  });

  document.getElementById("sort-by").addEventListener("change", function () { sortBy = this.value; page = 1; render(); });

  const vg = document.getElementById("view-grid");
  const vl = document.getElementById("view-list");
  vg.addEventListener("click", function () { view = "grid"; vg.classList.add("active"); vg.setAttribute("aria-pressed", "true"); vl.classList.remove("active"); vl.setAttribute("aria-pressed", "false"); render(); });
  vl.addEventListener("click", function () { view = "list"; vl.classList.add("active"); vl.setAttribute("aria-pressed", "true"); vg.classList.remove("active"); vg.setAttribute("aria-pressed", "false"); render(); });

  readFilters();
  render();
})();
