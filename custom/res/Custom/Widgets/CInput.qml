import QtQuick 6.5
import QtQuick.Controls 6.5
import "qrc:/Custom/qml/CustomStyles.js" as Style

TextField {
    id: control

    // property alias text: field.text
    property bool isPassword: false

    implicitWidth: parent.width
    implicitHeight: 32

    font.pixelSize: Style.fontSize.sm
    color: Style.textPrimary
    placeholderTextColor: Style.textSecondary
    echoMode: isPassword ? TextInput.Password : TextInput.Normal

    background: Rectangle {
        radius: Style.radius.xs
        border.width: 1.2
        border.color: Style.border
        color: Style.surface
    }

    padding: Style.space.sm
    horizontalAlignment: Text.AlignLeft
    verticalAlignment: Text.AlignVCenter

    // Hover / focus visual feedback
    states: [
        State {
            name: "hovered"
            when: control.hovered
            PropertyChanges { target: control.background; border.color: Style.accent }
        },
        State {
            name: "focused"
            when: control.activeFocus
            PropertyChanges { target: control.background; border.color: Style.primary }
        }
    ]

    transitions: Transition {
        NumberAnimation { properties: "border.color"; duration: 100 }
    }
}
