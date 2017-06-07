import QtQuick 2.0

/**
可自动销毁自己的类
*/
Rectangle {
    id: rect1
    width: 200;
    height: 200
    color: "yellow"
    Component.onCompleted:   console.log('rect1 construct');
    Component.onDestruction: console.log('rect1 destruct');

    // 淡出并销毁自己
    NumberAnimation on opacity {
        to: 0
        duration: 1000
        onRunningChanged: {
            if (!running) {
                console.log("rect1 destroying...")
                // 该文件独立运行的话，会报错：Invalid attempt to destroy() an indestructible object
                // 但放到其他文件里面去的话，运行正常
                // 销毁自己。。。必须有个父节点存在
                rect1.destroy();
            }
        }
    }
}
