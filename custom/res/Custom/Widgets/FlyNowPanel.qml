import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QGroundControl
import QGroundControl.Controls
import QGroundControl.FactControls

Rectangle {
    id: root
    color: "transparent"

    property var    activeVehicle:      QGroundControl.multiVehicleManager.activeVehicle
    property string na:                 qsTr("N/A")

    signal flyNowClicked()

    // Helper to convert RSSI-like values to percent
    function rssiToPercent(val) {
        if (val === undefined || val === null) return NaN;
        // PX4/ArduPilot RC RSSI sometimes use 255 as "unknown"
        if (val === 255) return NaN;
        // If already in 0..100 range, treat as percent
        if (val >= 0 && val <= 100) {
            return Math.round(val);
        }
        // Otherwise assume 0..255 scale and map to 0..100
        if (val > 100 && val <= 255) {
            return Math.round((val / 255.0) * 100.0);
        }
        // other values treat as NaN
        return NaN;
    }

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
                        font.bold: true
                        font.pixelSize: 12
                        text: {
                            if (!activeVehicle) return na;

                            // activeVehicle.batteries is a QmlObjectListModel of BatteryFactGroup
                            if (activeVehicle.batteries && activeVehicle.batteries.count > 0) {
                                var b = activeVehicle.batteries.get(0)
                                var pct = (b && b.percentRemaining) ? b.percentRemaining.value : NaN
                                return (isNaN(pct) ? na : (Math.round(pct) + "%"))
                            }
                            return na;
                        }
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
                        font.bold: true
                        font.pixelSize: 10
                        text: {
                            if (!activeVehicle || !activeVehicle.gps) return na;
                            // use the count fact's string form if available
                            var countFact = activeVehicle.gps.count
                            if (countFact) {
                                // valueString is often nicely formatted; fallback to numeric value
                                return countFact.valueString ? countFact.valueString : (isNaN(countFact.value) ? na : String(countFact.value))
                            }
                            return na;
                        }
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
                        font.bold: true
                        font.pixelSize: 10
                        text: {
                            if (!activeVehicle) return na;

                            // Prefer RC RSSI if available, else telemetry RSSI
                            var rc = activeVehicle.rcRSSI !== undefined ? activeVehicle.rcRSSI : undefined
                            var telem = activeVehicle.telemetryRRSSI !== undefined ? activeVehicle.telemetryRRSSI : undefined

                            var rcPct = rssiToPercent(rc)
                            var telemPct = rssiToPercent(telem)

                            var displayPct = !isNaN(rcPct) ? rcPct : (!isNaN(telemPct) ? telemPct : NaN)

                            return isNaN(displayPct) ? na : (displayPct + "%")
                        }

                        // optional tooltip to show raw values
                        ToolTip.visible: hovered
                        ToolTip.text: {
                            if (!activeVehicle) return ""
                            var rc = activeVehicle.rcRSSI
                            var telem = activeVehicle.telemetryRRSSI
                            return "RC RSSI: " + (rc === undefined ? "N/A" : rc) + "\nTelemetry RSSI: " + (telem === undefined ? "N/A" : telem)
                        }
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
