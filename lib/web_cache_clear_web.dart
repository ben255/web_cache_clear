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
  /// A getter for the window object, settable for testing purposes.
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
    final JSArray<JSString> keys = await window.caches.keys().toDart;
    for (final JSString key in keys.toDart) {
      await window.caches.delete(key.toDart).toDart;
    }
  }

  /// Checks the app version and clears cache if it's outdated.
  @override
  Future<void> checkAppVersion(String appVersion) async {
    final storedVersion = window.sessionStorage.getItem(getCacheKey());

    if (storedVersion != appVersion) {
      await clearCache();
      window.sessionStorage.setItem(getCacheKey(), appVersion);
      // Only reload if there was a different version before, not on first load.
      if (storedVersion != null) {
        window.location.reload();
      }
    }
  }
}
