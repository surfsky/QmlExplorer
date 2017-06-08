import QtQuick 2.0
import Enginio 1.0


/**
测试Qt Enginio数据服务（Baas）
该模块已经不包括在基础类库中了
*/
Rectangle {
    width: 600
    height: 600


    EnginioClient {
        id: enginio
        backendId: "544de508698b3c70c504139a"
    }
    Component.onCompleted: {
        var city = {
            objectType: "objects.city",
            name: "Helsinki",
            population: 606000
        };
        enginio.create(city);
    }
}
