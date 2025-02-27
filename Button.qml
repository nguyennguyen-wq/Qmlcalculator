import QtQuick
import QtQuick.Controls
RoundButton {
    id: button
    implicitWidth: 38
    implicitHeight: 38
    radius: buttonRadius
    property bool dimmable: false
    property bool dimmed: false
    readonly property int fontSize: 22
    readonly property int buttonRadius: 8
    property color textColor: "white"
    property color accentColor: "white"
    readonly property color backgroundColor: "blue"
    readonly property color borderColor: "blue"

    function getBackgroundColor() {
        if (button.dimmable && button.dimmed)
            return backgroundColor
        if (button.pressed)
            return accentColor
        return backgroundColor
    }

    function getBorderColor() {
        if (button.dimmable && button.dimmed)
            return borderColor
        if (button.pressed || button.hovered)
            return accentColor
        return borderColor
    }

    function getTextColor() {
        if (button.pressed)
            return backgroundColor
        if (button.hovered)
            return accentColor
        return textColor
    }

    background: Rectangle {
        radius: button.buttonRadius
        color: getBackgroundColor()
        border.color: getBorderColor()
    }

    contentItem: Text {
        text: button.text
        font.pixelSize: button.fontSize
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: getTextColor()
        Behavior on color {
            ColorAnimation {
                duration: 120
                easing.type: Easing.OutElastic
            }
        }
    }
}

