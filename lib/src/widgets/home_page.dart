import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:youtube_downloader/src/widgets/search_view/streams_list.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../models/query_video.dart';
import '../search_bar.dart';
import 'app_drawer.dart';

@immutable
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loadingStreams = false;
  String url = "";
  TextEditingController urlController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // get auto clipboard
    Clipboard.getData(Clipboard.kTextPlain).then((cdata) {
      if (cdata != null && cdata.text != null && (cdata.text!.toLowerCase().startsWith("https://www.youtube.com") || cdata.text!.toLowerCase().startsWith("https://youtu.be"))) {
        urlController.text = url = cdata.text ?? "";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50,),

            // logo
            Center(
              child: GestureDetector(
                onLongPress: () async {
                  if (!await launchUrlString("https://www.flaticon.com/free-icon/download_1950083")) {
                    // throw 'Could not launch $_url';
                    // oops nothing
                  }
                },
                child: Image.asset("assets/images/download.png", height: 256),
              )

            ),
            const SizedBox(height: 80.0,),

            Center(child: Text(AppLocalizations.of(context)!.startSearch)),
            const SizedBox(height: 20.0,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context)!.size.width * .60,
                  child: TextField(
                    controller: urlController,
                    onChanged: (value) => url = value,
                    onSubmitted: (value) async => await launchUrlStream(context),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: AppLocalizations.of(context)!.searchUrl,
                    ),
                  ),
                ),

                Container(
                  width: 50,
                  height: 50,
                  color: Colors.white70,
                  child: IconButton(
                    icon: const Icon(Icons.paste, size: 30, color: Colors.black45,),
                    tooltip: AppLocalizations.of(context)!.searchUrlTooltip,
                    onPressed: () async {
                      // get clipboard
                      ClipboardData? cdata = await Clipboard.getData(Clipboard.kTextPlain);
                      if (cdata != null && cdata.text != null && (cdata.text!.toLowerCase().startsWith("https://www.youtube.com") || cdata.text!.toLowerCase().startsWith("https://youtu.be"))) {
                        urlController.text = url = cdata.text ?? "";
                        await launchUrlStream(context);
                      }
                      else {
                        urlController.text = "Not valid!";
                        url = "";
                      }
                    },
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () async => await launchUrlStream(context),
                child: (loadingStreams) ? const CircularProgressIndicator() : Text(AppLocalizations.of(context)!.searchUrl),
              ),
            ),
          ],
        ),
      ),
      drawer: const AppDrawer(),
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight), child: SearchBar()),
    );
  }

  Future<void> launchUrlStream(BuildContext context) async {
    setState(() {
      loadingStreams = true;
    });

    try {
      final YoutubeExplode yt = YoutubeExplode();
      final videoYT = await yt.videos.get(url);
      final QueryVideo video = QueryVideo(
          videoYT.title,
          videoYT.id.toString(),
          videoYT.author,
          videoYT.duration!,
          videoYT.thumbnails.highResUrl,
          videoYT.uploadDate,
          videoYT.uploadDateRaw);
      showDialog(context: context, builder: (context) => StreamsList(video));
    } catch (e) {
      urlController.text = "Not valid!";
      url = "";
    }

    setState(() {
      loadingStreams = false;
    });
  }

}
