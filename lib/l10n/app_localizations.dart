import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ur.dart';
import 'app_localizations_zh.dart';

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
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
    Locale('it'),
    Locale('pt'),
    Locale('ur'),
    Locale('zh', 'TC'),
    Locale('zh')
  ];

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Youtube Downloader'**
  String get title;

  /// No description provided for @startSearch.
  ///
  /// In en, this message translates to:
  /// **'Put your video or playlist URL!'**
  String get startSearch;

  /// No description provided for @searchUrl.
  ///
  /// In en, this message translates to:
  /// **'Download URL'**
  String get searchUrl;

  /// No description provided for @searchUrlTooltip.
  ///
  /// In en, this message translates to:
  /// **'Paste your URL from clipboard'**
  String get searchUrlTooltip;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @ffmpegPath.
  ///
  /// In en, this message translates to:
  /// **'Path to FFMPEG\'s location'**
  String get ffmpegPath;

  /// No description provided for @ffmpegContainer.
  ///
  /// In en, this message translates to:
  /// **'FFPEG container'**
  String get ffmpegContainer;

  /// No description provided for @ffmpegDescription.
  ///
  /// In en, this message translates to:
  /// **'This is the output format when two tracks (audio + video) are merged'**
  String get ffmpegDescription;

  /// No description provided for @ffmpegNotFound.
  ///
  /// In en, this message translates to:
  /// **'FFMPEG not found in PATH or not configured'**
  String get ffmpegNotFound;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @downloadDir.
  ///
  /// In en, this message translates to:
  /// **'Download Directory'**
  String get downloadDir;

  /// No description provided for @selectDownloadDir.
  ///
  /// In en, this message translates to:
  /// **'Select download directory'**
  String get selectDownloadDir;

  /// No description provided for @invalidDir.
  ///
  /// In en, this message translates to:
  /// **'Invalid directory'**
  String get invalidDir;

  /// No description provided for @credits.
  ///
  /// In en, this message translates to:
  /// **'App credits'**
  String get credits;

  /// No description provided for @credits_content.
  ///
  /// In en, this message translates to:
  /// **'Graphics: https://www.flaticon.com/authors/freepik\nOriginal Author: https://github.com/Hexer10\nEdited by: https://github.com/mickbad'**
  String get credits_content;

  /// No description provided for @downloads.
  ///
  /// In en, this message translates to:
  /// **'Downloads'**
  String get downloads;

  /// No description provided for @author.
  ///
  /// In en, this message translates to:
  /// **'Author'**
  String get author;

  /// No description provided for @uploadDateRow.
  ///
  /// In en, this message translates to:
  /// **'Published'**
  String get uploadDateRow;

  /// No description provided for @downloadCleanUpList.
  ///
  /// In en, this message translates to:
  /// **'Clean download list (none deleted)'**
  String get downloadCleanUpList;

  /// No description provided for @downloadCleanUpListConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to clean the download list?'**
  String get downloadCleanUpListConfirm;

  /// No description provided for @navigateToDownloadPage.
  ///
  /// In en, this message translates to:
  /// **'Download Page'**
  String get navigateToDownloadPage;

  /// No description provided for @navigateToDownloadPageConfirm.
  ///
  /// In en, this message translates to:
  /// **'Do you want to navigate to the download page?'**
  String get navigateToDownloadPageConfirm;

  /// No description provided for @tracksTooltip.
  ///
  /// In en, this message translates to:
  /// **'Tap on line to download stream or long tap to select stream for merge'**
  String get tracksTooltip;

  /// No description provided for @mergeTracks.
  ///
  /// In en, this message translates to:
  /// **'Download & Merge tracks!'**
  String get mergeTracks;

  /// No description provided for @tracksBestMerge.
  ///
  /// In en, this message translates to:
  /// **'Best video + audio quality'**
  String get tracksBestMerge;

  /// No description provided for @tracksAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get tracksAll;

  /// No description provided for @tracksVideoAudio.
  ///
  /// In en, this message translates to:
  /// **'Video + Audio'**
  String get tracksVideoAudio;

  /// No description provided for @tracksVideo.
  ///
  /// In en, this message translates to:
  /// **'Video Only'**
  String get tracksVideo;

  /// No description provided for @tracksAudio.
  ///
  /// In en, this message translates to:
  /// **'Audio Only'**
  String get tracksAudio;

  /// No description provided for @trackID3EditTooltip.
  ///
  /// In en, this message translates to:
  /// **'Update mp3 ID3'**
  String get trackID3EditTooltip;

  /// No description provided for @trackID3Tooltip.
  ///
  /// In en, this message translates to:
  /// **'Update mp3 informations'**
  String get trackID3Tooltip;

  /// No description provided for @trackID3FieldTitle.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get trackID3FieldTitle;

  /// No description provided for @trackID3FieldArtist.
  ///
  /// In en, this message translates to:
  /// **'Author / Artist'**
  String get trackID3FieldArtist;

  /// No description provided for @trackID3FieldAlbum.
  ///
  /// In en, this message translates to:
  /// **'Album'**
  String get trackID3FieldAlbum;

  /// No description provided for @trackID3Action.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get trackID3Action;

  /// No description provided for @playlistParsing.
  ///
  /// In en, this message translates to:
  /// **'Playlist parsing: {percent}%'**
  String playlistParsing(Object percent);

  /// No description provided for @playlistTooltip.
  ///
  /// In en, this message translates to:
  /// **'Tap on line to select or deselect video to download'**
  String get playlistTooltip;

  /// No description provided for @playlistTitle.
  ///
  /// In en, this message translates to:
  /// **'List of all {count} videos or audios to download'**
  String playlistTitle(Object count);

  /// No description provided for @playlistDownloadVideos.
  ///
  /// In en, this message translates to:
  /// **'Download videos + audios'**
  String get playlistDownloadVideos;

  /// No description provided for @playlistDownloadAudiosOnly.
  ///
  /// In en, this message translates to:
  /// **'Download audios'**
  String get playlistDownloadAudiosOnly;

  /// No description provided for @playlistDownloadVideosOnly.
  ///
  /// In en, this message translates to:
  /// **'Download videos'**
  String get playlistDownloadVideosOnly;

  /// No description provided for @settingsQuotaTitle.
  ///
  /// In en, this message translates to:
  /// **'Download quota'**
  String get settingsQuotaTitle;

  /// No description provided for @settingsQuotaDescription.
  ///
  /// In en, this message translates to:
  /// **'The max number of authorized concurrent download and transform streams'**
  String get settingsQuotaDescription;

  /// No description provided for @settingsLeadingZeroTitle.
  ///
  /// In en, this message translates to:
  /// **'Playlist: filename header'**
  String get settingsLeadingZeroTitle;

  /// No description provided for @settingsLeadingZeroDescription.
  ///
  /// In en, this message translates to:
  /// **'Add a leading zero in the pathname when dowloading a playlist'**
  String get settingsLeadingZeroDescription;

  /// No description provided for @permissionError.
  ///
  /// In en, this message translates to:
  /// **'The app needs the storage permission to download files!'**
  String get permissionError;

  /// No description provided for @startDownload.
  ///
  /// In en, this message translates to:
  /// **'Started downloading: {title}'**
  String startDownload(Object title);

  /// No description provided for @failDownload.
  ///
  /// In en, this message translates to:
  /// **'Downloading failed: {title}'**
  String failDownload(Object title);

  /// No description provided for @cancelDownload.
  ///
  /// In en, this message translates to:
  /// **'Downloading cancelled: {title}'**
  String cancelDownload(Object title);

  /// No description provided for @finishDownload.
  ///
  /// In en, this message translates to:
  /// **'Downloading finished: {title}'**
  String finishDownload(Object title);

  /// No description provided for @startMerge.
  ///
  /// In en, this message translates to:
  /// **'Merging tracks of: {title}'**
  String startMerge(Object title);

  /// No description provided for @cancelMerge.
  ///
  /// In en, this message translates to:
  /// **'Cancelled merge of: {title}'**
  String cancelMerge(Object title);

  /// No description provided for @finishMerge.
  ///
  /// In en, this message translates to:
  /// **'Merge finished: {title}'**
  String finishMerge(Object title);

  /// No description provided for @finishConvert.
  ///
  /// In en, this message translates to:
  /// **'Convertion finished: {title}'**
  String finishConvert(Object title);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'en',
        'fr',
        'it',
        'pt',
        'ur',
        'zh'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'zh':
      {
        switch (locale.countryCode) {
          case 'TC':
            return AppLocalizationsZhTc();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'pt':
      return AppLocalizationsPt();
    case 'ur':
      return AppLocalizationsUr();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
