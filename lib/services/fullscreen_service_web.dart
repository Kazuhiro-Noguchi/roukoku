import 'dart:js_interop';

import 'package:web/web.dart' as web;

import 'fullscreen_service_interface.dart';

class _WebFullscreenService implements FullscreenService {
  @override
  Future<void> initialize() async {}

  @override
  Future<bool> setFullscreen(bool enable) async {
    if (enable) {
      final element = web.document.documentElement;
      if (element != null) {
        await element.requestFullscreen().toDart;
      }
    } else {
      await web.document.exitFullscreen().toDart;
    }

    return web.document.fullscreenElement != null;
  }
}

FullscreenService createFullscreenService() => _WebFullscreenService();