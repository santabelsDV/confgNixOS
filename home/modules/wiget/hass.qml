import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Quickshell

Window {
    id: root
    width: 380
    height: 240
    color: "transparent"
    visible: true
    title: "Home Assistant"

    flags: Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint

    Shortcut {
        sequence: "Escape"
        onActivated: Qt.quit()
    }

    property var themeColors: {
        var xhr = new XMLHttpRequest();
        xhr.open("GET", "file:///home/sasha/.config/gtk-3.0/noctalia.css", false);
        try {
            xhr.send();
            var css = xhr.responseText;
            var c = { windowBg: "#11111b", windowFg: "#cdd6f4", accentBg: "#38b259", headerBg: "#181825" };
            if (css) {
                var m;
                m = css.match(/@define-color window_bg_color\s+(#[0-9a-fA-F]+);/);
                if (m) c.windowBg = m[1];
                m = css.match(/@define-color window_fg_color\s+(#[0-9a-fA-F]+);/);
                if (m) c.windowFg = m[1];
                m = css.match(/@define-color accent_bg_color\s+(#[0-9a-fA-F]+);/);
                if (m) c.accentBg = m[1];
                m = css.match(/@define-color headerbar_bg_color\s+(#[0-9a-fA-F]+);/);
                if (m) c.headerBg = m[1];
            }
            return c;
        } catch (e) {
            return { windowBg: "#11111b", windowFg: "#cdd6f4", accentBg: "#38b259", headerBg: "#181825" };
        }
    }

    Rectangle {
        anchors.fill: parent
        radius: 20
        color: Qt.alpha(themeColors.headerBg, 0.8) // Напівпрозорий фон (80% непрозорості)
        border.color: themeColors.accentBg
        border.width: 2

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 25
            spacing: 20

            Text {
                text: "🏠 Сервіс Home Assistant"
                color: themeColors.windowFg
                font.pixelSize: 18
                font.bold: true
                Layout.alignment: Qt.AlignHCenter
            }

            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 20

                Rectangle {
                    width: 140
                    height: 45
                    radius: 12
                    color: "#a6e3a1"
                    
                    Text {
                        anchors.centerIn: parent
                        text: "Увімкнути"
                        color: "#11111b"
                        font.pixelSize: 15
                        font.bold: true
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            Quickshell.execDetached(["sudo", "/run/current-system/sw/bin/systemctl", "start", "home-assistant.service"]);
                            Quickshell.execDetached(["notify-send", "-t", "2000", "Home Assistant", "🟢 Сервіс УВІМКНЕНО"]);
                            Qt.quit();
                        }
                    }
                }

                Rectangle {
                    width: 140
                    height: 45
                    radius: 12
                    color: "#f38ba8"
                    
                    Text {
                        anchors.centerIn: parent
                        text: "Вимкнути"
                        color: "#11111b"
                        font.pixelSize: 15
                        font.bold: true
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            Quickshell.execDetached(["sudo", "/run/current-system/sw/bin/systemctl", "stop", "home-assistant.service"]);
                            Quickshell.execDetached(["notify-send", "-t", "2000", "Home Assistant", "🔴 Сервіс ВИМКНЕНО"]);
                            Qt.quit();
                        }
                    }
                }
            }

            // Кнопка відкриття Web-інтерфейсу
            Rectangle {
                Layout.alignment: Qt.AlignHCenter
                width: 300
                height: 45
                radius: 12
                color: themeColors.accentBg
                
                Text {
                    anchors.centerIn: parent
                    text: "🌐 Відкрити Web-інтерфейс"
                    color: themeColors.windowBg
                    font.pixelSize: 15
                    font.bold: true
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        Quickshell.execDetached(["xdg-open", "http://localhost:8123"]);
                        Qt.quit();
                    }
                }
            }
        }
        
        Rectangle {
            width: 24
            height: 24
            radius: 12
            color: themeColors.windowBg
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.margins: 12
            
            Text {
                anchors.centerIn: parent
                text: "✕"
                color: themeColors.windowFg
                font.bold: true
                font.pixelSize: 12
            }
            
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: Qt.quit()
            }
        }
    }
}
