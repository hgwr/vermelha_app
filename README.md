# Vermelha（ヴェルメーリャ）

Wizardryライクなキャラクター育成・ダンジョン探索と、ガンビット
(if-then形式)による全自動戦闘を組み合わせたテキスト中心のRPGです。
スマホでの短時間プレイを想定したUI/UXを目指しています。

## 概要
- Wizardry風のメニュー/ログ重視のゲーム体験
- ガンビットルールに基づく自動戦闘
- 自動探索と戦闘ログが時系列で進行
- v1は日本語のみ（i18n前提）

## 仕様書
v1仕様のカノニカルな参照先は `docs/spec.md` です。

## 開発環境
- Flutter SDK（stable）

## セットアップ
```bash
flutter pub get
```

## 実行
```bash
flutter run
```

## テスト
```bash
flutter test
```

## ビルド
```bash
flutter build apk --debug
flutter build ios --no-codesign
```

## ディレクトリ構成
- `assets/`: 画像/フォントなどのアセット
- `docs/`: 仕様書
- `lib/`: アプリ本体
- `lib/db/`: ローカル永続化（sqflite）
