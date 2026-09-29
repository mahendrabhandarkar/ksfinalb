/* Sangam Matrimony — i18n + accessibility helpers (no inline JS => CSP-safe) */
(function () {
  'use strict';

  var BS = {
    ltr: 'https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css',
    rtl: 'https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.rtl.min.css'
  };
  var RTL = ['ar'];

  var I18N = {
    en: {
      "skip":"Skip to main content","a11y.lang":"Select language","a11y.fsChanged":"Text size changed",
      "nav.home":"Home","nav.search":"Search Profiles","nav.membership":"Membership","nav.about":"About Us","nav.contact":"Contact","nav.login":"Login","nav.register":"Register Free",
      "footer.tagline":"Helping hearts meet since 2010.","footer.quick":"Quick Links","footer.legal":"Legal","footer.privacy":"Privacy Policy","footer.terms":"Terms of Use","footer.refund":"Refund Policy","footer.follow":"Follow Us","footer.copy":"© 2025 Sangam Matrimony. All rights reserved.",
      "hero.badge":"India's most trusted matrimony service","hero.title":"Find Your Perfect Life Partner","hero.subtitle":"100% verified profiles. Private and secure. Register free and begin your journey today.","hero.cta":"Register Free","hero.cta2":"Browse Profiles",
      "search.legend":"Find your match","search.lookingFor":"I'm looking for","look.groom":"A groom (male)","look.bride":"A bride (female)","search.ageFrom":"Age from","search.ageTo":"Age to","search.religion":"Religion","search.city":"City","search.citySelect":"Select city","search.submit":"Search Now","common.any":"Any",
      "religion.hindu":"Hindu","religion.muslim":"Muslim","religion.christian":"Christian","religion.sikh":"Sikh","religion.other":"Other",
      "stats.profiles":"Verified Profiles","stats.matches":"Successful Matches","stats.cities":"Cities Covered","stats.support":"24×7 Support",
      "how.title":"How It Works","how.s1t":"Create your profile","how.s1d":"Sign up free and add your details in minutes.","how.s2t":"Search & connect","how.s2d":"Use smart filters to find compatible matches.","how.s3t":"Get verified","how.s3d":"Verify your profile with OTP and documents.","how.s4t":"Meet & marry","how.s4d":"Talk, meet families and start your new life.",
      "feat.title":"Featured Profiles","feat.viewAll":"View all profiles","p.verified":"Verified","p.view":"View Profile","p.interest":"Send Interest","p.save":"Save",
      "testi.title":"Success Stories","testi1.q":"We found each other within two months. Thank you Sangam!","testi2.q":"The verification process gave our families complete confidence.",
      "plans.title":"Membership Plans","plan.free":"Free","plan.gold":"Gold","plan.platinum":"Platinum","plan.month":"/month","plan.cta":"Choose Plan","plan.popular":"Most Popular",
      "cta.title":"Ready to meet your special someone?","cta.text":"Join thousands of happy couples. Your story could be next.","cta.button":"Get Started Free",
      "sr.filters":"Filters","sr.apply":"Apply filters","sr.reset":"Reset","sr.sort":"Sort by","sort.match":"Best match","sort.newest":"Newest first","sr.showing":"Showing 1–6 of 128 profiles","sr.prev":"Previous","sr.next":"Next",
      "sr.height":"Height","sr.mstatus":"Marital status","mstatus.never":"Never married","mstatus.divorced":"Divorced","mstatus.widowed":"Widowed","sr.mtongue":"Mother tongue","sr.occupation":"Occupation",
      "mt.hindi":"Hindi","mt.marathi":"Marathi","mt.arabic":"Arabic","mt.english":"English",
      "reg.title":"Create your free profile","reg.name":"Full name","reg.email":"Email address","reg.phone":"Mobile number","reg.pass":"Password","reg.dob":"Date of birth","reg.gender":"Gender","reg.male":"Male","reg.female":"Female","reg.consent":"I agree to the Terms of Use and Privacy Policy.","reg.submit":"Create Profile","reg.login":"Already a member? Login",
      "login.title":"Member Login","login.remember":"Remember me","login.forgot":"Forgot password?","login.submit":"Login",
      "contact.subject":"Subject","contact.message":"Your message","contact.send":"Send message",
      "about.title":"About Sangam Matrimony","dash.title":"My Dashboard","dash.complete":"Profile completeness"
    },
    hi: {
      "skip":"मुख्य सामग्री पर जाएँ","a11y.lang":"भाषा चुनें","a11y.fsChanged":"टेक्स्ट आकार बदला गया",
      "nav.home":"होम","nav.search":"प्रोफ़ाइल खोजें","nav.membership":"सदस्यता","nav.about":"हमारे बारे में","nav.contact":"संपर्क करें","nav.login":"लॉगिन","nav.register":"निःशुल्क रजिस्टर करें",
      "footer.tagline":"2010 से दिलों को मिलाने में मदद कर रहे हैं।","footer.quick":"त्वरित लिंक","footer.legal":"कानूनी","footer.privacy":"गोपनीयता नीति","footer.terms":"उपयोग की शर्तें","footer.refund":"रिफंड नीति","footer.follow":"हमें फ़ॉलो करें","footer.copy":"© 2025 संगम मैट्रिमोनी। सर्वाधिकार सुरक्षित।",
      "hero.badge":"भारत की सबसे भरोसेमंद मैट्रिमोनी सेवा","hero.title":"अपना आदर्श जीवनसाथी खोजें","hero.subtitle":"100% सत्यापित प्रोफ़ाइल। निजी और सुरक्षित। निःशुल्क रजिस्टर करें और आज ही अपनी यात्रा शुरू करें।","hero.cta":"निःशुल्क रजिस्टर करें","hero.cta2":"प्रोफ़ाइल देखें",
      "search.legend":"अपना मैच खोजें","search.lookingFor":"मैं ढूँढ रहा/रही हूँ","look.groom":"वर (पुरुष)","look.bride":"वधू (महिला)","search.ageFrom":"आयु से","search.ageTo":"आयु तक","search.religion":"धर्म","search.city":"शहर","search.citySelect":"शहर चुनें","search.submit":"अभी खोजें","common.any":"कोई भी",
      "religion.hindu":"हिंदू","religion.muslim":"मुस्लिम","religion.christian":"ईसाई","religion.sikh":"सिख","religion.other":"अन्य",
      "stats.profiles":"सत्यापित प्रोफ़ाइल","stats.matches":"सफल मैच","stats.cities":"शहर","stats.support":"24×7 सहायता",
      "how.title":"यह कैसे काम करता है","how.s1t":"प्रोफ़ाइल बनाएँ","how.s1d":"निःशुल्क साइन अप करें और कुछ ही मिनटों में विवरण जोड़ें।","how.s2t":"खोजें और जुड़ें","how.s2d":"अनुकूल मैच खोजने के लिए स्मार्ट फ़िल्टर का उपयोग करें।","how.s3t":"सत्यापन कराएँ","how.s3d":"OTP और दस्तावेज़ों से अपनी प्रोफ़ाइल सत्यापित करें।","how.s4t":"मिलें और विवाह करें","how.s4d":"बात करें, परिवारों से मिलें और नया जीवन शुरू करें।",
      "feat.title":"चुनिंदा प्रोफ़ाइल","feat.viewAll":"सभी प्रोफ़ाइल देखें","p.verified":"सत्यापित","p.view":"प्रोफ़ाइल देखें","p.interest":"इंटरेस्ट भेजें","p.save":"सेव करें",
      "testi.title":"सफलता की कहानियाँ","testi1.q":"हम दो महीने के भीतर एक-दूसरे से मिल गए। धन्यवाद संगम!","testi2.q":"सत्यापन प्रक्रिया ने हमारे परिवारों को पूरा भरोसा दिया।",
      "plans.title":"सदस्यता योजनाएँ","plan.free":"फ्री","plan.gold":"गोल्ड","plan.platinum":"प्लैटिनम","plan.month":"/माह","plan.cta":"योजना चुनें","plan.popular":"सबसे लोकप्रिय",
      "cta.title":"अपने खास साथी से मिलने के लिए तैयार हैं?","cta.text":"हज़ारों खुश जोड़ों में शामिल हों। अगली कहानी आपकी हो सकती है।","cta.button":"निःशुल्क शुरू करें",
      "sr.filters":"फ़िल्टर","sr.apply":"फ़िल्टर लागू करें","sr.reset":"रीसेट","sr.sort":"क्रमबद्ध करें","sort.match":"सर्वश्रेष्ठ मैच","sort.newest":"नई प्रोफ़ाइल पहले","sr.showing":"128 में से 1–6 प्रोफ़ाइल दिखाई जा रही हैं","sr.prev":"पिछला","sr.next":"अगला",
      "sr.height":"ऊँचाई","sr.mstatus":"वैवाहिक स्थिति","mstatus.never":"अविवाहित","mstatus.divorced":"तलाकशुदा","mstatus.widowed":"विधवा/विधुर","sr.mtongue":"मातृभाषा","sr.occupation":"व्यवसाय",
      "mt.hindi":"हिन्दी","mt.marathi":"मराठी","mt.arabic":"अरबी","mt.english":"अंग्रेज़ी",
      "reg.title":"अपनी निःशुल्क प्रोफ़ाइल बनाएँ","reg.name":"पूरा नाम","reg.email":"ईमेल पता","reg.phone":"मोबाइल नंबर","reg.pass":"पासवर्ड","reg.dob":"जन्म तिथि","reg.gender":"लिंग","reg.male":"पुरुष","reg.female":"महिला","reg.consent":"मैं उपयोग की शर्तों और गोपनीयता नीति से सहमत हूँ।","reg.submit":"प्रोफ़ाइल बनाएँ","reg.login":"पहले से सदस्य हैं? लॉगिन करें",
      "login.title":"सदस्य लॉगिन","login.remember":"मुझे याद रखें","login.forgot":"पासवर्ड भूल गए?","login.submit":"लॉगिन",
      "contact.subject":"विषय","contact.message":"आपका संदेश","contact.send":"संदेश भेजें",
      "about.title":"संगम मैट्रिमोनी के बारे में","dash.title":"मेरा डैशबोर्ड","dash.complete":"प्रोफ़ाइल पूर्णता"
    },
    mr: {
      "skip":"मुख्य मजकुराकडे जा","a11y.lang":"भाषा निवडा","a11y.fsChanged":"मजकुराचा आकार बदलला",
      "nav.home":"मुख्यपृष्ठ","nav.search":"प्रोफाइल शोधा","nav.membership":"सदस्यता","nav.about":"आमच्याविषयी","nav.contact":"संपर्क","nav.login":"लॉगिन","nav.register":"मोफत नोंदणी करा",
      "footer.tagline":"2010 पासून हृदयांना जोडण्यात मदत करत आहोत.","footer.quick":"जलद दुवे","footer.legal":"कायदेशीर","footer.privacy":"गोपनीयता धोरण","footer.terms":"वापरण्याच्या अटी","footer.refund":"परतावा धोरण","footer.follow":"आमचे अनुसरण करा","footer.copy":"© 2025 संगम मॅट्रिमोनी. सर्व हक्क राखीव.",
      "hero.badge":"भारतातील सर्वात विश्वासार्ह मॅट्रिमोनी सेवा","hero.title":"तुमचा आदर्श जीवनसाथी शोधा","hero.subtitle":"100% सत्यापित प्रोफाइल्स. खाजगी आणि सुरक्षित. मोफत नोंदणी करा आणि आजच तुमचा प्रवास सुरू करा.","hero.cta":"मोफत नोंदणी करा","hero.cta2":"प्रोफाइल पहा",
      "search.legend":"तुमचा जोडीदार शोधा","search.lookingFor":"मी शोधत आहे","look.groom":"वर (पुरुष)","look.bride":"वधू (स्त्री)","search.ageFrom":"वयापासून","search.ageTo":"वयापर्यंत","search.religion":"धर्म","search.city":"शहर","search.citySelect":"शहर निवडा","search.submit":"आता शोधा","common.any":"कोणताही",
      "religion.hindu":"हिंदू","religion.muslim":"मुस्लिम","religion.christian":"ख्रिस्ती","religion.sikh":"शीख","religion.other":"इतर",
      "stats.profiles":"सत्यापित प्रोफाइल्स","stats.matches":"यशस्वी जोड्या","stats.cities":"शहरे","stats.support":"24×7 मदत",
      "how.title":"हे कसे कार्य करते","how.s1t":"प्रोफाइल तयार करा","how.s1d":"मोफत साइन अप करा आणि काही मिनिटांत तपशील जोडा.","how.s2t":"शोधा आणि जोडले जा","how.s2d":"अनुरूप जोडीदार शोधण्यासाठी स्मार्ट फिल्टर वापरा.","how.s3t":"सत्यापन करा","how.s3d":"OTP आणि कागदपत्रांद्वारे प्रोफाइल सत्यापित करा.","how.s4t":"भेटा आणि लग्न करा","how.s4d":"बोला, कुटुंबांना भेटा आणि नवीन जीवन सुरू करा.",
      "feat.title":"निवडक प्रोफाइल","feat.viewAll":"सर्व प्रोफाइल पहा","p.verified":"सत्यापित","p.view":"प्रोफाइल पहा","p.interest":"इंटरेस्ट पाठवा","p.save":"सेव करा",
      "testi.title":"यशोगाथा","testi1.q":"आम्ही दोन महिन्यांत एकमेकांना भेटलो. धन्यवाद संगम!","testi2.q":"सत्यापन प्रक्रियेने आमच्या कुटुंबांना संपूर्ण विश्वास दिला.",
      "plans.title":"सदस्यता योजना","plan.free":"मोफत","plan.gold":"गोल्ड","plan.platinum":"प्लॅटिनम","plan.month":"/महिना","plan.cta":"योजना निवडा","plan.popular":"सर्वाधिक लोकप्रिय",
      "cta.title":"तुमची खास व्यक्ती भेटण्यासाठी तयार आहात का?","cta.text":"हजारों आनंदी जोड्यांमध्ये सामील व्हा. पुढची गोष्ट तुमची असू शकते.","cta.button":"मोफत सुरू करा",
      "sr.filters":"फिल्टर","sr.apply":"फिल्टर लावा","sr.reset":"रीसेट","sr.sort":"क्रमवारी","sort.match":"सर्वोत्तम जोड","sort.newest":"नवीन आधी","sr.showing":"128 पैकी 1–6 प्रोफाइल दाखवत आहोत","sr.prev":"मागील","sr.next":"पुढील",
      "sr.height":"उंची","sr.mstatus":"वैवाहिक स्थिती","mstatus.never":"अविवाहित","mstatus.divorced":"घटस्फोटीत","mstatus.widowed":"विधवा/विधुर","sr.mtongue":"मातृभाषा","sr.occupation":"व्यवसाय",
      "mt.hindi":"हिंदी","mt.marathi":"मराठी","mt.arabic":"अरबी","mt.english":"इंग्रजी",
      "reg.title":"तुमची मोफत प्रोफाइल तयार करा","reg.name":"पूर्ण नाव","reg.email":"ईमेल पत्ता","reg.phone":"मोबाइल क्रमांक","reg.pass":"पासवर्ड","reg.dob":"जन्मतारीख","reg.gender":"लिंग","reg.male":"पुरुष","reg.female":"स्त्री","reg.consent":"मी वापरण्याच्या अटी आणि गोपनीयता धोरणाशी सहमत आहे.","reg.submit":"प्रोफाइल तयार करा","reg.login":"आधीच सदस्य आहात? लॉगिन करा",
      "login.title":"सदस्य लॉगिन","login.remember":"मला लक्षात ठेवा","login.forgot":"पासवर्ड विसरलात?","login.submit":"लॉगिन",
      "contact.subject":"विषय","contact.message":"तुमचा संदेश","contact.send":"संदेश पाठवा",
      "about.title":"संगम मॅट्रिमोनीविषयी","dash.title":"माझा डॅशबोर्ड","dash.complete":"प्रोफाइल पूर्णता"
    },
    ar: {
      "skip":"تخطَّ إلى المحتوى الرئيسي","a11y.lang":"اختر اللغة","a11y.fsChanged":"تم تغيير حجم النص",
      "nav.home":"الرئيسية","nav.search":"البحث عن ملفات","nav.membership":"العضوية","nav.about":"من نحن","nav.contact":"اتصل بنا","nav.login":"تسجيل الدخول","nav.register":"سجّل مجانًا",
      "footer.tagline":"نساعد القلوب على الالتقاء منذ 2010.","footer.quick":"روابط سريعة","footer.legal":"قانوني","footer.privacy":"سياسة الخصوصية","footer.terms":"شروط الاستخدام","footer.refund":"سياسة الاسترداد","footer.follow":"تابعنا","footer.copy":"© 2025 سانجام ماتريموني. جميع الحقوق محفوظة.",
      "hero.badge":"خدمة الزواج الأكثر ثقة","hero.title":"ابحث عن شريك حياتك المثالي","hero.subtitle":"ملفات موثّقة 100%. خاصة وآمنة. سجّل مجانًا وابدأ رحلتك اليوم.","hero.cta":"سجّل مجانًا","hero.cta2":"تصفّح الملفات",
      "search.legend":"ابحث عن شريكك","search.lookingFor":"أبحث عن","look.groom":"عريس (ذكر)","look.bride":"عروس (أنثى)","search.ageFrom":"العمر من","search.ageTo":"العمر إلى","search.religion":"الديانة","search.city":"المدينة","search.citySelect":"اختر المدينة","search.submit":"ابحث الآن","common.any":"الكل",
      "religion.hindu":"هندوسي","religion.muslim":"مسلم","religion.christian":"مسيحي","religion.sikh":"سيخي","religion.other":"أخرى",
      "stats.profiles":"ملفات تعريف موثّقة","stats.matches":"زيجات ناجحة","stats.cities":"مدن مغطاة","stats.support":"دعم على مدار الساعة",
      "how.title":"كيف يعمل الموقع","how.s1t":"أنشئ ملفك","how.s1d":"سجّل مجانًا وأضف تفاصيلك في دقائق.","how.s2t":"ابحث وتواصل","how.s2d":"استخدم فلاتر ذكية للعثور على شريك مناسب.","how.s3t":"وثّق ملفك","how.s3d":"وثّق ملفك برمز التحقق والمستندات.","how.s4t":"تعرّف وتزوّج","how.s4d":"تحدث، تعرّف على العائلات وابدأ حياتك الجديدة.",
      "feat.title":"ملفات مميزة","feat.viewAll":"عرض جميع الملفات","p.verified":"موثّق","p.view":"عرض الملف","p.interest":"أرسل اهتمامًا","p.save":"حفظ",
      "testi.title":"قصص نجاح","testi1.q":"وجدنا بعضنا خلال شهرين. شكرًا سانجام!","testi2.q":"لقد منح التوثيق عائلتينا ثقة كاملة.",
      "plans.title":"خطط العضوية","plan.free":"مجانية","plan.gold":"ذهبية","plan.platinum":"بلاتينية","plan.month":"/شهريًا","plan.cta":"اختر الخطة","plan.popular":"الأكثر شيوعًا",
      "cta.title":"هل أنت مستعد للقاء شريكك المثالي؟","cta.text":"انضم إلى آلاف الأزواج السعداء. قد تكون قصتك هي التالية.","cta.button":"ابدأ مجانًا",
      "sr.filters":"التصفية","sr.apply":"تطبيق الفلاتر","sr.reset":"إعادة تعيين","sr.sort":"الترتيب حسب","sort.match":"الأفضل","sort.newest":"الأحدث أولًا","sr.showing":"عرض 1–6 من 128 ملفًا","sr.prev":"السابق","sr.next":"التالي",
      "sr.height":"الطول","sr.mstatus":"الحالة الاجتماعية","mstatus.never":"أعزب/عزباء","mstatus.divorced":"مطلق/ة","mstatus.widowed":"أرمل/ة","sr.mtongue":"اللغة الأم","sr.occupation":"المهنة",
      "mt.hindi":"الهندية","mt.marathi":"الماراثية","mt.arabic":"العربية","mt.english":"الإنجليزية",
      "reg.title":"أنشئ ملفك المجاني","reg.name":"الاسم الكامل","reg.email":"البريد الإلكتروني","reg.phone":"رقم الجوال","reg.pass":"كلمة المرور","reg.dob":"تاريخ الميلاد","reg.gender":"الجنس","reg.male":"ذكر","reg.female":"أنثى","reg.consent":"أوافق على شروط الاستخدام وسياسة الخصوصية.","reg.submit":"إنشاء الملف","reg.login":"عضو بالفعل؟ تسجيل الدخول",
      "login.title":"تسجيل دخول العضو","login.remember":"تذكرني","login.forgot":"هل نسيت كلمة المرور؟","login.submit":"تسجيل الدخول",
      "contact.subject":"الموضوع","contact.message":"رسالتك","contact.send":"إرسال الرسالة",
      "about.title":"عن سانجام ماتريموني","dash.title":"لوحتي","dash.complete":"اكتمال الملف"
    }
  };

  var root = document.documentElement;

  function t(lang, key) {
    return (I18N[lang] && I18N[lang][key]) || I18N.en[key] || '';
  }
  function announce(msg) {
    var region = document.getElementById('a11y-status');
    if (region) { region.textContent = ''; setTimeout(function () { region.textContent = msg; }, 60); }
  }

  function applyLang(lang) {
    if (!I18N[lang]) lang = 'en';
    var isRtl = RTL.indexOf(lang) !== -1;
    root.lang = lang;
    root.dir = isRtl ? 'rtl' : 'ltr';
    var bs = document.getElementById('bs-css');
    if (bs) bs.href = isRtl ? BS.rtl : BS.ltr;

    document.querySelectorAll('[data-i18n]').forEach(function (el) {
      var v = t(lang, el.getAttribute('data-i18n')); if (v) el.textContent = v;
    });
    document.querySelectorAll('[data-i18n-placeholder]').forEach(function (el) {
      var v = t(lang, el.getAttribute('data-i18n-placeholder')); if (v) el.setAttribute('placeholder', v);
    });
    document.querySelectorAll('[data-i18n-aria-label]').forEach(function (el) {
      var v = t(lang, el.getAttribute('data-i18n-aria-label')); if (v) el.setAttribute('aria-label', v);
    });
    var sel = document.getElementById('langSelect');
    if (sel) sel.value = lang;
    try { localStorage.setItem('mm-lang', lang); } catch (e) {}
    var label = sel && sel.selectedOptions[0] ? sel.selectedOptions[0].text : lang;
    announce(t(lang, 'a11y.lang') + ': ' + label);
  }

  function applyFs(fs) {
    if (['sm','md','lg'].indexOf(fs) === -1) fs = 'md';
    root.setAttribute('data-fs', fs);
    try { localStorage.setItem('mm-fs', fs); } catch (e) {}
    document.querySelectorAll('[data-fs-btn]').forEach(function (b) {
      b.setAttribute('aria-pressed', b.getAttribute('data-fs-btn') === fs ? 'true' : 'false');
    });
    announce(t(root.lang || 'en', 'a11y.fsChanged'));
  }

  document.addEventListener('DOMContentLoaded', function () {
    var savedLang = 'en', savedFs = 'md';
    try { savedLang = localStorage.getItem('mm-lang') || 'en'; savedFs = localStorage.getItem('mm-fs') || 'md'; } catch (e) {}
    applyLang(savedLang);
    applyFs(savedFs);

    var sel = document.getElementById('langSelect');
    if (sel) sel.addEventListener('change', function (e) { applyLang(e.target.value); });

    document.querySelectorAll('[data-fs-btn]').forEach(function (b) {
      b.addEventListener('click', function () { applyFs(b.getAttribute('data-fs-btn')); });
    });

    /* Show / hide password (accessible toggle) */
    document.querySelectorAll('[data-toggle-password]').forEach(function (btn) {
      btn.addEventListener('click', function () {
        var input = document.getElementById(btn.getAttribute('data-toggle-password'));
        if (!input) return;
        var show = input.type === 'password';
        input.type = show ? 'text' : 'password';
        btn.setAttribute('aria-pressed', show ? 'true' : 'false');
        var icon = btn.querySelector('i');
        if (icon) icon.className = show ? 'bi bi-eye-slash' : 'bi bi-eye';
        btn.setAttribute('aria-label', show ? 'Hide password' : 'Show password');
      });
    });
  });
})();