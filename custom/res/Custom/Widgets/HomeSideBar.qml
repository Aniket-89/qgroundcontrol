import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "qrc:/Custom/qml/CustomStyles.js" as Styles

Rectangle {
    id: sidebar
    width: 220
    Layout.fillHeight: true
    color: Styles.border
    radius: 0
    border.color: Styles.border
    border.width: 1

    ColumnLayout {
        anchors.fill: parent
        spacing: Styles.spacing.xl
        // padding: 16

        // Logo
        Rectangle {
            id: logoBox
            width: parent.width
            height: 48
            radius: 8
            color: Styles.primary
            Layout.alignment: Qt.AlignLeft

            Text {
                anchors.centerIn: parent
                text: "DA\nGCS"
                color: "orange"
                font.bold: true
                font.pixelSize: 16
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }

        // Menu Items
        ColumnLayout {
            spacing: 16
            Layout.fillWidth: true

            // Fly Now (Selected)
            Rectangle {
                width: parent.width
                height: 40
                radius: 6
                color: "#C9C4A3"
                RowLayout {
                    anchors.fill: parent
                    spacing: 8
                    Image {
                        source: "qrc:/custom/img/play.png"
                        width: 8; height: 8
                        fillMode: Image.PreserveAspectfit
                    }
                    Text {
                        text: "Fly Now"
                        font.bold: true
                        color: Styles.textPrimary
                        verticalAlignment: Text.AlignVCenter
                        font.pixelSize: 16
                    }
                }
            }

            // Missions
            RowLayout {
                spacing: 8
                Layout.fillWidth: true
                Image {
                    source: "qrc:/custom/img/map.png"
                    width: 20; height: 20
                }
                Text {
                    text: "Missions"
                    color: Styles.textPrimary
                    font.pixelSize: 16
                }
            }

            // Media
            RowLayout {
                spacing: 8
                Layout.fillWidth: true
                Image {
                    source: "qrc:/custom/img/image.png"
                    width: 20; height: 20
                }
                Text {
                    text: "Media"
                    color: Styles.textPrimary
                    font.pixelSize: 16
                }
            }

            // Setup
            RowLayout {
                spacing: 8
                Layout.fillWidth: true
                Image {
                    source: "qrc:/custom/img/wrench.png"
                    width: 20; height: 20
                }
                Text {
                    text: "Setup"
                    color: Styles.textPrimary
                    font.pixelSize: 16
                }
            }
        }

        // Bottom Gear Icon
        Item {
            Layout.fillHeight: true
        }
        Image {
            source: "qrc:/custom/img/gear.png"
            width: 12
            height: 12
            opacity: 0.8
        }
    }
}
