import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtMultimedia 5.9
import QtAudioEngine 1.0
import org.kde.kirigami 2.1 as Kirigami
import Qt.labs.folderlistmodel 2.2

Kirigami.AbstractListItem {
    id:delegate
    Layout.fillWidth: true
    height: Kirigami.Units.gridUnit * 2

    Label {
            color: Kirigami.Theme.textColor
            text: fileName
            anchors.verticalCenter: parent.verticalCenter
    }


    onClicked: {
            //console.log(fileURL)
            fileIsDir ? view.path = fileURL : addToPlayList(fileURL); savePlayList(plistpath)
    }
}
