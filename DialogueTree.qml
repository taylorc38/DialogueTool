import QtQuick 2.0
import JsonToDialogueTree 1.0

Item {
    id: root

    property alias filename: jsonToTree.filename

    property var nodes: [] //list of all nodes in the tree

    signal ready //emitted after importing from .json file is finished

    onReady: {
        console.log("ready")
        printTree()
    }

    // -------internal data structure management -------- //

    function createNode(properties) {
        var component = Qt.createComponent("DialogueNode.qml")
        var node = component.createObject(root)
        if (node !== null){
            node.nodeId = properties.nodeId
            node.actor = properties.actor
            node.previous = properties.previous
            node.type = properties.type
            node.msg = properties.msg
            //etc properties

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

    // ------ JSON conversions ------- //

    function exportTreeToJson() {
        var jsonObject = {}
        for (var i = 0; i < nodes.length; i++) {
            jsonObject[i] = nodes[i].exportNodeToJson()
        }
        return jsonObject
    }

    function importFromJson(jsonObj) {
        clear()
        for (var i in jsonObj) {
            createNode(jsonObj[i])
        }
    }

    // ------- printing ---------//
    function printTree() {
        var jsonObj = exportTreeToJson()
        console.log("Tree dump :: " + JSON.stringify(jsonObj))
    }

    //prints a node by id or by node reference
    function printNode(nodeRefOrId) {
        var jsonObj
        if (typeof nodeRefOrId == "number") {
            jsonObj = nodes[nodeId].exportNodeToJson()
        } else if (typeof nodeRefOrId == "object") {
            jsonObj = nodeRefOrId.exportNodeToJson()
        } else {
            console.warn("PrintNode :: Attempted to pass invalid argument of type " + typeof nodeRefOrId)
            return
        }
        console.log("Node " + jsonObj.nodeId + " dump :: " + JSON.stringify(jsonObj))
    }

    //custom C++ QML object that imports a .json file to turn into a dialogue tree
    JsonToDialogueTree {
        id: jsonToTree

        onReady: {
            root.importFromJson(this.tree)
//            root.currentParentNode = root.nodes[0]
            root.ready()
        }
    }

}

