import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'web_cache_clear_platform_interface.dart';

/// An implementation of [WebCacheClearPlatform] that uses method channels.
class MethodChannelWebCacheClear extends WebCacheClearPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('web_cache_clear');

  @override
  Future<void> clearCache() async {
    await methodChannel.invokeMethod<void>('clearCache');
  }

  @override
  Future<void> checkAppVersion(String appVersion) async {
    // No-op for non-web platforms for now.
  }
}
