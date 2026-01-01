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
  String get dungeonTitle => 'ダンジョン';

  @override
  String get partyTitle => 'パーティ';

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
  String get selectConditionTitle => '条件を選択';

  @override
  String get selectActionTitle => 'アクションを選択';

  @override
  String get selectPlayerCharactersTitle => 'パーティメンバーを選択';

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
}
