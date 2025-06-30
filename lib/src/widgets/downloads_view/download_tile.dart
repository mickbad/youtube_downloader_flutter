import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as path;
import 'package:youtube_downloader/src/models/download_manager.dart';
import 'package:youtube_downloader/src/models/query_video.dart';
import 'package:youtube_downloader/src/providers.dart';
import 'package:youtube_downloader/src/widgets/downloads_view/download_id3tag.dart';

import '../../../l10n/app_localizations.dart';

class DownloadTile extends HookWidget {
  final SingleTrack video;

  const DownloadTile(this.video, {Key? key}) : super(key: key);

  String? getFileType(SingleTrack video) {
    final path = video.path;
    switch (video.streamType) {
      case StreamType.audio:
        {
          if (path.endsWith('.mp4') || path.endsWith('.mp3')) {
            return 'audio/mpeg';
          } else if (path.endsWith('.webm')) {
            return 'audio/webm';
          }
          return null;
        }
      case StreamType.video:
        {
          if (path.endsWith('.mp4')) {
            return 'video/mpeg';
          } else if (path.endsWith('.webm')) {
            return 'video/webm';
          } else if (path.endsWith('.mkv')) {
            return 'video/x-matroska';
          }
          return null;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    final video = useListenable(this.video);

    // check if path is valid
    final bValidPath = File(video.path).existsSync();
    return ListTile(
        onTap:
            video.downloadStatus == DownloadStatus.success && bValidPath ? _openFile : null,
        title: Text(video.title,
            style: video.downloadStatus == DownloadStatus.canceled ||
                    video.downloadStatus == DownloadStatus.failed ||
                    (!bValidPath && video.downloadStatus != DownloadStatus.downloading)
                ? TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey.withOpacity(0.7)
                  )
                : null),
        subtitle: video.downloadStatus == DownloadStatus.failed
            ? Text(video.error)
            : Text(video.path,
                style: video.downloadStatus == DownloadStatus.canceled ||
                        video.downloadStatus == DownloadStatus.failed ||
                        (!bValidPath && video.downloadStatus != DownloadStatus.downloading)
                    ? TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey.withOpacity(0.7))
                    : null),
        trailing: TrailingIcon(video),
        leading: LeadingIcon(video));
  }

  Future<void> _openFile() async {
    await OpenFile.open(video.path, type: getFileType(video));
  }
}

class LeadingIcon extends HookWidget {
  final SingleTrack video;

  const LeadingIcon(this.video, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (video.downloadStatus) {
      case DownloadStatus.downloading:
        return Text('${video.downloadPerc}%');
      case DownloadStatus.success:
        final bValidPath = File(video.path).existsSync();
        if (!bValidPath) {
          return Icon(Icons.close, color: Colors.grey.withOpacity(0.7),);
        }
        return const Icon(Icons.done);
      case DownloadStatus.failed:
        return const Icon(Icons.error);
      case DownloadStatus.muxing:
        return video.downloadPerc == 100
            ? const CircularProgressIndicator()
            : Text('${video.downloadPerc}%', style: const TextStyle(color: Colors.orange),);
      case DownloadStatus.canceled:
        return const Icon(Icons.cancel);
    }
  }
}

class TrailingIcon extends HookConsumerWidget {
  final SingleTrack video;

  const TrailingIcon(this.video, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final downloadManager = ref.watch(downloadProvider.state);
    final bValidPath = File(video.path).existsSync();
    if (!bValidPath) {
      return IconButton(
          icon: const Icon(Icons.delete_forever),
          onPressed: () async {
            downloadManager.state.removeVideo(video);
          });
    }

    switch (video.downloadStatus) {
      case DownloadStatus.downloading:
        return IconButton(
            icon: const Icon(Icons.cancel),
            onPressed: () async {
              video.cancelDownload();
            });
      case DownloadStatus.success:
          // change id3tag for mp3
          Widget id3tagChange = Container();
          if (video.streamType == StreamType.audio && video.path.toLowerCase().endsWith('.mp3')) {
            id3tagChange =  IconButton(
              icon: const Icon(Icons.edit),
              tooltip: AppLocalizations.of(context)!.trackID3EditTooltip,
              onPressed: () async {
                // get id3tag
                QueryVideo? myvideo = await QueryVideo.getId3Tag(video.path);
                if (myvideo != null) {
                  showDialog(context: context, builder: (context) => DownloadId3Tag(myvideo));
                }
              });
          }

          return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            id3tagChange,
            IconButton(
                icon: const Icon(Icons.folder_open),
                onPressed: () async {
                  final res = await OpenFile.open(path.dirname(video.path));
                  debugPrint('R: ${res.type} | M: ${res.message}');
                }),
            IconButton(
                icon: const Icon(Icons.delete_forever, color: Color.fromRGBO(250, 0, 0, 0.6),),
                onPressed: () async {
                  downloadManager.state.removeVideo(video);
                }),
          ],
        );
      case DownloadStatus.muxing:
        return IconButton(
            icon: const Icon(Icons.cancel),
            onPressed: () async {
              video.cancelDownload();
            });
      case DownloadStatus.failed:
      case DownloadStatus.canceled:
        return IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () async {
              downloadManager.state.removeVideo(video);
            });
    }
  }
}
