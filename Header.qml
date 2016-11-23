import QtQuick 2.0

Item {
    id: root

    signal browse

    //todo refactor this into a button component
    Rectangle {
        id: btnBrowse

        anchors {
            right: parent.right; rightMargin: 5
            top: parent.top; topMargin: 5
            bottom: parent.bottom; bottomMargin: 5
        }
        width: 75
        border.color: "black"

        Text {
            text: "Browse"
            anchors.centerIn: parent
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                root.browse()
            }
        }
    }

    Rectangle {
        anchors.bottom: parent.bottom
        width: parent.width
        height: 1
        color: "black"
    }
}
