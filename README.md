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

## Web版
GitHub Pagesで公開しています。CIが `main` へのpush時に更新します。
- https://hgwr.github.io/vermelha_app/
- `web/` に `sqlite3.wasm` と `drift_worker.js` を配置します（`application/wasm` で配信）。

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
# デバッグビルド
flutter build apk --debug
flutter build ios --no-codesign

# リリースビルド（配布用）
flutter build appbundle --release
flutter build ipa --release
```

## ディレクトリ構成
- `assets/`: 画像/フォントなどのアセット
- `docs/`: 仕様書
- `lib/`: アプリ本体
  - `db/`: ローカル永続化（drift）
