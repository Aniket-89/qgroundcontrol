import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Custom.Widgets
import "qrc:/Custom/qml/CustomStyles.js" as Styles

Rectangle {
    id: root
    anchors.fill: parent
    color: "transparent"
    clip: true

    Image {
        id: bg
        source: "qrc:/custom/img/home_bg.png"
        anchors.fill: parent
    }
    signal flyNowClicked()

    property int marginSize: 0

    Row {
        anchors.fill: parent
        anchors.margins: 0
        spacing: marginSize * 2

        // ================= LEFT SIDEBAR =================
        HomeSideBar {
            id: sidebar
            width: parent.width * 0.2 - marginSize
            height: parent.height
            radius: 0

            // Handle navigation changes
            onNavigationChanged: function(page) {
                console.log("Navigated to:", page)
                // Update the stack layout based on selected page
                switch(page) {
                    case "flyNow":
                        contentStack.currentIndex = 0
                        break
                    case "missions":
                        contentStack.currentIndex = 1
                        break
                    case "media":
                        contentStack.currentIndex = 2
                        break
                    case "setup":
                        contentStack.currentIndex = 3
                        break
                }
            }
        }

        // ================= RIGHT PANEL (StackLayout) =================
        StackLayout {
            id: contentStack
            width: parent.width * 0.8 - marginSize
            height: parent.height
            currentIndex: 0

            // Index 0: Fly Now Panel
            FlyNowPanel {
                onFlyNowClicked: mainWindow.showFlyView()
            }

            // Index 1: Missions Panel
            MissionsPanel {
                // You can add signals/properties here
            }

            // Index 2: Media Panel
            MediaPanel {
                // You can add signals/properties here
            }

            // Index 3: Setup Panel
            SetupPanel {
                // You can add signals/properties here
            }
        }
    }
}
