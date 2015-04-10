import QtQuick 2.0

Item {
    id: root

    /* This property defines the size of BusyIndicator.
       small = (64x64px)
       medium = (128x128px) (Default)
       large = (256x256px)
       huge = (512x512px)
    */
    property string size: "medium"

    /* This property defines if indicator animations are running or not
    */
    property bool running: true

    /* This property defines if indicator will be automatically hidden
       when it's not running anymore. Indicator will also be automatically
       shown when running is true again. Alternatively, call hide() and
       show() methods. Default is true.
    */
    property bool hidesWhenStopped: true;

    /* This property inverts indicator colors.
       Inverted might work better on white backgrounds.

       Note: All indicators might not have separate inverted theming.
       So inverted indicator may look same as non-inverted one.
    */
    property bool invertedTheme: false

    /* This function animates indicator to visible */
    function show() {
        priv.__isHidden = false;
        if (hideAnimation.running) hideAnimation.stop();
        showAnimation.restart();
    }

    /* This function animates indicator to hidden */
    function hide() {
        if (showAnimation.running) showAnimation.stop();
        hideAnimation.restart();
    }

    /* ************************************* */

    /*! \internal */

    property alias priv: priv

    Component.onCompleted: {
        showAnimation.start();
    }

    onRunningChanged: {
        if (hidesWhenStopped) {
            if (!running) {
                hide();
            } else {
                show();
            }
        }
    }

    onSizeChanged: {
        if (size === "small") {
            priv.__pixelSize = 64;
        } else if (size === "medium") {
            priv.__pixelSize = 128;
        } else if (size === "large") {
            priv.__pixelSize = 256;
        } else if (size === "huge") {
            priv.__pixelSize = 512;
        }
    }

    QtObject {
        id: priv
        property bool __isHidden: false
        property int __pixelSize: 128
    }
}
