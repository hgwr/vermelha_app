# Vermelha（ヴェルメーリャ） v1 仕様書（Draft / 2026-01-01）

目的：Wizardry風のテキストRPGを、FF12の「ガンビット」風 if-then ルールで自動戦闘させ、レベル上げ・装備収集・自動生成ダンジョン踏破を、スマホでスキマ時間に少しずつ楽しめる形で提供する。

---

## 1. 概要

### 1.1 ゲームの核（Core Loop）
1. 街（City）で準備（キャラ管理、装備、戦法/ガンビット、売買）
2. ダンジョン（Dungeon）で到達済みフロアにジャンプして探索開始
3. 探索はオート（移動・遭遇・戦闘・戦利品獲得）
4. 戦闘はガンビット（if-then ルール）に従い自動進行
5. 経験値・ドロップ・装備更新で強化
6. インベントリが溢れる前に街へ戻り、売買して再潜行（潜り放題）

### 1.2 対象プラットフォーム
- Flutter（iOS / Android を優先）
- v1 はスマホ体験最優先（片手操作・短時間プレイ）

### 1.3 ロケール
- v1：日本語のみ
- 将来：英語追加（i18n 前提で文字列は外出し）

---

## 2. v1 の範囲（スコープ）

### 2.1 v1 の完成条件（最低限）
- Title：New / Continue（オートセーブ前提でよい）
- City：テキストメニューで各画面へ移動
  - Tavern（キャラ管理）
  - Party/Character（詳細・装備）
  - Gambits（戦法編集）
  - Shop（売買：最低限は「売る」だけでも可）
  - Dungeon（潜行）
- Party：3人固定（前・中・後）
- Tavern：キャラクター作成・編集・削除
  - v1 では **職業/種族/初期ステ割り振りは無し**（全員同一テンプレで開始）
- Dungeon：
  - 到達済みフロアのみジャンプ可
  - 探索はオートで進行
  - Pause/Play、ログ、Camp、Return が使える
- Camp：HP/MP を **全回復**
- Battle：
  - ガンビットに従い自動進行
  - HP回復：回復魔法（MP消費）や回復系バフで可能
  - MP回復：アイテム、または「MPが徐々に回復する」バフで可能
- 敗北：
  - **ペナルティ無し**で Camp 画面に戻るだけ
- 報酬：
  - 経験値、レベルアップ
  - 武器/防具ドロップ → 装備更新できる
- セーブ：
  - 端末ローカルへオートセーブ

### 2.2 v1 の非目標（Non-goals）
- 職業/種族/初期ステ割り振り（v2）
- 食料/水などの消耗資源による遠征制限（v2/v3）
- 復活の呪文（セーブ移行用）（v2以降）
- オンライン要素（ランキング等）
- 画面演出の凝り（テキスト中心）

---

## 3. 画面・UX（スマホ最適）

### 3.1 画面一覧（推奨）
- Title
- City（メインメニュー）
- Tavern（キャラ一覧/作成/編集/削除）
- Character Detail（ステータス/装備/所持品）
- Equipment（装備変更）
- Gambits（戦法/ルール編集）
- Shop（売買）
- Dungeon Setup（到達済み階層の選択・開始）
- Dungeon Running（オート探索中：状態・ログ・Pause/Play・Camp・Return）
- Camp（回復・確認・装備・戦法）

### 3.2 操作方針
- 片手操作前提（大きめボタン、少ないタップ数）
- 「ログ」が主役（何が起きたかが追える）

---

## 4. データモデル（v1）

### 4.1 キャラクター（Character）
- id: string（UUID）
- name: string
- level: int
- exp: int
- hp / hpMax: int
- mp / mpMax: int
- baseStats（v1最小）
  - attack: int
  - defense: int
  - speed: int（ターン順や命中補正に利用）
- skills（v1は少なめ）
  - weaponProficiency:
    - oneHand: int
    - twoHand: int
    - bow: int
    - shield: int
  - magicProficiency:
    - attackMagic: int
    - healMagic: int
- equipment
  - rightHand: Item?
  - leftHand: Item?
  - armor: Item?
- inventory: List<Item>
- inventoryCapacity: int（例：20）
- gambitSetId: string

> v1：全キャラは同一テンプレから開始（職業/種族/初期ステ無し）

### 4.2 パーティ（Party）
- members: [forwardId, middleId, rearId]（3固定）

### 4.3 所持金（Gold）
- gold: int
- v1 は「売る」だけでも成立するが、可能なら回復アイテムの購入も実装する

### 4.4 アイテム（Item）
- id, name
- type: weapon / armor / consumable
- params（最小）
  - attackBonus?: int
  - defenseBonus?: int
  - speedBonus?: int
- weaponType?: oneHand / twoHand / bow / shield
- armorType?: heavy / medium / light
- price: int（売却/購入用）

### 4.5 敵（Enemy）
- id, name
- hp/hpMax
- attack, defense, speed
- enemyType: regular / irregular
- telegraph: bool（攻撃予兆フラグ）

### 4.6 ダンジョン状態（DungeonRun）
- currentFloor: int
- deepestReachedFloor: int（到達フロア管理）
- progressOnFloor（戦闘回数、ボス条件など）
- autoPlay: bool（Pause/Play）
- log: List<LogEntry>
- saveTimestamp

---

## 5. ダンジョン仕様（v1）

### 5.1 フロア選択（ジャンプ）
- 「到達済みフロア」のみ選択可能
- 深いほど敵が強い → 自然に適正フロアへ落ち着くことを期待

### 5.2 探索（オート）
- tick で進行（時間経過 or ボタンで進める、どちらでも可）
- イベント（例）
  - 敵遭遇 → 戦闘
  - 何も起きない
- ログに逐次記録

### 5.3 帰還と潜行スタイル
- v1：基本は **潜り放題**（街→潜る→帰還の強制はしない）
- ただし **インベントリ容量制限**により、
  - 満杯が近づいたら街に戻って売る/整理する動機が生まれる
- Return：任意タイミングで City に戻れる
- インベントリが満杯になった場合：
  - ドロップ取得不可（ログに「拾えなかった」を記録）
  - または「自動で破棄する」選択（v1では固定挙動でも可）

### 5.3.1 インベントリ満杯時の挙動（v1確定）
- インベントリには容量上限 `inventoryCapacity` がある。
- 戦闘やイベントでアイテムを入手しようとした時、空きがある場合は自動で取得する。
- 空きがない（満杯）場合は、**毎回「どれを捨てるか」選択してから取得**する。

#### 取得フロー（満杯時）
1. アイテム入手イベント発生（例：ドロップ `newItem`）
2. `inventory` が満杯なら `InventoryFullDialog` を表示
3. ダイアログで以下を提示：
   - 入手しようとしているアイテム `newItem`（名前 / 種別 / 主要パラメータ / 売値）
   - 現在の所持品一覧（装備中は区別表示）
4. プレイヤーは次のいずれかを選ぶ：
   - (A) **所持品から 1つ選んで捨てる → `newItem` を取得する**
   - (B) **`newItem` を捨てる（＝取得しない）**
   - (C) （任意）詳細比較を見る（装備や所持品の詳細表示へ）
5. 選択結果をログに記録
   - 例：「インベントリが満杯。〇〇を捨てて△△を拾った」
   - 例：「インベントリが満杯。△△を諦めた」

#### UI/UX 方針（スマホ優先）
- ダイアログは「1画面で完結」できることを優先（長い遷移は避ける）。
- 所持品一覧は **フィルタ/ソートは v1 では不要**（必要なら v1.1）。
- ただし選びやすさのため、各アイテム行に以下を表示する：
  - 名前、種別（武器/防具/消耗品）
  - 主要パラメータ（武器なら攻撃、盾/防具なら防御など）
  - 売値（価格）
  - 装備中バッジ（装備中は捨てられるが、確認を挟む）

#### 装備中アイテムを捨てる場合（v1確定）
- 装備中のアイテムも捨てられる。
- ただし捨てる前に確認ダイアログを必ず出す：
  - 「装備中の〇〇を捨てますか？（はい/いいえ）」
- 捨てた後は該当装備スロットを `null` にする（素手/防具なし状態を許容）。
- ログに必ず記録する。

#### 実装メモ
- `InventoryFullDialog` は「捨てる対象選択」と「新規アイテム破棄」を同時に扱う。
- 捨てる対象選択は `ListView` + `Radio` または `Tap` 選択でよい。
- v1では「複数個まとめて捨てる」は不要（1個交換のみ）。


### 5.4 敗北
- ペナルティ無しで Camp に戻る
- 状態は「戦闘後の処理を終えた」扱いにしてログへ記録

---

## 6. 戦闘仕様（v1）

### 6.1 バトルの基本
- 方式：ターン制（v1 推奨）
- 味方3人 vs 敵1〜N
- 各キャラは自分のガンビット（上から優先）を評価し、最初に成立した行動を実行

### 6.1.1 行動の基本（v1確定）
- 各キャラクターは自分のターンで 1アクションを行う。
- **アイテム使用（useItem）は 1ターンを消費する。**
  - 例：MP回復アイテムを使うと、そのターンは攻撃や魔法を行わない。
- アイテム使用もガンビットのアクションとして指定できる。

### 6.1.2 ターン順（v1確定）
- 行動順は speed に基づいて決定する。
- バトル開始時および各ラウンド開始時に「行動順リスト」を生成する。
- speed が同値の場合は、安定したタイブレークを持つ（例：固定のユニットID順、または乱数seedで一貫）。
- 速度バフ/デバフがある場合、次ラウンド以降の行動順生成に反映される（v1では未実装でもよい）。

### 6.2 ガンビット（戦法）モデル
- GambitRule = (condition, targetSelector, action)
- ルールは順序が重要（上ほど優先）

#### 6.2.1 条件（Condition）例（v1）
- allyHpBelowPct(X)（味方のHP%がX未満の者がいる）
- enemyTelegraph（敵の攻撃予兆がある）
- enemyExists（敵がいる）
- enemyTypeIs(regular/irregular)
- selfHasBuff(buffId) / selfMissingBuff(buffId)（バフ運用のため）
- always

#### 6.2.2 ターゲット（TargetSelector）例（v1）
- allyMostInjured（HP%が最も低い味方）
- allyHpBelowPct(X)
- self
- enemyLowestHp
- enemyOfType(regular/irregular)
- enemyTargetedBy(slot: forward/middle/rear)

#### 6.2.3 アクション（Action）例（v1）
- defend（防御）
- attack（通常攻撃）
  - withOneHand / withTwoHand / withBow
- castAttackMagic（攻撃魔法：MP消費）
- castHealSmall / castHealLarge（回復魔法：MP消費）
- applyBuffRegenHP（HP徐々に回復：MP消費 or 無消費でもよい）
- applyBuffRegenMP（MP徐々に回復：MP消費 or アイテムでもよい）
- useItem(itemId)（MP回復アイテム等）

> v1 はアクション種類は少なめでよい。まず「回復・防御・攻撃・敵タイプ分岐」が成立すればOK。

### 6.3 MP と回復の方針（v1）
- Camp：HP/MP 全回復
- 戦闘中：
  - HP回復：回復魔法（MP消費）、または回復バフ
  - MP回復：アイテム、またはMP回復バフ（徐々に回復）

### 6.4 敵タイプ（定型/非定型）
- 定型（regular）：物理寄りで倒せる
- 非定型（irregular）：魔法が刺さる等、戦法分岐の価値が出る

### 6.5 装備ルール（v1）
- 右手片手＋左手盾
- 片手武器二刀（右手/左手）
- 両手武器
- 弓
- 防具：重装/中装/軽装

---

## 7. 成長・報酬（v1）

### 7.1 経験値とレベル
- 勝利で exp
- レベルアップで hpMax/mpMax と baseStats が上昇

### 7.2 ドロップ
- 敵ごとにドロップテーブル（weapon/armor/consumable）
- インベントリ容量制限があるため、
  - 「嬉しいが拾いきれない」状況が自然に起こる

---

## 8. ショップ（売買）（v1）

### 8.1 目的
- インベントリ整理と、回復/MP供給の手段を提供
- 潜り放題でも「街に戻る」動機を作る

### 8.2 v1 最小仕様
- Sell：所持品を売却して gold を得る
- Buy（余裕があれば）：
  - MP回復アイテム
  - 低ランク装備（序盤用）

---

## 9. セーブ/ロード（v1）
- オートセーブのみ（ローカル保存）
- Title の Continue で直近セーブを復帰
- 復活の呪文（データ移行）は v2 以降

---

## 10. ログとデバッグ容易性（v1）
- Dungeon Running 画面でログ閲覧
- 戦闘ログ：ガンビット判定（どのルールが成立したか）、行動、ダメージ、回復、ドロップ、レベルアップ
- 生成AIでの実装支援を前提に、「原因追跡できる粒度」を重視

---

## 11. 実装順（おすすめ）
1. データモデル（Character/Item/GambitRule/DungeonRun）
2. Tavern：作成 → 一覧 → 詳細
3. Gambits：ルール追加/削除/並べ替え
4. Battle：ガンビット評価→行動→ログ（まずは敵1体でOK）
5. Dungeon：オート探索ループ（遭遇→戦闘）
6. ドロップ→インベントリ→装備更新
7. Shop：売却（→購入）
8. オートセーブ

---

## 12. v2 / v3 でやりたいこと（Roadmap）
- v2：
  - 職業/種族/初期ステ割り振り（キャラ差別化）
  - 復活の呪文（セーブ移行：マルチプラットフォーム対応）
  - ガンビット条件/ターゲットの拡張（状態異常、割合、属性など）
- v3：
  - 水/食料などのリソース（遠征計画・帰還判断）
  - さらに深い装備/ビルド多様化
