import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import Custom.Widgets
import "../CustomStyles.js" as Styles
// import QtGraphicalEffects

Rectangle {
    id: _root
    anchors.fill: parent
    visible: true
    color: Styles.background// background on left side

    RowLayout {
        anchors.fill: parent
        spacing: Styles.space.xl

        // LEFT SIDE: Login Form
        Item {
            Layout.preferredWidth: _root.width * 0.4
            Layout.fillHeight: true

            Column {
                width: parent.width
                spacing: Styles.space.md
                anchors {
                    left: parent.left
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                    margins: Styles.margin.xl
                }



                Text {
                    text: "Sign in to <b><font color='#1D3BFF'>DA GCS</font></b>"
                    font.pixelSize: Styles.fontSize.lg
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    width: parent.width
                }

                Text {
                    text: "Please enter your login details to start using the app."
                    color: Styles.textSecondary
                    font.pixelSize: Styles.fontSize.xs
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    width: parent.width
                }

                // Username field
                // TextField {
                //     id: usernameField
                //     placeholderText: "username/email"
                //     font.pixelSize: Styles.fontSize.base
                //     height: 22
                //     width: parent.width
                //     background: Rectangle {
                //         radius: Styles.radius.xs
                //         color: "white"
                //         border.color: "#C4C4C4"
                //     }
                // }

                // Password field
                // TextField {
                //     id: passwordField
                //     placeholderText: "password"
                //     echoMode: TextInput.Password
                //     font.pixelSize: Styles.fontSize.base
                //     height: 22
                //     width: parent.width
                //     background: Rectangle {
                //         radius: Styles.radius.xs
                //         color: "white"
                //         border.color: "#C4C4C4"
                //     }
                // }

                Column {
                    id: inputGroup
                    spacing: Styles.space.sm
                    width: parent.width

                    CInput {
                        id:user
                        placeholderText: "username/email"
                    }

                    CInput {
                        id:pass
                        placeholderText: "password"
                        isPassword: true
                    }
                }

                // Forgot Password Link
                Text {
                    text: "Forgot the password?"
                    color: Styles.accent
                    font.pixelSize: Styles.fontSize.xs
                    horizontalAlignment: Text.AlignHCenter
                    width: parent.width

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                    }
                }

                // Login Button
                // Button {
                //     text: "Login"
                //     font.pixelSize: Styles.fontSize.base
                //     height: 24
                //     width: parent.width
                //     background: Rectangle {
                //         radius: Styles.radius.xs
                //         color: "black"
                //     }
                //     contentItem: Text {
                //         text: parent.text
                //         color: "white"
                //         font.pixelSize: Styles.fontSize.base
                //         horizontalAlignment: Text.AlignHCenter
                //         verticalAlignment: Text.AlignVCenter
                //     }
                // }
                CButton {
                    text: "Login"; variant: "primary"
                    // loading: authManager.isLoading
                    onClicked: authManager.login(user.text, pass.text)
                }
            }
        }

        // RIGHT SIDE: Drone Image Background
        Item {
            Layout.preferredWidth: _root.width * 0.6
            Layout.fillHeight: true

            Image {
                anchors.fill: parent
                source: "qrc:/custom/img/login_bg.jpg" // Your drone image here
                fillMode: Image.PreserveAspectCrop
            }
        }
    }
}
