# roukoku (日本語版)

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://www.apache.org/licenses/LICENSE-2.0)

このリポジトリは、複数プラットフォームに対応した Flutter プロジェクトで、ウィジェットコンポーネント、サンプル画面、そして Android/iOS/macOS/Linux/Windows/Web 向けのビルド設定を含みます。

## 主な特徴

- カスタムウィジェット群（`lib/widgets/` を参照）
- クロスプラットフォームなプロジェクト構成
- モバイル・デスクトップ・Web 向けのビルド設定

## はじめに

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

## 開発

- ソースは `lib/` にあり、ウィジェットは `lib/widgets/` にまとめられています。
- テスト実行: `flutter test`

## コントリビュート

プルリクエストや Issue を歓迎します。コードスタイルに従い、UI の変更にはスクリーンショットやテストを添えてください。

## ライセンス

本プロジェクトは Apache License 2.0 の下で配布されています。詳細は `LICENSE` ファイルを参照してください。
