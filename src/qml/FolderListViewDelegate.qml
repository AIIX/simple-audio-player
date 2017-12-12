import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtMultimedia 5.9
import QtAudioEngine 1.0
import org.kde.kirigami 2.1 as Kirigami

Kirigami.SwipeListItem {
            id: folderlistItem
            Layout.fillWidth: true
            height: Kirigami.Units.gridUnit * 2

            Column {
                id: folderlistItemColoumn
                width: parent.width

            Label {
                id: folderlistItemLabel
                wrapMode: Text.WordWrap
                text: model.folderSource.match(/\/([^\/]+)\/?$/)[1]
                color: Kirigami.Theme.textColor
            }

            Kirigami.Separator {
                width: parent.width - Kirigami.Units.gridUnit * 2
                color: Kirigami.Theme.linkColor
                }
            }

            actions: [
                Kirigami.Action {
                        iconName: "window-close"
                        onTriggered: {
                        foldFLM.folder = ""
                        var tdt = model.folderSource.toString()
                        removeFolder(tdt)
                        musicflmodel.remove(model.currentIndex)
                    }
                }
            ]
}
