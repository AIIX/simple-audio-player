# Simple-Audio-Player
Simple Audio Player Application for Plasma Mobile

### Installation instructions
- git clone https://github.com/AIIX/simple-audio-player/
- mkdir build
- cd build
- cmake .. -DCMAKE_INSTALL_PREFIX=/usr
- make
- sudo make install

### Dependencies:
- Qt5 Core, QML, Quick, Widgets, Multimedia
- KF5 Config, Kirigami2

### KDE NEON:
- sudo apt install qml-module-qtquick-controls qtdeclarative5-dev build-essential g++ gettext qtdeclarative5-models-plugin cmake cmake-extras cmake-data qml-module-qtquick-layouts libkf5plasma-dev extra-cmake-modules qtmultimedia5-dev

### Known Bugs:
- Application does not store added folders on restart (Temporary workaround: Users Music folder is added by default to the playlist on restart)
