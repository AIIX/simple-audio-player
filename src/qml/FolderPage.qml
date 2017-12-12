import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtMultimedia 5.9
import QtAudioEngine 1.0
import org.kde.kirigami 2.1 as Kirigami
import Qt.labs.folderlistmodel 2.2
import QtQuick.Dialogs 1.2

Kirigami.Page {
     id: fileComponent
     background: Rectangle {
                color: Kirigami.Theme.backgroundColor
            }
     title: "Add Music Folders"

     function addFolder(foldername){
         var getSource = foldername.toString()
         musicflmodel.append({folderSource: getSource})
         foldFLM.caseType = "AddFolder"
         foldFLM.folder = Qt.resolvedUrl(getSource)
     }

     function removeFolder(foldername){
         foldFLM.caseType = "RemoveFolder"
         foldFLM.folder = Qt.resolvedUrl(foldername)
     }

     FileDialog {
         id: fileDialog
         visible: false
         title: "Please choose a file"
         selectFolder: true
         folder: shortcuts.home;
         onAccepted: {
             //console.log("You chose: " + fileDialog.fileUrls)
             var folderURL= fileDialog.fileUrls
             addFolder(folderURL)
         }
     }

     Rectangle {
         id: addFolderButton
         anchors.top: parent.top
         anchors.topMargin: Kirigami.Units.gridUnit * 3
         anchors.left: parent.left
         anchors.right: parent.right
         height: Kirigami.Units.gridUnit * 2
         color: Kirigami.Theme.backgroundColor
         border.width: 1
         border.color: Qt.lighter(Kirigami.Theme.textColor, 1.2);

         Label {
            id: addFolderButtonLabel
            anchors.centerIn: parent
            text: "Select Folder"
            color: Kirigami.Theme.textColor
         }

         MouseArea {
             id: addFolderButtonMouseArea
             anchors.fill: parent
             hoverEnabled: true
             onClicked: {
                 fileDialog.visible = true
                 foldFLM.folder = ""
             }
             onEntered: {
                 addFolderButton.color = Kirigami.Theme.textColor
                 addFolderButtonLabel.color = Kirigami.Theme.backgroundColor
             }
             onExited: {
                 addFolderButton.color = Kirigami.Theme.backgroundColor
                 addFolderButtonLabel.color = Kirigami.Theme.textColor
             }
         }
     }

      FolderListView {
        id: folderModelListView
        anchors.top: addFolderButton.bottom
        anchors.topMargin: Kirigami.Units.gridUnit * 5.5
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
     }

}
