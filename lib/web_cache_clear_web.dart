// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
@JS()
// ignore: avoid_web_libraries_in_flutter
import 'dart:js_interop';
import 'package:flutter/foundation.dart';
import 'package:web/web.dart' as html;
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'web_cache_clear_platform_interface.dart';
import 'web_cache_clear_current_version.dart';

/// A web implementation of the WebCacheClearPlatform of the WebCacheClear plugin.
class WebCacheClearWeb extends WebCacheClearPlatform {
  /// A getter for the window object, settable for testing purposes.asd
  @visibleForTesting
  html.Window window = html.window;

  /// Constructs a WebCacheClearWeb
  WebCacheClearWeb();

  static void registerWith(Registrar registrar) {
    WebCacheClearPlatform.instance = WebCacheClearWeb();
  }

  /// Clears the browser's Cache Storage.
  @override
  Future<void> clearCache() async {
    // The Cache API is only available in secure contexts (HTTPS), except for localhost.
    // First, let's confirm if `window.caches` is available.
    if (window.caches == null) {
      debugPrint(
        'WebCacheClear: Cache API is not available. The site might not be considered a secure context.',
      );
      return;
    }

    try {
      final JSArray<JSString> keys = await window.caches!.keys().toDart;
      final List<String> dartKeys =
          keys.toDart.map((jsString) => jsString.toDart).toList();

      // Filter for caches that are typically created by Flutter web apps.
      final flutterCacheKeys =
          dartKeys
              .where(
                (key) =>
                    key.startsWith('flutter-') || key.contains('-asset-cache'),
              )
              .toList();

      if (flutterCacheKeys.isEmpty) {
        debugPrint('WebCacheClear: No caches found to clear.');
        return;
      }

      debugPrint(
        'WebCacheClear: Found Flutter caches: $flutterCacheKeys. Attempting to delete...',
      );

      for (final String key in flutterCacheKeys) {
        // The key needs to be converted back to JSString for the delete method.
        await window.caches!.delete(key).toDart;
        debugPrint('WebCacheClear: Deleted cache with key: $key');
      }
    } catch (e) {
      debugPrint('WebCacheClear: An error occurred while clearing cache: $e');
    }
  }

  /// Checks the app version and clears cache if it's outdated.
  @override
  Future<void> checkAppVersion(String appVersion) async {
    final cacheKey = getCacheKey();
    debugPrint('WebCacheClear: Using session storage key: "$cacheKey"');
    debugPrint('WebCacheClear: Current app version from code: "$appVersion"');

    try {
      final String? storedVersion = window.sessionStorage.getItem(cacheKey);
      debugPrint(
        'WebCacheClear: Version found in session storage: "$storedVersion"',
      );

      if (storedVersion != appVersion) {
        debugPrint(
          'WebCacheClear: Versions do not match. Clearing cache and updating session storage.',
        );
        await clearCache();

        window.sessionStorage.setItem(cacheKey, appVersion);
        debugPrint(
          'WebCacheClear: Set session storage with new version: "$appVersion"',
        );

        // Only reload if there was a different version before, not on first load.
        if (storedVersion != null) {
          debugPrint('WebCacheClear: Reloading page to apply new version.');
          window.location.reload();
        }
      } else {
        debugPrint(
          'WebCacheClear: App version is up to date. No action needed.',
        );
      }
    } catch (e) {
      debugPrint('WebCacheClear: An error occurred during checkAppVersion: $e');
    }
  }
}
