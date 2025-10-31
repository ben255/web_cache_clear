



# web_cache_clear

This was vibe-coded but there was no real good way to clear the cache if you deployed a new version of the app on the web. Youll need to fetch the version of your current because im assuming youre using some kind of backend. Im gonna add a version field and set my number manually for this. Every time the page loads it will check the database version to the stored session version. If its not the same then it will clear the cache storage and update the session and reload the page.

## Introduction


A Flutter web plugin to automatically clear the browser's session storage and reload the page when a new app version is detected. This is ideal for clearing out old application state and ensuring users get the latest version of your web application.

## Getting Started

This plugin provides a single method, `checkAppVersion`, which compares a version string you provide with one stored in the browser's session storage. If they don't match, it clears the session storage and reloads the page.

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  web_cache_clear: ^0.0.3
```

## Usage

In your app's initialization logic (e.g., in `initState`), call `checkAppVersion` with your current application version. You can hardcode this version or fetch it from a server.

```dart
import 'package:flutter/material.dart';
import 'package:web_cache_clear/web_cache_clear.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    WebCacheClear().checkAppVersion("1.0.3"); // Your current app version
  }

  // ... rest of your widget build logic
}
```
