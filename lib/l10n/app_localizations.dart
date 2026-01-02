import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ja.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('ja')];

  /// No description provided for @appTitle.
  ///
  /// In ja, this message translates to:
  /// **'Vermelha'**
  String get appTitle;

  /// No description provided for @newGame.
  ///
  /// In ja, this message translates to:
  /// **'ニューゲーム'**
  String get newGame;

  /// No description provided for @newGameConfirmTitle.
  ///
  /// In ja, this message translates to:
  /// **'ニューゲームを開始しますか？'**
  String get newGameConfirmTitle;

  /// No description provided for @newGameConfirmBody.
  ///
  /// In ja, this message translates to:
  /// **'既存のデータは削除され、元に戻せません。'**
  String get newGameConfirmBody;

  /// No description provided for @loadGame.
  ///
  /// In ja, this message translates to:
  /// **'ロードゲーム'**
  String get loadGame;

  /// No description provided for @cityTitle.
  ///
  /// In ja, this message translates to:
  /// **'街'**
  String get cityTitle;

  /// No description provided for @tavernTitle.
  ///
  /// In ja, this message translates to:
  /// **'酒場'**
  String get tavernTitle;

  /// No description provided for @shopTitle.
  ///
  /// In ja, this message translates to:
  /// **'ショップ'**
  String get shopTitle;

  /// No description provided for @shopBuyTab.
  ///
  /// In ja, this message translates to:
  /// **'購入'**
  String get shopBuyTab;

  /// No description provided for @shopSellTab.
  ///
  /// In ja, this message translates to:
  /// **'売却'**
  String get shopSellTab;

  /// No description provided for @goldLabel.
  ///
  /// In ja, this message translates to:
  /// **'所持金'**
  String get goldLabel;

  /// No description provided for @priceLabel.
  ///
  /// In ja, this message translates to:
  /// **'{value}G'**
  String priceLabel(Object value);

  /// No description provided for @sellPriceLabel.
  ///
  /// In ja, this message translates to:
  /// **'売値 {value}G'**
  String sellPriceLabel(Object value);

  /// No description provided for @shopSelectCharacter.
  ///
  /// In ja, this message translates to:
  /// **'キャラクター'**
  String get shopSelectCharacter;

  /// No description provided for @notEnoughGold.
  ///
  /// In ja, this message translates to:
  /// **'ゴールドが足りません。'**
  String get notEnoughGold;

  /// No description provided for @dungeonTitle.
  ///
  /// In ja, this message translates to:
  /// **'ダンジョン'**
  String get dungeonTitle;

  /// No description provided for @dungeonLogTab.
  ///
  /// In ja, this message translates to:
  /// **'ログ'**
  String get dungeonLogTab;

  /// No description provided for @dungeonTaskTab.
  ///
  /// In ja, this message translates to:
  /// **'行動'**
  String get dungeonTaskTab;

  /// No description provided for @dungeonSelectTitle.
  ///
  /// In ja, this message translates to:
  /// **'ダンジョン選択'**
  String get dungeonSelectTitle;

  /// No description provided for @dungeonSelectReachedOnly.
  ///
  /// In ja, this message translates to:
  /// **'到達済みフロアのみ選択できます。'**
  String get dungeonSelectReachedOnly;

  /// No description provided for @unlockNextFloorProgress.
  ///
  /// In ja, this message translates to:
  /// **'次フロア解放: {current}/{required}'**
  String unlockNextFloorProgress(Object current, Object required);

  /// No description provided for @floorLabel.
  ///
  /// In ja, this message translates to:
  /// **'フロア{floor}'**
  String floorLabel(Object floor);

  /// No description provided for @battleCountProgress.
  ///
  /// In ja, this message translates to:
  /// **'戦闘回数: {current}/{required}'**
  String battleCountProgress(Object current, Object required);

  /// No description provided for @partyTitle.
  ///
  /// In ja, this message translates to:
  /// **'パーティ'**
  String get partyTitle;

  /// No description provided for @partyFormationTitle.
  ///
  /// In ja, this message translates to:
  /// **'パーティ編成'**
  String get partyFormationTitle;

  /// No description provided for @partyPositionForward.
  ///
  /// In ja, this message translates to:
  /// **'前衛'**
  String get partyPositionForward;

  /// No description provided for @partyPositionMiddle.
  ///
  /// In ja, this message translates to:
  /// **'中衛'**
  String get partyPositionMiddle;

  /// No description provided for @partyPositionRear.
  ///
  /// In ja, this message translates to:
  /// **'後衛'**
  String get partyPositionRear;

  /// No description provided for @partySlotEmpty.
  ///
  /// In ja, this message translates to:
  /// **'未設定'**
  String get partySlotEmpty;

  /// No description provided for @partyClearSlot.
  ///
  /// In ja, this message translates to:
  /// **'外す'**
  String get partyClearSlot;

  /// No description provided for @partyViewDetails.
  ///
  /// In ja, this message translates to:
  /// **'詳細を見る'**
  String get partyViewDetails;

  /// No description provided for @partyIncomplete.
  ///
  /// In ja, this message translates to:
  /// **'前衛・中衛・後衛の3人を設定してください'**
  String get partyIncomplete;

  /// No description provided for @inventoryCapacityLabel.
  ///
  /// In ja, this message translates to:
  /// **'所持品 {current}/{max}'**
  String inventoryCapacityLabel(Object current, Object max);

  /// No description provided for @inventoryEmpty.
  ///
  /// In ja, this message translates to:
  /// **'所持品がありません。'**
  String get inventoryEmpty;

  /// No description provided for @inventoryFullTitle.
  ///
  /// In ja, this message translates to:
  /// **'所持品がいっぱいです'**
  String get inventoryFullTitle;

  /// No description provided for @inventoryFullBody.
  ///
  /// In ja, this message translates to:
  /// **'捨てるアイテムを選んでください。'**
  String get inventoryFullBody;

  /// No description provided for @inventoryDiscardNewItem.
  ///
  /// In ja, this message translates to:
  /// **'新規: {name}'**
  String inventoryDiscardNewItem(Object name);

  /// No description provided for @equipmentTitle.
  ///
  /// In ja, this message translates to:
  /// **'装備'**
  String get equipmentTitle;

  /// No description provided for @equipmentEmpty.
  ///
  /// In ja, this message translates to:
  /// **'未装備'**
  String get equipmentEmpty;

  /// No description provided for @equipmentSlotWeapon.
  ///
  /// In ja, this message translates to:
  /// **'武器'**
  String get equipmentSlotWeapon;

  /// No description provided for @equipmentSlotArmor.
  ///
  /// In ja, this message translates to:
  /// **'防具'**
  String get equipmentSlotArmor;

  /// No description provided for @equipmentSlotAccessory.
  ///
  /// In ja, this message translates to:
  /// **'アクセサリ'**
  String get equipmentSlotAccessory;

  /// No description provided for @equipAction.
  ///
  /// In ja, this message translates to:
  /// **'装備'**
  String get equipAction;

  /// No description provided for @unequipAction.
  ///
  /// In ja, this message translates to:
  /// **'外す'**
  String get unequipAction;

  /// No description provided for @itemTypeWeapon.
  ///
  /// In ja, this message translates to:
  /// **'武器'**
  String get itemTypeWeapon;

  /// No description provided for @itemTypeArmor.
  ///
  /// In ja, this message translates to:
  /// **'防具'**
  String get itemTypeArmor;

  /// No description provided for @itemTypeConsumable.
  ///
  /// In ja, this message translates to:
  /// **'消耗品'**
  String get itemTypeConsumable;

  /// No description provided for @saveTitle.
  ///
  /// In ja, this message translates to:
  /// **'セーブ'**
  String get saveTitle;

  /// No description provided for @saveSuccess.
  ///
  /// In ja, this message translates to:
  /// **'セーブしました。'**
  String get saveSuccess;

  /// No description provided for @campTitle.
  ///
  /// In ja, this message translates to:
  /// **'キャンプ'**
  String get campTitle;

  /// No description provided for @campButton.
  ///
  /// In ja, this message translates to:
  /// **'キャンプ'**
  String get campButton;

  /// No description provided for @campHealButton.
  ///
  /// In ja, this message translates to:
  /// **'全回復して戻る'**
  String get campHealButton;

  /// No description provided for @returnToCity.
  ///
  /// In ja, this message translates to:
  /// **'街へ戻る'**
  String get returnToCity;

  /// No description provided for @settingsTitle.
  ///
  /// In ja, this message translates to:
  /// **'設定'**
  String get settingsTitle;

  /// No description provided for @settingsBody.
  ///
  /// In ja, this message translates to:
  /// **'設定'**
  String get settingsBody;

  /// No description provided for @noCharacters.
  ///
  /// In ja, this message translates to:
  /// **'キャラクターがいません'**
  String get noCharacters;

  /// No description provided for @noCharactersFound.
  ///
  /// In ja, this message translates to:
  /// **'キャラクターが見つかりません'**
  String get noCharactersFound;

  /// No description provided for @deleteCharacterTitle.
  ///
  /// In ja, this message translates to:
  /// **'キャラクターを削除しますか？'**
  String get deleteCharacterTitle;

  /// No description provided for @deleteCharacterBody.
  ///
  /// In ja, this message translates to:
  /// **'削除すると元に戻せません。'**
  String get deleteCharacterBody;

  /// No description provided for @cancel.
  ///
  /// In ja, this message translates to:
  /// **'キャンセル'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In ja, this message translates to:
  /// **'決定'**
  String get confirm;

  /// No description provided for @delete.
  ///
  /// In ja, this message translates to:
  /// **'削除'**
  String get delete;

  /// No description provided for @newCharacterTitle.
  ///
  /// In ja, this message translates to:
  /// **'新規'**
  String get newCharacterTitle;

  /// No description provided for @nameLabel.
  ///
  /// In ja, this message translates to:
  /// **'名前'**
  String get nameLabel;

  /// No description provided for @jobLabel.
  ///
  /// In ja, this message translates to:
  /// **'ジョブ'**
  String get jobLabel;

  /// No description provided for @partyJoinLabel.
  ///
  /// In ja, this message translates to:
  /// **'パーティ参加'**
  String get partyJoinLabel;

  /// No description provided for @levelLabel.
  ///
  /// In ja, this message translates to:
  /// **'レベル'**
  String get levelLabel;

  /// No description provided for @levelShort.
  ///
  /// In ja, this message translates to:
  /// **'Lv.'**
  String get levelShort;

  /// No description provided for @expLabel.
  ///
  /// In ja, this message translates to:
  /// **'経験値'**
  String get expLabel;

  /// No description provided for @hpLabel.
  ///
  /// In ja, this message translates to:
  /// **'HP'**
  String get hpLabel;

  /// No description provided for @mpLabel.
  ///
  /// In ja, this message translates to:
  /// **'MP'**
  String get mpLabel;

  /// No description provided for @attackLabel.
  ///
  /// In ja, this message translates to:
  /// **'攻撃力'**
  String get attackLabel;

  /// No description provided for @defenseLabel.
  ///
  /// In ja, this message translates to:
  /// **'防御力'**
  String get defenseLabel;

  /// No description provided for @magicPowerLabel.
  ///
  /// In ja, this message translates to:
  /// **'魔法力'**
  String get magicPowerLabel;

  /// No description provided for @speedLabel.
  ///
  /// In ja, this message translates to:
  /// **'素早さ'**
  String get speedLabel;

  /// No description provided for @statusParameterHp.
  ///
  /// In ja, this message translates to:
  /// **'HP'**
  String get statusParameterHp;

  /// No description provided for @statusParameterMp.
  ///
  /// In ja, this message translates to:
  /// **'MP'**
  String get statusParameterMp;

  /// No description provided for @statusParameterAttack.
  ///
  /// In ja, this message translates to:
  /// **'攻撃力'**
  String get statusParameterAttack;

  /// No description provided for @statusParameterDefense.
  ///
  /// In ja, this message translates to:
  /// **'防御力'**
  String get statusParameterDefense;

  /// No description provided for @statusParameterMagicPower.
  ///
  /// In ja, this message translates to:
  /// **'魔法力'**
  String get statusParameterMagicPower;

  /// No description provided for @statusParameterSpeed.
  ///
  /// In ja, this message translates to:
  /// **'素早さ'**
  String get statusParameterSpeed;

  /// No description provided for @priorityParametersLabel.
  ///
  /// In ja, this message translates to:
  /// **'優先パラメータ'**
  String get priorityParametersLabel;

  /// No description provided for @battleRulesLabel.
  ///
  /// In ja, this message translates to:
  /// **'戦闘ルール'**
  String get battleRulesLabel;

  /// No description provided for @priorityParametersDescription.
  ///
  /// In ja, this message translates to:
  /// **'このキャラクターがレベルアップした時、優先的に成長するパラメーターを３つ選びます'**
  String get priorityParametersDescription;

  /// No description provided for @battleRulesTitleWithName.
  ///
  /// In ja, this message translates to:
  /// **'戦闘ルール：{name}'**
  String battleRulesTitleWithName(Object name);

  /// No description provided for @battleRulesTitle.
  ///
  /// In ja, this message translates to:
  /// **'戦闘ルール'**
  String get battleRulesTitle;

  /// No description provided for @deleteRuleTitle.
  ///
  /// In ja, this message translates to:
  /// **'削除の確認'**
  String get deleteRuleTitle;

  /// No description provided for @deleteRuleBody.
  ///
  /// In ja, this message translates to:
  /// **'この戦闘ルールを削除しますか？'**
  String get deleteRuleBody;

  /// No description provided for @noLabel.
  ///
  /// In ja, this message translates to:
  /// **'いいえ'**
  String get noLabel;

  /// No description provided for @yesLabel.
  ///
  /// In ja, this message translates to:
  /// **'はい'**
  String get yesLabel;

  /// No description provided for @addBattleRule.
  ///
  /// In ja, this message translates to:
  /// **'新しい戦闘ルールを追加する'**
  String get addBattleRule;

  /// No description provided for @battleRuleLimitReached.
  ///
  /// In ja, this message translates to:
  /// **'戦闘ルールは最大16件です'**
  String get battleRuleLimitReached;

  /// No description provided for @selectConditionTitle.
  ///
  /// In ja, this message translates to:
  /// **'条件を選択'**
  String get selectConditionTitle;

  /// No description provided for @selectActionTitle.
  ///
  /// In ja, this message translates to:
  /// **'アクションを選択'**
  String get selectActionTitle;

  /// No description provided for @selectTargetTitle.
  ///
  /// In ja, this message translates to:
  /// **'ターゲットを選択'**
  String get selectTargetTitle;

  /// No description provided for @selectPlayerCharactersTitle.
  ///
  /// In ja, this message translates to:
  /// **'パーティメンバーを選択'**
  String get selectPlayerCharactersTitle;

  /// No description provided for @logTypeExplore.
  ///
  /// In ja, this message translates to:
  /// **'探索'**
  String get logTypeExplore;

  /// No description provided for @logTypeBattle.
  ///
  /// In ja, this message translates to:
  /// **'戦闘'**
  String get logTypeBattle;

  /// No description provided for @logTypeLoot.
  ///
  /// In ja, this message translates to:
  /// **'戦利品'**
  String get logTypeLoot;

  /// No description provided for @logTypeSystem.
  ///
  /// In ja, this message translates to:
  /// **'システム'**
  String get logTypeSystem;

  /// No description provided for @logExplorationStart.
  ///
  /// In ja, this message translates to:
  /// **'探索を開始した。'**
  String get logExplorationStart;

  /// No description provided for @logExplorationMove.
  ///
  /// In ja, this message translates to:
  /// **'探索を進めた。'**
  String get logExplorationMove;

  /// No description provided for @logExplorationTreasure.
  ///
  /// In ja, this message translates to:
  /// **'宝箱を見つけた。'**
  String get logExplorationTreasure;

  /// No description provided for @logExplorationTrap.
  ///
  /// In ja, this message translates to:
  /// **'罠にかかった。'**
  String get logExplorationTrap;

  /// No description provided for @logBattleEncounter.
  ///
  /// In ja, this message translates to:
  /// **'敵と遭遇した。'**
  String get logBattleEncounter;

  /// No description provided for @logBattleAction.
  ///
  /// In ja, this message translates to:
  /// **'{subject}は{action} → {targets}'**
  String logBattleAction(Object subject, Object action, Object targets);

  /// No description provided for @logBattleVictory.
  ///
  /// In ja, this message translates to:
  /// **'戦闘に勝利した。'**
  String get logBattleVictory;

  /// No description provided for @logLootNone.
  ///
  /// In ja, this message translates to:
  /// **'戦利品はなかった。'**
  String get logLootNone;

  /// No description provided for @logLootGold.
  ///
  /// In ja, this message translates to:
  /// **'ゴールド{amount}Gを獲得した。'**
  String logLootGold(Object amount);

  /// No description provided for @logLootItem.
  ///
  /// In ja, this message translates to:
  /// **'戦利品: {item}を入手した。'**
  String logLootItem(Object item);

  /// No description provided for @logCampHeal.
  ///
  /// In ja, this message translates to:
  /// **'キャンプで全回復した。'**
  String get logCampHeal;

  /// Log message for when the party is defeated, returns to the city, and is fully healed.
  ///
  /// In ja, this message translates to:
  /// **'全滅したため街へ帰還し、全回復した。'**
  String get logPartyDefeatedReturn;

  /// No description provided for @logReturnToCity.
  ///
  /// In ja, this message translates to:
  /// **'街へ帰還した。'**
  String get logReturnToCity;

  /// No description provided for @taskStatusComplete.
  ///
  /// In ja, this message translates to:
  /// **'完了'**
  String get taskStatusComplete;

  /// No description provided for @taskStatusCanceled.
  ///
  /// In ja, this message translates to:
  /// **'キャンセル'**
  String get taskStatusCanceled;

  /// No description provided for @progressPercent.
  ///
  /// In ja, this message translates to:
  /// **'{value}%'**
  String progressPercent(Object value);

  /// No description provided for @hpShort.
  ///
  /// In ja, this message translates to:
  /// **'HP'**
  String get hpShort;

  /// No description provided for @mpShort.
  ///
  /// In ja, this message translates to:
  /// **'MP'**
  String get mpShort;

  /// No description provided for @unknownLabel.
  ///
  /// In ja, this message translates to:
  /// **'不明'**
  String get unknownLabel;

  /// No description provided for @enemyRegular.
  ///
  /// In ja, this message translates to:
  /// **'定型の敵'**
  String get enemyRegular;

  /// No description provided for @enemyIrregular.
  ///
  /// In ja, this message translates to:
  /// **'非定型の敵'**
  String get enemyIrregular;

  /// No description provided for @enemyNameGoblin.
  ///
  /// In ja, this message translates to:
  /// **'ゴブリン'**
  String get enemyNameGoblin;

  /// No description provided for @enemyNameSkeleton.
  ///
  /// In ja, this message translates to:
  /// **'スケルトン'**
  String get enemyNameSkeleton;

  /// No description provided for @enemyNameOrc.
  ///
  /// In ja, this message translates to:
  /// **'オーク'**
  String get enemyNameOrc;

  /// No description provided for @enemyNameSlime.
  ///
  /// In ja, this message translates to:
  /// **'スライム'**
  String get enemyNameSlime;

  /// No description provided for @enemyNameWisp.
  ///
  /// In ja, this message translates to:
  /// **'ウィスプ'**
  String get enemyNameWisp;

  /// No description provided for @enemyNameGhost.
  ///
  /// In ja, this message translates to:
  /// **'ゴースト'**
  String get enemyNameGhost;

  /// No description provided for @jobFighter.
  ///
  /// In ja, this message translates to:
  /// **'戦士'**
  String get jobFighter;

  /// No description provided for @jobPaladin.
  ///
  /// In ja, this message translates to:
  /// **'神殿騎士'**
  String get jobPaladin;

  /// No description provided for @jobRanger.
  ///
  /// In ja, this message translates to:
  /// **'レンジャー'**
  String get jobRanger;

  /// No description provided for @jobWizard.
  ///
  /// In ja, this message translates to:
  /// **'魔法使い'**
  String get jobWizard;

  /// No description provided for @jobShaman.
  ///
  /// In ja, this message translates to:
  /// **'シャーマン'**
  String get jobShaman;

  /// No description provided for @jobPriest.
  ///
  /// In ja, this message translates to:
  /// **'僧侶'**
  String get jobPriest;

  /// No description provided for @actionPhysicalAttack.
  ///
  /// In ja, this message translates to:
  /// **'物理攻撃'**
  String get actionPhysicalAttack;

  /// No description provided for @actionAttackMagic.
  ///
  /// In ja, this message translates to:
  /// **'攻撃魔法'**
  String get actionAttackMagic;

  /// No description provided for @actionBigHeal.
  ///
  /// In ja, this message translates to:
  /// **'大回復魔法'**
  String get actionBigHeal;

  /// No description provided for @actionSmallHeal.
  ///
  /// In ja, this message translates to:
  /// **'小回復魔法'**
  String get actionSmallHeal;

  /// No description provided for @actionBigCure.
  ///
  /// In ja, this message translates to:
  /// **'大治癒術'**
  String get actionBigCure;

  /// No description provided for @actionSmallCure.
  ///
  /// In ja, this message translates to:
  /// **'小治癒術'**
  String get actionSmallCure;

  /// No description provided for @conditionLowestHpEnemy.
  ///
  /// In ja, this message translates to:
  /// **'最もHPが低い敵'**
  String get conditionLowestHpEnemy;

  /// No description provided for @conditionHighestHpEnemy.
  ///
  /// In ja, this message translates to:
  /// **'最もHPが高い敵'**
  String get conditionHighestHpEnemy;

  /// No description provided for @conditionRandomEnemy.
  ///
  /// In ja, this message translates to:
  /// **'ランダムな敵'**
  String get conditionRandomEnemy;

  /// No description provided for @conditionRandomAlly.
  ///
  /// In ja, this message translates to:
  /// **'ランダムな味方'**
  String get conditionRandomAlly;

  /// No description provided for @conditionAllEnemies.
  ///
  /// In ja, this message translates to:
  /// **'敵全体'**
  String get conditionAllEnemies;

  /// No description provided for @conditionAllAllies.
  ///
  /// In ja, this message translates to:
  /// **'味方全体'**
  String get conditionAllAllies;

  /// No description provided for @conditionEnemyTelegraph.
  ///
  /// In ja, this message translates to:
  /// **'敵が攻撃予兆'**
  String get conditionEnemyTelegraph;

  /// No description provided for @conditionEnemyIrregularExists.
  ///
  /// In ja, this message translates to:
  /// **'非定型の敵がいる'**
  String get conditionEnemyIrregularExists;

  /// No description provided for @conditionEnemyRegularExists.
  ///
  /// In ja, this message translates to:
  /// **'定型の敵がいる'**
  String get conditionEnemyRegularExists;

  /// No description provided for @conditionAllyHpBelow75.
  ///
  /// In ja, this message translates to:
  /// **'HPが75%以下の味方'**
  String get conditionAllyHpBelow75;

  /// No description provided for @conditionAllyHpBelow50.
  ///
  /// In ja, this message translates to:
  /// **'HPが50%以下の味方'**
  String get conditionAllyHpBelow50;

  /// No description provided for @conditionAllyHpBelow25.
  ///
  /// In ja, this message translates to:
  /// **'HPが25%以下の味方'**
  String get conditionAllyHpBelow25;

  /// No description provided for @conditionLowestMpEnemy.
  ///
  /// In ja, this message translates to:
  /// **'最もMPが低い敵'**
  String get conditionLowestMpEnemy;

  /// No description provided for @conditionHighestMpEnemy.
  ///
  /// In ja, this message translates to:
  /// **'最もMPが高い敵'**
  String get conditionHighestMpEnemy;

  /// No description provided for @conditionLowestAttackEnemy.
  ///
  /// In ja, this message translates to:
  /// **'最も攻撃力が低い敵'**
  String get conditionLowestAttackEnemy;

  /// No description provided for @conditionHighestAttackEnemy.
  ///
  /// In ja, this message translates to:
  /// **'最も攻撃力が高い敵'**
  String get conditionHighestAttackEnemy;

  /// No description provided for @conditionLowestDefenseEnemy.
  ///
  /// In ja, this message translates to:
  /// **'最も防御力が低い敵'**
  String get conditionLowestDefenseEnemy;

  /// No description provided for @conditionHighestDefenseEnemy.
  ///
  /// In ja, this message translates to:
  /// **'最も防御力が高い敵'**
  String get conditionHighestDefenseEnemy;

  /// No description provided for @conditionLowestSpeedEnemy.
  ///
  /// In ja, this message translates to:
  /// **'最も素早さが低い敵'**
  String get conditionLowestSpeedEnemy;

  /// No description provided for @conditionHighestSpeedEnemy.
  ///
  /// In ja, this message translates to:
  /// **'最も素早さが高い敵'**
  String get conditionHighestSpeedEnemy;

  /// No description provided for @conditionLowestHpAlly.
  ///
  /// In ja, this message translates to:
  /// **'最もHPが低い味方'**
  String get conditionLowestHpAlly;

  /// No description provided for @conditionHighestHpAlly.
  ///
  /// In ja, this message translates to:
  /// **'最もHPが高い味方'**
  String get conditionHighestHpAlly;

  /// No description provided for @conditionLowestMpAlly.
  ///
  /// In ja, this message translates to:
  /// **'最もMPが低い味方'**
  String get conditionLowestMpAlly;

  /// No description provided for @conditionHighestMpAlly.
  ///
  /// In ja, this message translates to:
  /// **'最もMPが高い味方'**
  String get conditionHighestMpAlly;

  /// No description provided for @conditionLowestAttackAlly.
  ///
  /// In ja, this message translates to:
  /// **'最も攻撃力が低い味方'**
  String get conditionLowestAttackAlly;

  /// No description provided for @conditionHighestAttackAlly.
  ///
  /// In ja, this message translates to:
  /// **'最も攻撃力が高い味方'**
  String get conditionHighestAttackAlly;

  /// No description provided for @conditionLowestDefenseAlly.
  ///
  /// In ja, this message translates to:
  /// **'最も防御力が低い味方'**
  String get conditionLowestDefenseAlly;

  /// No description provided for @conditionHighestDefenseAlly.
  ///
  /// In ja, this message translates to:
  /// **'最も防御力が高い味方'**
  String get conditionHighestDefenseAlly;

  /// No description provided for @conditionLowestSpeedAlly.
  ///
  /// In ja, this message translates to:
  /// **'最も素早さが低い味方'**
  String get conditionLowestSpeedAlly;

  /// No description provided for @conditionHighestSpeedAlly.
  ///
  /// In ja, this message translates to:
  /// **'最も素早さが高い味方'**
  String get conditionHighestSpeedAlly;

  /// No description provided for @targetMatchingAlly.
  ///
  /// In ja, this message translates to:
  /// **'条件に合う味方'**
  String get targetMatchingAlly;

  /// No description provided for @targetMatchingEnemy.
  ///
  /// In ja, this message translates to:
  /// **'条件に合う敵'**
  String get targetMatchingEnemy;

  /// No description provided for @targetSelf.
  ///
  /// In ja, this message translates to:
  /// **'自分自身'**
  String get targetSelf;

  /// No description provided for @targetRandomAlly.
  ///
  /// In ja, this message translates to:
  /// **'ランダムな味方'**
  String get targetRandomAlly;

  /// No description provided for @targetRandomEnemy.
  ///
  /// In ja, this message translates to:
  /// **'ランダムな敵'**
  String get targetRandomEnemy;

  /// No description provided for @targetAllAllies.
  ///
  /// In ja, this message translates to:
  /// **'味方全体'**
  String get targetAllAllies;

  /// No description provided for @targetAllEnemies.
  ///
  /// In ja, this message translates to:
  /// **'敵全体'**
  String get targetAllEnemies;

  /// No description provided for @targetLowestHpAlly.
  ///
  /// In ja, this message translates to:
  /// **'HPが最も低い味方'**
  String get targetLowestHpAlly;

  /// No description provided for @targetLowestHpEnemy.
  ///
  /// In ja, this message translates to:
  /// **'HPが最も低い敵'**
  String get targetLowestHpEnemy;

  /// No description provided for @targetHighestHpAlly.
  ///
  /// In ja, this message translates to:
  /// **'HPが最も高い味方'**
  String get targetHighestHpAlly;

  /// No description provided for @targetHighestHpEnemy.
  ///
  /// In ja, this message translates to:
  /// **'HPが最も高い敵'**
  String get targetHighestHpEnemy;

  /// No description provided for @targetLowestMpAlly.
  ///
  /// In ja, this message translates to:
  /// **'MPが最も低い味方'**
  String get targetLowestMpAlly;

  /// No description provided for @targetLowestMpEnemy.
  ///
  /// In ja, this message translates to:
  /// **'MPが最も低い敵'**
  String get targetLowestMpEnemy;

  /// No description provided for @targetHighestMpAlly.
  ///
  /// In ja, this message translates to:
  /// **'MPが最も高い味方'**
  String get targetHighestMpAlly;

  /// No description provided for @targetHighestMpEnemy.
  ///
  /// In ja, this message translates to:
  /// **'MPが最も高い敵'**
  String get targetHighestMpEnemy;

  /// No description provided for @targetLowestAttackAlly.
  ///
  /// In ja, this message translates to:
  /// **'最も攻撃力が低い味方'**
  String get targetLowestAttackAlly;

  /// No description provided for @targetLowestAttackEnemy.
  ///
  /// In ja, this message translates to:
  /// **'最も攻撃力が低い敵'**
  String get targetLowestAttackEnemy;

  /// No description provided for @targetHighestAttackAlly.
  ///
  /// In ja, this message translates to:
  /// **'最も攻撃力が高い味方'**
  String get targetHighestAttackAlly;

  /// No description provided for @targetHighestAttackEnemy.
  ///
  /// In ja, this message translates to:
  /// **'最も攻撃力が高い敵'**
  String get targetHighestAttackEnemy;

  /// No description provided for @targetLowestDefenseAlly.
  ///
  /// In ja, this message translates to:
  /// **'最も防御力が低い味方'**
  String get targetLowestDefenseAlly;

  /// No description provided for @targetLowestDefenseEnemy.
  ///
  /// In ja, this message translates to:
  /// **'最も防御力が低い敵'**
  String get targetLowestDefenseEnemy;

  /// No description provided for @targetHighestDefenseAlly.
  ///
  /// In ja, this message translates to:
  /// **'最も防御力が高い味方'**
  String get targetHighestDefenseAlly;

  /// No description provided for @targetHighestDefenseEnemy.
  ///
  /// In ja, this message translates to:
  /// **'最も防御力が高い敵'**
  String get targetHighestDefenseEnemy;

  /// No description provided for @targetLowestSpeedAlly.
  ///
  /// In ja, this message translates to:
  /// **'最も素早さが低い味方'**
  String get targetLowestSpeedAlly;

  /// No description provided for @targetLowestSpeedEnemy.
  ///
  /// In ja, this message translates to:
  /// **'最も素早さが低い敵'**
  String get targetLowestSpeedEnemy;

  /// No description provided for @targetHighestSpeedAlly.
  ///
  /// In ja, this message translates to:
  /// **'最も素早さが高い味方'**
  String get targetHighestSpeedAlly;

  /// No description provided for @targetHighestSpeedEnemy.
  ///
  /// In ja, this message translates to:
  /// **'最も素早さが高い敵'**
  String get targetHighestSpeedEnemy;

  /// No description provided for @itemWeaponShortSword.
  ///
  /// In ja, this message translates to:
  /// **'ショートソード'**
  String get itemWeaponShortSword;

  /// No description provided for @itemWeaponBattleAxe.
  ///
  /// In ja, this message translates to:
  /// **'バトルアックス'**
  String get itemWeaponBattleAxe;

  /// No description provided for @itemWeaponLongBow.
  ///
  /// In ja, this message translates to:
  /// **'ロングボウ'**
  String get itemWeaponLongBow;

  /// No description provided for @itemArmorLeather.
  ///
  /// In ja, this message translates to:
  /// **'レザーアーマー'**
  String get itemArmorLeather;

  /// No description provided for @itemArmorChain.
  ///
  /// In ja, this message translates to:
  /// **'チェインメイル'**
  String get itemArmorChain;

  /// No description provided for @itemConsumablePotion.
  ///
  /// In ja, this message translates to:
  /// **'回復薬'**
  String get itemConsumablePotion;

  /// No description provided for @itemConsumableEther.
  ///
  /// In ja, this message translates to:
  /// **'魔力水'**
  String get itemConsumableEther;

  /// No description provided for @actionDefend.
  ///
  /// In ja, this message translates to:
  /// **'防御'**
  String get actionDefend;

  /// No description provided for @actionUsePotion.
  ///
  /// In ja, this message translates to:
  /// **'回復薬を使う'**
  String get actionUsePotion;

  /// No description provided for @actionUseEther.
  ///
  /// In ja, this message translates to:
  /// **'魔力水を使う'**
  String get actionUseEther;

  /// No description provided for @conditionAlways.
  ///
  /// In ja, this message translates to:
  /// **'常に'**
  String get conditionAlways;

  /// No description provided for @targetFirstEnemy.
  ///
  /// In ja, this message translates to:
  /// **'先頭の敵'**
  String get targetFirstEnemy;

  /// No description provided for @targetAttackingEnemy.
  ///
  /// In ja, this message translates to:
  /// **'自分を攻撃している敵'**
  String get targetAttackingEnemy;

  /// No description provided for @notImplemented.
  ///
  /// In ja, this message translates to:
  /// **'未実装です。'**
  String get notImplemented;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ja'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ja':
      return AppLocalizationsJa();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
