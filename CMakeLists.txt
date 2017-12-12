project(simple-audio-player)

cmake_minimum_required(VERSION 2.8.12)
set(QT_MIN_VERSION "5.9.0")
set(KF5_MIN_VERSION "5.10.0")
set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(AUTORCC_OPTIONS "/src/qml.qrc")

find_package(ECM REQUIRED NO_MODULE)

set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH} ${ECM_KDE_MODULE_DIR} "${CMAKE_SOURCE_DIR}/cmake")

include(KDEInstallDirs)
include(KDECMakeSettings)
include(KDECompilerSettings)
include(ECMInstallIcons)
include(FeatureSummary)

find_package(PkgConfig REQUIRED)

find_package(Qt5 ${QT_MIN_VERSION} REQUIRED COMPONENTS 
    Core
    Qml 
    Quick 
    Widgets
    Multimedia
)


find_package(KF5 ${KF5_MIN_VERSION} REQUIRED
    Config 
    GuiAddons 
    CoreAddons
    Kirigami2
)

add_subdirectory(src)

feature_summary(WHAT ALL INCLUDE_QUIET_PACKAGES FATAL_ON_MISSING_REQUIRED_PACKAGES)
