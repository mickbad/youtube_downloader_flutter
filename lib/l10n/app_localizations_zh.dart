// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get title => 'YT下载者';

  @override
  String get startSearch => '写到视频网址或者播放列表网址';

  @override
  String get searchUrl => '下载网址';

  @override
  String get searchUrlTooltip => '从剪贴板粘贴网址';

  @override
  String get ok => '确定 (OK)';

  @override
  String get cancel => '取消';

  @override
  String get settings => '设定';

  @override
  String get darkMode => '神色主题';

  @override
  String get ffmpegPath => 'FFMPEG路径位置';

  @override
  String get ffmpegContainer => 'FFMPEG扩展名';

  @override
  String get ffmpegDescription => '两条轨（音响+视频）合并后这是输出的格式';

  @override
  String get ffmpegNotFound => 'FFMPEG在路径没找到，还是FFMPEG不好构成的';

  @override
  String get language => '语言';

  @override
  String get downloadDir => '下载目录';

  @override
  String get selectDownloadDir => '请选择目录';

  @override
  String get invalidDir => '目录无效';

  @override
  String get credits => '应用的片尾';

  @override
  String get credits_content =>
      '图形：https://www.flaticon.com/authors/freepik\n原创作者：https://github.com/Hexer10\n改写：https://github.com/mickbad';

  @override
  String get downloads => '下载';

  @override
  String get author => '创作者';

  @override
  String get uploadDateRow => '发表';

  @override
  String get downloadCleanUpList => '整理下载目录（无删除文件）';

  @override
  String get downloadCleanUpListConfirm => '确定清理下载目录吗？';

  @override
  String get navigateToDownloadPage => '下载页面';

  @override
  String get navigateToDownloadPageConfirm => '您想导航至下载页面吗？';

  @override
  String get tracksTooltip => '敲排为下载流程，或者长按排多种流程为合并';

  @override
  String get mergeTracks => '下载和合并轨！';

  @override
  String get tracksBestMerge => '最硬视频和最硬音响';

  @override
  String get tracksAll => '都';

  @override
  String get tracksVideoAudio => '视频和音响';

  @override
  String get tracksVideo => '只下载视频';

  @override
  String get tracksAudio => '只下载音响';

  @override
  String get trackID3EditTooltip => '更新ID3标记';

  @override
  String get trackID3Tooltip => '更新MP3的信息存储';

  @override
  String get trackID3FieldTitle => '曲名';

  @override
  String get trackID3FieldArtist => '演唱者';

  @override
  String get trackID3FieldAlbum => '专辑';

  @override
  String get trackID3Action => '储存';

  @override
  String playlistParsing(Object percent) {
    return '播放列表分析处理：$percent%';
  }

  @override
  String get playlistTooltip => '敲排为选择或取消选择视频';

  @override
  String playlistTitle(Object count) {
    return '$count段要下载的视频';
  }

  @override
  String get playlistDownloadVideos => '视频和音响下载';

  @override
  String get playlistDownloadAudiosOnly => '音响下载';

  @override
  String get playlistDownloadVideosOnly => '视频下载';

  @override
  String get settingsQuotaTitle => '下载指标';

  @override
  String get settingsQuotaDescription => '允许的同期下载和变换数';

  @override
  String get settingsLeadingZeroTitle => '播放列表：文件名称的前冠';

  @override
  String get settingsLeadingZeroDescription => '为播放列表下载加文件名称前零号';

  @override
  String get permissionError => '应用为下载文件必需储存允准！';

  @override
  String startDownload(Object title) {
    return '$title的下载开始了';
  }

  @override
  String failDownload(Object title) {
    return '$title的下载失败了';
  }

  @override
  String cancelDownload(Object title) {
    return '$title的下载取消了';
  }

  @override
  String finishDownload(Object title) {
    return '$title的下载完了';
  }

  @override
  String startMerge(Object title) {
    return '$title的轨在合并';
  }

  @override
  String cancelMerge(Object title) {
    return '$title的合并取消了';
  }

  @override
  String finishMerge(Object title) {
    return '$title的合并完了';
  }

  @override
  String finishConvert(Object title) {
    return '$title的变换完了';
  }
}

/// The translations for Chinese, as used in Turks and Caicos Islands (`zh_TC`).
class AppLocalizationsZhTc extends AppLocalizationsZh {
  AppLocalizationsZhTc() : super('zh_TC');

  @override
  String get title => 'YT下載者';

  @override
  String get startSearch => '寫到視頻網址或者播放列表網址';

  @override
  String get searchUrl => '下載網址';

  @override
  String get searchUrlTooltip => '從剪貼板粘貼網址';

  @override
  String get ok => '確定 (OK)';

  @override
  String get cancel => '取消';

  @override
  String get settings => '設定';

  @override
  String get darkMode => '神色主題';

  @override
  String get ffmpegPath => 'FFMPEG路徑位置';

  @override
  String get ffmpegContainer => 'FFMPEG擴展名';

  @override
  String get ffmpegDescription => '兩條軌（音響+視頻）合并後這是輸出的格式';

  @override
  String get ffmpegNotFound => 'FFMPEG在路徑沒找到，還是FFMPEG不好構成的';

  @override
  String get language => '語言';

  @override
  String get downloadDir => '下載目錄';

  @override
  String get selectDownloadDir => '請選擇目錄';

  @override
  String get invalidDir => '目錄無效';

  @override
  String get credits => '應用的片尾';

  @override
  String get credits_content =>
      '圖形：https://www.flaticon.com/authors/freepik\n原創作者：https://github.com/Hexer10\n改寫：https://github.com/mickbad';

  @override
  String get downloads => '下載';

  @override
  String get author => '創作者';

  @override
  String get uploadDateRow => '發表';

  @override
  String get downloadCleanUpList => '整理下載目錄（無刪除文件）';

  @override
  String get downloadCleanUpListConfirm => '確定清理下載目錄嗎？';

  @override
  String get navigateToDownloadPage => '下載頁面';

  @override
  String get navigateToDownloadPageConfirm => '您想導航至下載頁面嗎？';

  @override
  String get tracksTooltip => '敲排為下載流程，或者長按排多種流程為合并';

  @override
  String get mergeTracks => '下載和合并軌！';

  @override
  String get tracksBestMerge => '最硬視頻和最硬音響';

  @override
  String get tracksAll => '都';

  @override
  String get tracksVideoAudio => '視頻和音響';

  @override
  String get tracksVideo => '只下載視頻';

  @override
  String get tracksAudio => '只下載音響';

  @override
  String get trackID3EditTooltip => '更新ID3標記';

  @override
  String get trackID3Tooltip => '更新MP3的信息存儲';

  @override
  String get trackID3FieldTitle => '曲名';

  @override
  String get trackID3FieldArtist => '演唱者';

  @override
  String get trackID3FieldAlbum => '專輯';

  @override
  String get trackID3Action => '儲存';

  @override
  String playlistParsing(Object percent) {
    return '播放列表分析處理：$percent%';
  }

  @override
  String get playlistTooltip => '敲排為選擇或取消選擇視頻';

  @override
  String playlistTitle(Object count) {
    return '$count段要下載的視頻';
  }

  @override
  String get playlistDownloadVideos => '視頻和音響下載';

  @override
  String get playlistDownloadAudiosOnly => '音響下載';

  @override
  String get playlistDownloadVideosOnly => '視頻下載';

  @override
  String get settingsQuotaTitle => '下載指標';

  @override
  String get settingsQuotaDescription => '允許的同期下載和變換數';

  @override
  String get settingsLeadingZeroTitle => '播放列表：文件名稱的前冠';

  @override
  String get settingsLeadingZeroDescription => '為播放列表下載加文件名稱前零號';

  @override
  String get permissionError => '應用為下載文件必需儲存允准！';

  @override
  String startDownload(Object title) {
    return '$title的下載開始了';
  }

  @override
  String failDownload(Object title) {
    return '$title的下載失敗了';
  }

  @override
  String cancelDownload(Object title) {
    return '$title的下載取消了';
  }

  @override
  String finishDownload(Object title) {
    return '$title的下載完了';
  }

  @override
  String startMerge(Object title) {
    return '$title的軌在合并';
  }

  @override
  String cancelMerge(Object title) {
    return '$title的合并取消了';
  }

  @override
  String finishMerge(Object title) {
    return '$title的合并完了';
  }

  @override
  String finishConvert(Object title) {
    return '$title的變換完了';
  }
}
