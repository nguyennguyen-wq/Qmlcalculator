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
    readonly property int buttonRadius: 8

    function getBackgroundColor() {
        if (button.dimmable && button.dimmed)
            return backgroundColor
        if (button.pressed)
            return backgroundColor
        return backgroundColor
    }

    function getBorderColor() {
        if (button.dimmable && button.dimmed)
            return backgroundColor
        if (button.pressed || button.hovered)
            return backgroundColor
        return backgroundColor
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

