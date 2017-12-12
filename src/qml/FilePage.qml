import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtMultimedia 5.9
import QtAudioEngine 1.0
import org.kde.kirigami 2.1 as Kirigami
import Qt.labs.folderlistmodel 2.2

Kirigami.ScrollablePage {
     id: fileComponent
     background: Rectangle {
                color: Kirigami.Theme.backgroundColor
            }
     title: "Files"
     property alias path: view.path
     property alias fm: folderModel

     function addToPlayList(url){
         //console.log("HERE" + url)
         pl.addItem(Qt.resolvedUrl(url))
     }

     function savePlayList(savepath){
         pl.save("file://" + savepath + "playlist" + ".plist")
     }

     ListView {
        id: view
        anchors.fill: parent
        property alias path: folderModel.folder

         FolderListModel {
             id: folderModel
             nameFilters: ["*.mp3", "*.aac", "*.wav", "*.m4a", "*.m4b", "*.mpc", "*.ogg"]
             showDirs : true
             showDirsFirst : true
             showDotAndDotDot : true
             folder: "file:///home/"
         }

         model: folderModel
         delegate: FileDelegate{}
     }
}
