import QtQuick 2.0
import "ConditionFunctions.js" as CF

Item {
    id: root

    property int nodeId
    property string type: "npc"
    property string msg
    property string conditionExpression
    property bool condition
    property var conditionArgs
    property var choices: genChoices()
    property var possibleChoices


    function genChoices() {
        if (possibleChoices){
            var resultArr = []
            for (var index in possibleChoices) {
                var choice = possibleChoices[index]
                //verify the choiceNode's condition is true
                if (choice.condition) {
                    resultArr.push(choice.nodeId)
                }
            }
        }
    }

    function evaluateCondition(conditionExpression, conditionArgs) {
        argErr = "";

        switch (conditionExpression) {
        case "haveMoney":
            if (typeof conditionArgs.price === "number") {
                return CF.haveMoney(conditionArgs.price)
            }
            console.warn("Invalid or missing condition arg: price")
            break

        //other cases

        default:
            console.warn("Invalid condition expression provided to node " + nodeId)
            break;
        }
    }
}

