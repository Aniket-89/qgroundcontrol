import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Qt5Compat.GraphicalEffects
import "qrc:/Custom/qml/CustomStyles.js" as Styles
import Custom.Widgets

Rectangle {
    id: sidebar
    width: parent.width * 0.3
    Layout.fillHeight: true

    // Glassmorphic background
    color: Qt.rgba(0, 0, 0, 0.5)
    border.width: 1
    border.color: Qt.rgba(0, 0, 0, 0.58)

    property string activeButton: "flyNow"

    // Top highlight for glass effect
    Rectangle {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 1
        height: parent.height * 0.3
        gradient: Gradient {
            GradientStop { position: 0.0; color: Qt.rgba(0, 0, 0, 0.12) }
            GradientStop { position: 1.0; color: "transparent" }
        }
    }

    // Inner border for definition
    Rectangle {
        anchors.fill: parent
        anchors.margins: 1
        color: "transparent"
        border.width: 1
        border.color: Qt.rgba(1, 1, 1, 0.08)
    }

    // Drop shadow for depth
    layer.enabled: true
    layer.effect: DropShadow {
        color: Qt.rgba(0, 0, 0, 0.3)
        radius: 16
        samples: 33
        horizontalOffset: 4
        verticalOffset: 0
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: Styles.space.md
        spacing: Styles.space.md

        // Header with logo - Glass container
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 42
            // color: Qt.rgba(1, 1, 1, 0.05)
            color: 'transparent'
            // border.width: 1
            // border.color: Qt.rgba(1, 1, 1, 0.15)
            radius: Styles.radius.md

            // Top highlight
            // Rectangle {
            //     anchors.top: parent.top
            //     anchors.left: parent.left
            //     anchors.right: parent.right
            //     anchors.margins: 1
            //     height: parent.height * 0.5
            //     radius: parent.radius
            //     gradient: Gradient {
            //         GradientStop { position: 0.0; color: Qt.rgba(1, 1, 1, 0.1) }
            //         GradientStop { position: 1.0; color: "transparent" }
            //     }
            // }

            Rectangle {
                // anchors.centerIn: parent
                width: 42
                height: 42
                color: Qt.rgba(1, 1, 1, 0.1)
                border.width: 1
                border.color: Qt.rgba(1, 1, 1, 0.2)
                radius: Styles.radius.md
                clip: true

                // // Glass highlight on logo container
                // Rectangle {
                //     anchors.top: parent.top
                //     anchors.left: parent.left
                //     anchors.right: parent.right
                //     anchors.margins: 1
                //     height: parent.height * 0.4
                //     radius: parent.radius
                //     gradient: Gradient {
                //         GradientStop { position: 0.0; color: Qt.rgba(1, 1, 1, 0.15) }
                //         GradientStop { position: 1.0; color: "transparent" }
                //     }
                // }

                Image {
                    id: logoImage
                    source: "qrc:/custom/img/logo.png"
                    anchors.fill: parent
                    anchors.margins: 4
                    fillMode: Image.PreserveAspectFit
                }
            }
        }

        // Navigation Items
        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: Styles.space.sm

            // Fly Now Button
            CNavButton {
                Layout.fillWidth: true
                text: "Fly Now"
                iconSource: "play.png"
                iconColor: "#666666"
                isActive: sidebar.activeButton === "flyNow"
                isGlassmorphic: true
                onClicked: {
                    sidebar.activeButton = "flyNow"
                    console.log("Fly Now clicked")
                }
            }

            // Missions
            CNavButton {
                Layout.fillWidth: true
                text: "Missions"
                iconSource: "map.png"
                iconColor: "#4CAF50"
                isActive: sidebar.activeButton === "missions"
                isGlassmorphic: true
                onClicked: {
                    sidebar.activeButton = "missions"
                    console.log("Missions clicked")
                }
            }

            // Media
            CNavButton {
                Layout.fillWidth: true
                text: "Media"
                iconSource: "image.png"
                iconColor: "#FFA726"
                isActive: sidebar.activeButton === "media"
                isGlassmorphic: true
                onClicked: {
                    sidebar.activeButton = "media"
                    console.log("Media clicked")
                }
            }

            // Setup
            CNavButton {
                Layout.fillWidth: true
                text: "Setup"
                iconSource: "wrench.png"
                iconColor: "#78909C"
                isActive: sidebar.activeButton === "setup"
                isGlassmorphic: true
                onClicked: {
                    sidebar.activeButton = "setup"
                    console.log("Setup clicked")
                }
            }

            // Spacer
            Item {
                Layout.fillHeight: true
                Layout.fillWidth: true
            }

            // Divider line with glass effect
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 1
                Layout.margins: Styles.margin.md
                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop { position: 0.0; color: "transparent" }
                    GradientStop { position: 0.5; color: Qt.rgba(1, 1, 1, 0.2) }
                    GradientStop { position: 1.0; color: "transparent" }
                }
            }

            // Settings Button
            CNavButton {
                Layout.fillWidth: true
                text: "Settings"
                iconSource: "gear.png"
                iconColor: "#78909C"
                // isActive: sidebar.activeButton === "setup"
                isGlassmorphic: true
                onClicked: {
                    // sidebar.activeButton = "setup"
                    console.log("Settings clicked")
                    mainWindow.showSettingsTool()
                }
            }
        }
    }

    signal navigationChanged(string page)

    onActiveButtonChanged: {
        navigationChanged(activeButton)
    }
}
