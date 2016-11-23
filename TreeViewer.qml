import QtQuick 2.0

Item {
    id: root


    Flickable {
        id: flickable

        anchors.fill: parent
        clip: true
        contentWidth: width
        contentHeight: height

        Column {
            anchors.left: parent.left

            NodeView {

            }
        }


    }
}
