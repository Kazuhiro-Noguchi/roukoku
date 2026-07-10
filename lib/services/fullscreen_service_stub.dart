import 'fullscreen_service_interface.dart';

class _StubFullscreenService implements FullscreenService {
  @override
  Future<void> initialize() async {}

  @override
  Future<bool> setFullscreen(bool enable) async => enable;
}

FullscreenService createFullscreenService() => _StubFullscreenService();