# @lus プロジェクト

## アプリ概要
カップルが訪れた場所・思い出を地図上にピンで記録するFlutter Webアプリ。
将来的にiOSへの転用を予定。

## 技術スタック
- フレームワーク：Flutter（Web）
- 状態管理：flutter_riverpod
- ローカルDB：drift（SQLite/WASM）
- 地図：flutter_map（OpenStreetMap）
- 画像選択：image_picker（Base64でDB保存）
- 画面遷移：go_router
- ※ローカル通知はWeb非対応のためv2以降

## 設計方針
- サーバーなし・認証なし・ローカル保存のみ
- ブラウザのIndexedDBにデータ保存
- 仮実装→動作確認→デザイン調整の順で進める

## v1スコープ
F1: 地図表示（OpenStreetMap・日本中心）
F2: ピン追加（地図ロングタップ）
F3: ピン色分け（行った=ピンク/予定=ラベンダー/記念日=ゴールド）
F4: 提案者フラグ（自分/パートナー）
F5: ピン詳細表示（写真・★評価・コメント・訪問日）
F6: ピン編集・削除
F7: 一覧画面（日付順ソート）
F8: 記念日カウントダウン

## ドキュメント
- [docs/requirements.md](docs/requirements.md) — 要件定義（機能要件・非機能要件）
- [docs/screens.md](docs/screens.md) — 画面設計（4画面の構成と遷移）
- [docs/data_model.md](docs/data_model.md) — データ設計（pins・anniversaries）
- [docs/commit_plan.md](docs/commit_plan.md) — コミット戦略（14コミット計画）
