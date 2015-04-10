import QtQuick 2.0

/* This is the API definition of ProgressIndicator.
*/

Item {
    id: root

    /* This property defines the size of ProgressIndicator.
       small = (64x64px)
       medium = (128x128px) (Default)
       large = (256x256px)
       huge = (512x512px)
    */
    property string size: "medium"

    /* This property defines if indicator animations are running or not
    */
    property bool running: true

    /* This property holds the current value of ProgressIndicator.
       Value should be between 0 (0%) and 1 (100%).
    */
    property real value: 0

    /* This property defines if percentages text is shown or not.
       Default is true
    */
    property bool showPercentages: true

    /* This property defines if indicator will be automatically hidden
       when it's not running anymore. Alternatively, call hide() method
       when you want to hide the indicator. Default is true.
    */
    property bool hidesWhenStopped: true;

    /* This property defines the color used for highlighting progress.
       Default is yellowish.
    */
    property color highlightColor: "#ffff40"

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
        property real __value: Math.max(0,Math.min(1, value));
        property bool __isHidden: false
        property int __pixelSize: 128
    }
}
