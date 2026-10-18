/// Central registry of route paths used by [AppRouter].
abstract final class RouteNames {
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';

  static const String shell = '/app';
  static const String home = '$shell/home';
  static const String search = '$shell/search';
  static const String inbox = '$shell/inbox';
  static const String dashboard = '$shell/dashboard';
  static const String chat = '$inbox/chat';
  static const String membership = '$shell/membership';
  static const String profile = '/profile';

  static String chatFor(String conversationId) => '$chat/$conversationId';
  static String profileFor(String profileId) => '$profile/$profileId';
}
