import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:id3_codec/encode_metadata.dart';
import 'package:id3_codec/id3_encoder.dart';

class QueryVideo {
  final String title;
  final String id;
  final String author;
  final Duration duration;
  final String thumbnail;
  final DateTime? uploadDate;
  final String? uploadDateRaw;

  const QueryVideo(this.title, this.id, this.author, this.duration, this.thumbnail, this.uploadDate, this.uploadDateRaw);

  Future<void> setId3Tag(String fileAudio) async {
    // set id3tag for new mp3 file
    if (fileAudio.toLowerCase().endsWith(".mp3")) {
      // only for MP3
      final File file = File(fileAudio);
      final bytes = await file.readAsBytes();

      // thundnail mp3
      http.Response response = await http.get(Uri.parse(thumbnail));
      final headerBytes = response.bodyBytes;

      final al = {"comment":"Youtube Downloader Hexer10/Mick"};

      final encoder = ID3Encoder(bytes);
      final List<int> output = encoder.encodeSync(MetadataV2_4Body(
        title: title,
        imageBytes: headerBytes,
        artist: author,
        userDefines: {
          "comment": al.toString()
        },
      ));

      await File(fileAudio).writeAsBytes(output);
    }
  }
}
