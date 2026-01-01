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

  /// No description provided for @dungeonTitle.
  ///
  /// In ja, this message translates to:
  /// **'ダンジョン'**
  String get dungeonTitle;

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

  /// No description provided for @partyIncomplete.
  ///
  /// In ja, this message translates to:
  /// **'前衛・中衛・後衛の3人を設定してください'**
  String get partyIncomplete;

  /// No description provided for @saveTitle.
  ///
  /// In ja, this message translates to:
  /// **'セーブ'**
  String get saveTitle;

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

  /// No description provided for @selectPlayerCharactersTitle.
  ///
  /// In ja, this message translates to:
  /// **'パーティメンバーを選択'**
  String get selectPlayerCharactersTitle;

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
