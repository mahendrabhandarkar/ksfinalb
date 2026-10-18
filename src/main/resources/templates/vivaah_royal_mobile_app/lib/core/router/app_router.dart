import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/controllers/session_controller.dart';
import '../../presentation/views/auth/login_screen.dart';
import '../../presentation/views/auth/register_screen.dart';
import '../../presentation/views/chat/chat_screen.dart';
import '../../presentation/views/chat/inbox_screen.dart';
import '../../presentation/views/dashboard/dashboard_screen.dart';
import '../../presentation/views/home/home_screen.dart';
import '../../presentation/views/membership/membership_screen.dart';
import '../../presentation/views/onboarding/onboarding_screen.dart';
import '../../presentation/views/profile/profile_detail_screen.dart';
import '../../presentation/views/search/search_screen.dart';
import '../../presentation/views/shell/app_shell.dart';
import '../../presentation/views/splash/splash_screen.dart';
import 'route_names.dart';

/// Declarative navigation graph.
///
/// The router reacts to authentication changes through `refreshListenable`,
/// which is bumped whenever [sessionControllerProvider] emits new state.
/// This keeps route guards (the `redirect` below) purely declarative —
/// screens never push auth routes manually.
final routerProvider = Provider<GoRouter>((ref) {
  final refresh = ValueNotifier<Object?>(null);
  ref.listen(sessionControllerProvider, (_, _) => refresh.value = Object());
  ref.onDispose(refresh.dispose);

  return GoRouter(
    initialLocation: RouteNames.splash,
    refreshListenable: refresh,
    debugLogDiagnostics: false,
    redirect: (context, state) {
      final session = ref.read(sessionControllerProvider);
      final location = state.matchedLocation;

      // While the session is being restored show only the splash screen.
      if (session.isLoading) {
        return location == RouteNames.splash ? null : RouteNames.splash;
      }

      final signedIn = session.value != null;
      const guestRoutes = <String>{
        RouteNames.splash,
        RouteNames.onboarding,
        RouteNames.login,
        RouteNames.register,
      };

      if (signedIn) {
        return (location == RouteNames.login || location == RouteNames.register)
            ? RouteNames.home
            : null;
      }
      return guestRoutes.contains(location) ? null : RouteNames.login;
    },
    routes: [
      GoRoute(
        path: RouteNames.splash,
        builder: (_, _) => const SplashScreen(),
      ),
      GoRoute(
        path: RouteNames.onboarding,
        builder: (_, _) => const OnboardingScreen(),
      ),
      GoRoute(
        path: RouteNames.login,
        builder: (_, _) => const LoginScreen(),
      ),
      GoRoute(
        path: RouteNames.register,
        builder: (_, _) => const RegisterScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (_, _, navigationShell) => AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.home,
                builder: (_, _) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.search,
                builder: (_, _) => const SearchScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.inbox,
                builder: (_, _) => const InboxScreen(),
                routes: [
                  GoRoute(
                    path: 'chat/:conversationId',
                    builder: (_, state) => ChatScreen(
                      conversationId: state.pathParameters['conversationId']!,
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.dashboard,
                builder: (_, _) => const DashboardScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: RouteNames.membership,
        builder: (_, _) => const MembershipScreen(),
      ),
      GoRoute(
        path: '${RouteNames.profile}/:profileId',
        builder: (_, state) => ProfileDetailScreen(
          profileId: state.pathParameters['profileId']!,
        ),
      ),
    ],
  );
});
