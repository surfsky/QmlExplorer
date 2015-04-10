import QtQuick 2.0

/* BusyIndicator is an animated item idicating that something is loading.
   It should be used when duration of loading is unknown and loading
   progress will not be shown. BusyIndicator is more lightweight in
   loading time and animation complexity than ProgressIndicator.

   The API is defined in AbstractBusyIndicator.
*/

AbstractBusyIndicator {
    id: root

    width: priv.__pixelSize
    height: priv.__pixelSize
    visible: !priv.__isHidden

    ParallelAnimation {
        id: showAnimation
        NumberAnimation {
            target: shaderEffect
            property: "showing"
            to: 1.0
            duration: 2000
            easing.type: Easing.OutElastic
            easing.period: 0.5
        }
        NumberAnimation {
            target: shaderEffect
            property: "opacity"
            to: 1.0
            duration: 1000
            easing.type: Easing.OutQuad
        }
    }

    SequentialAnimation {
        id: hideAnimation
        ParallelAnimation {
            NumberAnimation {
                target: shaderEffect
                property: "showing"
                to: 0.2
                duration: 500
                easing.type: Easing.InQuad
            }
            NumberAnimation {
                target: shaderEffect
                property: "opacity"
                to: 0.0
                duration: 500
                easing.type: Easing.OutQuad
            }
        }
        PropertyAction {
            target: priv
            property: "__isHidden"
            value: true
        }
    }

    Image {
        id: sourceItem
        anchors.centerIn: parent
        source: root.invertedTheme ? "images/dots_512_invert.png" : "images/dots_512.png"
        sourceSize.width: priv.__pixelSize
        sourceSize.height: priv.__pixelSize
        visible: false
    }

    ShaderEffect {
        id: shaderEffect
        property variant source: sourceItem
        property real showing: 0.2

        property real animPos: 0
        NumberAnimation on animPos {
            loops: Animation.Infinite
            from: 0
            to: 2 * Math.PI
            duration: 3000
            easing.type: Easing.Bezier
            easing.bezierCurve: [ 0.2, 0.2, 0.4, 0.6, 1, 1 ]
            running: root.running
        }

        width: priv.__pixelSize
        height: priv.__pixelSize
        opacity: 0.0
        scale: showing

        mesh: GridMesh {
            resolution: Qt.size(2 + priv.__pixelSize/32, 2 + priv.__pixelSize/32)
        }
        vertexShader: "
            uniform highp mat4 qt_Matrix;
            attribute highp vec4 qt_Vertex;
            attribute highp vec2 qt_MultiTexCoord0;
            varying highp vec2 qt_TexCoord0;
            uniform highp float animPos;
            uniform highp float showing;
            void main() {
                highp vec4 pos = qt_Vertex;
                gl_Position = qt_Matrix * pos;

                const highp float size = 0.6;
                const highp float zoom = 0.4;
                const highp float cradius = 0.3;
                const highp float hPi = 3.14159/2.0;

                highp vec2 tc = qt_MultiTexCoord0;
                highp vec2 cen = vec2(0.5 + sin(animPos)*cradius, 0.5 + sin(animPos-hPi)*cradius);

                highp float dis = distance(tc, cen);
                highp float opacity = smoothstep(0.0, size, dis);

                highp vec2 dir = zoom * (cen - tc);

                // show/hide animation
                highp vec2 twist = 0.5 + (tc-0.5)+(0.14*sin(tc*200.0)-0.07);
                tc = mix(twist, tc, showing);

                qt_TexCoord0 = tc + dir*(1.0 - opacity);

            }"

    }
}
