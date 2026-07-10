import 'dart:html' as html;

import 'fullscreen_service_interface.dart';

class _WebFullscreenService implements FullscreenService {
  @override
  Future<void> initialize() async {}

  @override
  Future<bool> setFullscreen(bool enable) async {
    if (enable) {
      await html.document.documentElement?.requestFullscreen();
    } else {
      await html.document.exitFullscreen();
    }

    return html.document.fullscreenElement != null;
  }
}

FullscreenService createFullscreenService() => _WebFullscreenService();