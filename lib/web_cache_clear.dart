import 'package:web_cache_clear/web_cache_clear_platform_interface.dart';

/// The main class for interacting with the web_cache_clear plugin.
///
/// This class provides methods to clear the browser cache and to check
/// the application version, triggering a cache clear and page reload if
/// the version is outdated.
class WebCacheClear {
  /// Clears the browser's Cache Storage.
  Future<void> clearCache() {
    return WebCacheClearPlatform.instance.clearCache();
  }

  /// Checks the app version against a stored version in session storage.
  /// If the versions do not match, it clears the cache and reloads the page.
  Future<void> checkAppVersion(String appVersion) {
    return WebCacheClearPlatform.instance.checkAppVersion(appVersion);
  }
}
