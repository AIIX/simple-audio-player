import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtMultimedia 5.9
import QtAudioEngine 1.0
import org.kde.kirigami 2.1 as Kirigami

Kirigami.SwipeListItem {
            id: plItem
            Layout.fillWidth: true
            height: Kirigami.Units.gridUnit * 2
            objectName: source

            Column {
                id: plItemColoumn
                width: parent.width

            Label {
                id: plItemLabel
                wrapMode: Text.WordWrap
                color: Kirigami.Theme.textColor

                Component.onCompleted: {
                    var filterName = source.toString();
                    plItemLabel.text = filterName.match(/\/([^\/]+)\/?$/)[1]
                }
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
                        pl.removeItem(index)
                    }
                }
            ]

            onClicked: {
                audioPlay(index)
                songtitle.text = source.toString().match(/\/([^\/]+)\/?$/)[1]
             }
}
