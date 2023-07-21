///
/// Fonctions utiles
///

///
/// Convertion d'une url en url youtube
///
/// https://www.youtube.com/shorts/XXXXX -> https://www.youtube.com/watch?v=XXXXX
///
String? convertYoutubeUrl(String url) {
  if (url.isEmpty || (!url.toLowerCase().startsWith("https://youtube.com") && !url.toLowerCase().startsWith("https://www.youtube.com") && !url.toLowerCase().startsWith("https://youtu.be"))) {
    return null;
  }

  // replace url
  if (url.indexOf('?') > 0 && url.indexOf('v=') < 1) {
    url = url.substring(0, url.indexOf('?'));
  }
  url = url.replaceAll("https://youtu.be/", "https://www.youtube.com/watch?v=");
  url = url.replaceAll("https://www.youtube.com/shorts/", "https://www.youtube.com/watch?v=");
  url = url.replaceAll("https://youtube.com/shorts/", "https://www.youtube.com/watch?v=");
  return url;
}