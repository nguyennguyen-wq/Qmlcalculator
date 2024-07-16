pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts

Item {
    id: controller
    implicitWidth: isPortraitMode ? portraitModeWidth : landscapeModeWidth
    implicitHeight: mainGrid.height
    readonly property int spacing: 5
    readonly property color qtGreenColor: "white"
    readonly property color backspaceRedColor: "white"
    property bool isPortraitMode: root.isPortraitMode
    property int portraitModeWidth: mainGrid.width
    property int landscapeModeWidth:  mainGrid.width

    function updateDimmed(){
        for (let i = 0; i < mainGrid.children.length; i++){
            mainGrid.children[i].dimmed = root.isButtonDisabled(mainGrid.children[i].text)
        }
    }
    component DigitButton: Button {
        onReleased: {
            root.digitPressed(text)
            updateDimmed()
        }
    }
    component OperatorButton: Button {
        onReleased: {
            root.operatorPressed(text)
            updateDimmed()
        }
        textColor: controller.qtGreenColor
        implicitWidth: 48
        dimmable: true
    }
    Component.onCompleted: updateDimmed()
    Rectangle {
        id: numberPad
        anchors.fill: parent
        radius: 8
        color: "transparent"
        RowLayout {
            spacing: controller.spacing
            GridLayout {
                id: mainGrid
                columns: 5
                columnSpacing: controller.spacing
                rowSpacing: controller.spacing
                OperatorButton {
                    text: "="
                    implicitHeight: 38
                }
                OperatorButton {
                    text: "÷"
                    implicitWidth: 38
                }
                DigitButton { text: "7" }
                DigitButton { text: "8" }
                DigitButton { text: "9" }
                OperatorButton {
                    text: "C"
                }
                OperatorButton {
                    text: "×"
                    implicitWidth: 38
                }
                DigitButton { text: "4" }
                DigitButton { text: "5" }
                DigitButton { text: "6" }
                BsButton {}
                OperatorButton {
                    text: "−"
                    implicitWidth: 38
                }
                DigitButton { text: "1" }
                DigitButton { text: "2" }
                DigitButton { text: "3" }
                OperatorButton {
                    text: "±"
                    textColor: controller.backspaceRedColor
                    accentColor: controller.backspaceRedColor
                }
                OperatorButton {
                    text: "+"
                    implicitWidth: 38
                }
                DigitButton {
                    text: "."
                    dimmable: true
                }
                DigitButton { text: "0" }
            }
        }
    }
}
