import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Quickshell

Window {
    id: root
    width: 400
    height: 260
    color: "transparent"
    visible: true
    title: "Display Scale"
    
    flags: Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint

    Shortcut {
        sequence: "Escape"
        onActivated: Qt.quit()
    }

    // Динамічно зчитуємо системну тему Noctalia
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

            // Секція масштабу
            Text {
                text: "🔍 Масштаб дисплея"
                color: themeColors.windowFg
                font.pixelSize: 18
                font.bold: true
                Layout.alignment: Qt.AlignHCenter
            }

            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 15

                Rectangle {
                    width: 90
                    height: 40
                    radius: 12
                    color: themeColors.accentBg
                    
                    Text {
                        anchors.centerIn: parent
                        text: "100%"
                        color: themeColors.windowBg
                        font.pixelSize: 15
                        font.bold: true
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            Quickshell.execDetached(["niri", "msg", "output", "eDP-1", "scale", "1.0"]);
                            Qt.quit();
                        }
                    }
                }

                Rectangle {
                    width: 90
                    height: 40
                    radius: 12
                    color: themeColors.accentBg
                    
                    Text {
                        anchors.centerIn: parent
                        text: "125%"
                        color: themeColors.windowBg
                        font.pixelSize: 15
                        font.bold: true
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            Quickshell.execDetached(["niri", "msg", "output", "eDP-1", "scale", "1.25"]);
                            Qt.quit();
                        }
                    }
                }

                Rectangle {
                    width: 90
                    height: 40
                    radius: 12
                    color: themeColors.accentBg
                    
                    Text {
                        anchors.centerIn: parent
                        text: "150%"
                        color: themeColors.windowBg
                        font.pixelSize: 15
                        font.bold: true
                    }

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

            // Секція герцовки
            Text {
                text: "⚡ Частота оновлення"
                color: themeColors.windowFg
                font.pixelSize: 18
                font.bold: true
                Layout.alignment: Qt.AlignHCenter
                Layout.topMargin: 5
            }

            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 15

                Rectangle {
                    width: 140
                    height: 40
                    radius: 12
                    color: themeColors.accentBg
                    
                    Text {
                        anchors.centerIn: parent
                        text: "60 Hz (Економія)"
                        color: themeColors.windowBg
                        font.pixelSize: 15
                        font.bold: true
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            Quickshell.execDetached(["niri", "msg", "output", "eDP-1", "mode", "2560x1600@60.000"]);
                            Quickshell.execDetached(["notify-send", "-a", "Дисплей", "-t", "2000", "🔄 Герцовка", "60 Hz"]);
                            Qt.quit();
                        }
                    }
                }

                Rectangle {
                    width: 140
                    height: 40
                    radius: 12
                    color: themeColors.accentBg
                    
                    Text {
                        anchors.centerIn: parent
                        text: "165 Hz (Геймінг)"
                        color: themeColors.windowBg
                        font.pixelSize: 15
                        font.bold: true
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            Quickshell.execDetached(["niri", "msg", "output", "eDP-1", "mode", "2560x1600@165.002"]);
                            Quickshell.execDetached(["notify-send", "-a", "Дисплей", "-t", "2000", "🔄 Герцовка", "165 Hz"]);
                            Qt.quit();
                        }
                    }
                }
            }
        }
        
        // Кнопка закриття
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