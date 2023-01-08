import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:youtube_downloader/src/widgets/downloads_view/download_tile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../providers.dart';

class DownloadsPage extends HookConsumerWidget {
  const DownloadsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final downloadManager = ref.watch(downloadProvider.state);
    useListenable(downloadManager.state);

    final length = downloadManager.state.videos.length;

    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: DownloadsAppBar()),
      body: ListView.separated(
        separatorBuilder: (BuildContext context, int index) => const Divider(
          height: 0,
        ),
        itemCount: length,
        itemBuilder: (BuildContext context, int index) {
          final video = downloadManager.state.videos[(length - 1) - index];
          return DownloadTile(video);
        },
      ),
    );
  }
}

class DownloadsAppBar extends HookConsumerWidget {
  const DownloadsAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final downloadManager = ref.watch(downloadProvider.state);
    useListenable(downloadManager.state);

    return SafeArea(
      child: Material(
        elevation: 5,
        child: Container(
          padding: const EdgeInsets.only(left: 10),
          height: kToolbarHeight,
          child: Row(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.of(context).pop()),

                Center(
                  child: Text(
                    AppLocalizations.of(context)!.downloads,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
              ],
            ),

            if (downloadManager.state.videos.isNotEmpty)
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: (downloadManager.state.videos.isEmpty) ? Colors.grey : Colors.blueAccent,
                  padding: const EdgeInsets.all(10),
                ),
                onPressed: () async {
                  // check
                  if (downloadManager.state.videos.isEmpty) {
                    return;
                  }

                  // clean
                  await downloadManager.state.removeAllVideos(forceDelete: false);
                },
                child: Text(AppLocalizations.of(context)!.downloadCleanUpList),
              ),
          ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        ),
      ),
    );
  }
}
