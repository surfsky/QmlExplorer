import QtQuick 2.0
import Qt.WebSockets 1.0

Text {
    id: root
    width: 480
    height: 48

    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter

    WebSocket {
        id: socket
        url: "ws://echo.websocket.org"
        active: true
        onStatusChanged: {
            if (socket.status == WebSocket.Error) {
                root.text = "Error: " + socket.errorString;
            } else if (socket.status == WebSocket.Open) {
                root.text = "Open";
                socket.sendTextMessage("ping");
            } else if (socket.status == WebSocket.Closed) {
                root.text = "closed";
            }
        }
        onTextMessageReceived: {
            text = message;
        }
    }
}
