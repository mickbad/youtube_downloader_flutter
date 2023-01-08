import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:id3_codec/encode_metadata.dart';
import 'package:id3_codec/id3_encoder.dart';
import 'package:id3tag/id3tag.dart';
import 'package:youtube_downloader/src/models/settings.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'download_manager.dart';


///
/// QueryVideo: struct for current video download
///
class QueryVideo {
  String title;
  final String id;
  String author;
  final Duration duration;
  final String thumbnail;
  final DateTime? uploadDate;
  final String? uploadDateRaw;

  String? album;
  int? track;
  final String? path;
  final List<int>? thumbnailBytes;
  String prefixName;

  QueryVideo(this.title, this.id, this.author, this.duration, this.thumbnail, this.uploadDate, this.uploadDateRaw, {this.album, this.track, this.path, this.thumbnailBytes, this.prefixName = ""});

  @override
  String toString() {
    return "[$id] $author - $title: ${duration.toString()}";
  }

  static Future<QueryVideo?> getId3Tag(String fileAudio) async {
    if (!fileAudio.toLowerCase().endsWith(".mp3")) {
      return null;
    }

    // only for MP3
    final parser = ID3TagReader.path(fileAudio);
    final ID3Tag tag = await parser.readTag();

    // thumbnail
    String thumbnail = "";
    List<int>? thumbnailBytes;
    if (tag.pictures.isNotEmpty) {
      // TODO: bug when get imageData twice, bytes are not completed, missing some informations!
      thumbnailBytes = tag.pictures[0].imageData;
    }

    return QueryVideo(
      tag.title ?? "",
      "29",
      tag.artist ?? "",
      tag.duration ?? const Duration(seconds: 0),
      thumbnail,
      null,
      null,
      album: tag.album,
      path: fileAudio,
      thumbnailBytes: thumbnailBytes,
    );
  }

  Future<void> setId3Tag(String fileAudio) async {
    // set id3tag for new mp3 file
    if (!fileAudio.toLowerCase().endsWith(".mp3")) {
      return;
    }

    // only for MP3
    final File file = File(fileAudio);
    final bytes = await file.readAsBytes();

    // thundnail mp3
    List<int>? headerBytes;
    if (thumbnail.isNotEmpty) {
      http.Response response = await http.get(Uri.parse(thumbnail));
      headerBytes = response.bodyBytes;
    }

    final al = {"comment":"Youtube Downloader Hexer10/Mick"};

    final encoder = ID3Encoder(bytes);
    final List<int> output = encoder.encodeSync(MetadataV2_4Body(
      title: title,
      imageBytes: headerBytes,
      artist: author,
      album: album,
      userDefines: {
        "comment": al.toString()
      },
    ));

    await File(fileAudio).writeAsBytes(output);
  }
}

///
/// QueryListVideos: struct for stock all queryvideo from a list
///
/// sample: https://www.youtube.com/watch?v=x81hFfubG5I&list=PLpllqzgq8wPYK_L_LH6GqiwVW66iXnmVt
///
class QueryListVideos {
  late String title;
  late String author;
  late String id;
  final String url;
  late List<QueryListVideoItem> items;

  QueryListVideos({required this.url}) {
    items = [];
  }

  ///
  /// Properties
  ///
  int get videoCount => items.length;
  int get videoEnableCount => items.where((element) => element.enable).length;
  bool get isEmpty => items.isEmpty;
  bool get isNotEmpty => items.isNotEmpty;
  Iterable<QueryListVideoItem> get videosEnableList => items.where((element) => element.enable) ?? [];

  ///
  /// toString()
  ///
  @override
  String toString() {
    String ret = "[$id] $author - $title: $videoCount videos";
    for(QueryListVideoItem item in items) {
      ret += "\n${item.toString()}";
    }
    return ret;
  }

  ///
  /// parse: get all videos from current list
  ///
  Stream<double> parse() async* {
    // return progress
    yield 0.0;

    // Get playlist metadata.
    final YoutubeExplode yt = YoutubeExplode();
    var playlist = await yt.playlists.get(url);

    // check if list is empty
    int videoCount = playlist.videoCount ?? 0;
    if (videoCount < 1) {
      yield 100.0;
    }

    // properties
    id = playlist.id.value;
    title = playlist.title;
    author = playlist.author;

    // get all videos
    int currentVideoCount = 1;
    await for (var video in yt.playlists.getVideos(playlist.id)) {
      // get streams list
      StreamManifest manifest = await yt.videos.streamsClient.getManifest(video.id);
      List<StreamInfo> filterStream = manifest.streams.toList(growable: false);

      // choose best values
      VideoOnlyStreamInfo? streamBestVideo;
      AudioOnlyStreamInfo? streamBestAudio;

      // parsing list of stream widget to get best format
      for(var stream in filterStream) {
        // check video stream
        if (stream is VideoOnlyStreamInfo) {
          // search best format
          streamBestVideo ??= stream; // first is best
          if (/*stream.videoCodec == "mp4" && */stream.size.totalBytes > streamBestVideo.size.totalBytes) {
            // set new one
            streamBestVideo = stream;
          }
        }

        // check audio stream
        if (stream is AudioOnlyStreamInfo) {
          // search best format
          streamBestAudio ??= stream; // first is best
          if (stream.size.totalBytes > streamBestAudio.size.totalBytes) {
            // set new one
            streamBestAudio = stream;
          }
        }
      }

      // check if we have informations
      if (streamBestVideo == null || streamBestAudio == null) {
        // not valid stream video
        continue;
      }

      // get more informations
      final videoYT = await yt.videos.get(video.url);
      final QueryVideo queryVideo = QueryVideo(
          videoYT.title,
          videoYT.id.toString(),
          videoYT.author,
          videoYT.duration!,
          videoYT.thumbnails.highResUrl,
          videoYT.uploadDate,
          videoYT.uploadDateRaw,
          album: title,
      );

      // add current stream to Video list download
      QueryListVideoItem item = QueryListVideoItem(url: video.url, queryVideo: queryVideo, streamBestAudio: streamBestAudio, streamBestVideo: streamBestVideo);
      items.add(item);

      // show progress
      yield double.parse((currentVideoCount * 100.0 / videoCount).toStringAsFixed(1));
      currentVideoCount ++;
    }

    // return if videos found
    yield 100.0;
  }

  ///
  /// Enable/disable video stream in playlist
  ///
  bool enableVideo(String id, bool enable) {
    for(QueryListVideoItem item in items.where((element) => element.id == id)) {
      item.enable = enable;
    }
    return enable;
  }

  ///
  /// download playlist
  ///
  Future<void> download(DownloadManager downloadManager, YoutubeExplode yt, Settings settings, AppLocalizations localizations, QueryListDownload type) async {
    // parse each stream enable to download
    int currentStreamNumber = 0;
    int maxLeadingPrefix = videoEnableCount.toString().length;
    for(QueryListVideoItem stream in videosEnableList) {
      // increment
      currentStreamNumber ++;

      // set prefix name
      if (settings.isLeadingZeroPlaylist) {
        stream.queryVideo.prefixName = currentStreamNumber.toString().padLeft(maxLeadingPrefix, '0') + " - ";
      }

      // add track number in video (for mp3 extraction?)
      stream.queryVideo.track = currentStreamNumber;

      // download stream
      switch(type) {
        case QueryListDownload.merge:
          // download video+audio
          final mergeTracks = StreamMerge();
          mergeTracks.video = stream.streamBestVideo;
          mergeTracks.audio = stream.streamBestAudio;
          await downloadManager.downloadStream(yt, stream.queryVideo, settings,
              StreamType.video, localizations,
              merger: mergeTracks, ffmpegContainer: settings.ffmpegContainer);
          break;

        case QueryListDownload.audio:
          // download audio only
          await downloadManager.downloadStream(yt, stream.queryVideo, settings,
              StreamType.audio, localizations,
              singleStream: stream.streamBestAudio);
          break;

        case QueryListDownload.video:
          // download video only
          await downloadManager.downloadStream(yt, stream.queryVideo, settings,
              StreamType.video, localizations,
              singleStream: stream.streamBestVideo);
          break;
      }
    }
  }
}

///
/// Enum for download type
///
enum QueryListDownload {
  audio,
  video,
  merge,
}

///
/// QueryListVideoItem: stock video item information
///
class QueryListVideoItem {
  bool enable = true;
  late String id;
  final String url;
  final QueryVideo queryVideo;
  final VideoOnlyStreamInfo streamBestVideo;
  final AudioOnlyStreamInfo streamBestAudio;

  QueryListVideoItem({required this.url, required this.queryVideo, required this.streamBestAudio, required this.streamBestVideo}) {
    // repeat id to quickly access
    id = queryVideo.id;
  }

  @override
  String toString() {
    return "${queryVideo.toString()} - $url";
  }
}
