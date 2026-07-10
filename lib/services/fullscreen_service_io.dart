import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:window_manager/window_manager.dart';

import 'fullscreen_service_interface.dart';

class _IoFullscreenService implements FullscreenService {
  @override
  Future<void> initialize() async {
    if (_isDesktop) {
      await windowManager.ensureInitialized();
    }
  }

  @override
  Future<bool> setFullscreen(bool enable) async {
    if (_isDesktop) {
      await windowManager.setFullScreen(enable);
    } else {
      await SystemChrome.setEnabledSystemUIMode(
        enable ? SystemUiMode.immersiveSticky : SystemUiMode.edgeToEdge,
      );
    }

    return enable;
  }

  bool get _isDesktop =>
      Platform.isWindows || Platform.isMacOS || Platform.isLinux;
}

FullscreenService createFullscreenService() => _IoFullscreenService();