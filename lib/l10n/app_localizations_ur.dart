// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class AppLocalizationsUr extends AppLocalizations {
  AppLocalizationsUr([String locale = 'ur']) : super(locale);

  @override
  String get title => 'Youtube Downloader';

  @override
  String get startSearch => '!تلاش شروع کرو';

  @override
  String get searchUrl => 'Download URL';

  @override
  String get searchUrlTooltip => 'Paste your URL from clipboard';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Cancel';

  @override
  String get settings => 'ترتیبات';

  @override
  String get darkMode => 'اندھیرا موڈ';

  @override
  String get ffmpegPath => 'Path to FFMPEG\'s location';

  @override
  String get ffmpegContainer => 'ffmpeg ڈبہ';

  @override
  String get ffmpegDescription =>
      'یہ آؤٹ پٹ فارمیٹ ہے جب دو ٹریکس (آڈیو + ویڈیو) آپس میں ضم ہوتے ہیں۔';

  @override
  String get ffmpegNotFound => 'میں Path ملا نہیں FFMPEG or not configured';

  @override
  String get language => 'زبان';

  @override
  String get downloadDir => 'ڈائریکٹری ڈاؤن لوڈ';

  @override
  String get selectDownloadDir => 'ڈاؤن لوڈ ڈائریکٹری منتخب کریں۔';

  @override
  String get invalidDir => 'غلط ڈائریکٹری';

  @override
  String get credits => 'Application credits';

  @override
  String get credits_content =>
      'Graphics: https://www.flaticon.com/authors/freepik\nOriginal Author: https://github.com/Hexer10\nModified: https://github.com/mickbad';

  @override
  String get downloads => 'ڈاؤن لوڈز';

  @override
  String get author => 'مصنف';

  @override
  String get uploadDateRow => 'Published';

  @override
  String get downloadCleanUpList => 'Clean download list (none deleted)';

  @override
  String get downloadCleanUpListConfirm =>
      'Are you sure you want to clean the download list?';

  @override
  String get navigateToDownloadPage => 'Download Page';

  @override
  String get navigateToDownloadPageConfirm =>
      'Do you want to navigate to the download page?';

  @override
  String get tracksTooltip =>
      'Tap on line to download stream or long tap to select stream for merge';

  @override
  String get mergeTracks => 'Download & Merge tracks!';

  @override
  String get tracksBestMerge => 'Best video + audio quality';

  @override
  String get tracksAll => 'All';

  @override
  String get tracksVideoAudio => 'Video + Audio';

  @override
  String get tracksVideo => 'Video Only';

  @override
  String get tracksAudio => 'Audio Only';

  @override
  String get trackID3EditTooltip => 'Update mp3 ID3';

  @override
  String get trackID3Tooltip => 'Update mp3 informations';

  @override
  String get trackID3FieldTitle => 'Title';

  @override
  String get trackID3FieldArtist => 'Author / Artist';

  @override
  String get trackID3FieldAlbum => 'Album';

  @override
  String get trackID3Action => 'Update';

  @override
  String playlistParsing(Object percent) {
    return 'Playlist parsing: $percent%';
  }

  @override
  String get playlistTooltip =>
      'Tap on line to select or deselect video to download';

  @override
  String playlistTitle(Object count) {
    return 'List of all $count videos or audios to download';
  }

  @override
  String get playlistDownloadVideos => 'Download videos + audios';

  @override
  String get playlistDownloadAudiosOnly => 'Download audios';

  @override
  String get playlistDownloadVideosOnly => 'Download videos';

  @override
  String get settingsQuotaTitle => 'Download quota';

  @override
  String get settingsQuotaDescription =>
      'The max number of authorized concurrent download and transform streams';

  @override
  String get settingsLeadingZeroTitle => 'Playlist: filename header';

  @override
  String get settingsLeadingZeroDescription =>
      'Add a leading zero in the pathname when dowloading a playlist';

  @override
  String get permissionError =>
      '!ایپ کو فائلیں ڈاؤن لوڈ کرنے کے لیے اسٹوریج کی اجازت درکار ہے';

  @override
  String startDownload(Object title) {
    return '$title: ڈاؤن لوڈ کرنا شروع ہوا';
  }

  @override
  String failDownload(Object title) {
    return '$title: ڈاؤن لوڈنگ ناکام ہو گئی۔';
  }

  @override
  String cancelDownload(Object title) {
    return '$title: ڈاؤن لوڈنگ منسوخ کر دی گئی۔';
  }

  @override
  String finishDownload(Object title) {
    return '$title: ڈاؤن لوڈ مکمل ہو گیا۔';
  }

  @override
  String startMerge(Object title) {
    return '$title: ٹریکس کو ضم کرنا';
  }

  @override
  String cancelMerge(Object title) {
    return '$title: انضمام منسوخ کر دیا گیا۔';
  }

  @override
  String finishMerge(Object title) {
    return '$title: ضم ہو گیا۔';
  }

  @override
  String finishConvert(Object title) {
    return 'Convertion finished : $title';
  }
}
