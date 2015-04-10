import QtQuick 2.0
import ".."

Item {
    id: root

    height: contentArea.height

    GridView {
        anchors.fill: parent
        model: 60
        cellWidth: 192
        cellHeight: 192
        delegate: delegateItem
    }

    Component {
        id: delegateItem
        Rectangle {
            property int fakeLoadingTime: 1000
            property int fakeProgress: 0
            property int imageIndex: 1
            width: 184
            height: 184
            color: "#80202020"
            border.color: "#000000"
            border.width: 2
            Component.onCompleted: {
                imageIndex = Math.floor(Math.random()*8 + 1);
                fakeLoadingTime = 500 + Math.random()*5000;
                loaderTimer.start();
                progressTimer.start();
            }

            Loader {
                id: loader
                anchors.fill: parent
                anchors.margins: 2
                opacity: 0.0
                scale: 0.5
                onStatusChanged: {
                    if (status == Loader.Ready) {
                        loadingAnimation.restart();
                    }
                }
            }

            ProgressIndicator {
                id: indicator
                anchors.centerIn: parent
                size: "medium"
                showPercentages: false
                value: fakeProgress/10
                opacity: 0.2
            }

            SequentialAnimation {
                id: loadingAnimation

                ScriptAction {
                    script: indicator.hide();
                }
                ParallelAnimation {
                    NumberAnimation {
                        target: loader
                        property: "opacity"
                        to: 1
                        duration: 500
                        easing.type: Easing.InOutQuad
                    }
                    NumberAnimation {
                        target: loader
                        property: "scale"
                        to: 1
                        duration: 500
                        easing.type: Easing.OutBack
                    }
                }
            }

            Component {
                id: imageComponent
                Image {
                    source: "images/" + imageIndex + ".jpg"
                }
            }

            Timer {
                id: loaderTimer
                interval: fakeLoadingTime
                onTriggered: {
                    loader.sourceComponent = imageComponent;
                }
            }

            Timer {
                id: progressTimer
                repeat: true
                interval: fakeLoadingTime / 10;
                onTriggered: fakeProgress++;
            }
        }
    }
}
