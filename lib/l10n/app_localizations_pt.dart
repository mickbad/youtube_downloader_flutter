// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get title => 'Youtube Downloader';

  @override
  String get startSearch => 'Inicie sua busca!';

  @override
  String get searchUrl => 'Download URL';

  @override
  String get searchUrlTooltip => 'Paste your URL from clipboard';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Cancelar';

  @override
  String get settings => 'Configurações';

  @override
  String get darkMode => 'Modo Noturno';

  @override
  String get ffmpegPath => 'FFMPEG path localisation';

  @override
  String get ffmpegContainer => 'FFMPEG container';

  @override
  String get ffmpegDescription =>
      'Este é o formato de saida quando dois arquivos (audio + video) são mesclados';

  @override
  String get ffmpegNotFound =>
      'FFMPEG não foi encontrado em PATH ou não configurado';

  @override
  String get language => 'Idioma';

  @override
  String get downloadDir => 'Local de armazenamento';

  @override
  String get selectDownloadDir => 'Selecione uma pasta para download';

  @override
  String get invalidDir => 'Local de armazenamento inválido';

  @override
  String get credits => 'Application credits';

  @override
  String get credits_content =>
      'Graphics: https://www.flaticon.com/authors/freepik\nOriginal Author: https://github.com/Hexer10\nModified: https://github.com/mickbad';

  @override
  String get downloads => 'Transferências';

  @override
  String get author => 'Autor';

  @override
  String get uploadDateRow => 'Publicada';

  @override
  String get downloadCleanUpList => 'Lista limpa (sem eliminação)';

  @override
  String get downloadCleanUpListConfirm =>
      'Quer mesmo limpar a lista de downloads?';

  @override
  String get navigateToDownloadPage => 'Página de download';

  @override
  String get navigateToDownloadPageConfirm =>
      'Quer navegar até à página de download?';

  @override
  String get tracksTooltip =>
      'Toque na linha para descarregar o fluxo ou toque longo para selecionar o fluxo a fundir';

  @override
  String get mergeTracks => 'Descarregue e mescle faixas!';

  @override
  String get tracksBestMerge => 'Melhor qualidade de vídeo + áudio';

  @override
  String get tracksAll => 'Tudo';

  @override
  String get tracksVideoAudio => 'Vídeo + Áudio';

  @override
  String get tracksVideo => 'Somente vídeo';

  @override
  String get tracksAudio => 'Somente áudio';

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
      'O applicativo precisa ter acesso ao seu armazenamento para realizar seus downloads!';

  @override
  String startDownload(Object title) {
    return 'Iniciando download: $title';
  }

  @override
  String failDownload(Object title) {
    return 'Ocorreu um erro em: $title';
  }

  @override
  String cancelDownload(Object title) {
    return 'Download cancelado: $title';
  }

  @override
  String finishDownload(Object title) {
    return 'Download finalizado: $title';
  }

  @override
  String startMerge(Object title) {
    return 'Mesclando arquivos de: $title';
  }

  @override
  String cancelMerge(Object title) {
    return 'Junção cancelada: $title';
  }

  @override
  String finishMerge(Object title) {
    return 'Finalizado a junção de: $title';
  }

  @override
  String finishConvert(Object title) {
    return 'Convertion finished : $title';
  }
}
