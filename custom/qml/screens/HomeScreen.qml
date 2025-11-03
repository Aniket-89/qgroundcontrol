import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Custom.Widgets

Rectangle {
    id: root
    anchors.fill: parent
    color: "#FAF9F6" // dark background

    signal flyNowClicked()

    property int marginSize: 0

    Row {
        anchors.fill: parent
        anchors.margins: 0
        spacing: marginSize * 2

        // ================= LEFT SIDEBAR =================
        HomeSideBar {
            id: homeSideBar
            width: parent.width * 0.2 - marginSize
            height: parent.height
            radius: 0
        }

        // ================= RIGHT PANEL =================
        Rectangle {
            width: parent.width * 0.8 - marginSize
            height: parent.height
            radius: 0
            color: "#D9D8D1"

            Column {
                anchors.fill: parent
                anchors.margins: 10 * 2
                spacing: 20

                // Top Row (Battery, GPS, Signal, Last Connected)
                Row {
                    id: topStatusRow
                    width: parent.width
                    height: 30
                    spacing: 80  // increased spacing for clarity

                    RowLayout {
                        spacing: 8
                    // Battery
                    Row {
                        spacing: 4
                        width: implicitWidth
                        anchors.verticalCenter: parent.verticalCenter

                            Image { source: "qrc:/custom/img/battery.png"; width: 22; height: 22 }


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
                        width: implicitWidth
                        anchors.verticalCenter: parent.verticalCenter

                        Image { source: "qrc:/custom/img/gps.png"; width: 22; height: 22 }

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
                        width: implicitWidth
                        anchors.verticalCenter: parent.verticalCenter

                        Image { source: "qrc:/custom/img/wifi.png"; width: 22; height: 22 }

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
                }

                    // Spacer pushes "Last Connected" to right edge
                    Item {
                        Layout.fillWidth: true

                    }

                    // Last Connected
                    Column {
                        spacing: 2
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
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

                    Image {
                        source: "qrc:/custom/img/home_bg.png"
                        anchors.centerIn: parent
                        width: parent.width * 0.8
                        height: parent.height
                        fillMode: Image.PreserveAspectFit
                    }
                }

                // Bottom Section
                RowLayout {
                    width: parent.width
                    spacing: 20

                    // Rectangle {
                    //     width:
                    // Text {
                    //     text: "DA-P10pro"
                    //     font.bold: true
                    //     font.pixelSize: 32
                    //     color: "#000"
                    //     anchors.verticalCenter: parent.verticalCenter
                    //     Layout.alignment: Qt.AlignLeft
                    // }
                    // }
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

                    Item { width: parent.width - 400 } // spacer

                    Button {
                        topPadding: 10
                        bottomPadding: 10
                        leftPadding: 10 * 2.5
                        rightPadding: 10 * 2.5
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
    }
}
