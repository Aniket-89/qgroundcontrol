import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "qrc:/Custom/qml/CustomStyles.js" as Styles

Rectangle {
    id: sidebar
    width: parent.width * 0.3
    Layout.fillHeight: true
    color: Styles.surface

    property string activeButton: "flyNow"

    ColumnLayout {
        anchors.fill: parent
        spacing: Styles.space.md

        // Header with logo
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 32
            // color: Styles.surface

            Rectangle {
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.margins: Styles.margin.xs
                width: 32
                height: 32
                // color: Styles.secondary
                radius: Styles.radius.sm
                clip: true

                Image {
                    id: logoImage
                    source: "qrc:/custom/img/logo.png"
                    anchors.fill: parent
                }
            }
        }

        // Navigation Items
        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 0

            // Fly Now Button
            CNavButton {
                Layout.fillWidth: true
                text: "Fly Now"
                iconText: "▶"
                iconColor: "#666666"
                isActive: sidebar.activeButton === "flyNow"
                onClicked: {
                    sidebar.activeButton = "flyNow"
                    console.log("Fly Now clicked")
                }
            }

            // Missions
            CNavButton {
                Layout.fillWidth: true
                text: "Missions"
                iconText: "📊"
                iconColor: "#4CAF50"
                isActive: sidebar.activeButton === "missions"
                onClicked: {
                    sidebar.activeButton = "missions"
                    console.log("Missions clicked")
                }
            }

            // Media
            CNavButton {
                Layout.fillWidth: true
                text: "Media"
                iconText: "🖼"
                iconColor: "#FFA726"
                isActive: sidebar.activeButton === "media"
                onClicked: {
                    sidebar.activeButton = "media"
                    console.log("Media clicked")
                }
            }

            // Setup
            CNavButton {
                Layout.fillWidth: true
                text: "Setup"
                iconText: "🔧"
                iconColor: "#78909C"
                isActive: sidebar.activeButton === "setup"
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

            // Settings Button
            CNavButton {
                Layout.fillWidth: true
                text: ""
                iconText: "⚙"
                iconColor: "#666666"
                onClicked: console.log("Settings clicked")
            }
        }
    }

    signal navigationChanged(string page)

    onActiveButtonChanged: {
        navigationChanged(activeButton)
    }
}
