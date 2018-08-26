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
    Rectangle {
        width: parent.height
        height: parent.width
        anchors.centerIn: parent
        rotation: 90
        gradient: Gradient {
                  GradientStop { position: 0.0; color: colorRect }
                  GradientStop { position: 1.0; color: "#ffffff" }
              }
        border.color: "black"
        border.width: 2
        radius: 1
    }

    Repeater {
        model: 6
        Rectangle {
            id: rect
            width: 200
            height: 200
            z: mouseArea.drag.active ||  mouseArea.pressed ? 2 : 1
            color: colorBoxes
            x: index * ((parent.width-width)/5)
            y: (parent.height-height)/2
            property point beginDrag
            border { width:1; color: "#000000" }
            radius: 5
            Drag.active: mouseArea.drag.active

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                drag.target: parent
                onPressed: {
                    rect.beginDrag = Qt.point(rect.x, rect.y);
                }
                onReleased: {
                    backAnimX.from = rect.x;
                    backAnimX.to = beginDrag.x;
                    backAnimY.from = rect.y;
                    backAnimY.to = beginDrag.y;
                    backAnim.start()
                    rotate.start()
                }
            }
            RotationAnimation {
                        id: rotate
                        target:rect
                        property: "rotation"
                        from: 0
                        to: 90
                        duration: 400
                        direction: RotationAnimation.Clockwise
                    }

            ParallelAnimation {
                id: backAnim
                SpringAnimation { id: backAnimX; target: rect; property: "x"; duration: 800; spring: 3; damping: 0.2 }
                SpringAnimation { id: backAnimY; target: rect; property: "y"; duration: 800; spring: 3; damping: 0.2 }
            }
        }
    }
}
