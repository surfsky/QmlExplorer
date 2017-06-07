import QtQuick 2.0


/**遮罩效果*/
ShaderEffect {
    width: source.width;
    height: source.height
    property var source
    property var mask

    fragmentShader: "
           uniform lowp sampler2D source;
           uniform lowp sampler2D mask;
           varying highp vec2 qt_TexCoord0;

           void main (void)
           {
               vec4 c = texture2D(source, qt_TexCoord0);
               vec4 m = texture2D(mask, qt_TexCoord0);
               //gl_FragColor = vec4(c.rgb, m.a);
               gl_FragColor = m.a==0 ? vec4(0,0,0,0) : c;
           }
           "
}

