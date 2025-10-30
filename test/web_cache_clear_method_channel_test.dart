import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:web_cache_clear/web_cache_clear_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelWebCacheClear platform = MethodChannelWebCacheClear();
  const MethodChannel channel = MethodChannel('web_cache_clear');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
          return '42';
        });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });
}
