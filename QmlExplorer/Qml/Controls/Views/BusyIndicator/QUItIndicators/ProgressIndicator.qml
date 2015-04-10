import QtQuick 2.0

/* ProgressIndicator is a combination of busy indicator (circular element
   showing something is loading) and progress bar (horizontal bar showing
   how loading is progressing).

   The API is defined in AbstractProgressIndicator.
*/

AbstractProgressIndicator {
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

    Item {
        id: sourceItem
        width: sourceItemImage.width
        height: sourceItemImage.height
        visible: false
        layer.enabled: showPercentages
        layer.smooth: true
        Image {
            id: sourceItemImage
            anchors.centerIn: parent
            source: root.invertedTheme ? "images/dots2_512_invert.png" : "images/dots2_512.png"
            sourceSize.width: priv.__pixelSize
            sourceSize.height: priv.__pixelSize
        }

        Text {
            anchors.centerIn: parent
            font.pixelSize: 6 + priv.__pixelSize * 0.10
            color: root.invertedTheme ? "#000000" : "#ffffff"
            styleColor: "#808080"
            style: Text.Outline
            text: showPercentages ? (priv.__value*100).toFixed(0) + "%" : ""
            font.bold: true
            visible: showPercentages
        }
    }

    Image {
        id: sourceItem2
        anchors.centerIn: parent
        source: "images/dots2_lights_512.png"
        sourceSize.width: priv.__pixelSize
        sourceSize.height: priv.__pixelSize
        visible: false
    }

    ShaderEffect {
        id: shaderEffect
        property variant source: showPercentages ? sourceItem : sourceItemImage
        property variant source2: sourceItem2
        property real showing: 0.2
        property real currentAngle: priv.__value * 2 * Math.PI * 0.92
        property alias highlightColor: root.highlightColor
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
        Behavior on currentAngle {
            enabled: root.running
            SmoothedAnimation { velocity: 4 }
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

        fragmentShader: "
            varying highp vec2 qt_TexCoord0;
            uniform sampler2D source;
            uniform sampler2D source2;
            uniform lowp float qt_Opacity;
            uniform highp float currentAngle;
            uniform highp vec4 highlightColor;
            void main() {
                lowp vec4 pix = texture2D(source, qt_TexCoord0);
                lowp vec4 pix2 = texture2D(source2, qt_TexCoord0) * highlightColor;

                const highp float PI = 3.14159265;
                const highp float PIx2inv = 0.1591549;
                highp vec2 center = vec2(0.5, 0.5);
                highp vec2 dif = vec2(center - qt_TexCoord0);

                highp float angle = currentAngle;
                highp float a = (atan(-dif.x, -dif.y) + angle - PI) * PIx2inv;

                // faster, but non-smooth
                //lowp float isVis = step(0.0, a);
                lowp float isVis = smoothstep(-0.10, 0.04, a);

                // Don't draw over center
                isVis = (1.0 - step(distance(center, qt_TexCoord0), 0.24))*isVis;

                gl_FragColor = mix(pix, pix2, isVis) * qt_Opacity;

            }"
    }
}
