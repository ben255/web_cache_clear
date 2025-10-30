import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'web_cache_clear_method_channel.dart';

abstract class WebCacheClearPlatform extends PlatformInterface {
  /// Constructs a WebCacheClearPlatform.
  WebCacheClearPlatform() : super(token: _token);

  static final Object _token = Object();

  static WebCacheClearPlatform _instance = MethodChannelWebCacheClear();

  /// The default instance of [WebCacheClearPlatform] to use.
  ///
  /// Defaults to [MethodChannelWebCacheClear].
  static WebCacheClearPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [WebCacheClearPlatform] when
  /// they register themselves.
  static set instance(WebCacheClearPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> clearCache() {
    throw UnimplementedError('clearCache() has not been implemented.');
  }

  Future<void> checkAppVersion(String appVersion) {
    throw UnimplementedError('checkAppVersion() has not been implemented.');
  }
}
