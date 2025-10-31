import 'package:flutter_test/flutter_test.dart';
import 'package:web_cache_clear/web_cache_clear.dart';
import 'package:web_cache_clear/web_cache_clear_platform_interface.dart';
import 'package:web_cache_clear/web_cache_clear_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';



void main() {
  final WebCacheClearPlatform initialPlatform = WebCacheClearPlatform.instance;

  test('$MethodChannelWebCacheClear is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelWebCacheClear>());
  });

  test('getPlatformVersion', () async {
    WebCacheClear webCacheClearPlugin = WebCacheClear();
    
  });
}
