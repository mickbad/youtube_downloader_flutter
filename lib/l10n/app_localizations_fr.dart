// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get title => 'Youtube Downloader';

  @override
  String get startSearch => 'Saisissez une URL d\'une vidéo ou d\'une playlist';

  @override
  String get searchUrl => 'Télécharger l\'URL';

  @override
  String get searchUrlTooltip => 'Coller votre url depuis le presse papier';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Annuler';

  @override
  String get settings => 'Paramètres';

  @override
  String get darkMode => 'Mode nuit';

  @override
  String get ffmpegPath => 'Chemin d\'accès à FFMPEG';

  @override
  String get ffmpegContainer => 'FFMPEG extension';

  @override
  String get ffmpegDescription =>
      'Format de sortie pour fusionner deux pistes (audio + video)';

  @override
  String get ffmpegNotFound =>
      'FFMPEG introuvable dans le PATH ou non configuré';

  @override
  String get language => 'Langage';

  @override
  String get downloadDir => 'Dossier de téléchargement';

  @override
  String get selectDownloadDir => 'Sélectionnez un dossier de téléchargement';

  @override
  String get invalidDir => 'Dossier invalide';

  @override
  String get credits => 'Crédits de l\'application';

  @override
  String get credits_content =>
      'Graphiques : https://www.flaticon.com/authors/freepik\nAuteur original : https://github.com/Hexer10\nModifications : https://github.com/mickbad';

  @override
  String get downloads => 'Téléchargements';

  @override
  String get author => 'Auteur';

  @override
  String get uploadDateRow => 'Publication';

  @override
  String get downloadCleanUpList => 'Nettoyer la liste (aucune suppression)';

  @override
  String get downloadCleanUpListConfirm =>
      'Voulez-vous vraiment nettoyer la liste de téléchargements ?';

  @override
  String get navigateToDownloadPage => 'Page des téléchargements';

  @override
  String get navigateToDownloadPageConfirm =>
      'Voulez-vous naviguer vers la page des téléchargements ?';

  @override
  String get tracksTooltip =>
      'Tapez sur une ligne pour télécharger ou un appui long pour sélectionner la fusion';

  @override
  String get mergeTracks => 'Télécharger et fusionner les pistes !';

  @override
  String get tracksBestMerge => 'Meilleure qualité vidéo et audio';

  @override
  String get tracksAll => 'Tout';

  @override
  String get tracksVideoAudio => 'Vidéo et Audio';

  @override
  String get tracksVideo => 'Vidéo seulement';

  @override
  String get tracksAudio => 'Audio seulement';

  @override
  String get trackID3EditTooltip => 'Mettre à jour les tags ID3';

  @override
  String get trackID3Tooltip => 'Modifiez les informations du mp3';

  @override
  String get trackID3FieldTitle => 'Titre';

  @override
  String get trackID3FieldArtist => 'Auteur';

  @override
  String get trackID3FieldAlbum => 'Album';

  @override
  String get trackID3Action => 'Appliquez';

  @override
  String playlistParsing(Object percent) {
    return 'Lecture de la playlist : $percent %';
  }

  @override
  String get playlistTooltip =>
      'Tapez sur la ligne pour sélectionner ou déselectionner un titre de la liste';

  @override
  String playlistTitle(Object count) {
    return 'Liste des $count vidéos ou audios à télécharger';
  }

  @override
  String get playlistDownloadVideos => 'Télécharger les vidéos + audios';

  @override
  String get playlistDownloadAudiosOnly => 'Télécharger les audios';

  @override
  String get playlistDownloadVideosOnly => 'Télécharger les vidéos';

  @override
  String get settingsQuotaTitle => 'Quota de téléchargement';

  @override
  String get settingsQuotaDescription =>
      'Nombre de téléchargements et de conversions simultanés';

  @override
  String get settingsLeadingZeroTitle => 'Playlist : préfixe du nom du fichier';

  @override
  String get settingsLeadingZeroDescription =>
      'Ajout de zéro en tête de nom du fichier pour les téléchargements de playlist';

  @override
  String get permissionError =>
      'L\'application a besoin des permissions de stockage pour télécharger les fichiers !';

  @override
  String startDownload(Object title) {
    return 'Démarrage du téléchargement : $title';
  }

  @override
  String failDownload(Object title) {
    return 'Echec de téléchargement : $title';
  }

  @override
  String cancelDownload(Object title) {
    return 'Téléchargement annulé : $title';
  }

  @override
  String finishDownload(Object title) {
    return 'Téléchargement terminé: $title';
  }

  @override
  String startMerge(Object title) {
    return 'Fusion des pistes de : $title';
  }

  @override
  String cancelMerge(Object title) {
    return 'Annulation de la fusion de : $title';
  }

  @override
  String finishMerge(Object title) {
    return 'Fusion terminée : $title';
  }

  @override
  String finishConvert(Object title) {
    return 'Convertion terminée : $title';
  }
}
