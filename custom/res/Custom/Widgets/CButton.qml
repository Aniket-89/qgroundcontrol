import QtQuick 6.5
import QtQuick.Controls 6.5
import "qrc:/Custom/qml/CustomStyles.js" as Style

Button {
    id: control

    property string variant: "primary" // "primary", "secondary", "outlined"
    // property alias text: label.text

    implicitWidth: parent.width
    implicitHeight: 40
    font.pixelSize: Style.fontSize.lg
    font.bold: true

    background: Rectangle {
        id: bg
        radius: Style.radius.xs
        width: parent.width
        color: {
            switch (control.variant) {
            case "primary": return Style.button.primaryBg
            case "secondary": return Style.button.secondaryBg
            case "outlined": return "transparent"
            default: return Style.button.primaryBg
            }
        }
        border.color: {
            switch (control.variant) {
            case "outlined": return Style.button.outlinedBorder
            case "secondary": return Style.button.secondaryBg
            default: return "transparent"
            }
        }
        border.width: 2
        opacity: 1.0
    }

    contentItem: Text {
        id: label
        anchors.fill: parent                // ✅ Add this line
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        text: control.text
        font.pixelSize: Style.fontSize.sm
        font.bold: true
        color: {
            switch (control.variant) {
            case "primary": return Style.button.primaryText
            case "secondary": return Style.button.secondaryText
            case "outlined": return Style.button.outlinedText
            default: return Style.button.primaryText
            }
        }
    }


    // Hover and Press feedback
    states: [
        State {
            name: "hovered"
            when: control.hovered
            PropertyChanges { target: bg; opacity: Style.button.hoverOpacity }
        },
        State {
            name: "pressed"
            when: control.down
            PropertyChanges { target: bg; opacity: Style.button.pressedOpacity }
        }
    ]

    transitions: Transition {
        NumberAnimation { properties: "opacity"; duration: 120 }
    }
}
