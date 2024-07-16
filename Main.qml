import QtQuick.Window
import QtQuick.Layouts
import "Operation.js" as Calculation

Window {
    visible: true
    width: 320
    height: 520
    minimumWidth: Math.max(buttons.portraitModeWidth, display.Width) + root.margin
    minimumHeight: display.Height + buttons.height + root.margin
    color: root.backgroundColor

    Item {
        id: root
        anchors.fill: parent
        readonly property int margin: 18
        readonly property color backgroundColor: "white"
        readonly property int minLandscapeModeWidth: buttons.landscapeModeWidth
                                                     + display.Width
                                                     + margin
        property bool isPortraitMode: width < minLandscapeModeWidth

        AllButtons {
            id: buttons;
            Layout.margins: root.margin
        }
		
        Caloperations {
            id: display
            Layout.fillWidth: true
                       Layout.fillHeight: true
            Layout.margins: root.margin
        }

        ColumnLayout {
            id: portraitMode
            anchors.fill: parent
            visible: true
            LayoutItemProxy {
                target: display
                  Layout.alignment: Qt.AlignHCenter
            }
            LayoutItemProxy {
                target: buttons
                Layout.alignment: Qt.AlignHCenter
            }
        }

        RowLayout {
            id: landscapeMode
            anchors.fill: parent
            visible: false
            LayoutItemProxy {
                target: display
                Layout.alignment: Qt.AlignHCenter
            }
            LayoutItemProxy {
                target: buttons
                Layout.alignment: Qt.AlignVCenter
            }
        }

        function operatorPressed(operator) {
            Calculation.operatorPressed(operator, display)
        }

        function digitPressed(digit) {
            Calculation.digitPressed(digit, display)
        }

        function isButtonDisabled(op) {
            return Calculation.isOperationDisabled(op, display)
        }
    }
}

