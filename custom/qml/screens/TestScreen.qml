import QtQuick 2.15
import "../CustomStyles.js" as Style

Rectangle {
    width: 400
    height: 300
    color: Style.background

    Text {
        anchors.centerIn: parent
        text: "Custom Styles Working!"
        font.pixelSize: Style.fontSize.xl
        color: Style.primary
    }
}
