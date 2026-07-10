abstract class FullscreenService {
  Future<void> initialize();

  Future<bool> setFullscreen(bool enable);
}