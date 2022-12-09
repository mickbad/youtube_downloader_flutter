#!/bin/sh
# documentation du compilateur DMG : https://github.com/create-dmg/create-dmg

# vérification de l'installation du compacteur
if [ ! -x "$(which create-dmg)" ]; then
    echo "No compactor found!"
    echo "Please install it: https://github.com/create-dmg/create-dmg"
    echo
    echo "$ brew install create-dmg"
    echo
    exit 1
fi

# vérification du logiciel à installer
APPNAME_ORIG="youtube_downloader_flutter.app"
APPNAME="youtube_downloader.app"
APP_ORIG="../../build/macos/Build/Products/Release/$APPNAME_ORIG"
APP="../../build/macos/Build/Products/Release/$APPNAME"
if [ ! -d "$APP_ORIG" ]; then
    echo "No release build found"
    echo "Please make a compilation from IDE or commandline"
    echo
    echo "$ flutter build macos --release"
    echo
    exit 1
fi
cp -a "$APP_ORIG" "$APP"

# vérification de l'image de fond
DMG_BACKGROUND="apps-darwin-dmg-bg.png"
if [ ! -r "$DMG_BACKGROUND" ]; then
    echo "No background image '$DMG_BACKGROUND' found in current directory"
    echo
    exit 1
fi

# vérification de l'image de l'icône
DMG_ICON="apps-icon.icns"
if [ ! -r "$DMG_ICON" ]; then
    echo "No icon image '$DMG_ICON' found in current directory"
    echo
    exit 1
fi

# copie de l'application dans le lieu temporaire
SOURCES_TEMP="./sources"
echo "copy application '$APP'"
rm -fr "$SOURCES_TEMP"
mkdir -p "$SOURCES_TEMP"
cp -va "$APP" "$SOURCES_TEMP/." > /dev/null

# procédure d'installation
DMG_OUPUT="youtube_downloader-darwin.dmg"
test -f "$DMG_OUPUT" && rm -f "$DMG_OUPUT"
create-dmg \
  --volname "Youtube Downloader Installation" \
  --volicon "$DMG_ICON" \
  --background "$DMG_BACKGROUND" \
  --window-size 656 351 \
  --text-size 16 \
  --icon-size 150 \
  --icon "$APPNAME" 50 150 \
  --hide-extension "$APPNAME" \
  --app-drop-link 475 150 \
  --no-internet-enable \
  "$DMG_OUPUT" \
  "$SOURCES_TEMP/"

# nettoyage
rm -fr "$SOURCES_TEMP"
