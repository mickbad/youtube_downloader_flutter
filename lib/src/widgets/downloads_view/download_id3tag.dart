import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path/path.dart';
import 'package:youtube_downloader/src/models/query_video.dart';

class DownloadId3Tag extends HookConsumerWidget {
  final QueryVideo video;

  late String title;
  TextEditingController titleController = TextEditingController();

  late String artist;
  TextEditingController artistController = TextEditingController();

  late String album;
  TextEditingController albumController = TextEditingController();

  DownloadId3Tag(this.video, {Key? key}) : super(key: key) {
    titleController.text = title = video.title;
    artistController.text = artist = video.author;
    albumController.text = album = video.album ?? "";
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      contentPadding: const EdgeInsets.only(top: 9),
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
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: TextField(
                      controller: titleController,
                      onChanged: (value) => title = value,
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
                      onChanged: (value) => artist = value,
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
                      onChanged: (value) => album = value,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: AppLocalizations.of(context)!.trackID3FieldAlbum,
                      ),
                    ),
                  ),

                ],
              ),
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
              if (video.path != null) {
                video.title = title;
                video.author = artist;
                video.album = album;

                await video.setId3Tag(video.path!);
              }
              Navigator.of(context).pop();
            },
            child: Text(AppLocalizations.of(context)!.trackID3Action)),
      ],
    );
  }

}
