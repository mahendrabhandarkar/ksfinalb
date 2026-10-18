# Vivaah Royal — Flutter App

A premium matrimony app built with **Flutter 3.47 (stable) / Dart 3.13**, sound
null safety throughout, and only **Flutter Favorite / first-party** packages.
The visual identity (deep crimson `#8F1D22`, royal gold `#C89B2C`, ivory) is
drawn from the Kartavirya Sahasrarjun painting.

**Targets: Android and iOS only** — this project intentionally ships no web,
Windows, macOS or Linux platform folders. The `android/` and `ios/` folders are
included, generated with Flutter 3.47.7 tooling (Gradle 8.x / Kotlin, Swift
`AppDelegate`), so the app builds for phones and tablets out of the box.

---

## 1. Architecture — Layered MVVM + Repository (Riverpod)

Business logic and UI are strictly separated. Each layer may only talk to the
layer directly below it, and dependencies always point **inwards**:

```
┌────────────────────────────────────────────────────────────┐
│  UI (Views)                        lib/presentation/views  │
│  Pure Flutter widgets. Zero business logic. They watch     │
│  providers, dispatch intents, render state.                │
└──────────────▲─────────────────────────────────────────────┘
               │ watch state / send intents
┌──────────────┴─────────────────────────────────────────────┐
│  ViewModels (Controllers)        lib/presentation/controllers
│  Riverpod Notifier / AsyncNotifier classes. Own UI state,  │
│  validate intent, call repositories, expose derived state. │
└──────────────▲─────────────────────────────────────────────┘
               │ domain contracts only
┌──────────────┴─────────────────────────────────────────────┐
│  Domain                          lib/domain                │
│  Pure Dart: entities (Profile, AppUser, ChatMessage,       │
│  MembershipPlan, SearchFilters) + repository interfaces.   │
│  No Flutter imports — 100% unit-testable.                  │
└──────────────▲─────────────────────────────────────────────┘
               │ implemented by
┌──────────────┴─────────────────────────────────────────────┐
│  Data                            lib/data                  │
│  Repository implementations + data sources:                │
│  MockDataSource (offline demo), LocalStorageDataSource     │
│  (shared_preferences), RemoteAuthDataSource (dio), mappers │
└──────────────▲─────────────────────────────────────────────┘
               │ wired by
┌──────────────┴─────────────────────────────────────────────┐
│  Core + DI      lib/core (theme, router, validators,       │
│                 network, errors)  ·  lib/di.dart           │
└────────────────────────────────────────────────────────────┘
```

### Why this stack

| Concern | Choice | Why |
|---|---|---|
| State management / DI | `flutter_riverpod` (Flutter Favorite) | Compile-safe, testable, no BuildContext for logic; `Notifier`/`AsyncNotifier` are the modern API |
| Navigation | `go_router` (Flutter Favorite, by the Flutter team) | Declarative routes, deep links, `StatefulShellRoute.indexedStack` keeps tab state |
| HTTP | `dio` (Flutter Favorite) | Interceptors, timeouts, typed errors — pre-wired in `ApiClient` |
| Persistence | `shared_preferences` (first-party) | Key-value session/shortlist/chat cache via the new `SharedPreferencesWithCache` |
| Fonts | `google_fonts` (Flutter Favorite) | Playfair Display + Inter with graceful runtime loading |
| Images | `cached_network_image` (Flutter Favorite) | Cached profile photos with `InitialsAvatar` fallback |
| Formatting | `intl` (first-party) | `en_IN` currency + date formatting |
| Tests | `flutter_test` + `mocktail` (Flutter Favorite) | Pure-domain unit tests included |
| Lints | `flutter_lints` (official) + strict casts/inference | CI-grade analysis in `analysis_options.yaml` |

### Data flow example — sending an interest

```
ProfileDetailScreen (View)
   └─ ref.read(interestsControllerProvider.notifier).send(id)   ← intent
        └─ InterestsController (ViewModel)
             └─ ProfileRepository.sendInterest(id)              ← contract
                  └─ ProfileRepositoryImpl (Data)
                       └─ LocalStorageDataSource                ← persists
             ← returns InterestRecord(sent)
        └─ state = {id: sent} → UI updates automatically
        └─ await repo.awaitAcceptance(id) (demo transport, 6 s)
        └─ state = {id: accepted} → button flips to "Matched 🎉"
```

Route guards are declarative: `routerProvider` listens to
`sessionControllerProvider` and redirects between splash → onboarding →
login → app shell. Screens never push auth routes manually.

---

## 2. Project layout

```
lib/
├── main.dart                  # prefs init + ProviderScope overrides
├── app.dart                   # MaterialApp.router + theme
├── di.dart                    # composition root (all providers wired)
├── core/
│   ├── constants/app_constants.dart
│   ├── errors/app_exceptions.dart      # sealed AppException hierarchy
│   ├── network/api_client.dart         # configured Dio for the future API
│   ├── router/ (app_router.dart, route_names.dart)
│   ├── theme/ (app_colors.dart, app_theme.dart)
│   └── utils/validators.dart           # pure validation rules
├── domain/
│   ├── entities/ (profile, user, chat, interest, membership_plan,
│   │              search_filters)
│   └── repositories/ (auth, profile, chat, membership)   # interfaces
├── data/
│   ├── datasources/ (mock_data_source, local_storage_data_source,
│   │                 remote_auth_data_source)
│   ├── mappers/user_mapper.dart
│   └── repositories/ (…_impl.dart)
└── presentation/
    ├── controllers/ (session, profiles, search, chat, membership)
    ├── widgets/ (PrimaryButton, InitialsAvatar, ProfileCard/Tile,
    │             SectionHeader, EmptyState)
    └── views/ (splash, onboarding, auth/login+register, shell,
                home, search, profile, chat/inbox+thread,
                membership, dashboard)
test/  (validators, search filters, mock data + repository)
```

### Screens included

Splash · Onboarding · Login (password + OTP tabs) · 4-step Register ·
Home feed (premium carousel + match grid) · Search with full filter sheet ·
Profile detail (interest / shortlist / chat actions) · Inbox · Chat with
typing indicator · Membership plans with duration pricing · Dashboard with
stats and sign-out.

---

## 3. Getting started

Requirements: **Flutter ≥ 3.47.0** (Dart ≥ 3.13). Check with `flutter --version`.

```bash
# 1. Fetch packages
flutter pub get

# 2. Run on an Android or iOS device / emulator / simulator
flutter devices            # list available targets
flutter run                # picks a connected mobile device
flutter run -d android     # or -d <device-id>, e.g. iPhone 15 simulator

# 3. Release builds
flutter build apk --release          # Android
flutter build ipa --release          # iOS (requires macOS + Xcode)

# If your Flutter version differs and Gradle/Xcode regenerate is needed:
flutter create . --project-name vivaah_royal \
    --org com.vivaahroyal --platforms android,ios

# 4. Static analysis + tests
flutter analyze
flutter test
```

> The archive already contains a `pubspec.lock` for reproducible resolution.
> If your Flutter version differs, `pub` will re-resolve automatically.

### Demo behaviour (no backend needed)

* **Sign in / OTP** — any well-formed credentials work; the demo OTP is shown
  in a snackbar for reviewers.
* **Interests** — sending one flips to *Interest sent*, then auto-*accepted*
  after ~6 s (simulated response) → the chat action unlocks.
* **Chat** — partners reply after a short "typing…" delay; threads persist.
* **Shortlists, session, onboarding** — persisted locally across restarts.
* **Photos** — mock avatars load from pravatar.cc; offline they gracefully
  fall back to branded initials tiles.

---

## 4. Going to production

1. **API** — point `AppConstants.apiBaseUrl` at your backend and flip
   `useRemoteApi: true` in `AuthRepositoryImpl`; `RemoteAuthDataSource` +
   `ApiClient` (auth header, timeouts, error mapping) are already implemented.
2. **Real-time chat** — implement `ChatRepository` against WebSockets/FCM;
   the controller and UI need no changes.
3. **Auth hardening** — swap the mock auth for Firebase Auth or your OAuth
   provider behind the same `AuthRepository` contract.
4. **Models at scale** — consider `freezed` + `json_serializable`
   (Flutter Favorites) to replace the hand-written `toJson/fromJson`.
5. **Payments** — replace `MembershipRepositoryImpl.purchase` with your
   payment gateway; keep the same receipt contract.
6. **Fonts offline** — bundle Playfair Display/Inter TTFs and switch
   `google_fonts` to local assets.

## 5. Design tokens

| Token | Value |
|---|---|
| Primary (crimson) | `#8F1D22` · dark `#661114` |
| Secondary (royal gold) | `#C89B2C` · light `#E9C46A` |
| Accent (royal blue) | `#2B4C8C` |
| Background (ivory) | `#FAF5EC` · surface `#FFFDF8` |
| Ink / muted text | `#33251F` / `#7A6A5F` |
| Headings font | Playfair Display (700) |
| Body font | Inter (400–700) |
