import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "qrc:/Custom/qml/CustomStyles.js" as Styles

Rectangle {
    id: root
    color: "#3A3A3A"

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 20

        // Header Row
        RowLayout {
            Layout.fillWidth: true
            spacing: 20

            Text {
                text: "Saved Missions"
                font.pixelSize: 32
                font.bold: true
                color: "#FFFFFF"
                Layout.fillWidth: true
            }

            // Action buttons
            CButton {
                Layout.preferredWidth: 140
                Layout.preferredHeight: 50
                text: "Load File"
                variant: "outlined"
                onClicked: {
                    console.log("Load File clicked")
                }
            }

            CButton {
                Layout.preferredWidth: 140
                Layout.preferredHeight: 50
                text: "New"
                variant: "primary"
                onClicked: {
                    console.log("New mission clicked")
                }
            }
        }

        // Missions Grid - 3 cards per row with scrolling
        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true

            GridLayout {
                width: parent.width
                columns: 3
                columnSpacing: 16
                rowSpacing: 16

                Repeater {
                    model: 12  // Example: 12 missions (4 rows × 3 columns)

                    CCard {
                        Layout.preferredWidth: (parent.width - 32) / 3  // Divide by 3, subtract spacing
                        Layout.preferredHeight: 240
                        title: "Mission " + (index + 1)
                        dateTime: "12-11-2024"
                        imageSource: index % 2 === 0 ? "qrc:/custom/img/mission_preview.png" : ""

                        onClicked: {
                            console.log("Mission clicked:", index + 1)
                        }

                        onImageClicked: {
                            console.log("Image clicked for Mission:", index + 1)
                        }
                    }
                }
            }
        }
    }
}
