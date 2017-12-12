import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtMultimedia 5.9
import QtAudioEngine 1.0
import org.kde.kirigami 2.1 as Kirigami
import EnvironmentVariables 1.0
import Qt.labs.folderlistmodel 2.2

Kirigami.ApplicationWindow {
    id: window
    visible: true
    pageStack.initialPage: mainPageComponent
    property alias pl: playlistModel
    property string plistpath: envvar.value("HOME") + "/Music/"
    property var folderls: []

    header: Kirigami.ApplicationHeader {}

    function initSampleFLD(){
        musicflmodel.append({folderSource: "file://" + plistpath})
        foldFLM.caseType = "AddFolder"
        foldFLM.folder = Qt.resolvedUrl("file://" + plistpath)
    }

//    function saveFLDSources(){

//    }

//    function retriveFLDSources(){

//    }

    function setFLDSource(sourceURL, caseType){
       foldFLM.folder = Qt.resolvedUrl(sourceURL);
       switch(caseType){
            case "AddFolder":
            addItemFromFLD()
            break
            case "RemoveFolder":
            removeFLDnItems()
            break
       }
    }

    function addItemFromFLD(){
        var filesources = []
        //console.log(foldFLM.folder)
        for (var i = 0; i<foldFLM.count; i++) {
            filesources.push(foldFLM.get(i, "fileURL").toString().split('\n'));
        }
        //console.log(filesources)
        for (var s = 0; s<filesources.length; s++){
            addItemToPl(filesources[s])
        }
    }

    function addItemToPl(getURL){
        var flSource = getURL.toString();
        pl.addItem(Qt.resolvedUrl(flSource))
    }

    function removeFLDnItems(){
        //console.log("HIT REMOVE")
        var filesources = []
        for (var i = 0; i<foldFLM.count; i++) {
            filesources.push(foldFLM.get(i, "fileURL").toString().split('\n'));
        }
        //console.log(filesources)
        for (var s = 0; s<filesources.length; s++){
           //var plSources = pl.itemSource(s)
           if (filesources.toString().indexOf(pl.itemSource(s)) > -1){
              //console.log(filesources.toString())
              //console.log(plSources.toString())
              pl.removeItem(pl.itemSource(s))
          }
           else {
            console.log("Error")
           }
        }
        foldFLM.folder = ""
    }

    globalDrawer: Kirigami.GlobalDrawer {
       title: "Navigation"
       drawerOpen: false
       actions: [
            Kirigami.Action {
                text: "Home"
                onTriggered: {
                pageStack.layers.pop(null)
                    }
                },
             Kirigami.Action {
                   text: "Add Music Track"
                   onTriggered: {
                        pageStack.layers.push(Qt.resolvedUrl("FilePage.qml"))
                   }
                  },
           Kirigami.Action {
                 text: "Add Music Folders"
                 onTriggered: {
                         pageStack.layers.push(Qt.resolvedUrl("FolderPage.qml"))
                 }
                }
               ]
    }

    PlayListModel {
       id: playlistModel

       onItemCountChanged: {
        //console.log(playlistModel.items.source)
        playlistModel.save("file://" + plistpath + "Playlist")
       }
    }

    ListModel {
       id: musicflmodel
    }

    FolderListModel {
        id: foldFLM
        nameFilters: ["*.mp3", "*.aac", "*.wav", "*.m4a", "*.m4b", "*.mpc", "*.ogg"]
        showDirs: false
        property string caseType

        onFolderChanged: {
            //addItemFromFLD()
            setFLDSource(foldFLM.folder, caseType)
            //console.log(foldFLM.count)
        }
    }

    QmlEnvironmentVariable
    {
     id: envvar
    }

    Kirigami.Page {
         id: mainPageComponent

         background: Rectangle {
                    color: Kirigami.Theme.backgroundColor
         }

         title: "Simple Music Player"

         MusicPlayerListStyle {
            anchors.fill: parent
         }
    }
}
