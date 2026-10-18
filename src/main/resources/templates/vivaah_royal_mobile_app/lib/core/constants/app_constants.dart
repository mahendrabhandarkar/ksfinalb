/// Application-wide constants for Vivaah Royal.
///
/// Keep every magic string/number used across features in this file so that
/// rebranding or tuning the app never requires touching feature code.
abstract final class AppConstants {
  static const String appName = 'Vivaah Royal';
  static const String appTagline = 'Where royal hearts unite';

  /// Placeholder REST endpoint. Swap with the real backend when available.
  static const String apiBaseUrl = 'https://api.vivaahroyal.example.com/v1';

  /// Base URL used for mock profile photography in the demo build.
  static const String mockAvatarBaseUrl = 'https://i.pravatar.cc/480?img=';

  /// Demo latency injected by the mock data layer so loading states are
  /// realistic during design reviews.
  static const Duration mockNetworkLatency = Duration(milliseconds: 450);

  /// Delay before the simulated partner reply lands in a chat thread.
  static const Duration mockReplyDelay = Duration(milliseconds: 2600);

  /// Delay before a sent interest is auto-accepted in the demo.
  static const Duration mockInterestAcceptDelay = Duration(seconds: 6);

  static const Duration splashDuration = Duration(milliseconds: 2200);
}
