import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path/path.dart';
import 'package:youtube_downloader/src/models/query_video.dart';

class DownloadId3Tag extends HookConsumerWidget {
  final QueryVideo video;

  TextEditingController titleController = TextEditingController();
  TextEditingController artistController = TextEditingController();
  TextEditingController albumController = TextEditingController();

  DownloadId3Tag(this.video, {Key? key}) : super(key: key) {
    titleController.text = video.title;
    artistController.text = video.author;
    albumController.text = video.album ?? "";
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      contentPadding: const EdgeInsets.only(top: 9),
      scrollable: true,
      title: Text(
        basename(video.path!),
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
              padding: const EdgeInsets.all(10.0),
              child: Text(AppLocalizations.of(context)!.trackID3Tooltip),
            ),

            // streams
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: TextField(
                    controller: titleController,
                    onChanged: (value) => video.title = value,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: AppLocalizations.of(context)!.trackID3FieldTitle,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: TextField(
                    controller: artistController,
                    onChanged: (value) => video.author = value,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: AppLocalizations.of(context)!.trackID3FieldArtist,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: TextField(
                    controller: albumController,
                    onChanged: (value) => video.album = value,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: AppLocalizations.of(context)!.trackID3FieldAlbum,
                    ),
                  ),
                ),

              ],
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
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(20))
            ),
            onPressed: () async {
              Navigator.of(context).pop();
              if (video.path != null) {
                await video.setId3Tag(video.path!);
              }
            },
            child: Text(AppLocalizations.of(context)!.trackID3Action)),
      ],
    );
  }

}
