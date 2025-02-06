import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:youtube_downloader/src/widgets/downloads_view/download_tile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../providers.dart';

class DownloadsPage extends StatefulHookConsumerWidget {
  const DownloadsPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState()  => _DownloadsPage();
}

class _DownloadsPage extends ConsumerState<DownloadsPage> {
  late Timer refreshScreenTimer;
  String signatureExistFiles = '';

  @override
  void initState() {
    super.initState();

    // Chargement d'un timer pour rafraîchir la page si un changement a lieu dans la liste
    refreshScreenTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final downloadManager = ref.watch(downloadProvider.state);
      String signatureExistFilesWorking = '';

      // get new signature: check if exist files in download folder
      for (var video in downloadManager.state.videos) {
        bool bValidPath = File(video.path).existsSync();
        signatureExistFilesWorking += bValidPath.toString() + ';';
      }

      // check if new signature
      if (signatureExistFiles != signatureExistFilesWorking) {
        setState(() {
          signatureExistFiles = signatureExistFilesWorking;
        });
      }
    });
  }

  @override
  void dispose() {
    refreshScreenTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
  const DownloadsAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final downloadManager = ref.watch(downloadProvider.state);
    useListenable(downloadManager.state);

    // create cleanup button
    Widget cleanUpButtonElement;
    if (MediaQuery.of(context).size.width >= 560) {
      // LANDSCAPE
      cleanUpButtonElement = Text(
        AppLocalizations.of(context)!.downloadCleanUpList,
      );
    }
    else {
      // PORTRAIT
      cleanUpButtonElement = IconButton(
        icon: const Icon(Icons.cleaning_services, color: Colors.blueAccent,),
        tooltip: AppLocalizations.of(context)!.downloadCleanUpList,
        onPressed: null,
      );
    }

    return SafeArea(
      child: Material(
        elevation: 5,
        child: Container(
          padding: const EdgeInsets.only(left: 10),
          height: kToolbarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.of(context).pop()),

                  Center(
                    child: Text(
                      AppLocalizations.of(context)!.downloads,
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineSmall,
                    ),
                  ),
                ],
              ),

              if (downloadManager.state.videos.isNotEmpty) ...[
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: (downloadManager.state.videos.isEmpty)
                        ? Colors.grey
                        : Colors.blueAccent,
                    padding: const EdgeInsets.all(10),
                  ),
                  onPressed: () async {
                    // check
                    if (downloadManager.state.videos.isEmpty) {
                      return;
                    }

                    // show dialog
                    await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(AppLocalizations.of(context)!.downloadCleanUpList),
                        content: Text(AppLocalizations.of(context)!.downloadCleanUpListConfirm),
                        actions: [
                          TextButton(
                            child: Text(AppLocalizations.of(context)!.cancel),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          TextButton(
                            child: Text(AppLocalizations.of(context)!.ok),
                            onPressed: () {
                              // clean
                              downloadManager.state.removeAllVideos(forceDelete: false);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  child: cleanUpButtonElement,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
