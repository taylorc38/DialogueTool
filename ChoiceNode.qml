import QtQuick 2.0
import "ConditionFunctions.js" as CF

Item {
    id: root

    property int nodeId
    property string type: "choice"
    property string msg
    property string conditionExpression // "haveMoney"
    property bool condition: evaulateCondition(conditionExpression, conditionArgs)
    property var conditionArgs// { "price":20 }
    property var nextNodes: genNextNodes()
    property var possibleNextNodes

    function genNextNodes() {
        if (possibleNextNodes){
            var resultArr = []
            for (var index in possibleNextNodes) {
                var nextNode = possibleChoices[index]
                //verify the choiceNode's condition is true
                if (nextNode.condition) {
                    resultArr.push(nextNode.nodeId)
                }
            }
        }
    }

    function exportAsJson() {
        var jsonObject = {
            "nodeId"    : nodeId,
            "type"      : "choice",
            "msg"       : msg,
            "condition": conditionExpression
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

