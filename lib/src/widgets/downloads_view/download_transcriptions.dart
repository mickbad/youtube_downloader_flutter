import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:slugify/slugify.dart';
import 'package:youtube_downloader/src/models/query_video.dart';

import '../../../l10n/app_localizations.dart';

// const contentAnalyseURL = "https://c965-82-66-19-210.ngrok-free.app";
const contentAnalyseURL = "https://www.pause-musique.com";

class DownloadTranscriptions extends StatefulHookConsumerWidget {
  final QueryVideo video;

  DownloadTranscriptions(this.video, {super.key}) {
    // titleController.text = video.title;
    // artistController.text = video.author;
    // albumController.text = video.album ?? "";
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState()  => _DownloadTranscriptionsPage();
}

class _DownloadTranscriptionsPage extends ConsumerState<DownloadTranscriptions> {
  bool isLoading = true;
  late InAppWebViewController webViewController;

  late URLRequest postRequest;

  @override
  void initState() {
    super.initState();
    _preparePostRequest();
  }

  @override
  Widget build(BuildContext context) {
    // constructeur du navigateur
    Widget browser = isLoading
        ? Center(child: CircularProgressIndicator())
        : showWebView(context);

    return AlertDialog(
      contentPadding: const EdgeInsets.only(top: 9),
      scrollable: true,
      title: Text(
        basename(widget.video.path!),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        softWrap: false,
      ),
      content: SizedBox(
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height * .7,
        child: Column(
          children: [
            // tips
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(AppLocalizations.of(context)!.trackAITooltip),
            ),

            // moteur de l'analyse
            SizedBox(
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height * .6,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: browser,
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
      // actionsAlignment: MainAxisAlignment.end,
      // actions: <Widget>[
      //   OutlinedButton(
      //       style: ButtonStyle(
      //         padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(20))
      //       ),
      //       onPressed: () async {
      //         Navigator.of(context).pop();
      //         if (video.path != null) {
      //           await video.setId3Tag(video.path!);
      //         }
      //       },
      //       child: Text(AppLocalizations.of(context)!.trackID3Action)),
      // ],
    );
  }

  ///
  /// Création du navigateur interne vers le moteur d'analyse
  ///
  Widget showWebView(BuildContext context) {
    return InAppWebView(
      initialUrlRequest: postRequest,

      initialSettings: InAppWebViewSettings(
        transparentBackground: true,
        safeBrowsingEnabled: true,
        isFraudulentWebsiteWarningEnabled: true,
        javaScriptEnabled: true,
        javaScriptCanOpenWindowsAutomatically: true,
        disableContextMenu: true,
      ),

      ///
      /// Gestion du controleur de la webview
      ///
      onWebViewCreated: (controller) {
        webViewController = controller;

        ///
        /// Interception Javascript du download des éléments générés
        ///
        webViewController.addJavaScriptHandler(
          handlerName: 'download',
          callback: (args) {
            final url = args.first as String;
            _downloadToFile(context, url);
          },
        );
      },

      // onProgressChanged: (controller, int progress) {
      //   print("-----> progress : $progress");
      // },

      ///
      /// Fabrication d'un intercepteur JS pour récupérer le download d'un fichier généré
      ///
      onLoadStop: (controller, url) async {
        // fin de chargement
        setState(() => isLoading = false);

        // Ajout d'un listener JS pour intercepter les clics sur <a> avec une url contenant /download/
        await controller.evaluateJavascript(source: '''
            document.querySelectorAll('a').forEach(a => {
              a.addEventListener('click', e => {
                const href = a.href;
                if (href.includes('/download/')) {
                  e.preventDefault();
                  window.flutter_inappwebview.callHandler('download', href);
                }
              });
            });
          ''');
      },

    );
  }

  ///
  /// Envoi des données au serveur
  ///
  Future<void> _preparePostRequest() async {
    setState(() => isLoading = true);

    final file = File(widget.video.path ?? "");
    final fileBytes = await file.readAsBytes();
    final audioBase64 = base64Encode(fileBytes);
    final sha = sha1.convert(utf8.encode(file.path)).toString();
    final filename = basename(file.path);

    final formMap = {
      "audio_identification": sha,
      "audio_filename": filename,
      "audio_base64": audioBase64,
    };

    final encodedForm = formMap.entries.map((e) =>
      '${Uri.encodeQueryComponent(e.key)}=${Uri.encodeQueryComponent(e.value)}').join('&');

    final bodyBytes = Uint8List.fromList(utf8.encode(encodedForm));

    postRequest = URLRequest(
      url: WebUri("$contentAnalyseURL/transcribe/proxy/je-commence.html"),
      method: 'POST',
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: bodyBytes,
    );

    setState(() => isLoading = false);
  }


  ///
  /// Procédure de téléchargement d'une url vers un fichier local
  ///
  Future<void> _downloadToFile(BuildContext context, String url) async {
    try {
      final fileNameFromURL = url.split('/').last;
      final fileExtension = fileNameFromURL.split(".").last;
      final fileName = "${slugify("${fileNameFromURL.replaceAll(fileExtension, "")} ${widget.video.title}")}.$fileExtension";

      // Choisir l'emplacement et le nom du fichier
      late String savePath;
      if (Platform.isAndroid || Platform.isIOS) {
        // Utiliser le dossier "Download"
        Directory? directory;
        if (Platform.isAndroid) {
          directory = Directory('/storage/emulated/0/Download');
          if (!await directory.exists()) {
            directory = await getExternalStorageDirectory();
          }
        } else {
          directory = await getApplicationDocumentsDirectory();
        }

        savePath = '${directory!.path}/$fileName';
      } else {
        // Desktop : demander où enregistrer
        final pickedPath = await FilePicker.platform.saveFile(
          dialogTitle: AppLocalizations.of(context)!.downloads,
          fileName: fileName,
          type: FileType.custom,
          allowedExtensions: [fileExtension],
        );

        if (pickedPath == null) return;
        savePath = pickedPath;
      }

      if (savePath.isEmpty) {
        return;
      }

      // Télécharger le fichier
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final file = File(savePath);
        await file.writeAsBytes(response.bodyBytes);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$savePath: ok')),
        );
        debugPrint('$savePath: ok');

        // Ouvrir le fichier téléchargé
        final result = await OpenFile.open(savePath);
        if (result.type != ResultType.done) {
          debugPrint('Échec à l\'ouverture: ${result.message}');
        }
      } else {
        throw Exception('Download error: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Erreur: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

}
