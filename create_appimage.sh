#!/bin/sh

# Create Application Directory
mkdir -p AppDir

# Create AppRun file(required by AppImage)
echo '#!/bin/sh

cd "$(dirname "$0")"
export PATH=.:$PATH
exec ./youtube_downloader' > AppDir/AppRun
sudo chmod +x AppDir/AppRun

# Copy All build files to AppDir
cp -r build/linux/x64/release/bundle/* AppDir

# Copy third party soft
cp -a installation/linux/ffmpeg AppDir/.
chmod +x AppDir/ffmpeg

## Add Application metadata
# Copy app icon
sudo mkdir -p AppDir/usr/share/icons/hicolor/256x256/apps/
cp android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png AppDir/youtube_downloader.png
sudo cp AppDir/youtube_downloader_flutter.png AppDir/usr/share/icons/hicolor/256x256/apps/youtube_downloader.png

sudo mkdir -p AppDir/usr/share/applications

# Either copy .desktop file content from file or with echo command
# cp assets/youtube_downloader.desktop AppDir/youtube_downloader.desktop

echo '[Desktop Entry]
Version=1.0
Type=Application
Name=Youtube downloader
Icon=youtube_downloader
Exec=youtube_downloader %u
StartupWMClass=youtube_downloader
Categories=Utility;' > AppDir/youtube_downloader.desktop

# Also copy the same .desktop file to usr folder
sudo cp AppDir/youtube_downloader.desktop AppDir/usr/share/applications/youtube_downloader.desktop

## Start build
test ! -e appimagetool-x86_64.AppImage && curl -L https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage -o appimagetool-x86_64.AppImage
sudo chmod +x appimagetool-x86_64.AppImage
ARCH=x86_64 ./appimagetool-x86_64.AppImage AppDir/ youtube_downloader-x86_64.AppImage
