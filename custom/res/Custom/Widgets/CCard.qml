import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Qt5Compat.GraphicalEffects
import "qrc:/Custom/qml/CustomStyles.js" as Styles

Rectangle {
    id: root

    // Public properties
    property string title: "Mission 1"
    property string dateTime: "12-11-2024"
    property string imageSource: ""
    property bool enableHover: true
    property bool enableShadow: true
    property color cardColor: Styles.surface
    property real cardRadius: Styles.radius.md

    // Signals
    signal clicked()
    signal imageClicked()

    // Fixed styling for mobile grid layout
    implicitWidth: 200
    implicitHeight: 240
    color: cardColor
    radius: cardRadius

    // Card shadow
    layer.enabled: enableShadow
    layer.effect: DropShadow {
        color: Qt.rgba(0, 0, 0, 0.15)
        radius: 8
        samples: 17
        horizontalOffset: 0
        verticalOffset: 4
    }

    // Vertical layout: Image 70% top, Info 30% bottom
    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        // Image section - 70% of card height
        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: root.height * 0.7
            clip: true

            Rectangle {
                anchors.fill: parent
                color: Styles.border

                Image {
                    id: cardImage
                    anchors.fill: parent
                    source: root.imageSource
                    fillMode: Image.PreserveAspectCrop

                    // Loading placeholder
                    Rectangle {
                        anchors.fill: parent
                        visible: parent.status !== Image.Ready && root.imageSource !== ""
                        color: Styles.border

                        Text {
                            anchors.centerIn: parent
                            text: "📷"
                            font.pixelSize: 36
                            color: Styles.textSecondary
                        }
                    }

                    // Default placeholder pattern when no image
                    Grid {
                        visible: root.imageSource === ""
                        anchors.centerIn: parent
                        columns: 5
                        rows: 5
                        spacing: 2

                        Repeater {
                            model: 25
                            Rectangle {
                                width: 24
                                height: 24
                                color: index % 3 === 0 ?
                                       Qt.darker(Styles.border, 1.1) :
                                       Styles.border
                                radius: 2
                            }
                        }
                    }
                }

                // Image overlay on hover
                Rectangle {
                    anchors.fill: parent
                    color: Qt.rgba(0, 0, 0, 0.3)
                    opacity: imageMouseArea.containsMouse ? 1 : 0

                    Behavior on opacity {
                        NumberAnimation { duration: 150 }
                    }

                    Text {
                        anchors.centerIn: parent
                        text: "🔍"
                        font.pixelSize: 32
                        opacity: parent.opacity
                    }
                }

                MouseArea {
                    id: imageMouseArea
                    anchors.fill: parent
                    hoverEnabled: root.enableHover
                    cursorShape: Qt.PointingHandCursor
                    onClicked: root.imageClicked()
                }
            }
        }

        // Info section - 30% of card height
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: root.cardColor

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: Styles.margin.sm
                spacing: Styles.space.xs

                // Mission name
                Text {
                    text: root.title
                    font.pixelSize: Styles.fontSize.md
                    font.bold: true
                    color: Styles.textPrimary
                    Layout.fillWidth: true
                    elide: Text.ElideRight
                    maximumLineCount: 1
                    horizontalAlignment: Text.AlignLeft
                }

                // Date/Time
                Text {
                    text: root.dateTime
                    font.pixelSize: Styles.fontSize.xs
                    color: Styles.textSecondary
                    Layout.fillWidth: true
                    elide: Text.ElideRight
                    maximumLineCount: 1
                    horizontalAlignment: Text.AlignLeft
                }
            }
        }
    }

    // Hover effect
    states: [
        State {
            name: "hovered"
            when: cardMouseArea.containsMouse && root.enableHover
            PropertyChanges {
                target: root
                scale: 1.03
            }
        },
        State {
            name: "pressed"
            when: cardMouseArea.pressed
            PropertyChanges {
                target: root
                scale: 0.97
            }
        }
    ]

    transitions: Transition {
        NumberAnimation {
            properties: "scale"
            duration: 150
            easing.type: Easing.OutCubic
        }
    }

    // Card click area
    MouseArea {
        id: cardMouseArea
        anchors.fill: parent
        hoverEnabled: root.enableHover
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
    }
}
