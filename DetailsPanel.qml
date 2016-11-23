import QtQuick 2.0
import QtQuick.Controls 1.1

Item {
    id: root

    property var node //node to display

    height: list.height+20

    function viewNode(node) {
        unbind()
        root.node = node
        updateView()
    }

    function updateView() {
        // initialize values
        listModel.get(0).content = node.actor
        listModel.get(1).content = node.type
        listModel.get(2).content = node.msg
        listModel.get(3).content = node.conditionExpression

        // bind values details -> node
        node.actor = Qt.binding(function() { return listModel.get(0).content })
        node.type = Qt.binding(function() { return listModel.get(1).content })
        node.msg = Qt.binding(function() { return listModel.get(2).content })
        node.conditionExpression = Qt.binding(function() { return listModel.get(3).content })
    }

    function unbind() {
        if (!node) {
            return
        }
        // break bindings
        node.actor = node.actor
        node.type = node.type
        node.msg = node.msg
        node.conditionExpression = node.conditionExpression
    }

    ListModel {
        id: listModel
        ListElement {
            title: "Actor"
            content: ""
        }
        ListElement {
            title: "Type"
        }
        ListElement {
            title: "Msg"
        }
        ListElement {
            title: "Condition"
        }
    }

    ListView {
        id: list

        anchors {
            left: parent.left; leftMargin: 10
            right: parent.right; rightMargin: 10
            bottom: parent.bottom; bottomMargin: 10
        }
        height: childrenRect.height
        clip: true
        boundsBehavior: Flickable.StopAtBounds
        model: listModel
        delegate: Item {
            id: delegateRoot

            width: ListView.view.width
            height: row.height + 10

            EntryRow {
                id: row

                anchors{
                    top: parent.top
                    left: parent.left
                    right: parent.right
                }
                height: Math.max(30, textEditContentHeight)
                titleText: model.title
                textEditWidth: list.width - title.width - 10

                onTextChanged: listModel.get(index).content = text
            }
            Rectangle {
                id: border

                anchors {
                    top: row.bottom
                    topMargin: 5
                }
                width: parent.width
                height: 1
                color: "black"
            }
        }
    }

    Rectangle {
        width: parent.width
        height: 1
        color: "black"
        anchors.bottom: list.top
        anchors.bottomMargin: 10
    }
}
