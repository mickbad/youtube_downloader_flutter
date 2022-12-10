import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:youtube_downloader/src/models/download_manager.dart';
import 'package:youtube_downloader/src/models/query_video.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../../providers.dart';
import '../../shared.dart';

class StreamsList extends HookConsumerWidget {
  final QueryVideo video;

  StreamsList(this.video, {Key? key}) : super(key: key);

  final mergeTracks = StreamMerge();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final yt = ref.watch(ytProvider);
    final settings = ref.watch(settingsProvider.state);
    final downloadManager = ref.watch(downloadProvider.state);

    final filter = useState(Filter.all);
    final merger = useListenable(mergeTracks);

    final manifest = useMemoFuture(
        () => yt.videos.streamsClient.getManifest(video.id),
        initialData: null,
        keys: [video.id]);

    if (!manifest.hasData) {
      return const Center(child: CircularProgressIndicator());
    }

    final filteredList = filterStream(manifest.data!, filter.value);

    // search best video
    List<Widget> filteredListWidget = [];
    var streamBestVideo = null;
    var streamBestAudio = null;

    // list of stream widget
    for(var stream in filteredList) {
      Widget widgetStream = ListTile(
          title: Text('${stream.container} ${stream.runtimeType}'));

      if (stream is MuxedStreamInfo) {
        widgetStream = MaterialButton(
          onPressed: () {
            downloadManager.state.downloadStream(yt, video, settings.state,
                StreamType.video, AppLocalizations.of(context)!,
                singleStream: stream);
          },
          child: ListTile(
            subtitle: Text(
                '${stream.qualityLabel} - ${stream.videoCodec} | ${stream.audioCodec}'),
            title: Text(
                '${AppLocalizations.of(context)!.tracksVideoAudio} (.${stream.container}) - ${bytesToString(stream.size.totalBytes)}'),
          ),
        );
      }
      if (stream is VideoOnlyStreamInfo) {
        // search best format
        streamBestVideo ??= stream; // first is best
        if (/*stream.videoCodec == "mp4" && */stream.size.totalBytes > streamBestVideo.size.totalBytes) {
          // set new one
          streamBestVideo = stream;
        }

        widgetStream = MaterialButton(
          onLongPress: () {
            merger.video = stream;
          },
          onPressed: () {
            downloadManager.state.downloadStream(yt, video, settings.state,
                StreamType.video, AppLocalizations.of(context)!,
                singleStream: stream);
          },
          child: ListTile(
            subtitle: Text(
                '${stream.qualityLabel} - ${stream.videoCodec}'),
            title: Text(
                '${AppLocalizations.of(context)!.tracksVideo} (.${stream.container}) - ${bytesToString(stream.size.totalBytes)}'),
            trailing:
            stream == merger.video ? const Icon(Icons.done) : null,
          ),
        );
      }
      if (stream is AudioOnlyStreamInfo) {
        // search best format
        streamBestAudio ??= stream; // first is best
        if (stream.size.totalBytes > streamBestAudio.size.totalBytes) {
          // set new one
          streamBestAudio = stream;
        }
        widgetStream = MaterialButton(
          onLongPress: () {
            merger.audio = stream;
          },
          onPressed: () {
            downloadManager.state.downloadStream(yt, video, settings.state,
                StreamType.audio, AppLocalizations.of(context)!,
                singleStream: stream);
          },
          child: ListTile(
            subtitle: Text(
                '${stream.audioCodec} | Bitrate: ${stream.bitrate}'),
            title: Text(
                '${AppLocalizations.of(context)!.tracksAudio} (.${stream.container}) - ${bytesToString(stream.size.totalBytes)}'),
            trailing:
            stream == merger.audio ? const Icon(Icons.done) : null,
          ),
        );
      }

      // add widget
      filteredListWidget.add(widgetStream);
    }

    // add best stream merge
    if (streamBestVideo != null && streamBestAudio != null) {
      filteredListWidget.insert(0,
          MaterialButton(
            onPressed: () {
              merger.video = streamBestVideo;
              merger.audio = streamBestAudio;
            },
            child: ListTile(
              subtitle: Text(
                  'video: ${streamBestVideo.qualityLabel} - ${streamBestVideo.videoCodec} | audio: ${streamBestAudio.audioCodec}\nvideo ouput in ${settings.state.ffmpegContainer} format'),
              title: Text(
                  '${AppLocalizations.of(context)!.tracksBestMerge} (.${streamBestVideo.container})'),
            ),
          )
      );
    }

    // picture height
    double pictureHeight = 100;
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      pictureHeight = 200;
    }

    return AlertDialog(
      contentPadding: const EdgeInsets.only(top: 9),
      title: Text(
        video.title,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        softWrap: false,
      ),
      content: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Column(
          children: [
            // preview
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: GestureDetector(
                      onTap: () async {
                        if (!await launchUrlString("https://youtu.be/${video.id}")) {
                          // throw 'Could not launch $_url';
                          // oops nothing
                        }
                      },
                      child: Image.network(video.thumbnail, height: pictureHeight, fit: BoxFit.fitWidth,)
                  ),
                ),

                Positioned(
                    right: 9,
                    bottom: 9,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(.75),
                          borderRadius: BorderRadius.circular(4)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 3, vertical: 1),
                      child: Text(
                        _formatDuration(video.duration),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(
                            fontSize: 11, color: Colors.white),
                      ),
                    )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(AppLocalizations.of(context)!.tracksTooltip),
            ),

            // streams
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
                itemCount: filteredListWidget.length,
                itemBuilder: (context, index) {
                  return filteredListWidget[index];
                }),
            ),
          ],
        ),
      ),

      // close dialog icon
      iconPadding: EdgeInsets.zero,
      iconColor: Colors.red,
      icon: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),

      // actions
      actionsAlignment: MainAxisAlignment.end,
      actions: <Widget>[
        if (merger.audio != null && merger.video != null)
          OutlinedButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(20))),
              onPressed: () {
                downloadManager.state.downloadStream(yt, video, settings.state,
                    StreamType.video, AppLocalizations.of(context)!,
                    merger: merger, ffmpegContainer: settings.state.ffmpegContainer);
              },
              child: Text(AppLocalizations.of(context)!.mergeTracks)),
        DropdownButton<Filter>(
          value: filter.value,
          items: [
            DropdownMenuItem(
              value: Filter.all,
              child: Text(AppLocalizations.of(context)!.tracksAll),
            ),
            DropdownMenuItem(
              value: Filter.videoAudio,
              child: Text(AppLocalizations.of(context)!.tracksVideoAudio),
            ),
            DropdownMenuItem(
              value: Filter.video,
              child: Text(AppLocalizations.of(context)!.tracksVideo),
            ),
            DropdownMenuItem(
              value: Filter.audio,
              child: Text(AppLocalizations.of(context)!.tracksAudio),
            ),
          ],
          onChanged: (newFilter) {
            filter.value = newFilter!;
          },
        ),
      ],
    );
  }

  List<StreamInfo> filterStream(StreamManifest manifest, Filter filter) {
    switch (filter) {
      case Filter.all:
        return manifest.streams.toList(growable: false);
      case Filter.videoAudio:
        return manifest.muxed.toList(growable: false);
      case Filter.audio:
        return manifest.audioOnly.toList(growable: false);
      case Filter.video:
        return manifest.videoOnly.toList(growable: false);
    }
  }
}

enum Filter {
  all,
  videoAudio,
  audio,
  video,
}

String _formatDuration(Duration d) {
  final totalSecs = d.inSeconds;
  final hours = totalSecs ~/ 3600;
  final minutes = (totalSecs % 3600) ~/ 60;
  final seconds = totalSecs % 60;
  final buffer = StringBuffer();

  if (hours > 0) {
    buffer.write('$hours:');
  }
  buffer.write('${minutes.toString().padLeft(2, '0')}:');
  buffer.write(seconds.toString().padLeft(2, '0'));
  return buffer.toString();
}
