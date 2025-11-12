import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: root
    color: "transparent"

    signal flyNowClicked()

    Column {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 20

        // Top Row (Battery, GPS, Signal, Last Connected)
        RowLayout {
            id: topStatusRow
            width: parent.width
            height: 30
            spacing: 8

            // Battery
            Row {
                spacing: 4
                anchors.verticalCenter: parent.verticalCenter

                Image {
                    source: "qrc:/custom/img/battery.png"
                    width: 22
                    height: 22
                }

                Column {
                    spacing: 0
                    Text {
                        text: "Battery"
                        font.pixelSize: 8
                        color: "#333"
                    }
                    Text {
                        text: "70%"
                        font.bold: true
                        font.pixelSize: 12
                    }
                }
            }

            // GPS
            Row {
                spacing: 4
                anchors.verticalCenter: parent.verticalCenter

                Image {
                    source: "qrc:/custom/img/gps.png"
                    width: 22
                    height: 22
                }

                Column {
                    spacing: 0
                    Text {
                        text: "GPS"
                        font.pixelSize: 8
                        color: "#333"
                    }
                    Text {
                        text: "14"
                        font.bold: true
                        font.pixelSize: 10
                    }
                }
            }

            // Signal
            Row {
                spacing: 4
                anchors.verticalCenter: parent.verticalCenter

                Image {
                    source: "qrc:/custom/img/wifi.png"
                    width: 22
                    height: 22
                }

                Column {
                    spacing: 0
                    Text {
                        text: "Signal"
                        font.pixelSize: 8
                        color: "#333"
                    }
                    Text {
                        text: "90%"
                        font.bold: true
                        font.pixelSize: 10
                    }
                }
            }

            // Spacer
            Item {
                Layout.fillWidth: true
            }

            // Last Connected
            Column {
                spacing: 2
                anchors.verticalCenter: parent.verticalCenter
                Text {
                    text: "Last Connected"
                    font.bold: true
                    font.pixelSize: 10
                    color: "#000"
                    horizontalAlignment: Text.AlignRight
                }
                Text {
                    text: "2h ago"
                    font.pixelSize: 14
                    font.bold: true
                    color: "#000"
                    horizontalAlignment: Text.AlignRight
                }
            }
        }

        // Drone Image Center
        Item {
            width: parent.width
            height: parent.height - 120

            // Image {
            //     source: "qrc:/custom/img/home_bg.png"
            //     anchors.centerIn: parent
            //     width: parent.width * 0.8
            //     height: parent.height
            //     fillMode: Image.PreserveAspectFit
            // }
        }

        // Bottom Section
        RowLayout {
            width: parent.width
            spacing: 20

            Label {
                text: "DA-P10pro"
                color: "black"
                background: Rectangle {
                    gradient: Gradient {
                        orientation: Gradient.Horizontal
                        GradientStop { position: 0.0; color: "#fff" }
                        GradientStop { position: 1.0; color: Qt.rgba(1, 1, 1, 0.1) }
                    }
                    radius: 2
                }
                padding: 6
                font.pixelSize: 24
                font.bold: true
                Layout.alignment: Qt.AlignLeft
            }

            Item { Layout.fillWidth: true } // spacer

            Button {
                topPadding: 10
                bottomPadding: 10
                leftPadding: 25
                rightPadding: 25
                height: 40
                Layout.alignment: Qt.AlignRight

                background: Rectangle {
                    radius: 2
                    color: "#1E90FF"
                }

                contentItem: Text {
                    text: "Fly Now"
                    color: "white"
                    font.bold: true
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: root.flyNowClicked()
            }
        }
    }
}
