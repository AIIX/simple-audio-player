import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtMultimedia 5.9
import QtAudioEngine 1.0
import org.kde.kirigami 2.1 as Kirigami

ListView {
   id: fMListView
   anchors.fill: parent
   model: musicflmodel
   delegate: FolderListViewDelegate{}
}
