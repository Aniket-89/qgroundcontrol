import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Qt5Compat.GraphicalEffects
import "qrc:/Custom/qml/CustomStyles.js" as Styles

Rectangle {
    id: root

    // Public properties
    property string text: ""
    property string iconSource: ""
    property string iconColor: Styles.textSecondary
    property bool isActive: false
    property bool isClickable: true
    property bool isGlassmorphic: false

    // Signals
    signal clicked()

    // Styling
    implicitWidth: parent ? parent.width : 280
    implicitHeight: 36
    radius: Styles.radius.md

    // Color based on state and style
    color: {
        if (isGlassmorphic) {
            if (isActive) {
                return Qt.rgba(1, 1, 1, 0.15)
            }
            return Qt.rgba(1, 1, 1, 0.05)
        } else {
            if (isActive) {
                return Styles.button.secondaryBg
            }
            return Styles.surface
        }
    }

    // Glass border
    border.width: isGlassmorphic ? 1 : 0
    border.color: isGlassmorphic ? Qt.rgba(1, 1, 1, 0.2) : "transparent"

    // Top highlight for glass effect
    Rectangle {
        visible: isGlassmorphic
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 1
        height: parent.height * 0.5
        radius: parent.radius
        gradient: Gradient {
            GradientStop { position: 0.0; color: Qt.rgba(1, 1, 1, isActive ? 0.2 : 0.1) }
            GradientStop { position: 1.0; color: "transparent" }
        }
    }

    // Inner border for glass definition
    Rectangle {
        visible: isGlassmorphic
        anchors.fill: parent
        anchors.margins: 1
        color: "transparent"
        border.width: 1
        border.color: Qt.rgba(1, 1, 1, 0.08)
        radius: parent.radius - 1
    }

    // Hover state
    states: [
        State {
            name: "hovered"
            when: mouseArea.containsMouse && !isActive && isClickable
            PropertyChanges {
                target: root
                color: isGlassmorphic ? Qt.rgba(1, 1, 1, 0.12) : Qt.darker(Styles.surface, 1.05)
            }
        },
        State {
            name: "pressed"
            when: mouseArea.pressed && isClickable
            PropertyChanges {
                target: root
                color: isGlassmorphic ? Qt.rgba(1, 1, 1, 0.18) : Qt.darker(Styles.surface, 1.1)
                scale: 0.98
            }
        }
    ]

    transitions: [
        Transition {
            ColorAnimation {
                duration: 150
                easing.type: Easing.OutCubic
            }
            NumberAnimation {
                property: "scale"
                duration: 100
                easing.type: Easing.OutCubic
            }
        }
    ]

    // Content
    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: Styles.margin.lg
        anchors.rightMargin: Styles.margin.md
        spacing: Styles.space.md

        // Icon
        // Text {
        //     id: iconLabel
        //     text: root.iconText
        //     font.pixelSize: 24
        //     color: isGlassmorphic ? (isActive ? "#FFFFFF" : Qt.rgba(1, 1, 1, 0.7)) : root.iconColor
        //     Layout.alignment: Qt.AlignVCenter
        //     visible: root.iconText !== ""
        // }

        Image {
            id: _icon
            source: "qrc:/custom/img/" + root.iconSource
            height: 24
            width: 24
        }

        // Text Label
        Text {
            id: textLabel
            text: root.text
            font.pixelSize: Styles.fontSize.base
            font.bold: true
            color: {
                if (isGlassmorphic) {
                    return isActive ? "#FFFFFF" : Qt.rgba(1, 1, 1, 0.8)
                }
                return isActive ? Styles.button.secondaryText : Styles.textPrimary
            }
            Layout.alignment: Qt.AlignVCenter
            Layout.fillWidth: true
        }

        // Active indicator (glass style)
        Rectangle {
            visible: isActive && isGlassmorphic
            width: 4
            height: parent.height * 0.5
            radius: 2
            gradient: Gradient {
                GradientStop { position: 0.0; color: Qt.rgba(1, 1, 1, 0.8) }
                GradientStop { position: 1.0; color: Qt.rgba(1, 1, 1, 0.4) }
            }
            Layout.alignment: Qt.AlignVCenter

            // Glow effect
            layer.enabled: true
            layer.effect: Glow {
                samples: 15
                color: "white"
                spread: 0.3
            }
        }

        // Active indicator (normal style)
        Rectangle {
            visible: isActive && !isGlassmorphic
            width: 4
            height: parent.height * 0.5
            color: Styles.secondary
            radius: 2
            Layout.alignment: Qt.AlignVCenter
        }
    }

    // Mouse interaction
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: root.isClickable
        cursorShape: root.isClickable ? Qt.PointingHandCursor : Qt.ArrowCursor
        enabled: root.isClickable

        onClicked: {
            if (root.isClickable) {
                root.clicked()
            }
        }
    }

    // Subtle shadow for glass buttons
    layer.enabled: isGlassmorphic
    layer.effect: DropShadow {
        color: Qt.rgba(0, 0, 0, isActive ? 0.3 : 0.15)
        radius: isActive ? 8 : 4
        samples: 17
        horizontalOffset: 0
        verticalOffset: 2
    }
}
