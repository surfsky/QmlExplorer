/****************************************************************************
**
** Copyright (C) 2013-2014 Oleg Yadrov.
** Contact: wearyinside@gmail.com
**
** This file is part of QML Creator.
**
** QML Creator is free software: you can redistribute it and/or modify
** it under the terms of the GNU General Public License as published by
** the Free Software Foundation, either version 3 of the License, or
** (at your option) any later version.
**
** QML Creator is distributed in the hope that it will be useful,
** but WITHOUT ANY WARRANTY; without even the implied warranty of
** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
** GNU General Public License for more details.
**
** You should have received a copy of the GNU General Public License
** along with QML Creator. If not, see http://www.gnu.org/licenses/.
**
****************************************************************************/

#include "QMLHighlighter.h"

class QMLBlockData: public QTextBlockUserData
{
public:
    QList<int> bracketPositions;
};


QMLHighlighter::QMLHighlighter(QTextDocument *parent) : QSyntaxHighlighter(parent)
    , m_markCaseSensitivity(Qt::CaseInsensitive)
{
    m_colors[Normal]     = QColor("#000000");
    m_colors[Comment]    = QColor("#008000");
    m_colors[Number]     = QColor("#000080");
    m_colors[String]     = QColor("#008000");
    m_colors[Operator]   = QColor("#000000");
    m_colors[Keyword]    = QColor("#808000");
    m_colors[BuiltIn]    = QColor("#0055af");
    m_colors[Marker]     = QColor("#ffff00");
    m_colors[Item]       = QColor("#800080");
    m_colors[Property]   = QColor("#800000");

    m_keywords << "break";
    m_keywords << "case";
    m_keywords << "catch";
    m_keywords << "continue";
    m_keywords << "default";
    m_keywords << "delete";
    m_keywords << "do";
    m_keywords << "double";
    m_keywords << "else";
    m_keywords << "finally";
    m_keywords << "for";
    m_keywords << "function";
    m_keywords << "if";
    m_keywords << "import";
    m_keywords << "in";
    m_keywords << "int";
    m_keywords << "instanceof";
    m_keywords << "new";
    m_keywords << "on";
    m_keywords << "property";
    m_keywords << "real";
    m_keywords << "return";
    m_keywords << "signal";
    m_keywords << "string";
    m_keywords << "switch";
    m_keywords << "this";
    m_keywords << "throw";
    m_keywords << "try";
    m_keywords << "typeof";
    m_keywords << "var";
    m_keywords << "variant";
    m_keywords << "void";
    m_keywords << "while";
    m_keywords << "with";

    m_keywords << "true";
    m_keywords << "false";
    m_keywords << "null";

    m_jsIds << "Object";
    m_jsIds << "prototype";
    m_jsIds << "create";
    m_jsIds << "defineProperty";
    m_jsIds << "defineProperties";
    m_jsIds << "getOwnPropertyDescriptor";
    m_jsIds << "keys";
    m_jsIds << "getOwnPropertyNames";
    m_jsIds << "constructor";
    m_jsIds << "__parent__";
    m_jsIds << "__proto__";
    m_jsIds << "__defineGetter__";
    m_jsIds << "__defineSetter__";
    m_jsIds << "eval";
    m_jsIds << "hasOwnProperty";
    m_jsIds << "isPrototypeOf";
    m_jsIds << "__lookupGetter__";
    m_jsIds << "__lookupSetter__";
    m_jsIds << "__noSuchMethod__";
    m_jsIds << "propertyIsEnumerable";
    m_jsIds << "toSource";
    m_jsIds << "toLocaleString";
    m_jsIds << "toString";
    m_jsIds << "unwatch";
    m_jsIds << "valueOf";
    m_jsIds << "watch";

    m_jsIds << "Function";
    m_jsIds << "arguments";
    m_jsIds << "arity";
    m_jsIds << "caller";
    m_jsIds << "constructor";
    m_jsIds << "name";
    m_jsIds << "apply";
    m_jsIds << "bind";
    m_jsIds << "call";

    m_jsIds << "String";
    m_jsIds << "fromCharCode";
    m_jsIds << "charAt";
    m_jsIds << "charCodeAt";
    m_jsIds << "concat";
    m_jsIds << "indexOf";
    m_jsIds << "lastIndexOf";
    m_jsIds << "localCompare";
    m_jsIds << "match";
    m_jsIds << "quote";
    m_jsIds << "replace";
    m_jsIds << "search";
    m_jsIds << "slice";
    m_jsIds << "split";
    m_jsIds << "substr";
    m_jsIds << "substring";
    m_jsIds << "toLocaleLowerCase";
    m_jsIds << "toLocaleUpperCase";
    m_jsIds << "toLowerCase";
    m_jsIds << "toUpperCase";
    m_jsIds << "trim";
    m_jsIds << "trimLeft";
    m_jsIds << "trimRight";

    m_jsIds << "Array";
    m_jsIds << "isArray";
    m_jsIds << "input";
    m_jsIds << "pop";
    m_jsIds << "push";
    m_jsIds << "reverse";
    m_jsIds << "shift";
    m_jsIds << "sort";
    m_jsIds << "splice";
    m_jsIds << "unshift";
    m_jsIds << "concat";
    m_jsIds << "join";
    m_jsIds << "filter";
    m_jsIds << "forEach";
    m_jsIds << "every";
    m_jsIds << "map";
    m_jsIds << "some";
    m_jsIds << "reduce";
    m_jsIds << "reduceRight";

    m_jsIds << "RegExp";
    m_jsIds << "global";
    m_jsIds << "ignoreCase";
    m_jsIds << "lastIndex";
    m_jsIds << "multiline";
    m_jsIds << "exec";
    m_jsIds << "test";

    m_jsIds << "JSON";
    m_jsIds << "parse";
    m_jsIds << "stringify";
    m_jsIds << "navigator";
    m_jsIds << "userAgent";
    m_jsIds << "XMLHttpRequest";
    m_jsIds << "Qt";
    m_jsIds << "event";

    m_jsIds << "decodeURI";
    m_jsIds << "decodeURIComponent";
    m_jsIds << "encodeURI";
    m_jsIds << "encodeURIComponent";
    m_jsIds << "eval";
    m_jsIds << "isFinite";
    m_jsIds << "isNaN";
    m_jsIds << "parseFloat";
    m_jsIds << "parseInt";
    m_jsIds << "Infinity";
    m_jsIds << "NaN";
    m_jsIds << "undefined";

    m_jsIds << "Math";
    m_jsIds << "E";
    m_jsIds << "LN2";
    m_jsIds << "LN10";
    m_jsIds << "LOG2E";
    m_jsIds << "LOG10E";
    m_jsIds << "PI";
    m_jsIds << "SQRT1_2";
    m_jsIds << "SQRT2";
    m_jsIds << "abs";
    m_jsIds << "acos";
    m_jsIds << "asin";
    m_jsIds << "atan";
    m_jsIds << "atan2";
    m_jsIds << "ceil";
    m_jsIds << "cos";
    m_jsIds << "exp";
    m_jsIds << "floor";
    m_jsIds << "log";
    m_jsIds << "max";
    m_jsIds << "min";
    m_jsIds << "pow";
    m_jsIds << "random";
    m_jsIds << "round";
    m_jsIds << "sin";
    m_jsIds << "sqrt";
    m_jsIds << "tan";

    // Qt QML
    m_qmlIds << "Date";
    m_qmlIds << "Number";
    m_qmlIds << "String";
    m_qmlIds << "Component";
    m_qmlIds << "QtObject";
    m_qmlIds << "Locale";
    m_qmlIds << "Binding";
    m_qmlIds << "Connections";
    m_qmlIds << "Instantiator";
    m_qmlIds << "Timer";
    // Qt Quick
    m_qmlIds << "Item";
    m_qmlIds << "Rectangle";
    m_qmlIds << "Image";
    m_qmlIds << "BorderImage";
    m_qmlIds << "AnimatedImage";
    m_qmlIds << "AnimatedSprite";
    m_qmlIds << "SpriteSequence";
    m_qmlIds << "Text";
    m_qmlIds << "Accessible";
    m_qmlIds << "Gradient";
    m_qmlIds << "GradientStop";
    m_qmlIds << "SystemPalette";
    m_qmlIds << "Sprite";
    m_qmlIds << "FontLoader";
    m_qmlIds << "Repeater";
    m_qmlIds << "Loader";
    m_qmlIds << "Transform";
    m_qmlIds << "Scale";
    m_qmlIds << "Rotation";
    m_qmlIds << "Translate";
    m_qmlIds << "MouseArea";
    m_qmlIds << "Keys";
    m_qmlIds << "KeyNavigation";
    m_qmlIds << "FocusScope";
    m_qmlIds << "Flickable";
    m_qmlIds << "PinchArea";
    m_qmlIds << "MultiPointTouchArea";
    m_qmlIds << "Drag";
    m_qmlIds << "DropArea";
    m_qmlIds << "TextInput";
    m_qmlIds << "TextEdit";
    m_qmlIds << "IntValidator";
    m_qmlIds << "DoubleValidator";
    m_qmlIds << "RegExpValidator";
    m_qmlIds << "TouchPoint";
    m_qmlIds << "PinchEvent";
    m_qmlIds << "WheelEvent";
    m_qmlIds << "MouseEvent";
    m_qmlIds << "KeyEvent";
    m_qmlIds << "DragEvent";
    m_qmlIds << "Positioner";
    m_qmlIds << "Column";
    m_qmlIds << "Row";
    m_qmlIds << "Grid";
    m_qmlIds << "Flow";
    m_qmlIds << "LayoutMirroring";
    m_qmlIds << "State";
    m_qmlIds << "PropertyChanges";
    m_qmlIds << "StateGroup";
    m_qmlIds << "StateChangeScript";
    m_qmlIds << "ParentChange";
    m_qmlIds << "AnchorChanges";
    m_qmlIds << "Transition";
    m_qmlIds << "ViewTransition";
    m_qmlIds << "SequentialAnimation";
    m_qmlIds << "ParallelAnimation";
    m_qmlIds << "Behavior";
    m_qmlIds << "PropertyAction";
    m_qmlIds << "PauseAnimation";
    m_qmlIds << "SmoothedAnimation";
    m_qmlIds << "SpringAnimation";
    m_qmlIds << "ScriptAction";
    m_qmlIds << "Animation";
    m_qmlIds << "PropertyAnimation";
    m_qmlIds << "NumberAnimation";
    m_qmlIds << "Vector3dAnimation";
    m_qmlIds << "ColorAnimation";
    m_qmlIds << "RotationAnimation";
    m_qmlIds << "ParentAnimation";
    m_qmlIds << "AnchorAnimation";
    m_qmlIds << "PathAnimation";
    m_qmlIds << "PathInterpolator";
    m_qmlIds << "AnimationController";
    m_qmlIds << "Path";
    m_qmlIds << "PathLine";
    m_qmlIds << "PathQuad";
    m_qmlIds << "PathCubic";
    m_qmlIds << "PathArc";
    m_qmlIds << "PathCurve";
    m_qmlIds << "PathSvg";
    m_qmlIds << "PathAttribute";
    m_qmlIds << "PathPercent";
    m_qmlIds << "ListView";
    m_qmlIds << "GridView";
    m_qmlIds << "PathView";
    m_qmlIds << "Package";
    m_qmlIds << "Flipable";
    m_qmlIds << "ShaderEffect";
    m_qmlIds << "ShaderEffectSource";
    m_qmlIds << "GridMesh";
    m_qmlIds << "Connections";
    m_qmlIds << "Binding";
    m_qmlIds << "WorkerScript";
    m_qmlIds << "Canvas";
    m_qmlIds << "Context2D";
    m_qmlIds << "CanvasGradient";
    m_qmlIds << "CanvasPixelArray";
    m_qmlIds << "CanvasImageData";
    m_qmlIds << "TextMetrics";
    // Qt Graphical Effects
    m_qmlIds << "Blend";
    m_qmlIds << "BrightnessContrast";
    m_qmlIds << "ColorOverlay";
    m_qmlIds << "Colorize";
    m_qmlIds << "ConicalGradient";
    m_qmlIds << "Desaturate";
    m_qmlIds << "DirectionalBlur";
    m_qmlIds << "Displace";
    m_qmlIds << "DropShadow";
    m_qmlIds << "FastBlur";
    m_qmlIds << "GammaAdjust";
    m_qmlIds << "GaussianBlur";
    m_qmlIds << "Glow";
    m_qmlIds << "HueSaturation";
    m_qmlIds << "InnerShadow";
    m_qmlIds << "LevelAdjust";
    m_qmlIds << "LinearGradient";
    m_qmlIds << "MaskedBlur";
    m_qmlIds << "OpacityMask";
    m_qmlIds << "RadialBlur";
    m_qmlIds << "RadialGradient";
    m_qmlIds << "RectangularGlow";
    m_qmlIds << "RecursiveBlur";
    m_qmlIds << "ThresholdMask";
    m_qmlIds << "ZoomBlur";
    // Qt QML Models
    m_qmlIds << "FolderListModel";
    m_qmlIds << "XmlListModel";
    m_qmlIds << "XmlRole";
    m_qmlIds << "DelegateModel";
    m_qmlIds << "DelegateModelGroup";
    m_qmlIds << "ListModel";
    m_qmlIds << "ListElement";
    m_qmlIds << "ObjectModel";
    // Local Storage
    m_qmlIds << "LocalStorage";
    // Window
    m_qmlIds << "Screen";
    m_qmlIds << "Window";
    m_qmlIds << "CloseEvent";
    // Particles
    m_qmlIds << "Age";
    m_qmlIds << "AngleDirection";
    m_qmlIds << "CumulativeDirection";
    m_qmlIds << "CustomParticle";
    m_qmlIds << "Direction";
    m_qmlIds << "EllipseShape";
    m_qmlIds << "Friction";
    m_qmlIds << "Gravity";
    m_qmlIds << "GroupGoal";
    m_qmlIds << "ImageParticle";
    m_qmlIds << "ItemParticle";
    m_qmlIds << "LineShape";
    m_qmlIds << "MaskShape";
    m_qmlIds << "Affector";
    m_qmlIds << "Emitter";
    m_qmlIds << "Shape";
    m_qmlIds << "ParticleGroup";
    m_qmlIds << "ParticlePainter";
    m_qmlIds << "ParticleSystem";
    m_qmlIds << "Attractor";
    m_qmlIds << "PointDirection";
    m_qmlIds << "RectangleShape";
    m_qmlIds << "SpriteGoal";
    m_qmlIds << "TargetDirection";
    m_qmlIds << "TrailEmitter";
    m_qmlIds << "Turbulence";
    m_qmlIds << "Particle";
    m_qmlIds << "Wander";
    // Controls
    m_qmlIds << "ApplicationWindow";
    m_qmlIds << "Button";
    m_qmlIds << "CheckBox";
    m_qmlIds << "ComboBox";
    m_qmlIds << "GroupBox";
    m_qmlIds << "Label";
    m_qmlIds << "Menu";
    m_qmlIds << "MenuBar";
    m_qmlIds << "ProgressBar";
    m_qmlIds << "RadioButton";
    m_qmlIds << "ScrollView";
    m_qmlIds << "Slider";
    m_qmlIds << "SpinBox";
    m_qmlIds << "SplitView";
    m_qmlIds << "StackView";
    m_qmlIds << "StackViewDelegate";
    m_qmlIds << "StatusBar";
    m_qmlIds << "Tab";
    m_qmlIds << "TabView";
    m_qmlIds << "TableView";
    m_qmlIds << "TableViewColumn";
    m_qmlIds << "TextArea";
    m_qmlIds << "TextField";
    m_qmlIds << "ToolBar";
    m_qmlIds << "ToolButton";
    m_qmlIds << "Action";
    m_qmlIds << "ExclusiveGroup";
    m_qmlIds << "MenuSeparator";
    m_qmlIds << "MenuItem";
    m_qmlIds << "Stack";
    // Controls Styles
    m_qmlIds << "ButtonStyle";
    m_qmlIds << "CheckBoxStyle";
    m_qmlIds << "ComboBoxStyle";
    m_qmlIds << "ProgressBarStyle";
    m_qmlIds << "RadioButtonStyle";
    m_qmlIds << "ScrollViewStyle";
    m_qmlIds << "SliderStyle";
    m_qmlIds << "TabViewStyle";
    m_qmlIds << "TableViewStyle";
    m_qmlIds << "TextFieldStyle";
    // Dialogs
    m_qmlIds << "ColorDialog";
    m_qmlIds << "FileDialog";
    // Layouts
    m_qmlIds << "Layout";
    m_qmlIds << "RowLayout";
    m_qmlIds << "ColumnLayout";
    m_qmlIds << "GridLayout";
    // 3D
    m_qmlIds << "Viewport";
    m_qmlIds << "Item3D";
    m_qmlIds << "Rotation3D";
    m_qmlIds << "Scale3D";
    m_qmlIds << "Sphere";
    m_qmlIds << "Cube";
    m_qmlIds << "Mesh";
    m_qmlIds << "Camera";
    // Sensors
    m_qmlIds << "Accelerometer";

    // Multimedia
    m_qmlIds << "VideoOutput";
    m_qmlIds << "MediaPlayer";
    m_qmlIds << "Torch";

    // Properties
    m_properties << "id";
    m_properties << "objectName";
    m_properties << "anchors";
    m_properties << "centerIn";
    m_properties << "fill";
    m_properties << "fillWidth";
    m_properties << "fillHeight";
    m_properties << "spacing";
    m_properties << "left";
    m_properties << "right";
    m_properties << "top";
    m_properties << "bottom";
    m_properties << "leftMargin";
    m_properties << "rightMargin";
    m_properties << "topMargin";
    m_properties << "bottomMargin";
    m_properties << "margins";
    m_properties << "minimumWidth";
    m_properties << "maximumWidth";
    m_properties << "minimumHeight";
    m_properties << "maximumHeight";
    m_properties << "x";
    m_properties << "y";
    m_properties << "width";
    m_properties << "height";
    m_properties << "opacity";
    m_properties << "visible";
    m_properties << "clip";
    m_properties << "antialiasing";
    m_properties << "color";
    m_properties << "scale";
    m_properties << "from";
    m_properties << "to";
    m_properties << "duration";
    m_properties << "loops";
    m_properties << "radius";
    m_properties << "running";
    m_properties << "repeat";
    m_properties << "interval";
    m_properties << "source";
    m_properties << "enabled";
    m_properties << "active";
    m_properties << "text";
    m_properties << "font";
    m_properties << "Keys";
    m_properties << "onClicked";
    m_properties << "onPressed";
    m_properties << "onReleased";
    m_properties << "onCompleted";
    m_properties << "onTriggered";
    m_properties << "onTouchUpdated";
    m_properties << "onPaint";
    m_properties << "triggeredOnStart";
    m_properties << "model";
    m_properties << "delegate";
    m_properties << "horizontalAlignment";
    m_properties << "verticalAlignment";
    m_properties << "system";
    m_properties << "group";
    m_properties << "groups";
    m_properties << "emitRate";
    m_properties << "lifeSpan";
    m_properties << "acceleration";
    m_properties << "xVariation";
    m_properties << "yVariation";
    m_properties << "size";
    m_properties << "sizeVariation";
    m_properties << "endSize";
    m_properties << "wrapMode";
    m_properties << "showDirs";
    m_properties << "showDirsFirst";
    m_properties << "showDotAndDotDot";
    m_properties << "folder";
    m_properties << "maximumTouchPoints";
    m_properties << "transform";
    m_properties << "hoverEnabled";
    m_properties << "fragmentShader";
    m_properties << "vertexShader";
    m_properties << "status";
    m_properties << "effect";
    m_properties << "levelOfDetail";
    m_properties << "angle";
    m_properties << "axis";
    m_properties << "mesh";
    m_properties << "camera";
    m_properties << "eye";
    m_properties << "texture";
    m_properties << "fillColor";
    m_properties << "decal";
    m_properties << "renderMode";
    m_properties << "picking";
    m_properties << "useLighting";
    m_properties << "position";
    m_properties << "sortChildren";
    m_properties << "navigation";
    m_properties << "scaleFactor";
    m_properties << "autoRotation";
    m_properties << "redVariation";
    m_properties << "greenVariation";
    m_properties << "blueVariation";
    m_properties << "rotationVariation";
    m_properties << "rotationVelocityVariation";
    m_properties << "entryEffect";
    m_properties << "maximumEmitted";
    m_properties << "velocity";
    m_properties << "angleVariation";
    m_properties << "magnitude";
    m_properties << "dateRate";
    m_properties << "border";
    m_properties << "captureMode";
    m_properties << "imageCapture";
    m_properties << "videoRecorder";
    m_properties << "resolution";
    m_properties << "frameRate";
    m_properties << "autoPlay";
    m_properties << "power";
    m_properties << "cached";
    m_properties << "length";
    m_properties << "samples";
    m_properties << "transparentBorder";
}

void QMLHighlighter::setColor(ColorComponent component, const QColor &color)
{
    m_colors[component] = color;
    rehighlight();
}

void QMLHighlighter::highlightBlock(const QString &text)
{
    enum {
        Start = 0,
        Number = 1,
        Identifier = 2,
        String = 3,
        Comment = 4,
        Regex = 5
    };

    QList<int> bracketPositions;

    int blockState = previousBlockState();
    int bracketLevel = blockState >> 4;
    int state = blockState & 15;
    if (blockState < 0) {
        bracketLevel = 0;
        state = Start;
    }

    int start = 0;
    int i = 0;
    while (i <= text.length()) {
        QChar ch = (i < text.length()) ? text.at(i) : QChar();
        QChar next = (i < text.length() - 1) ? text.at(i + 1) : QChar();

        switch (state) {

        case Start:
            start = i;
            if (ch.isSpace()) {
                ++i;
            } else if (ch.isDigit()) {
                ++i;
                state = Number;
            } else if (ch.isLetter() || ch == '_') {
                ++i;
                state = Identifier;
            } else if (ch == '\'' || ch == '\"') {
                ++i;
                state = String;
            } else if (ch == '/' && next == '*') {
                ++i;
                ++i;
                state = Comment;
            } else if (ch == '/' && next == '/') {
                i = text.length();
                setFormat(start, text.length(), m_colors[ColorComponent::Comment]);
            } else if (ch == '/' && next != '*') {
                ++i;
                state = Regex;
            } else {
                if (!QString("(){}[]").contains(ch))
                    setFormat(start, 1, m_colors[Operator]);
                if (ch =='{' || ch == '}') {
                    bracketPositions += i;
                    if (ch == '{')
                        bracketLevel++;
                    else
                        bracketLevel--;
                }
                ++i;
                state = Start;
            }
            break;

        case Number:
            if (ch.isSpace() || !ch.isDigit()) {
                setFormat(start, i - start, m_colors[ColorComponent::Number]);
                state = Start;
            } else {
                ++i;
            }
            break;

        case Identifier:
            if (ch.isSpace() || !(ch.isDigit() || ch.isLetter() || ch == '_')) {
                QString token = text.mid(start, i - start).trimmed();
                if (m_keywords.contains(token))
                    setFormat(start, i - start, m_colors[Keyword]);
                else if (m_jsIds.contains(token))
                    setFormat(start, i - start, m_colors[BuiltIn]);
                else if (m_qmlIds.contains(token))
                    setFormat(start, i - start, m_colors[Item]);
                else if (m_properties.contains(token))
                    setFormat(start, i - start, m_colors[Property]);
                state = Start;
            } else {
                ++i;
            }
            break;

        case String:
            if (ch == text.at(start)) {
                QChar prev = (i > 0) ? text.at(i - 1) : QChar();
                if (prev != '\\') {
                    ++i;
                    setFormat(start, i - start, m_colors[ColorComponent::String]);
                    state = Start;
                } else {
                    ++i;
                }
            } else {
                ++i;
            }
            break;

        case Comment:
            if (ch == '*' && next == '/') {
                ++i;
                ++i;
                setFormat(start, i - start, m_colors[ColorComponent::Comment]);
                state = Start;
            } else {
                ++i;
            }
            break;

        case Regex:
            if (ch == '/') {
                QChar prev = (i > 0) ? text.at(i - 1) : QChar();
                if (prev != '\\') {
                    ++i;
                    setFormat(start, i - start, m_colors[ColorComponent::String]);
                    state = Start;
                } else {
                    ++i;
                }
            } else {
                ++i;
            }
            break;

        default:
            state = Start;
            break;
        }
    }

    if (state == Comment)
        setFormat(start, text.length(), m_colors[ColorComponent::Comment]);
    else
        state = Start;

    if (!m_markString.isEmpty()) {
        int pos = 0;
        int len = m_markString.length();
        QTextCharFormat markerFormat;
        markerFormat.setBackground(m_colors[ColorComponent::Marker]);
        markerFormat.setForeground(m_colors[ColorComponent::Normal]);
        for (;;) {
            pos = text.indexOf(m_markString, pos, m_markCaseSensitivity);
            if (pos < 0)
                break;
            setFormat(pos, len, markerFormat);
            ++pos;
        }
    }

    if (!bracketPositions.isEmpty()) {
        QMLBlockData *blockData = reinterpret_cast<QMLBlockData*>(currentBlock().userData());
        if (!blockData) {
            blockData = new QMLBlockData;
            currentBlock().setUserData(blockData);
        }
        blockData->bracketPositions = bracketPositions;
    }

    blockState = (state & 15) | (bracketLevel << 4);
    setCurrentBlockState(blockState);
}

void QMLHighlighter::mark(const QString &str, Qt::CaseSensitivity caseSensitivity)
{
    m_markString = str;
    m_markCaseSensitivity = caseSensitivity;
    rehighlight();
}


