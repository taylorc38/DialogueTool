import QtQuick 2.0

Text {
    id: root

    property int textSize

    font {
        family: "Monospace"
        pixelSize: textSize
    }
}
