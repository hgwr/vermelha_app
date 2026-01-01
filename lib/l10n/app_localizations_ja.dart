// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'Vermelha';

  @override
  String get newGame => 'ニューゲーム';

  @override
  String get loadGame => 'ロードゲーム';

  @override
  String get cityTitle => '街';

  @override
  String get tavernTitle => '酒場';

  @override
  String get shopTitle => 'ショップ';

  @override
  String get shopBuyTab => '購入';

  @override
  String get shopSellTab => '売却';

  @override
  String get goldLabel => '所持金';

  @override
  String priceLabel(Object value) {
    return '${value}G';
  }

  @override
  String sellPriceLabel(Object value) {
    return '売値 ${value}G';
  }

  @override
  String get shopSelectCharacter => 'キャラクター';

  @override
  String get notEnoughGold => 'ゴールドが足りません。';

  @override
  String get dungeonTitle => 'ダンジョン';

  @override
  String get dungeonSelectTitle => 'ダンジョン選択';

  @override
  String get dungeonSelectReachedOnly => '到達済みフロアのみ選択できます。';

  @override
  String unlockNextFloorProgress(Object current, Object required) {
    return '次フロア解放: $current/$required';
  }

  @override
  String floorLabel(Object floor) {
    return 'フロア$floor';
  }

  @override
  String battleCountProgress(Object current, Object required) {
    return '戦闘回数: $current/$required';
  }

  @override
  String get partyTitle => 'パーティ';

  @override
  String get partyFormationTitle => 'パーティ編成';

  @override
  String get partyPositionForward => '前衛';

  @override
  String get partyPositionMiddle => '中衛';

  @override
  String get partyPositionRear => '後衛';

  @override
  String get partySlotEmpty => '未設定';

  @override
  String get partyClearSlot => '外す';

  @override
  String get partyIncomplete => '前衛・中衛・後衛の3人を設定してください';

  @override
  String inventoryCapacityLabel(Object current, Object max) {
    return '所持品 $current/$max';
  }

  @override
  String get inventoryEmpty => '所持品がありません。';

  @override
  String get inventoryFullTitle => '所持品がいっぱいです';

  @override
  String get inventoryFullBody => '捨てるアイテムを選んでください。';

  @override
  String inventoryDiscardNewItem(Object name) {
    return '新規: $name';
  }

  @override
  String get equipmentTitle => '装備';

  @override
  String get equipmentEmpty => '未装備';

  @override
  String get equipmentSlotWeapon => '武器';

  @override
  String get equipmentSlotArmor => '防具';

  @override
  String get equipmentSlotAccessory => 'アクセサリ';

  @override
  String get equipAction => '装備';

  @override
  String get unequipAction => '外す';

  @override
  String get itemTypeWeapon => '武器';

  @override
  String get itemTypeArmor => '防具';

  @override
  String get itemTypeConsumable => '消耗品';

  @override
  String get saveTitle => 'セーブ';

  @override
  String get saveSuccess => 'セーブしました。';

  @override
  String get campTitle => 'キャンプ';

  @override
  String get campButton => 'キャンプ';

  @override
  String get campHealButton => '全回復して戻る';

  @override
  String get returnToCity => '街へ戻る';

  @override
  String get settingsTitle => '設定';

  @override
  String get settingsBody => '設定';

  @override
  String get noCharacters => 'キャラクターがいません';

  @override
  String get noCharactersFound => 'キャラクターが見つかりません';

  @override
  String get deleteCharacterTitle => 'キャラクターを削除しますか？';

  @override
  String get deleteCharacterBody => '削除すると元に戻せません。';

  @override
  String get cancel => 'キャンセル';

  @override
  String get confirm => '決定';

  @override
  String get delete => '削除';

  @override
  String get newCharacterTitle => '新規';

  @override
  String get nameLabel => '名前';

  @override
  String get jobLabel => 'ジョブ';

  @override
  String get partyJoinLabel => 'パーティ参加';

  @override
  String get levelLabel => 'レベル';

  @override
  String get levelShort => 'Lv.';

  @override
  String get expLabel => '経験値';

  @override
  String get hpLabel => 'HP';

  @override
  String get mpLabel => 'MP';

  @override
  String get attackLabel => '攻撃力';

  @override
  String get defenseLabel => '防御力';

  @override
  String get magicPowerLabel => '魔法力';

  @override
  String get speedLabel => '素早さ';

  @override
  String get statusParameterHp => 'HP';

  @override
  String get statusParameterMp => 'MP';

  @override
  String get statusParameterAttack => '攻撃力';

  @override
  String get statusParameterDefense => '防御力';

  @override
  String get statusParameterMagicPower => '魔法力';

  @override
  String get statusParameterSpeed => '素早さ';

  @override
  String get priorityParametersLabel => '優先パラメータ';

  @override
  String get battleRulesLabel => '戦闘ルール';

  @override
  String get priorityParametersDescription =>
      'このキャラクターがレベルアップした時、優先的に成長するパラメーターを３つ選びます';

  @override
  String battleRulesTitleWithName(Object name) {
    return '戦闘ルール：$name';
  }

  @override
  String get battleRulesTitle => '戦闘ルール';

  @override
  String get deleteRuleTitle => '削除の確認';

  @override
  String get deleteRuleBody => 'この戦闘ルールを削除しますか？';

  @override
  String get noLabel => 'いいえ';

  @override
  String get yesLabel => 'はい';

  @override
  String get addBattleRule => '新しい戦闘ルールを追加する';

  @override
  String get battleRuleLimitReached => '戦闘ルールは最大16件です';

  @override
  String get selectConditionTitle => '条件を選択';

  @override
  String get selectActionTitle => 'アクションを選択';

  @override
  String get selectTargetTitle => 'ターゲットを選択';

  @override
  String get selectPlayerCharactersTitle => 'パーティメンバーを選択';

  @override
  String get logTypeExplore => '探索';

  @override
  String get logTypeBattle => '戦闘';

  @override
  String get logTypeLoot => '戦利品';

  @override
  String get logTypeSystem => 'システム';

  @override
  String get logExplorationStart => '探索を開始した。';

  @override
  String get logExplorationMove => '探索を進めた。';

  @override
  String get logExplorationTreasure => '宝箱を見つけた。';

  @override
  String get logExplorationTrap => '罠にかかった。';

  @override
  String get logBattleEncounter => '敵と遭遇した。';

  @override
  String logBattleAction(Object subject, Object action, Object targets) {
    return '$subjectは$action → $targets';
  }

  @override
  String get logBattleVictory => '戦闘に勝利した。';

  @override
  String get logLootNone => '戦利品はなかった。';

  @override
  String logLootGold(Object amount) {
    return 'ゴールド${amount}Gを獲得した。';
  }

  @override
  String logLootItem(Object item) {
    return '戦利品: $itemを入手した。';
  }

  @override
  String get logCampHeal => 'キャンプで全回復した。';

  @override
  String get logReturnToCity => '街へ帰還した。';

  @override
  String get taskStatusComplete => '完了';

  @override
  String get taskStatusCanceled => 'キャンセル';

  @override
  String progressPercent(Object value) {
    return '$value%';
  }

  @override
  String get hpShort => 'HP';

  @override
  String get mpShort => 'MP';

  @override
  String get unknownLabel => '不明';

  @override
  String get enemyRegular => '定型の敵';

  @override
  String get enemyIrregular => '非定型の敵';

  @override
  String get jobFighter => '戦士';

  @override
  String get jobPaladin => '神殿騎士';

  @override
  String get jobRanger => 'レンジャー';

  @override
  String get jobWizard => '魔法使い';

  @override
  String get jobShaman => 'シャーマン';

  @override
  String get jobPriest => '僧侶';

  @override
  String get actionPhysicalAttack => '物理攻撃';

  @override
  String get actionAttackMagic => '攻撃魔法';

  @override
  String get actionBigHeal => '大回復魔法';

  @override
  String get actionSmallHeal => '小回復魔法';

  @override
  String get actionBigCure => '大治癒術';

  @override
  String get actionSmallCure => '小治癒術';

  @override
  String get conditionLowestHpEnemy => '最もHPが低い敵';

  @override
  String get conditionHighestHpEnemy => '最もHPが高い敵';

  @override
  String get conditionRandomEnemy => 'ランダムな敵';

  @override
  String get conditionRandomAlly => 'ランダムな味方';

  @override
  String get conditionAllEnemies => '敵全体';

  @override
  String get conditionAllAllies => '味方全体';

  @override
  String get conditionEnemyTelegraph => '敵が攻撃予兆';

  @override
  String get conditionEnemyIrregularExists => '非定型の敵がいる';

  @override
  String get conditionEnemyRegularExists => '定型の敵がいる';

  @override
  String get conditionAllyHpBelow75 => 'HPが75%以下の味方';

  @override
  String get conditionAllyHpBelow50 => 'HPが50%以下の味方';

  @override
  String get conditionAllyHpBelow25 => 'HPが25%以下の味方';

  @override
  String get conditionLowestMpEnemy => '最もMPが低い敵';

  @override
  String get conditionHighestMpEnemy => '最もMPが高い敵';

  @override
  String get conditionLowestAttackEnemy => '最も攻撃力が低い敵';

  @override
  String get conditionHighestAttackEnemy => '最も攻撃力が高い敵';

  @override
  String get conditionLowestDefenseEnemy => '最も防御力が低い敵';

  @override
  String get conditionHighestDefenseEnemy => '最も防御力が高い敵';

  @override
  String get conditionLowestSpeedEnemy => '最も素早さが低い敵';

  @override
  String get conditionHighestSpeedEnemy => '最も素早さが高い敵';

  @override
  String get conditionLowestHpAlly => '最もHPが低い味方';

  @override
  String get conditionHighestHpAlly => '最もHPが高い味方';

  @override
  String get conditionLowestMpAlly => '最もMPが低い味方';

  @override
  String get conditionHighestMpAlly => '最もMPが高い味方';

  @override
  String get conditionLowestAttackAlly => '最も攻撃力が低い味方';

  @override
  String get conditionHighestAttackAlly => '最も攻撃力が高い味方';

  @override
  String get conditionLowestDefenseAlly => '最も防御力が低い味方';

  @override
  String get conditionHighestDefenseAlly => '最も防御力が高い味方';

  @override
  String get conditionLowestSpeedAlly => '最も素早さが低い味方';

  @override
  String get conditionHighestSpeedAlly => '最も素早さが高い味方';

  @override
  String get targetMatchingAlly => '条件に合う味方';

  @override
  String get targetMatchingEnemy => '条件に合う敵';

  @override
  String get targetSelf => '自分自身';

  @override
  String get targetRandomAlly => 'ランダムな味方';

  @override
  String get targetRandomEnemy => 'ランダムな敵';

  @override
  String get targetAllAllies => '味方全体';

  @override
  String get targetAllEnemies => '敵全体';

  @override
  String get targetLowestHpAlly => 'HPが最も低い味方';

  @override
  String get targetLowestHpEnemy => 'HPが最も低い敵';

  @override
  String get targetHighestHpAlly => 'HPが最も高い味方';

  @override
  String get targetHighestHpEnemy => 'HPが最も高い敵';

  @override
  String get targetLowestMpAlly => 'MPが最も低い味方';

  @override
  String get targetLowestMpEnemy => 'MPが最も低い敵';

  @override
  String get targetHighestMpAlly => 'MPが最も高い味方';

  @override
  String get targetHighestMpEnemy => 'MPが最も高い敵';

  @override
  String get targetLowestAttackAlly => '最も攻撃力が低い味方';

  @override
  String get targetLowestAttackEnemy => '最も攻撃力が低い敵';

  @override
  String get targetHighestAttackAlly => '最も攻撃力が高い味方';

  @override
  String get targetHighestAttackEnemy => '最も攻撃力が高い敵';

  @override
  String get targetLowestDefenseAlly => '最も防御力が低い味方';

  @override
  String get targetLowestDefenseEnemy => '最も防御力が低い敵';

  @override
  String get targetHighestDefenseAlly => '最も防御力が高い味方';

  @override
  String get targetHighestDefenseEnemy => '最も防御力が高い敵';

  @override
  String get targetLowestSpeedAlly => '最も素早さが低い味方';

  @override
  String get targetLowestSpeedEnemy => '最も素早さが低い敵';

  @override
  String get targetHighestSpeedAlly => '最も素早さが高い味方';

  @override
  String get targetHighestSpeedEnemy => '最も素早さが高い敵';

  @override
  String get itemWeaponShortSword => 'ショートソード';

  @override
  String get itemWeaponBattleAxe => 'バトルアックス';

  @override
  String get itemWeaponLongBow => 'ロングボウ';

  @override
  String get itemArmorLeather => 'レザーアーマー';

  @override
  String get itemArmorChain => 'チェインメイル';

  @override
  String get itemConsumablePotion => '回復薬';

  @override
  String get itemConsumableEther => '魔力水';

  @override
  String get notImplemented => '未実装です。';
}
