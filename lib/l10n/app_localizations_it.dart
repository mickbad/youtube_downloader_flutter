// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get title => 'Youtube Downloader';

  @override
  String get startSearch => 'Inserisci l\'URL di un video o di una playlist';

  @override
  String get searchUrl => 'Download l\'URL';

  @override
  String get searchUrlTooltip => 'Incolla la tua URL dal appunti';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Annulla';

  @override
  String get settings => 'Impostazioni';

  @override
  String get darkMode => 'Modalità scura';

  @override
  String get ffmpegPath => 'Percorso del FFMPEG';

  @override
  String get ffmpegContainer => 'FFMPEG estenzione';

  @override
  String get ffmpegDescription =>
      'Il format di output quando due tracce (audio + video) vengono unite';

  @override
  String get ffmpegNotFound => 'FFMPEG non trovato in PATH o non configurato';

  @override
  String get language => 'Lingua';

  @override
  String get downloadDir => 'Cartella Download';

  @override
  String get selectDownloadDir => 'Selezione la cartella per i download';

  @override
  String get invalidDir => 'Cartella non valida';

  @override
  String get credits => 'Crediti dell\'app';

  @override
  String get credits_content =>
      'Graphica: https://www.flaticon.com/authors/freepik\nAutore originale: https://github.com/Hexer10\nA cura di: https://github.com/mickbad';

  @override
  String get downloads => 'Downloads';

  @override
  String get author => 'Autore';

  @override
  String get uploadDateRow => 'Pubblicato';

  @override
  String get downloadCleanUpList =>
      'Lista delle download pulita (nessuna cancellamento)';

  @override
  String get downloadCleanUpListConfirm =>
      'Cancellare la lista delle download?';

  @override
  String get navigateToDownloadPage => 'Scarica la pagina';

  @override
  String get navigateToDownloadPageConfirm =>
      'Vuoi andare alla pagina di download?';

  @override
  String get tracksTooltip =>
      'Tocca sulla linea per download il stream, o premere a lungo per selezionare più stream';

  @override
  String get mergeTracks => 'Download i Unire le tracce!';

  @override
  String get tracksBestMerge => 'Il migliore video + qualità dell\'audio';

  @override
  String get tracksAll => 'Tutto';

  @override
  String get tracksVideoAudio => 'Video + Audio';

  @override
  String get tracksVideo => 'Solo il video';

  @override
  String get tracksAudio => 'Solo il audio';

  @override
  String get trackID3EditTooltip => 'Aggiorna le tag ID3';

  @override
  String get trackID3Tooltip => 'Cambia le informazioni dell\'MP3';

  @override
  String get trackID3FieldTitle => 'Titolo';

  @override
  String get trackID3FieldArtist => 'Autore';

  @override
  String get trackID3FieldAlbum => 'Album';

  @override
  String get trackID3Action => 'Salva';

  @override
  String playlistParsing(Object percent) {
    return 'Riproducendo la playlist: $percent %';
  }

  @override
  String get playlistTooltip =>
      'Tocca sulla linea per selezionare o deselezionare un titolo della lista';

  @override
  String playlistTitle(Object count) {
    return 'Lista dei $count video da download';
  }

  @override
  String get playlistDownloadVideos => 'Download i video + audio';

  @override
  String get playlistDownloadAudiosOnly => 'Download i audio';

  @override
  String get playlistDownloadVideosOnly => 'Download i video';

  @override
  String get settingsQuotaTitle => 'Quota di download';

  @override
  String get settingsQuotaDescription =>
      'Numero di download i converzione simultanee';

  @override
  String get settingsLeadingZeroTitle => 'Playlist: prefisso sul nome del file';

  @override
  String get settingsLeadingZeroDescription =>
      ' Aggiunto lo zero iniziale al nome del file per i download delle playlist';

  @override
  String get permissionError =>
      'L\'app necessità del permesso di storage per scaricare i contenuti!';

  @override
  String startDownload(Object title) {
    return 'Inizio download: $title';
  }

  @override
  String failDownload(Object title) {
    return 'Download fallito: $title';
  }

  @override
  String cancelDownload(Object title) {
    return 'Download cancellato: $title';
  }

  @override
  String finishDownload(Object title) {
    return 'Download completato: $title';
  }

  @override
  String startMerge(Object title) {
    return 'Unificando le traccie: $title';
  }

  @override
  String cancelMerge(Object title) {
    return 'Unificazione cancellata: $title';
  }

  @override
  String finishMerge(Object title) {
    return 'Video completo: $title';
  }

  @override
  String finishConvert(Object title) {
    return 'Converzione finito: $title';
  }
}
