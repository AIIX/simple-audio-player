import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtMultimedia 5.9
import QtAudioEngine 1.0
import org.kde.kirigami 2.1 as Kirigami
import QtGraphicalEffects 1.0

Kirigami.ScrollablePage {
id: playlistComponentPage
property alias plistindex: plistview.currentIndex

Component.onCompleted: {
initSampleFLD()
}

function audioPlay(getIndex){
        pl.currentIndex = getIndex
        player.play();
}

function setPlaybackMode(getMode){
    switch(getMode){
    case "Normal":
        player.playlist.playbackMode = Playlist.Sequential
        break
   case "LoopPlaylist":
        player.playlist.playbackMode = Playlist.Loop
        break
   case "LoopTrack":
        player.playlist.playbackMode = Playlist.CurrentItemInLoop
        break
    }
}

ListView {
    id: plistview
    model: pl
    currentIndex: pl.currentIndex
    anchors.fill: parent
    delegate: PlayListDelegate{}
}

 MediaPlayer {
    id: player
    playlist: pl
    readonly property string title: !!metaData.author && !!metaData.title ? qsTr("%1 - %2").arg(metaData.author).arg(metaData.title) : metaData.author || metaData.title || source
  }

 footer: Rectangle {
     id: musicControllerArea
     width: playlistComponentPage.width
     height: Kirigami.Units.gridUnit * 6
     color: Kirigami.Theme.backgroundColor

     Rectangle {
        anchors.top: parent.top
        color: Kirigami.Theme.textColor
        width: parent.width
        height: Kirigami.Units.gridUnit * 0.05

        Rectangle {
            id: playButton
            anchors.centerIn: parent
            width: Kirigami.Units.gridUnit * 6
            height: Kirigami.Units.gridUnit * 6
            color: Kirigami.Theme.backgroundColor
            border.width: 1
            border.color: Qt.lighter(Kirigami.Theme.textColor, 1.2);
            radius: 100

            Image {
                id: playIcon
                width: Kirigami.Units.gridUnit * 2
                height: Kirigami.Units.gridUnit * 2
                anchors.centerIn: parent
                source: player.playbackState === MediaPlayer.PlayingState ? "../images/media-playback-pause.svg" : "../images/media-playback-start.svg"
            }

            ColorOverlay {
                id: coverlayplay
                anchors.fill: playIcon
                source: playIcon
                color: Kirigami.Theme.textColor
            }

            MouseArea {
                id: mAreaPlayButton
                anchors.fill: parent
                onClicked: player.playbackState === MediaPlayer.PlayingState ? player.pause() : player.play()
                hoverEnabled: true

                onEntered: {
                    playButton.color = Kirigami.Theme.textColor
                    coverlayplay.color = Kirigami.Theme.backgroundColor
                }
                onExited: {
                    playButton.color = Kirigami.Theme.backgroundColor
                    coverlayplay.color = Kirigami.Theme.textColor
                }
            }
        }

        Rectangle {
            id: previousButton
            anchors.right: playButton.left
            anchors.rightMargin: Kirigami.Units.gridUnit * 2
            anchors.verticalCenter: parent.verticalCenter
            width: Kirigami.Units.gridUnit * 4
            height: Kirigami.Units.gridUnit * 4
            color: Kirigami.Theme.backgroundColor
            border.width: 1
            border.color: Qt.lighter(Kirigami.Theme.textColor, 1.2);
            radius: 100

            Image {
                id: previousIcon
                width: Kirigami.Units.gridUnit * 2
                height: Kirigami.Units.gridUnit * 2
                anchors.centerIn: parent
                source: "../images/media-skip-backward.svg"
            }

            ColorOverlay {
                id: coverlayprevious
                anchors.fill: previousIcon
                source: previousIcon
                color: Kirigami.Theme.textColor
            }

            MouseArea {
                id: mAreaPreviousButton
                anchors.fill: parent
                onClicked: {
                    //console.log("Previous Clicked")
                    pl.previous()
                    //console.log("previousexecute")
                }
                hoverEnabled: true

                onEntered: {
                    previousButton.color = Kirigami.Theme.textColor
                    coverlayprevious.color = Kirigami.Theme.backgroundColor
                }
                onExited: {
                    previousButton.color = Kirigami.Theme.backgroundColor
                    coverlayprevious.color = Kirigami.Theme.textColor
                }
            }
        }

        Rectangle {
            id: nextButton
            anchors.left: playButton.right
            anchors.leftMargin: Kirigami.Units.gridUnit * 2
            anchors.verticalCenter: parent.verticalCenter
            width: Kirigami.Units.gridUnit * 4
            height: Kirigami.Units.gridUnit * 4
            color: Kirigami.Theme.backgroundColor
            border.width: 1
            border.color: Qt.lighter(Kirigami.Theme.textColor, 1.2);
            radius: 100

            Image {
                id: nextIcon
                width: Kirigami.Units.gridUnit * 2
                height: Kirigami.Units.gridUnit * 2
                anchors.centerIn: parent
                source: "../images/media-skip-forward.svg"
            }

            ColorOverlay {
                id: coverlaynext
                anchors.fill: nextIcon
                source: nextIcon
                color: Kirigami.Theme.textColor
            }

            MouseArea {
                id: mAreaNextButton
                anchors.fill: parent
                onClicked: pl.next()
                hoverEnabled: true

                onEntered: {
                    nextButton.color = Kirigami.Theme.textColor
                    coverlaynext.color = Kirigami.Theme.backgroundColor
                }
                onExited: {
                    nextButton.color = Kirigami.Theme.backgroundColor
                    coverlaynext.color = Kirigami.Theme.textColor
                }
            }
        }
     }

     Rectangle {
         id: loopButton
         anchors.left: parent.left
         anchors.leftMargin: Kirigami.Units.gridUnit * 2
         anchors.verticalCenter: parent.verticalCenter
         anchors.verticalCenterOffset: Kirigami.Units.gridUnit * 0.5
         width: Kirigami.Units.gridUnit * 2
         height: Kirigami.Units.gridUnit * 2
         color: Kirigami.Theme.backgroundColor
         border.width: 1
         border.color: Qt.lighter(Kirigami.Theme.textColor, 1.2);
         radius: 10
         property string selectedmode: "Normal"
         property int il: 0

         Image {
             id: loopIcon
             width: Kirigami.Units.gridUnit * 1.6
             height: Kirigami.Units.gridUnit * 1.6
             anchors.centerIn: parent
             source: "../images/media-album-track.svg"
         }

         ColorOverlay {
             id: coverlayloop
             anchors.fill: loopIcon
             source: loopIcon
             color: Kirigami.Theme.textColor
         }

         MouseArea {
             id: mAreaLoopButton
             anchors.fill: parent
             onClicked: {
                    loopButton.selectedmode = loopButton.selectedmode === "Normal" ? "LoopTrack" : loopButton.selectedmode === "LoopTrack" ? "LoopPlaylist" : "Normal";
                 switch(loopButton.selectedmode){
                    case "Normal":
                        loopIcon.source = "../images/media-album-track.svg"
                        setPlaybackMode("Normal");
                        break
                    case "LoopPlaylist":
                        loopIcon.source = "../images/media-repeat-playlist.svg"
                        setPlaybackMode("LoopPlaylist")
                        break
                    case "LoopTrack":
                        loopIcon.source = "../images/media-repeat-track.svg"
                        setPlaybackMode("LoopTrack")
                        break
                    }
                 }
             hoverEnabled: true
             onEntered: {
                 loopButton.color = Kirigami.Theme.textColor
                 coverlayloop.color = Kirigami.Theme.backgroundColor
             }
             onExited: {
                 loopButton.color = Kirigami.Theme.backgroundColor
                 coverlayloop.color = Kirigami.Theme.textColor
             }
         }
     }

     Rectangle {
         id: randomButton
         anchors.right: parent.right
         anchors.rightMargin: Kirigami.Units.gridUnit * 2
         anchors.verticalCenter: parent.verticalCenter
         anchors.verticalCenterOffset: Kirigami.Units.gridUnit * 0.5
         width: Kirigami.Units.gridUnit * 2
         height: Kirigami.Units.gridUnit * 2
         color: Kirigami.Theme.backgroundColor
         border.width: 1
         border.color: Qt.lighter(Kirigami.Theme.textColor, 1.2);
         radius: 10

         Image {
             id: randomIcon
             width: Kirigami.Units.gridUnit * 1.6
             height: Kirigami.Units.gridUnit * 1.6
             anchors.centerIn: parent
             source: "../images/media-playlist-shuffle.svg"
         }

         ColorOverlay {
             id: coverlayrandom
             anchors.fill: randomIcon
             source: randomIcon
             color: Kirigami.Theme.textColor
         }

         MouseArea {
             id: mAreaRandomButton
             anchors.fill: parent
             onClicked: pl.shuffle()
             hoverEnabled: true

             onEntered: {
                 randomButton.color = Kirigami.Theme.textColor
                 coverlayrandom.color = Kirigami.Theme.backgroundColor
             }
             onExited: {
                 randomButton.color = Kirigami.Theme.backgroundColor
                 coverlayrandom.color = Kirigami.Theme.textColor
             }
         }
     }


    Label {
    id: songtitle
    anchors.bottom: parent.bottom
    anchors.left: parent.left
    anchors.leftMargin: Kirigami.Units.gridUnit * 6
    anchors.right: parent.right
    anchors.rightMargin: Kirigami.Units.gridUnit * 6
    height: Kirigami.Units.gridUnit * 2
    anchors.bottomMargin: Kirigami.Units.gridUnit * 0.5
    color: Kirigami.Theme.textColor

    Connections {
            target: player
            onTitleChanged:{
                songtitle.text = "Current Track: " + player.errorString || player.title
            }
        }
    }

    Slider {
        id: seekableslider
        anchors.bottom: parent.bottom
        maximumValue: player.duration
        anchors.left: parent.left
        anchors.leftMargin: Kirigami.Units.gridUnit * 6
        anchors.right: parent.right
        anchors.rightMargin: Kirigami.Units.gridUnit * 6
        property bool sync: false

        onValueChanged: {
            if (!sync)
                player.seek(value)
        }

        Connections {
            target: player
            onPositionChanged: {
                seekableslider.sync = true
                seekableslider.value = player.position
                seekableslider.sync = false
            }
        }
    }
    Label {
        id: positionLabel
        color: Kirigami.Theme.textColor
        anchors.right: parent.right
        anchors.rightMargin: Kirigami.Units.gridUnit * 4
        anchors.verticalCenter: seekableslider.verticalCenter
        readonly property int minutes: Math.floor(player.position / 60000)
        readonly property int seconds: Math.round((player.position % 60000) / 1000)
        text: Qt.formatTime(new Date(0, 0, 0, 0, minutes, seconds), qsTr("mm:ss"))
        }
    }
}
