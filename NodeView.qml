import QtQuick 2.0
import QtQuick.Controls 1.1

Item {
    id: root

    width: 150
    height: 125

    Rectangle {
        id: rect

        anchors.fill: parent
        border {
            color: "black"
        }
        radius: 20
        color: "#e0f5ee"

        Column {
            anchors {
                top: parent.top; topMargin: 10
                horizontalCenter: parent.horizontalCenter
            }
            spacing: 10

            Label {
                text: node.actor
            }
            Label {
                text: node.type
            }
            Label {
                text: node.msg
            }
            Label {
                text: node.conditionExpression
            }
        }
    }

    DialogueNode {
        id: node

        actor: "Tester"
        type: "npc"
        msg: "Hello world"
        conditionExpression: ""
    }
}
