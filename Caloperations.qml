pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Window

Item {
    id: display
    property int fontSize: 22
    readonly property int maxDigits: Math.min((width / fontSize) + 1, 9)
    property string displayedOperand: ""
    readonly property string errorString: qsTr("ERROR")
    readonly property bool isError: displayedOperand === errorString
    property bool enteringDigits: false
    readonly property color qtGreenColor: "white"
    readonly property color backgroundColor: "blue"

    Item {
        anchors.fill: parent
        Rectangle {
            anchors.fill: parent
            radius: 8
            color: display.backgroundColor
            ListView {
                id: showListView
                x: 2
                y: 20
                width: parent.width
                height: parent.height
                clip: true
                delegate: Item {
                    height: display.fontSize * 1.1
                    width: showListView.width
                    required property string operator
                    required property string operand
                    Text {
                        font.pixelSize: display.fontSize
                        color: display.qtGreenColor
                        text: parent.operator
                         anchors.rightMargin: 16
                         anchors.right: parent.right
                    }
                    Text {
                        font.pixelSize: display.fontSize
                        anchors.left: parent.left
                        anchors.leftMargin: 16
                        text: parent.operand
                        color: "white"
                    }
                }
                model: ListModel { }
            }
        }
    }

    function displayOperator(operator) {
        showListView.model.append({ "operator": operator, "operand": "" })
        enteringDigits = true
        showListView.positionViewAtEnd()
    }

    function newLine(operator, operand) {
        displayedOperand = displayNumber(operand)
        showListView.model.append({ "operator": operator, "operand": displayedOperand })
        enteringDigits = false
        showListView.positionViewAtEnd()
    }

    function appendDigit(digit) {
        if (!enteringDigits)
            showListView.model.append({ "operator": "", "operand": "" })
        const i = showListView.model.count - 1
        showListView.model.get(i).operand = showListView.model.get(i).operand + digit
        enteringDigits = true
        showListView.positionViewAtEnd()
    }

    function setDigit(digit) {
        const i = showListView.model.count - 1
        showListView.model.get(i).operand = digit
        showListView.positionViewAtEnd()
    }

    function backspace() {
        const i = showListView.model.count - 1
        if (i >= 0) {
            let operand = showListView.model.get(i).operand
            showListView.model.get(i).operand = operand.toString().slice(0, -1)
            return
        }
        return
    }

    function isOperandEmpty() {
        const i = showListView.model.count - 1
        return i >= 0 ? showListView.model.get(i).operand === "" : true
    }

    function isDisplayEmpty() {
        const i = showListView.model.count - 1
        return i == -1 ? true : (i == 0 ? showListView.model.get(0).operand === ""  : false)
    }

    function clear() {
        displayedOperand = ""
        if (enteringDigits) {
            const i = showListView.model.count - 1
            if (i >= 0)
                showListView.model.remove(i)
            enteringDigits = false
        }
    }

    function allClear()
    {
        display.clear()
        showListView.model.clear()
        enteringDigits = false
    }

    function displayNumber(num) {
        if (typeof(num) !== "number")
            return errorString
        const abs = Math.abs(num)
        if (abs.toString().length <= maxDigits) {
            return isFinite(num) ? num.toString() : errorString
        }
        if (abs < 1) {
            if (Math.floor(abs * 100000) === 0) {
                const expVal = num.toExponential(maxDigits - 6).toString()
                if (expVal.length <= maxDigits + 1)
                    return expVal
            } else {
                return num.toFixed(maxDigits - 2)
            }
        } else {
            const intAbs = Math.floor(abs)
            if (intAbs.toString().length <= maxDigits)
                return parseFloat(num.toPrecision(maxDigits - 1)).toString()
            const expVal = num.toExponential(maxDigits - 6).toString()
            if (expVal.length <= maxDigits + 1)
                return expVal
        }
        return errorString
    }
}


