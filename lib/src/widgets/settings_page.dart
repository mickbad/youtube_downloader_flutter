import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/download_manager.dart';
import '../models/settings.dart';
import '../providers.dart';

class SettingsPage extends HookConsumerWidget {
  SettingsPage({Key? key}) : super(key: key);

  static const ffmpegContainers = <DropdownMenuItem<String>>[
    DropdownMenuItem(value: '.mp4', child: Text('.mp4')),
    DropdownMenuItem(value: '.webm', child: Text('.webm')),
    DropdownMenuItem(value: '.mkv', child: Text('.mkv'))
  ];

  static const downloadQuotaItems = <DropdownMenuItem<int>>[
    DropdownMenuItem(value: 1, child: Text('1')),
    DropdownMenuItem(value: 2, child: Text('2')),
    DropdownMenuItem(value: 3, child: Text('3')),
    DropdownMenuItem(value: 4, child: Text('4')),
    DropdownMenuItem(value: 5, child: Text('5')),
    DropdownMenuItem(value: 6, child: Text('6')),
  ];

  final locales = AppLocalizations.supportedLocales
      .map((e) => DropdownMenuItem(value: e, child: Text(e.languageCode)))
      .toList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final intl = AppLocalizations.of(context)!;
    final settings = ref.watch(settingsProvider.state);

    // ffmpeg path directory if windows/linux
    Widget ffmpeg_locator_settings = Container();
    if (Platform.isWindows || Platform.isLinux) {
      ffmpeg_locator_settings = ListTile(
        title: Text(intl.ffmpegPath),
        subtitle: Text(settings.state.ffmpegPath),
        onTap: () async {
          final result = await FilePicker.platform
              .pickFiles(dialogTitle: 'Choose FFMPEG localisation');
          if (result?.files.single.path?.isEmpty ?? true) {
            return;
          }

          // check if ffmpeg ready
          final ffmpegPath = result?.files.single.path ?? "nothing";
          final process = await Process.run(ffmpegPath, [], runInShell: true);
          if (!(process.stderr as String).startsWith("ffmpeg version")) {
            showSnackbar(SnackBar(content: Text(intl.ffmpegNotFound)));
            return;
          }

          // save
          settings.state = settings.state.copyWith(ffmpegPath: ffmpegPath);
        },
      );
    }

    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: SettingsAppBar()),
      body: ListView(
        padding: const EdgeInsets.only(top: 10),
        children: [
          ListTile(
            title: Text(intl.darkMode),
            leading: Icon(settings.state.theme == ThemeSetting.dark
                ? Icons.brightness_2
                : Icons.wb_sunny),
            trailing: Switch(
              value: settings.state.theme == ThemeSetting.dark,
              onChanged: (bool value) => themeOnChanged(settings, value),
            ),
            onTap: () => themeOnChanged(
                settings, settings.state.theme != ThemeSetting.dark),
          ),
          const Divider(
            height: 0,
          ),

          ListTile(
            title: Text(intl.downloadDir),
            subtitle: Text(settings.state.downloadPath),
            onTap: () async {
              final result = await FilePicker.platform
                  .getDirectoryPath(dialogTitle: 'Choose Download Folder');
              if (result?.isEmpty ?? true) {
                return;
              }
              settings.state = settings.state.copyWith(downloadPath: result);
            },
          ),
          const Divider(
            height: 0,
          ),

          ffmpeg_locator_settings,
          const Divider(
            height: 0,
          ),

          ListTile(
            title: Text(intl.ffmpegContainer),
            subtitle: Text(intl.ffmpegDescription),
            trailing: DropdownButton(
              value: settings.state.ffmpegContainer,
              onChanged: (String? value) => settings.state =
                  settings.state.copyWith(ffmpegContainer: value),
              items: ffmpegContainers,
            ),
          ),
          const Divider(
            height: 0,
          ),

          ListTile(
            title: Text(intl.language),
            trailing: DropdownButton(
              value: settings.state.locale,
              onChanged: (Locale? value) =>
                  settings.state = settings.state.copyWith(locale: value),
              items: locales,
            ),
          ),
          const Divider(
            height: 0,
          ),

          ListTile(
            title: Text(intl.playlistSettingsQuotaTitle),
            subtitle: Text(intl.playlistSettingsQuotaDescription),
            trailing: DropdownButton(
              value: settings.state.downloadQuota,
              onChanged: (int? value) => settings.state = settings.state.copyWith(downloadQuota: value),
              items: downloadQuotaItems,
            ),
          ),
          const Divider(
            height: 0,
          ),

          ListTile(
            title: Text(intl.credits),
            subtitle: Text(intl.credits_content),
          ),
          const Divider(
            height: 0,
          ),

        ],
      ),
    );
  }

  // ignore: avoid_positional_boolean_parameters
  void themeOnChanged(StateController<Settings> settings, bool value) {
    if (value) {
      settings.state = settings.state.copyWith(theme: ThemeSetting.dark);
      return;
    }
    settings.state = settings.state.copyWith(theme: ThemeSetting.light);
  }
}

class SettingsAppBar extends HookWidget {
  const SettingsAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        elevation: 5,
        child: Container(
          padding: const EdgeInsets.only(left: 10),
          height: kToolbarHeight,
          child: Row(children: [
            IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop()),
            Center(
              child: Text(
                AppLocalizations.of(context)!.settings,
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
