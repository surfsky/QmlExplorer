import QtQuick 2.0
import QtQuick.Controls 1.1


/**
用键盘控制切换
*/
Rectangle {
    width: 480;
    height: 300;
    color: "black";
    id: root;

    Component {
        id: rectDelegate;
        Item {
            id: wrapper;
            z: PathView.zOrder;
            opacity: PathView.itemAlpha;
            scale: PathView.itemScale;
            Rectangle {
                width: 100;
                height: 60;
                color: Qt.rgba(Math.random(), Math.random(), Math.random(), 1);
                border.width: 2;
                border.color: wrapper.PathView.isCurrentItem ? "red" : "lightgray";
                Text {
                    anchors.centerIn: parent;
                    font.pixelSize: 28;
                    text: index;
                    color: Qt.lighter(parent.color, 2);
                }
            }
        }
    }

    PathView {
        id: pathView;
        anchors.fill: parent;
        interactive: true;
        pathItemCount: 7;
        preferredHighlightBegin: 0.5;
        preferredHighlightEnd: 0.5;
        highlightRangeMode: PathView.StrictlyEnforceRange;

        delegate: rectDelegate;
        model: 15;

        path:Path {
            startX: 10;
            startY: 100;
            PathAttribute { name: "zOrder"; value: 0 }
            PathAttribute { name: "itemAlpha"; value: 0.1 }
            PathAttribute { name: "itemScale"; value: 0.6 }
            PathLine {
                x: root.width/2 - 40;
                y: 100;
            }
            PathAttribute { name: "zOrder"; value: 10 }
            PathAttribute { name: "itemAlpha"; value: 0.8 }
            PathAttribute { name: "itemScale"; value: 1.2 }
            PathLine {
                relativeX: root.width/2 - 60;
                relativeY: 0;
            }
            PathAttribute { name: "zOrder"; value: 0 }
            PathAttribute { name: "itemAlpha"; value: 0.1 }
            PathAttribute { name: "itemScale"; value: 0.6 }
        }

        focus: true;
        Keys.onLeftPressed: decrementCurrentIndex();
        Keys.onRightPressed: incrementCurrentIndex();
    }
}
