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

class PlaylistsList extends StatefulHookConsumerWidget {
  final QueryListVideos playlist;

  PlaylistsList(this.playlist, {Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState()  => _PlaylistsLists();
}

class _PlaylistsLists extends ConsumerState<PlaylistsList> {
  @override
  Widget build(BuildContext context) {
    // list stream titles
    List<Widget> filteredListWidget = [];

    // var
    final yt = ref.watch(ytProvider);
    final settings = ref.watch(settingsProvider.state);
    final downloadManager = ref.watch(downloadProvider.state);

    // list of stream widget
    for(var stream in widget.playlist.items) {
      // image leading
      Widget image = Image.network(stream.queryVideo.thumbnail, height: 60, fit: BoxFit.fitWidth,);
      if (!stream.enable) {
        image = ColorFiltered(
          colorFilter: const ColorFilter.mode(
            Colors.black87,
            BlendMode.multiply,
          ),
          child:Image.network(stream.queryVideo.thumbnail, height: 60, fit: BoxFit.fitWidth,),
        );
      }

      // tile for stream video
      Widget widgetStream = MaterialButton(
        onPressed: () {
          // change download status
          setState(() => widget.playlist.enableVideo(stream.id, !stream.enable));
        },
        child: ListTile(
          subtitle: Text(
            '${stream.queryVideo.author} - ${stream.queryVideo.duration}',
            style: stream.enable ? null : const TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey),
          ),
          title: Text(
            stream.queryVideo.title,
            style: stream.enable ? null : const TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey),
          ),
          leading: image,
          trailing: (stream.enable) ? const Icon(Icons.done) : const Icon(Icons.close, color: Colors.grey,),
        ),
      );

      // add widget
      filteredListWidget.add(widgetStream);
    }

    return AlertDialog(
      contentPadding: const EdgeInsets.only(top: 9),
      title: Text(
        widget.playlist.title,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        softWrap: false,
      ),
      content: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(AppLocalizations.of(context)!.playlistTitle(widget.playlist.videoEnableCount), style: const TextStyle(fontSize: 20),),
            ),

            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(AppLocalizations.of(context)!.playlistTooltip, style: const TextStyle(fontSize: 13),),
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
        OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: (widget.playlist.videoEnableCount < 1) ? Colors.grey : Colors.blueAccent,
              padding: const EdgeInsets.all(10),
            ),
            onPressed: () async {
              // check
              if (widget.playlist.videoEnableCount < 1) {
                return;
              }

              // close window
              Navigator.of(context).pop();

              // start download
              await widget.playlist.download(downloadManager.state, yt, settings.state, AppLocalizations.of(context)!, QueryListDownload.merge);
            },
            child: Text(AppLocalizations.of(context)!.playlistDownloadVideos)
        ),

        OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: (widget.playlist.videoEnableCount < 1) ? Colors.grey : Colors.orange,
              padding: const EdgeInsets.all(10),
            ),
            onPressed: () async {
              // check
              if (widget.playlist.videoEnableCount < 1) {
                return;
              }

              // close window
              Navigator.of(context).pop();

              // start download
              await widget.playlist.download(downloadManager.state, yt, settings.state, AppLocalizations.of(context)!, QueryListDownload.audio);
            },
            child: Text(AppLocalizations.of(context)!.playlistDownloadAudiosOnly)
        ),

        OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: (widget.playlist.videoEnableCount < 1) ? Colors.grey : Colors.orange,
              padding: const EdgeInsets.all(10),
            ),
            onPressed: () async {
              // check
              if (widget.playlist.videoEnableCount < 1) {
                return;
              }

              // close window
              Navigator.of(context).pop();

              // start download
              await widget.playlist.download(downloadManager.state, yt, settings.state, AppLocalizations.of(context)!, QueryListDownload.video);
            },
            child: Text(AppLocalizations.of(context)!.playlistDownloadVideosOnly)
        ),

      ],
    );
  }

}
