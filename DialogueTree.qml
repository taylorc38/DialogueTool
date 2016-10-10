import QtQuick 2.0

Item {
    id: root

    property string rootMsg: "Default root msg"
    property var nodes: []
    property var rootNode: {
        "nodeId":0,
        "previous":-1,
        "type":"npc",
        "msg": rootMsg

    }

    signal ready

    Component.onCompleted: {
        createNode(rootNode)
        ready()
    }

    function createNode(properties) {
        var component = Qt.createComponent("DialogueNode.qml")
        var node = component.createObject(root)
        if (node !== null){
            node.nodeId = properties.nodeId
            node.previous = properties.previous
            node.type = properties.type
            node.msg = properties.msg

            if (properties.conditionExpression)
                node.conditionExpression = properties.conditionExpression

            if (properties.conditionArgs)
                node.conditionArgs = properties.conditionArgs

            if (properties.connections)
                node.connections = properties.connections
        }
        connect(node)
    }

    function connect(node) {
        for (var i = 0; i < nodes.length; i++) {
            if (nodes[i].nodeId == node.previous) {
                var parentNode = nodes[i]
                //if this connection already exists, don't add it
                for (var k = 0; k < parentNode.connections.length; k++) {
                    if (parentNode.connections[k] == node.nodeId) {
                        nodes.push(node)
                        return
                    }
                }
                //verified this connection doesn't already exist
                parentNode.connections.push(node.nodeId)
            }
        }
        nodes.push(node)
    }

    function clear() {
        nodes = []
    }

    function exportTreeToJson() {
        var jsonObject = {}
        for (var i = 0; i < nodes.length; i++) {
            jsonObject[i] = nodes[i].exportNodeToJson()
        }
        //TODO save to file
        return jsonObject
    }

    function importFromJson(jsonObj) {
        clear()
        for (var i in jsonObj) {
            createNode(jsonObj[i])
        }
    }

    function printTree(jsonObj) {
        console.log("Tree dump :: " + JSON.stringify(jsonObj))
    }
}

