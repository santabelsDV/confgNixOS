import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Quickshell

Window {
    id: root
    width: 420
    height: 220
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
            var c = { windowBg: "#11111b", windowFg: "#cdd6f4", accentBg: "#ff0000ff", headerBg: "#181825" };
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
        radius: 12 // Менший радіус як у буфера обміну
        color: Qt.alpha(themeColors.headerBg, 0.85)
        border.color: Qt.alpha(themeColors.windowFg, 0.1) // Тонка ледь помітна рамка
        border.width: 1

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 16
            spacing: 16

            // Верхня панель (Header)
            RowLayout {
                Layout.fillWidth: true
                
                Text {
                    text: "Home Assistant"
                    color: themeColors.windowFg
                    font.pixelSize: 16
                    font.bold: true
                    Layout.fillWidth: true
                }
                
                // Кнопка закриття як у буфері
                Rectangle {
                    id: btnClose
                    width: 28
                    height: 28
                    radius: 8
                    activeFocusOnTab: true
                    KeyNavigation.down: btnOn

                    color: activeFocus || mouseClose.containsMouse ? Qt.alpha(themeColors.windowFg, 0.15) : Qt.alpha(themeColors.windowFg, 0.05)
                    border.color: activeFocus ? themeColors.windowFg : "transparent"
                    border.width: activeFocus ? 1 : 0
                    
                    Text {
                        anchors.centerIn: parent
                        text: "✕"
                        color: themeColors.windowFg
                        font.pixelSize: 14
                    }
                    MouseArea {
                        id: mouseClose
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true
                        onClicked: Qt.quit()
                    }
                    Keys.onPressed: (event) => {
                        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter || event.key === Qt.Key_Space) {
                            Qt.quit()
                            event.accepted = true
                        }
                    }
                }
            }

            // Лінія-роздільник
            Rectangle {
                Layout.fillWidth: true
                height: 1
                color: Qt.alpha(themeColors.windowFg, 0.1)
            }

            // Кнопки Увімкнути / Вимкнути
            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 16

                Rectangle {
                    id: btnOn
                    width: 160
                    height: 40
                    radius: 8
                    activeFocusOnTab: true
                    focus: true // Ця кнопка у фокусі за замовчуванням
                    
                    KeyNavigation.right: btnOff
                    KeyNavigation.down: btnWeb
                    KeyNavigation.up: btnClose

                    color: activeFocus || mouseOn.containsMouse ? Qt.alpha(themeColors.accentBg, 0.25) : Qt.alpha(themeColors.accentBg, 0.15)
                    border.color: activeFocus ? themeColors.accentBg : Qt.alpha(themeColors.accentBg, 0.5)
                    border.width: activeFocus ? 2 : 1
                    
                    Text {
                        anchors.centerIn: parent
                        text: "Увімкнути"
                        color: themeColors.accentBg
                        font.pixelSize: 14
                        font.bold: true
                    }
                    MouseArea {
                        id: mouseOn
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true
                        onClicked: root.actionTurnOn()
                    }
                    Keys.onPressed: (event) => {
                        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter || event.key === Qt.Key_Space) {
                            root.actionTurnOn()
                            event.accepted = true
                        }
                    }
                }

                Rectangle {
                    id: btnOff
                    width: 160
                    height: 40
                    radius: 8
                    activeFocusOnTab: true
                    
                    KeyNavigation.left: btnOn
                    KeyNavigation.down: btnWeb
                    KeyNavigation.up: btnClose

                    color: activeFocus || mouseOff.containsMouse ? Qt.alpha("#f38ba8", 0.25) : Qt.alpha("#f38ba8", 0.15)
                    border.color: activeFocus ? "#f38ba8" : Qt.alpha("#f38ba8", 0.5)
                    border.width: activeFocus ? 2 : 1
                    
                    Text {
                        anchors.centerIn: parent
                        text: "Вимкнути"
                        color: "#f38ba8"
                        font.pixelSize: 14
                        font.bold: true
                    }
                    MouseArea {
                        id: mouseOff
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true
                        onClicked: root.actionTurnOff()
                    }
                    Keys.onPressed: (event) => {
                        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter || event.key === Qt.Key_Space) {
                            root.actionTurnOff()
                            event.accepted = true
                        }
                    }
                }
            }

            // Web UI
            Rectangle {
                id: btnWeb
                Layout.alignment: Qt.AlignHCenter
                width: 336
                height: 40
                radius: 8
                activeFocusOnTab: true
                
                KeyNavigation.up: btnOn
                
                color: activeFocus || mouseWeb.containsMouse ? Qt.darker(themeColors.accentBg, 1.1) : themeColors.accentBg
                border.color: themeColors.windowFg
                border.width: activeFocus ? 2 : 0
                
                Text {
                    anchors.centerIn: parent
                    text: "🌐 Відкрити Web-інтерфейс"
                    color: themeColors.windowBg
                    font.pixelSize: 14
                    font.bold: true
                }
                MouseArea {
                    id: mouseWeb
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    hoverEnabled: true
                    onClicked: root.actionWeb()
                }
                Keys.onPressed: (event) => {
                    if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter || event.key === Qt.Key_Space) {
                        root.actionWeb()
                        event.accepted = true
                    }
                }
            }
        }
    }

    function actionTurnOn() {
        Quickshell.execDetached(["sudo", "/run/current-system/sw/bin/systemctl", "start", "home-assistant.service"]);
        Quickshell.execDetached(["notify-send", "-t", "2000", "Home Assistant", "🟢 Сервіс УВІМКНЕНО"]);
        Qt.quit();
    }
    function actionTurnOff() {
        Quickshell.execDetached(["sudo", "/run/current-system/sw/bin/systemctl", "stop", "home-assistant.service"]);
        Quickshell.execDetached(["notify-send", "-t", "2000", "Home Assistant", "🔴 Сервіс ВИМКНЕНО"]);
        Qt.quit();
    }
    function actionWeb() {
        Quickshell.execDetached(["xdg-open", "http://localhost:8123"]);
        Qt.quit();
    }
