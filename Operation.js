.pragma library

let curVal = 0
let previousOperator = ""
let lastOp = ""
let digits = ""

function isOperationDisabled(op, display) {
    if (digits !== "" && lastOp !== "=" && (op === "π" || op === "e"))
        return true
    if (digits === "" && !((op >= "0" && op <= "9") || op === "π" || op === "e" || op === "C"))
        return true
    if (op === "bs" && (display.isOperandEmpty() || !((lastOp >= "0" && lastOp <= "9")
                                                      || lastOp === "π" || lastOp === "e" || lastOp === ".")))
        return true
    if (op === '=' && previousOperator.length != 1)
        return true
    if (op === "." && digits.search(/\./) != -1)
        return true
    if (op === "√" &&  digits.search(/-/) != -1)
        return true
    if (op === "C" && display.isDisplayEmpty())
        return true
    return false
}

function digitPressed(op, display) {
    if (isOperationDisabled(op, display))
        return
    if (lastOp.toString().length === 1 && ((lastOp >= "0" && lastOp <= "9") || lastOp === ".") ) {
        if (digits.length >= display.maxDigits)
            return
        digits = digits + op.toString()
        display.appendDigit(op.toString())
    } else {
        digits = op.toString()
        display.appendDigit(digits)
    }
    lastOp = op
}

function operatorPressed(op, display) {
    if (isOperationDisabled(op, display))
        return
    if (op === "±") {
        digits = Number(digits.valueOf() * -1).toString()
        display.setDigit(display.displayNumber(Number(digits)))
        return
    }
    if (op === "bs") {
        digits = digits.slice(0, -1)
        display.backspace()
        return
    }
    lastOp = op
    if (previousOperator === "+") {
        digits = (Number(curVal) + Number(digits.valueOf())).toString()
    } else if (previousOperator === "−") {
        digits = (Number(curVal) - Number(digits.valueOf())).toString()
    } else if (previousOperator === "×") {
        digits = (Number(curVal) * Number(digits.valueOf())).toString()
    } else if (previousOperator === "÷") {
        digits = (Number(curVal) / Number(digits.valueOf())).toString()
    }
    if (op === "+" || op === "−" || op === "×" || op === "÷") {
        previousOperator = op
        curVal = digits.valueOf()
        digits = ""
        display.displayOperator(previousOperator)
        return
    }
    curVal = 0
    previousOperator = ""
    if (op === "=") {
        display.newLine("=", Number(digits))
    }
    if (op === "C") {
        display.allClear()
        curVal = 0
        lastOp = ""
        digits = ""
        previousOperator = ""
    }
}
