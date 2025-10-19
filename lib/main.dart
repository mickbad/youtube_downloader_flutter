import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';
import 'package:version/version.dart';
import 'package:win32/win32.dart';
import 'package:window_size/window_size.dart';
import 'package:youtube_downloader/src/models/download_manager.dart';

import 'l10n/app_localizations.dart';
import 'src/models/settings.dart';
import 'src/providers.dart';
import 'src/widgets/home_page.dart';


// Urls de mise à jour de l'application
const String appUpdateCastUrl = "https://raw.githubusercontent.com/mickbad/youtube_downloader_flutter/refs/heads/master/updater/youtube-downloader-updater.xml";

// gestion de l'état globale de l'application
final GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory.current = '.';

  // Only call clearSavedSettings() during testing to reset internal values.
  await Upgrader.clearSavedSettings();

  // gestion des mise à jour de l'application
  final osVersion = await getCurrentOSVersion();
  final upgrader = (kIsWeb) ? null : Upgrader(
    storeController: UpgraderStoreController(
      onMacOS: () => UpgraderAppcastStore(appcastURL: appUpdateCastUrl, osVersion: osVersion),
      onWindows: () => UpgraderAppcastStore(appcastURL: appUpdateCastUrl, osVersion: osVersion),
      onLinux: () => UpgraderAppcastStore(appcastURL: appUpdateCastUrl, osVersion: osVersion),
      onAndroid: () => UpgraderAppcastStore(appcastURL: appUpdateCastUrl, osVersion: osVersion),
      oniOS: () => UpgraderAppcastStore(appcastURL: appUpdateCastUrl, osVersion: osVersion),
    ),

    debugLogging: false,  // kDebugMode,
    // countryCode: "fr",
    // languageCode: "fr",
  );

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Youtube Downloader');
    setWindowMinSize(const Size(600, 800));
    setWindowMaxSize(Size.infinite);

    // init size
    final screen = await getCurrentScreen();
    if (screen != null) {
      final screenFrame = screen.visibleFrame;
      final x = (screenFrame.width - 1300) / 2;
      final y = (screenFrame.height - 800) / 2;
      setWindowFrame(Rect.fromLTWH(x, y, 1300, 800));
    }

    if (Platform.isWindows) {
      SetProcessDpiAwareness(1);
    }
  }
  runApp(MyApp(upgrader: upgrader));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.upgrader});

  final Upgrader? upgrader;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      observers: [MainObserver()],
      child: AppInit(upgrader: upgrader),
    );
  }
}

class MainObserver implements ProviderObserver {
  @override
  void didAddProvider(
      ProviderBase provider, Object? value, ProviderContainer container) {
    debugPrint('Added: $provider : $value(${value.runtimeType})');
  }

  @override
  void didDisposeProvider(ProviderBase provider, ProviderContainer container) {
    debugPrint('Disposed: $provider');
  }

  @override
  void didUpdateProvider(ProviderBase provider, Object? previousValue,
      Object? newValue, ProviderContainer container) {
    debugPrint('Update: $provider : $newValue');
  }

  @override
  void providerDidFail(ProviderBase provider, Object error, StackTrace stackTrace, ProviderContainer container) {
    // TODO: implement providerDidFail
  }
}

class AppInit extends HookConsumerWidget {
  static final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  const AppInit({super.key, required this.upgrader});

  final Upgrader? upgrader;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fetched = useState<bool>(false);
    final settings = ref.watch(settingsProvider.state);
    final downloadManager = ref.watch(downloadProvider.state);

    useEffect(() {
      SharedPreferences.getInstance().then((value) async {
        downloadManager.state = DownloadManagerImpl.init(value);
        settings.state = await SettingsImpl.init(value);
        fetched.value = true;
      });
      return null;
    }, []);

    if (!fetched.value) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Youtube Downloader',
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    // TODO: Might be worth finding another way to achieve this
    return MaterialApp(
      scaffoldMessengerKey: scaffoldKey,
      navigatorKey: appNavigatorKey,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: settings.state.locale,
      title: 'Youtube Downloader',
      theme: settings.state.theme.themeData,

      builder: (context, child) {
        // procédure de recherche de mise à jour de l'application
        // uniquement pour les applications desktop et mobiles
        if (!kIsWeb) {
          child = UpgradeAlert(
            dialogStyle: (Platform.isMacOS || Platform.isIOS) ? UpgradeDialogStyle.cupertino : UpgradeDialogStyle.material,
            upgrader: upgrader,
            navigatorKey: appNavigatorKey,
            showIgnore: false,
            child: child,
          );
        }

        // retour du widget
        return child ?? const CircularProgressIndicator();
      },
    );
  }
}

class UpgraderDevice {
  Future<String?> getOsVersionString(UpgraderOS upgraderOS) async {
    final deviceInfo = DeviceInfoPlugin();
    String? osVersionString;
    if (upgraderOS.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      osVersionString = androidInfo.version.baseOS;
    } else if (upgraderOS.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      osVersionString = iosInfo.systemVersion;
    } else if (upgraderOS.isFuchsia) {
      osVersionString = '';
    } else if (upgraderOS.isLinux) {
      final info = await deviceInfo.linuxInfo;
      osVersionString = info.version;
    } else if (upgraderOS.isMacOS) {
      final info = await deviceInfo.macOsInfo;
      final release = info.osRelease;

      // For macOS the release string looks like: Version 13.2.1 (Build 22D68)
      // We need to parse out the actual OS version number.

      String regExpSource = r"[\w]*[\s]*(?<version>[^\s]+)";
      final regExp = RegExp(regExpSource, caseSensitive: false);
      final match = regExp.firstMatch(release);
      final version = match?.namedGroup('version');
      osVersionString = version;
    } else if (upgraderOS.isWeb) {
      osVersionString = '0.0.0';
    } else if (upgraderOS.isWindows) {
      final info = await deviceInfo.windowsInfo;
      osVersionString = info.displayVersion;
    }

    // If the OS version string is not valid, don't use it.
    try {
      Version.parse(osVersionString!);
    } catch (e) {
      osVersionString = null;
    }

    return osVersionString;
  }
}

Future<Version> getCurrentOSVersion() async {
  final upgraderDevice = UpgraderDevice();
  final osVersionString = await upgraderDevice.getOsVersionString(UpgraderOS());

  Version osVersion;

  try {
    osVersion = osVersionString?.isNotEmpty == true
        ? Version.parse(osVersionString!)
        : Version(0, 0, 0);
  } catch (e) {
    osVersion = Version(0, 0, 0);
  }
  return osVersion;
}
