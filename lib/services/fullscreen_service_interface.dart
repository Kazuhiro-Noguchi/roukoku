abstract class FullscreenService {
  Future<void> initialize();

  Future<bool> setFullscreen(bool enable);
}

FullscreenService createFullscreenService();

Future<void> initializeFullscreenSupport() async {
  final service = createFullscreenService();
  await service.initialize();
}