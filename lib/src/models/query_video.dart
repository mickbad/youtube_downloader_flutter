import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:id3_codec/encode_metadata.dart';
import 'package:id3_codec/id3_encoder.dart';
import 'package:id3tag/id3tag.dart';

class QueryVideo {
  String title;
  final String id;
  String author;
  final Duration duration;
  final String thumbnail;
  final DateTime? uploadDate;
  final String? uploadDateRaw;

  String? album;
  final String? path;
  final List<int>? thumbnailBytes;

  QueryVideo(this.title, this.id, this.author, this.duration, this.thumbnail, this.uploadDate, this.uploadDateRaw, {this.album, this.path, this.thumbnailBytes});

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
