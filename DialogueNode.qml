import QtQuick 2.0
import "ConditionFunctions.js" as CF

Item {
    id: root

    property int nodeId
    property int previous
    property string type    // "choice" or "npc"
    property string msg
    property string conditionExpression     // "haveMoney"
    property bool condition: evaluateCondition(conditionExpression, conditionArgs)
    property var conditionArgs  // { "price":20 }
    property var verifiedConnections: verifyConnections()
    property var connections: []    // -1 if this node is the end of a dialogue tree

    //returns an array of nodeIds
    function verifyConnections() {
        if (connections) {
            var verified = []
            for (var i in connections) {
                var nextNode = connections[i]
                if (nextNode.condition) {
                    verified.push(nextNode.nodeId)
                }
            }
        } else {        //this is an end node
            return -1
        }
    }

    function evaluateCondition(conditionExpression, conditionArgs) {
        if (!conditionExpression) {
            return true
        }

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

    function exportNodeToJson() {
        var jsonObject = {
            "nodeId"        : nodeId,
            "previous"      : previous,
            "type"          : type,
            "msg"           : msg,
            "condition"     : conditionExpression,
            "conditionArgs" : conditionArgs,
            "connections"   : connections
        }
        return jsonObject
    }
}



