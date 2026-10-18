/* ============================================================
   Vivaah Royal Matrimony — Mock data layer
   ============================================================ */
"use strict";

const RELIGIONS = ["Hindu", "Muslim", "Christian", "Sikh", "Jain", "Buddhist"];
const COMMUNITIES = ["Brahmin", "Kshatriya", "Agarwal", "Khatri", "Iyer", "Nair", "Reddy", "Patel", "Sindhi", "Kayastha", "Jat", "Bunt"];
const TONGUES = ["Hindi", "Marathi", "Gujarati", "Tamil", "Telugu", "Kannada", "Malayalam", "Punjabi", "Bengali", "Konkani"];
const MARITAL = ["Never Married", "Divorced", "Widowed", "Awaiting Divorce"];
const DIETS = ["Vegetarian", "Non-Vegetarian", "Eggetarian", "Jain Food"];
const COUNTRIES = ["India", "United Arab Emirates", "United States", "United Kingdom", "Singapore", "Australia", "Canada"];
const EDU = ["B.Tech", "M.Tech", "MBBS", "MD", "MBA", "CA", "M.Com", "B.Arch", "Ph.D", "LLB", "M.Sc", "B.Des"];
const JOBS = [
  "Software Engineer at Infosys", "Doctor at Apollo Hospitals", "Chartered Accountant (Self Employed)",
  "Product Manager at Flipkart", "Civil Services - IAS", "Professor at Delhi University",
  "Business Analyst at TCS", "Architect at L&T", "Investment Banker at HDFC",
  "Graphic Designer at Zoho", "Advocate at Delhi High Court", "Entrepreneur - Textile Export",
  "Data Scientist at Amazon", "HR Manager at Wipro", "Bank Officer at SBI",
  "Marketing Lead at Asian Paints", "Pilot at Air India", "Research Scientist at ISRO"
];

/* gender: F = Female (bride), M = Male (groom) */
const PROFILES = [
  { id: 1,  name: "Ananya Sharma",      gender: "F", age: 26, height: "5 ft 4 in", city: "Mumbai",       state: "Maharashtra",    country: "India",        religion: "Hindu",    community: "Brahmin",    tongue: "Marathi",   marital: "Never Married", edu: "M.Tech", college: "IIT Bombay",        job: "Software Engineer at Infosys",     income: "₹ 14 - 16 Lakh", diet: "Vegetarian",    verified: true,  premium: true,  isNew: true,  lastSeen: "Online now",  about: "I am a software engineer who loves classical dance, weekend treks and quiet Sunday mornings with a good book. Family means everything to me and I hope to find a partner who values warmth, honesty and laughter." },
  { id: 2,  name: "Arjun Chauhan",      gender: "M", age: 28, height: "5 ft 10 in", city: "Delhi NCR",    state: "Delhi",          country: "India",        religion: "Hindu",    community: "Kshatriya",  tongue: "Hindi",     marital: "Never Married", edu: "MBA",    college: "IIM Ahmedabad",     job: "Product Manager at Flipkart",      income: "₹ 22 - 25 Lakh", diet: "Non-Vegetarian",verified: true,  premium: true,  isNew: false, lastSeen: "2 hours ago", about: "Third-generation army family now settled in Delhi. I enjoy cricket, road trips and exploring street food. Looking for a partner who is independent, kind and ready to build a home full of joy." },
  { id: 3,  name: "Priya Iyer",         gender: "F", age: 25, height: "5 ft 3 in", city: "Bengaluru",    state: "Karnataka",      country: "India",        religion: "Hindu",    community: "Iyer",       tongue: "Tamil",     marital: "Never Married", edu: "MBBS",   college: "CMC Vellore",       job: "Doctor at Apollo Hospitals",       income: "₹ 18 - 20 Lakh", diet: "Vegetarian",    verified: true,  premium: false, isNew: true,  lastSeen: "Online now",  about: "A paediatrician by profession and a Carnatic music enthusiast by heart. I believe marriage is a partnership of equals. Seeking a caring, well-settled person who respects both tradition and individuality." },
  { id: 4,  name: "Vikram Reddy",       gender: "M", age: 30, height: "6 ft 0 in", city: "Hyderabad",    state: "Telangana",      country: "India",        religion: "Hindu",    community: "Reddy",      tongue: "Telugu",    marital: "Never Married", edu: "M.Tech", college: "NIT Warangal",      job: "Data Scientist at Amazon",         income: "₹ 30 - 35 Lakh", diet: "Non-Vegetarian",verified: true,  premium: true,  isNew: false, lastSeen: "Yesterday",   about: "I run the analytics team at a large e-commerce firm. Weekend cyclist, aspiring cook and a devoted son. I would love to meet someone who balances career and family with grace." },
  { id: 5,  name: "Sneha Patel",        gender: "F", age: 24, height: "5 ft 5 in", city: "Ahmedabad",    state: "Gujarat",        country: "India",        religion: "Hindu",    community: "Patel",      tongue: "Gujarati",  marital: "Never Married", edu: "B.Des",  college: "NID Ahmedabad",     job: "Graphic Designer at Zoho",         income: "₹ 8 - 10 Lakh",  diet: "Jain Food",     verified: true,  premium: false, isNew: true,  lastSeen: "3 days ago",  about: "Designer, doodler and die-hard Garba fan. I grew up in a joint family and value closeness, festivals and home-cooked meals. Hoping to find a partner who is my best friend first." },
  { id: 6,  name: "Rahul Khatri",       gender: "M", age: 27, height: "5 ft 9 in", city: "Pune",         state: "Maharashtra",    country: "India",        religion: "Hindu",    community: "Khatri",     tongue: "Hindi",     marital: "Never Married", edu: "B.Tech", college: "VIT Vellore",       job: "Business Analyst at TCS",          income: "₹ 12 - 14 Lakh", diet: "Eggetarian",    verified: false, premium: false, isNew: false, lastSeen: "4 hours ago", about: "Simple, ambitious and slightly obsessed with badminton. I believe in growing together and celebrating small wins. Looking for a cheerful partner to share life's journey." },
  { id: 7,  name: "Kavya Nair",         gender: "F", age: 27, height: "5 ft 2 in", city: "Kochi",        state: "Kerala",         country: "India",        religion: "Hindu",    community: "Nair",       tongue: "Malayalam", marital: "Never Married", edu: "MBA",    college: "IIM Kozhikode",     job: "Marketing Lead at Asian Paints",   income: "₹ 16 - 18 Lakh", diet: "Non-Vegetarian",verified: true,  premium: false, isNew: false, lastSeen: "Online now",  about: "Marketing professional, Bharatanatyam dancer and monsoon lover. I come from a close-knit family in Kerala. Seeking a mature, humorous partner who cherishes both silence and conversations." },
  { id: 8,  name: "Aditya Singh",       gender: "M", age: 29, height: "6 ft 1 in", city: "Lucknow",      state: "Uttar Pradesh",  country: "India",        religion: "Hindu",    community: "Kshatriya",  tongue: "Hindi",     marital: "Never Married", edu: "LLB",    college: "NLU Lucknow",       job: "Advocate at Delhi High Court",     income: "₹ 20 - 24 Lakh", diet: "Vegetarian",    verified: true,  premium: false, isNew: true,  lastSeen: "1 hour ago",  about: "Practising advocate, history buff and weekend poet. I value integrity above all. Looking for a partner who is articulate, compassionate and grounded in family values." },
  { id: 9,  name: "Meera Desai",        gender: "F", age: 28, height: "5 ft 6 in", city: "Bengaluru",    state: "Karnataka",      country: "India",        religion: "Hindu",    community: "Bunt",       tongue: "Konkani",   marital: "Never Married", edu: "M.Sc",   college: "IISc Bengaluru",    job: "Research Scientist at ISRO",       income: "₹ 19 - 22 Lakh", diet: "Vegetarian",    verified: true,  premium: true,  isNew: false, lastSeen: "Online now",  about: "Space research, stray-dog rescue and coastal Konkan summers describe me well. I seek a partner who is curious about the universe and gentle in everyday life." },
  { id: 10, name: "Siddharth Gupta",    gender: "M", age: 31, height: "5 ft 11 in", city: "Mumbai",      state: "Maharashtra",    country: "India",        religion: "Hindu",    community: "Agarwal",    tongue: "Hindi",     marital: "Divorced",      edu: "CA",     college: "SRCC Delhi",        job: "Chartered Accountant (Self Employed)", income: "₹ 28 - 32 Lakh", diet: "Vegetarian",verified: true, premium: false, isNew: false, lastSeen: "2 days ago",  about: "A fresh start matters more than a perfect past. I run my own practice, love long drives and learning tabla. Looking for a mature partner ready to build a peaceful, happy home." },
  { id: 11, name: "Ishita Roy",         gender: "F", age: 26, height: "5 ft 4 in", city: "Kolkata",      state: "West Bengal",    country: "India",        religion: "Hindu",    community: "Kayastha",   tongue: "Bengali",   marital: "Never Married", edu: "M.Com",  college: "Presidency University", job: "Bank Officer at SBI",          income: "₹ 9 - 11 Lakh",  diet: "Non-Vegetarian",verified: false, premium: false, isNew: true,  lastSeen: "6 hours ago", about: "Banker by day, Rabindra Sangeet singer by evening. I enjoy adda over coffee and riverside walks. Seeking a partner who finds poetry in ordinary days." },
  { id: 12, name: "Nikhil Mehta",       gender: "M", age: 26, height: "5 ft 8 in", city: "Dubai",        state: "Dubai",          country: "United Arab Emirates", religion: "Hindu", community: "Sindhi", tongue: "Sindhi", marital: "Never Married", edu: "B.Tech", college: "BITS Pilani",       job: "Investment Banker at HDFC",        income: "₹ 35 - 40 Lakh", diet: "Vegetarian",    verified: true,  premium: true,  isNew: false, lastSeen: "Yesterday",   about: "Based in Dubai, rooted in Mumbai. I love fintech, Formula 1 and my grandmother's sindhi kadhi. Hoping to meet someone who values ambition and family in equal measure." },
  { id: 13, name: "Roshni Kaur",        gender: "F", age: 27, height: "5 ft 7 in", city: "Chandigarh",   state: "Punjab",         country: "India",        religion: "Sikh",     community: "Jat",        tongue: "Punjabi",   marital: "Never Married", edu: "MBA",    college: "UBS Chandigarh",    job: "HR Manager at Wipro",              income: "₹ 15 - 18 Lakh", diet: "Non-Vegetarian",verified: true,  premium: false, isNew: false, lastSeen: "Online now",  about: "Punjabi at heart, global at work. Bhangra keeps me fit and langar seva keeps me humble. Looking for a partner with a good heart and a great sense of humour." },
  { id: 14, name: "Harsh Joshi",        gender: "M", age: 28, height: "5 ft 7 in", city: "Vadodara",     state: "Gujarat",        country: "India",        religion: "Hindu",    community: "Brahmin",    tongue: "Gujarati",  marital: "Never Married", edu: "B.Arch", college: "CEPT University",   job: "Architect at L&T",                 income: "₹ 13 - 15 Lakh", diet: "Vegetarian",    verified: false, premium: false, isNew: true,  lastSeen: "3 hours ago", about: "I design sustainable homes and dream of opening a design school. Seeking a partner who shares my love for art, travel and simple living." },
  { id: 15, name: "Neha Agarwal",       gender: "F", age: 29, height: "5 ft 3 in", city: "Delhi NCR",    state: "Delhi",          country: "India",        religion: "Jain",     community: "Agarwal",    tongue: "Hindi",     marital: "Never Married", edu: "CA",     college: "Hansraj College",   job: "Chartered Accountant (Self Employed)", income: "₹ 20 - 24 Lakh", diet: "Jain Food", verified: true, premium: true, isNew: false, lastSeen: "Online now", about: "Practising Jain, practising CA. Paryushan parv and powerlifting both feature in my week. Looking for a respectful, health-conscious partner who loves family gatherings." },
  { id: 16, name: "Varun Pillai",       gender: "M", age: 32, height: "5 ft 10 in", city: "Singapore",   state: "Singapore",      country: "Singapore",    religion: "Hindu",    community: "Nair",       tongue: "Malayalam", marital: "Never Married", edu: "Ph.D",   college: "NUS Singapore",     job: "Research Scientist at A*STAR",     income: "₹ 40 - 45 Lakh", diet: "Vegetarian",    verified: true,  premium: true,  isNew: false, lastSeen: "5 hours ago", about: "Scientist in Singapore, soul from Palakkad. Chess, cycling and Chettinad cuisine are my constants. Seeking a kind, thoughtful partner to share explorations with." },
  { id: 17, name: "Pallavi Kulkarni",   gender: "F", age: 25, height: "5 ft 5 in", city: "Nagpur",       state: "Maharashtra",    country: "India",        religion: "Buddhist", community: "Kayastha",   tongue: "Marathi",   marital: "Never Married", edu: "B.Tech", college: "VNIT Nagpur",       job: "Business Analyst at TCS",          income: "₹ 10 - 12 Lakh", diet: "Vegetarian",    verified: false, premium: false, isNew: true,  lastSeen: "Online now",  about: "Engineer, yoga practitioner and proud mulgi of Nagpur. I meditate daily and love molecular gastronomy experiments. Seeking a calm, curious partner." },
  { id: 18, name: "Aakash Malhotra",    gender: "M", age: 27, height: "6 ft 0 in", city: "New York",     state: "New York",       country: "United States", religion: "Hindu",   community: "Khatri",     tongue: "Punjabi",   marital: "Never Married", edu: "MBA",    college: "NYU Stern",         job: "Investment Banker at HDFC",        income: "₹ 45 - 50 Lakh", diet: "Non-Vegetarian",verified: true,  premium: false, isNew: false, lastSeen: "Yesterday",   about: "Wall Street by profession, Bollywood dancer by talent. I call my parents every night and cook every Sunday. Looking for a partner open to a global life with Indian roots." },
  { id: 19, name: "Divya Raghavan",     gender: "F", age: 30, height: "5 ft 6 in", city: "Chennai",      state: "Tamil Nadu",     country: "India",        religion: "Hindu",    community: "Iyer",       tongue: "Tamil",     marital: "Awaiting Divorce", edu: "MD",  college: "Madras Medical College", job: "Doctor at Apollo Hospitals",  income: "₹ 24 - 28 Lakh", diet: "Vegetarian", verified: true, premium: false, isNew: false, lastSeen: "2 days ago", about: "A dermatologist who believes healing begins with listening. Life gave me a second chance and I am ready to fill it with trust, travel and filter coffee." },
  { id: 20, name: "Rohan Deshmukh",     gender: "M", age: 33, height: "5 ft 9 in", city: "London",       state: "London",         country: "United Kingdom", religion: "Hindu",  community: "Patel",      tongue: "Marathi",   marital: "Widowed",       edu: "M.Tech", college: "Imperial College London", job: "Data Scientist at Amazon",   income: "₹ 38 - 42 Lakh", diet: "Non-Vegetarian",verified: true, premium: true, isNew: false, lastSeen: "6 hours ago", about: "After losing my first wife, I rebuilt myself around gratitude. I have a 3-year-old daughter who is my sunshine. Seeking a compassionate friend for life's second innings." },
  { id: 21, name: "Shruti Verma",       gender: "F", age: 24, height: "5 ft 4 in", city: "Indore",       state: "Madhya Pradesh", country: "India",        religion: "Hindu",    community: "Brahmin",    tongue: "Hindi",     marital: "Never Married", edu: "LLB",    college: "DAVV Indore",       job: "Advocate at Delhi High Court",     income: "₹ 7 - 9 Lakh",   diet: "Vegetarian",    verified: false, premium: false, isNew: true,  lastSeen: "Online now",  about: "Young lawyer, old soul. I enjoy kathak, court craft and my nani's chutneys. Looking for a partner who respects dreams — mine and his." },
  { id: 22, name: "Devansh Saxena",     gender: "M", age: 25, height: "5 ft 8 in", city: "Bengaluru",    state: "Karnataka",      country: "India",        religion: "Hindu",    community: "Kayastha",   tongue: "Hindi",     marital: "Never Married", edu: "B.Tech", college: "PES University",    job: "Software Engineer at Infosys",     income: "₹ 11 - 13 Lakh", diet: "Eggetarian",    verified: false, premium: false, isNew: false, lastSeen: "4 hours ago", about: "Full-stack developer, full-time foodie. Weekend cricket, weekday code. Looking for a partner who laughs easily and dreams big." },
  { id: 23, name: "Tanvi Shah",         gender: "F", age: 26, height: "5 ft 2 in", city: "Surat",        state: "Gujarat",        country: "India",        religion: "Jain",     community: "Agarwal",    tongue: "Gujarati",  marital: "Never Married", edu: "B.Des",  college: "MIT Institute of Design", job: "Graphic Designer at Zoho",  income: "₹ 9 - 11 Lakh",  diet: "Jain Food",    verified: true,  premium: false, isNew: false, lastSeen: "1 hour ago",  about: "Typography nerd, Chikankari collector and temple-hop traveller. Seeking a partner who values compassion, cleanliness and a shared cup of masala chai." },
  { id: 24, name: "Karthik Menon",      gender: "M", age: 29, height: "5 ft 11 in", city: "Kochi",       state: "Kerala",         country: "India",        religion: "Christian", community: "Nair",      tongue: "Malayalam", marital: "Never Married", edu: "MBA",    college: "IIM Calcutta",      job: "Marketing Lead at Asian Paints",   income: "₹ 21 - 24 Lakh", diet: "Non-Vegetarian",verified: true,  premium: false, isNew: true,  lastSeen: "Online now",  about: "Marketer, map-lover and monsoon-trekker. I believe faith is personal and partnership is practical poetry. Looking for a warm, witty partner." }
];

const SUCCESS_STORIES = [
  {
    couple: "Ritika & Sameer", city: "Mumbai", married: "Married in February 2025",
    img: "img/story-1.png",
    quote: "We matched on a Tuesday and talked for six hours that night. Four years and one beautiful daughter later, we still talk till 2 AM — only now it is about baby names for the second one!",
    rating: 5
  },
  {
    couple: "Lakshmi & Nandish", city: "Bengaluru", married: "Married in December 2024",
    img: "img/story-2.png",
    quote: "Our horoscopes matched, but more importantly our memes matched. The family filter helped both sets of parents approve within a month. Thank you Vivaah Royal for making it so easy!",
    rating: 5
  },
  {
    couple: "Farah & Imran", city: "Hyderabad", married: "Married in June 2025",
    img: null,
    quote: "We were each other's first 'express interest'. From a single notification to a nikkah of a thousand blessings — this platform respected our faith, privacy and pace.",
    rating: 5
  },
  {
    couple: "Simran & Tejas", city: "Pune", married: "Married in January 2026",
    img: null,
    quote: "Both of us worked nights — the 'Online now' feature meant we always found each other. The video-call before meeting was the game changer for us.",
    rating: 4
  }
];

const PLANS = [
  {
    id: "free", name: "Freedom", price: "0", per: "Free Forever",
    tagline: "Begin your search",
    feats: [
      ["Create a detailed profile", true],
      ["Browse unlimited profiles", true],
      ["Send up to 5 interests / month", true],
      ["Receive & accept interests", true],
      ["View phone numbers", false],
      ["Unlimited chat with members", false],
      ["Priority in search results", false],
      ["Dedicated relationship advisor", false]
    ]
  },
  {
    id: "silver", name: "Silver", price: "1,999", per: "3 Months",
    tagline: "Start connecting",
    feats: [
      ["Create a detailed profile", true],
      ["Browse unlimited profiles", true],
      ["Send up to 25 interests / month", true],
      ["Receive & accept interests", true],
      ["View phone numbers", true],
      ["Unlimited chat with members", false],
      ["Priority in search results", false],
      ["Dedicated relationship advisor", false]
    ]
  },
  {
    id: "gold", name: "Gold", price: "3,499", per: "6 Months",
    tagline: "Most loved by members",
    feats: [
      ["Create a detailed profile", true],
      ["Browse unlimited profiles", true],
      ["Send unlimited interests", true],
      ["Receive & accept interests", true],
      ["View phone numbers", true],
      ["Unlimited chat with members", true],
      ["Priority in search results", true],
      ["Dedicated relationship advisor", false]
    ]
  },
  {
    id: "platinum", name: "Platinum", price: "5,999", per: "12 Months",
    tagline: "The royal treatment",
    feats: [
      ["Create a detailed profile", true],
      ["Browse unlimited profiles", true],
      ["Send unlimited interests", true],
      ["Receive & accept interests", true],
      ["View phone numbers", true],
      ["Unlimited chat with members", true],
      ["Priority in search results", true],
      ["Dedicated relationship advisor", true]
    ]
  }
];

const FAQS = [
  { cat: "Getting Started", q: "How do I create my profile on Vivaah Royal?", a: "Click 'Join Free Now', complete the four simple steps — basic details, community information, education & career, and contact details. Registration takes under 5 minutes and your profile becomes visible to millions of members instantly. You can edit anything later from your dashboard." },
  { cat: "Getting Started", q: "Is Vivaah Royal really free to join?", a: "Yes. Creating a profile, browsing matches and sending up to 5 interests every month is completely free, forever. Our Freedom plan never expires. Premium plans simply unlock faster, richer ways to connect — like viewing contact numbers and unlimited chat." },
  { cat: "Matches & Privacy", q: "Who can see my photos and contact details?", a: "You are always in control. Photos are shown with a 'Protected' badge by default and contact details are never displayed publicly — only members you have accepted can view them. You may further restrict visibility in Settings → Privacy at any time." },
  { cat: "Matches & Privacy", q: "How does Vivaah Royal suggest matches?", a: "Our engine weighs over 30 signals — age, height, community, mother tongue, city, education, profession, diet, lifestyle and partner preferences you set. New matches are refreshed daily and appear under 'Today's Matches' in your dashboard." },
  { cat: "Matches & Privacy", q: "What is a Protected Profile?", a: "A protected profile hides your photo from public search results and shows an elegant placeholder instead. Photos are shared only with members you express interest in or accept. Many members choose this until they feel comfortable." },
  { cat: "Verification & Safety", q: "What does the blue verified tick mean?", a: "A blue tick confirms the member's mobile number AND at least one government ID have been manually checked by our trust & safety team. Look for it before you share personal information — it is our strongest authenticity signal." },
  { cat: "Verification & Safety", q: "How do I report a suspicious profile?", a: "Use the 'Report' link on any profile. Our team reviews every report within 24 hours and removes members who violate our guidelines. Never share OTPs, bank details or transfer money — legitimate matches will never ask." },
  { cat: "Membership & Billing", q: "How do I upgrade or cancel my plan?", a: "Go to Membership → choose a plan → pay securely via UPI, cards or net banking. Upgrades apply instantly; you can cancel auto-renewal anytime from Settings — your premium features continue till the paid period ends." },
  { cat: "Membership & Billing", q: "Is there a refund policy?", a: "Yes. If you find no genuine matches within 30 days of a premium purchase, contact support with your registered number. Eligible refunds are processed to the original payment method within 7 working days." }
];

/* ---------- helpers ---------- */
function getProfile(id) {
  return PROFILES.find(function (p) { return p.id === Number(id); }) || null;
}

function initialsOf(name) {
  return name.trim().split(/\s+/).map(function (w) { return w[0]; }).slice(0, 2).join("").toUpperCase();
}

/* Simple deterministic filter used by search + matches pages */
function filterProfiles(f) {
  f = f || {};
  return PROFILES.filter(function (p) {
    if (f.gender && p.gender !== f.gender) return false;
    if (f.ageMin && p.age < f.ageMin) return false;
    if (f.ageMax && p.age > f.ageMax) return false;
    if (f.religion && p.religion !== f.religion) return false;
    if (f.community && p.community !== f.community) return false;
    if (f.tongue && p.tongue !== f.tongue) return false;
    if (f.country && p.country !== f.country) return false;
    if (f.marital && p.marital !== f.marital) return false;
    if (f.diet && p.diet !== f.diet) return false;
    if (f.edu && p.edu !== f.edu) return false;
    if (f.verifiedOnly && !p.verified) return false;
    if (f.premiumOnly && !p.premium) return false;
    if (f.photoOnly && !p.verified) return false;
    if (f.kw) {
      const kw = f.kw.toLowerCase();
      const hay = (p.name + " " + p.city + " " + p.edu + " " + p.job + " " + p.community + " " + p.tongue + " " + p.about).toLowerCase();
      if (hay.indexOf(kw) === -1) return false;
    }
    return true;
  });
}
