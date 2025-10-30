import 'package:flutter/material.dart';
import 'dart:async';
import 'package:web/web.dart' as html;

import 'package:flutter/services.dart';
import 'package:web_cache_clear/web_cache_clear.dart';
import 'package:web_cache_clear/web_cache_clear_current_version.dart';

void main() {
  // Ensure that plugin services are initialized so that `available` works
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _cacheStatus = 'Cache status: Unknown';
  final _webCacheClearPlugin = WebCacheClear();

  @override
  void initState() {
    super.initState();
    _checkVersionFromServer();
  }

  Future<void> _checkVersionFromServer() async {
    // --- Placeholder for your server fetch ---
    // Replace this with your actual logic to fetch the version string.
    // For example, using the `http` package.
    final String serverVersion = await Future.delayed(
      const Duration(milliseconds: 100),
      () => "1.0.3",
    );
    // -----------------------------------------

    // This single line checks the version and reloads if they don't match.
    await _webCacheClearPlugin.checkAppVersion(serverVersion);

    // This code only runs if the versions match and the page doesn't reload.
    if (mounted) {
      setState(() {
        final storedVersion = html.window.sessionStorage.getItem(getCacheKey());
        _cacheStatus = 'Cache contains version: $storedVersion';
      });
    }
  }

  Future<void> _clearWebCache() async {
    await _webCacheClearPlugin.clearCache();
    // After clearing, update the UI to show the cache is empty (null).
    setState(() {
      _cacheStatus = 'Cache contains version: null';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_cacheStatus),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _clearWebCache,
                  child: const Text('Clear Web Cache'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
