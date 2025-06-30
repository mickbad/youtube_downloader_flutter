// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get title => 'Youtube Downloader';

  @override
  String get startSearch => 'Put your video or playlist URL!';

  @override
  String get searchUrl => 'Download URL';

  @override
  String get searchUrlTooltip => 'Paste your URL from clipboard';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Cancel';

  @override
  String get settings => 'Settings';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get ffmpegPath => 'Path to FFMPEG\'s location';

  @override
  String get ffmpegContainer => 'FFPEG container';

  @override
  String get ffmpegDescription =>
      'This is the output format when two tracks (audio + video) are merged';

  @override
  String get ffmpegNotFound => 'FFMPEG not found in PATH or not configured';

  @override
  String get language => 'Language';

  @override
  String get downloadDir => 'Download Directory';

  @override
  String get selectDownloadDir => 'Select download directory';

  @override
  String get invalidDir => 'Invalid directory';

  @override
  String get credits => 'App credits';

  @override
  String get credits_content =>
      'Graphics: https://www.flaticon.com/authors/freepik\nOriginal Author: https://github.com/Hexer10\nEdited by: https://github.com/mickbad';

  @override
  String get downloads => 'Downloads';

  @override
  String get author => 'Author';

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
      'The app needs the storage permission to download files!';

  @override
  String startDownload(Object title) {
    return 'Started downloading: $title';
  }

  @override
  String failDownload(Object title) {
    return 'Downloading failed: $title';
  }

  @override
  String cancelDownload(Object title) {
    return 'Downloading cancelled: $title';
  }

  @override
  String finishDownload(Object title) {
    return 'Downloading finished: $title';
  }

  @override
  String startMerge(Object title) {
    return 'Merging tracks of: $title';
  }

  @override
  String cancelMerge(Object title) {
    return 'Cancelled merge of: $title';
  }

  @override
  String finishMerge(Object title) {
    return 'Merge finished: $title';
  }

  @override
  String finishConvert(Object title) {
    return 'Convertion finished: $title';
  }
}
