# Roukoku

- [English](#english) · [日本語](#日本語)

## English

A Flutter application containing a collection of small UI widgets and utilities.

### Overview

This repository contains a multi-platform Flutter project with widget components, example screens, and platform-specific builds for Android, iOS, macOS, Linux, Windows and Web.

### Features

- A set of custom widgets (see `lib/widgets/`)
- Cross-platform Flutter project structure
- Build configurations for mobile, desktop and web

### Getting Started

Prerequisites:

- Flutter SDK (stable) installed and on your PATH
- Platform tooling for your target (Android SDK, Xcode for iOS/macOS, etc.)

Quick start:

```bash
flutter pub get
flutter run
```

Build examples:

- Android APK: `flutter build apk`
- iOS: `flutter build ios` (requires Xcode and a macOS host)
- Web: `flutter build web`

### Development

- Code lives in `lib/` with widgets under `lib/widgets/`.
- To run tests: `flutter test`

### Contributing

Contributions are welcome. Please open issues or pull requests on the repository. Follow the existing code style and include tests or screenshots for UI changes when appropriate.

### License

This project is licensed under the Apache License, Version 2.0. See the `LICENSE` file for details.

```
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

---

## 日本語

このリポジトリは、複数プラットフォームに対応した Flutter プロジェクトで、ウィジェットコンポーネント、サンプル画面、そして Android/iOS/macOS/Linux/Windows/Web 向けのビルド設定を含みます。

### 主な特徴

- カスタムウィジェット群（`lib/widgets/` を参照）
- クロスプラットフォームなプロジェクト構成
- モバイル・デスクトップ・Web 向けのビルド設定

### はじめに

前提:

- Flutter SDK（stable）がインストールされ PATH に設定されていること
- ターゲットプラットフォームの開発ツール（Android SDK、Xcode など）が利用可能であること

クイックスタート:

```bash
flutter pub get
flutter run
```

ビルド例:

- Android APK: `flutter build apk`
- iOS: `flutter build ios`（Xcode と macOS ホストが必要）
- Web: `flutter build web`

### 開発

- ソースは `lib/` にあり、ウィジェットは `lib/widgets/` にまとめられています。
- テスト実行: `flutter test`

### コントリビュート

プルリクエストや Issue を歓迎します。コードスタイルに従い、UI の変更にはスクリーンショットやテストを添えてください。

### ライセンス

本プロジェクトは Apache License 2.0 の下で配布されています。詳細は `LICENSE` ファイルを参照してください。
