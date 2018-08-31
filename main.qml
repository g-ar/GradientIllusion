import QtQuick 2.6
import QtQuick.Window 2.2

Window {
    id: win
    visible: true
    width: Screen.width
    height: Screen.height
    title: qsTr("Gradient Illusion")
    property string colorRect : "#000000"
    property string colorBoxes: "#7f7f7f"
    property int sqlen: 100
    Rectangle {
        width: parent.height
        height: parent.width
        anchors.centerIn: parent
        rotation: -90

        gradient: Gradient {
                  GradientStop { position: 0.0; color: colorRect }
                  GradientStop { position: 1.0; color: "#ffffff" }
              }
        border.color: "black"
        border.width: 2
        radius: 1
    }


    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onPressed: {
            var clr = (mouse.x/Screen.width)
            modelTest.append({
                                 "x": (mouse.x - sqlen/2).toString(),
                                 "y": (mouse.y-sqlen/2).toString(),
                                 "color": Qt.rgba(clr,clr,clr).toString()
                             })

        }
    }

    Repeater {
        model: ListModel {
            id: modelTest
        }

        delegate: Rectangle {
            id: rect
            width: sqlen
            height: sqlen
            z: mouseAreaInt.drag.active ||  mouseAreaInt.pressed ? 2 : 1
            color: model.color
            x: model.x
            y: model.y
            property point beginDrag
            border { width:0; color: "#000000" }
            radius: 5
            Drag.active: mouseAreaInt.drag.active


            MouseArea {
                id: mouseAreaInt
                anchors.fill: parent
                drag.target: rect
            }

        }
    }
}
