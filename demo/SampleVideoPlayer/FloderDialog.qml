/*
 * author qyvlik
 * email qyvlik@qq.com
 * time 2015/4/10
*/
import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import FlatUI 2.0
import Qt.labs.folderlistmodel 2.1

FlatDialog {
    id:floderDialog;
    title:folderModel.folder
    width: 640
    height: 480

    signal selectFileName(var filename);

    FolderListModel {
        id: folderModel
        nameFilters:["*.mp3","*.mp4","*.flv","*.flac"]
        folder: "file:/f:/"
        rootFolder: "file:/f:/"
        sortField:FolderListModel.Type
        showDotAndDotDot:true
        showHidden:true
    }

    content: ScrollView{
        GridView{
            add: Transition {
                NumberAnimation { properties: "x,y"; from: 100; duration: 500 }
            }
            move: Transition {
                NumberAnimation { properties: "x,y"; duration: 500 }
            }
            displaced: Transition {
                NumberAnimation { properties: "x,y"; duration: 1000 }
            }
            model: folderModel
            delegate:textArea
        }
    }
    Component{
        id:textArea;
        Rectangle{
            implicitHeight: 86
            implicitWidth: 86
            color:mouse.pressed?afterPressColor:beforePressColor
            border.color: "#ccc"
            border.width: 1
            radius: FlatGlobal.radius
            readonly property color beforePressColor: FlatGlobal.colorPeterRiver
            readonly property color afterPressColor: FlatGlobal.colorBelizeHole
            Text {
                id:showFile;
                width: parent.width
                anchors.top:parent.top
                wrapMode: Text.WordWrap
                text: fileName
                font:FlatGlobal.font;
            }
            MouseArea{
                id:mouse
                anchors.fill: parent;
                onClicked: {
                    var isDir = folderModel.get(index,"fileIsDir");
                    if(isDir){
                        folderModel.folder = folderModel.get(index,"fileURL");
                    } else {
                        selectFileName(folderModel.get(index,"fileURL"));
                        floderDialog.close();
                    }
                }
            }
        }
    }
}
