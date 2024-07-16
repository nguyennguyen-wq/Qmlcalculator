import QtQuick
import QtQuick.Controls
RoundButton {
    id: button
    implicitWidth: 48
    implicitHeight: 38
    radius: buttonRadius
    text: "BS"

    property bool dimmable: true
    property bool dimmed: false
    readonly property color backgroundColor: "blue"
    readonly property color backspaceRedColor: "blue"
    readonly property int buttonRadius: 8

    function getBackgroundColor() {
        if (button.dimmable && button.dimmed)
            return backgroundColor
        if (button.pressed)
            return backspaceRedColor
        return backgroundColor
    }

    function getBorderColor() {
        if (button.dimmable && button.dimmed)
            return borderColor
        if (button.pressed || button.hovered)
            return backspaceRedColor
        return borderColor
    }

    onReleased: {
        root.operatorPressed("bs")
        updateDimmed()
    }

    background: Rectangle {
        radius: button.buttonRadius
        color: getBackgroundColor()
        border.color: getBorderColor()
    }
}

