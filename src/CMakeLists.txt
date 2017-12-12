add_subdirectory(icons)
qt5_add_resources(simple_audio_player_SRCS qml.qrc)

add_executable(simple-audio-player ${simple_audio_player_SRCS}
    main.cpp
    qmlenvironmentvariable.cpp
)

target_link_libraries(simple-audio-player 
    Qt5::Quick
    Qt5::Gui 
    Qt5::Core 
    Qt5::Qml
    Qt5::Multimedia
)

install(TARGETS simple-audio-player ${INSTALL_TARGETS_DEFAULT_ARGS})

set(DesktopNoDisplay "false")
set(DesktopMimeType "application/vnd.debian.binary-package;application/x-rpm;")
set(DesktopExec "simple-audio-player %F")
configure_file(org.simple.audio.player.desktop.cmake ${CMAKE_CURRENT_BINARY_DIR}/org.simple.audio.player.desktop)
install(PROGRAMS ${CMAKE_CURRENT_BINARY_DIR}/org.simple.audio.player.desktop DESTINATION ${XDG_APPS_INSTALL_DIR})
