# データ設計

drift（SQLite/WASM）でブラウザの IndexedDB に永続化する。
v1 のテーブルは `pins` と `anniversaries` の2つ。

## pins テーブル

ピン（訪れた場所・予定・記念日）1件を表す。

| カラム | 型 | 制約 | 説明 |
|--------|-----|------|------|
| id | INTEGER | PK, AUTOINCREMENT | ピンID |
| latitude | REAL | NOT NULL | 緯度 |
| longitude | REAL | NOT NULL | 経度 |
| name | TEXT | NOT NULL | 名称（場所名など） |
| kind | TEXT | NOT NULL | 種別：`visited`(行った) / `planned`(予定) / `anniversary`(記念日) |
| proposer | TEXT | NOT NULL | 提案者：`me`(自分) / `partner`(パートナー) |
| rating | INTEGER | NULL (1〜5) | ★評価 |
| comment | TEXT | NULL | コメント |
| photo_base64 | TEXT | NULL | 写真（Base64エンコードした画像データ） |
| visited_at | DATE | NULL | 訪問日 |
| created_at | DATETIME | NOT NULL | 作成日時 |
| updated_at | DATETIME | NOT NULL | 更新日時 |

### kind と地図上の色
| kind | 意味 | 色 |
|------|------|-----|
| visited | 行った | ピンク |
| planned | 予定 | ラベンダー |
| anniversary | 記念日 | ゴールド |

### proposer
| proposer | 意味 |
|----------|------|
| me | 自分 |
| partner | パートナー |

## anniversaries テーブル

記念日カウントダウン（F8）に用いる。

| カラム | 型 | 制約 | 説明 |
|--------|-----|------|------|
| id | INTEGER | PK, AUTOINCREMENT | 記念日ID |
| title | TEXT | NOT NULL | 記念日名（例：付き合った記念日） |
| date | DATE | NOT NULL | 記念日の日付 |
| recurring | BOOL | NOT NULL | 毎年繰り返すかどうか |
| created_at | DATETIME | NOT NULL | 作成日時 |

### カウントダウンの考え方
- `recurring = true` の場合、今年（または次回）の `date` までの残り日数を算出。
- 当日は「今日」、経過済みは次回の発生日を基準に再計算する。
- `recurring = false` の場合は、その日付までの残り日数のみ（経過後は経過済み表示）。

## 補足
- 画像は image_picker で取得後、Base64 文字列にエンコードして `photo_base64` に保存する（別ファイル管理は行わない）。
- drift の型では `visited_at` / `date` を `DateColumn`、`created_at` / `updated_at` を `DateTimeColumn` として扱う。
- 将来 iOS へ転用する際もスキーマは共通で利用できる構成とする。
