import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Quickshell

Window {
    id: root
    width: 300
    height: 100
    color: "#1e1e2e" // Темний фон
    visible: true

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 15
        spacing: 10

        Text {
            text: "Масштаб дисплея (eDP-1)"
            color: "white"
            font.pixelSize: 14
            font.bold: true
            Layout.alignment: Qt.AlignHCenter
        }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 10

            Button {
                text: "100%"
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        Quickshell.execDetached(["niri", "msg", "output", "eDP-1", "scale", "1.0"]);
                        Qt.quit();
                    }
                }
            }

            Button {
                text: "125%"
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        Quickshell.execDetached(["niri", "msg", "output", "eDP-1", "scale", "1.25"]);
                        Qt.quit();
                    }
                }
            }

            Button {
                text: "150%"
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        Quickshell.execDetached(["niri", "msg", "output", "eDP-1", "scale", "1.5"]);
                        Qt.quit();
                    }
                }
            }
        }
    }
}