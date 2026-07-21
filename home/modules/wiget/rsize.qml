import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Quickshell

Window {
    id: root
    width: 420
    height: 250
    color: "transparent"
    visible: true
    title: "Display Scale"
    
    flags: Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint

    onActiveChanged: {
        if (!active) {
            Qt.quit()
        }
    }

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
        radius: 12
        color: Qt.alpha(themeColors.headerBg, 0.85)
        border.color: Qt.alpha(themeColors.windowFg, 0.1)
        border.width: 1

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 16
            spacing: 12

            // Верхня панель (Header)
            RowLayout {
                Layout.fillWidth: true
                
                Text {
                    text: "Налаштування дисплея"
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
                    KeyNavigation.down: btn100
                    
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

            // Секція масштабу
            Text {
                text: "Масштаб (eDP-1)"
                color: Qt.alpha(themeColors.windowFg, 0.7)
                font.pixelSize: 13
                Layout.topMargin: 4
            }

            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 12

                Rectangle {
                    id: btn100
                    width: 104
                    height: 36
                    radius: 8
                    activeFocusOnTab: true
                    focus: true
                    KeyNavigation.right: btn125
                    KeyNavigation.down: btn60
                    KeyNavigation.up: btnClose

                    color: activeFocus || mouse100.containsMouse ? Qt.alpha(themeColors.accentBg, 0.25) : Qt.alpha(themeColors.accentBg, 0.15)
                    border.color: activeFocus ? themeColors.accentBg : Qt.alpha(themeColors.accentBg, 0.5)
                    border.width: activeFocus ? 2 : 1
                    
                    Text {
                        anchors.centerIn: parent
                        text: "100%"
                        color: themeColors.accentBg
                        font.pixelSize: 14
                        font.bold: true
                    }
                    MouseArea {
                        id: mouse100
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true
                        onClicked: root.actionSetScale("1.0")
                    }
                    Keys.onPressed: (event) => {
                        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter || event.key === Qt.Key_Space) {
                            root.actionSetScale("1.0")
                            event.accepted = true
                        }
                    }
                }

                Rectangle {
                    id: btn125
                    width: 104
                    height: 36
                    radius: 8
                    activeFocusOnTab: true
                    KeyNavigation.left: btn100
                    KeyNavigation.right: btn150
                    KeyNavigation.down: btn165
                    KeyNavigation.up: btnClose

                    color: activeFocus || mouse125.containsMouse ? Qt.alpha(themeColors.accentBg, 0.25) : Qt.alpha(themeColors.accentBg, 0.15)
                    border.color: activeFocus ? themeColors.accentBg : Qt.alpha(themeColors.accentBg, 0.5)
                    border.width: activeFocus ? 2 : 1
                    
                    Text {
                        anchors.centerIn: parent
                        text: "125%"
                        color: themeColors.accentBg
                        font.pixelSize: 14
                        font.bold: true
                    }
                    MouseArea {
                        id: mouse125
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true
                        onClicked: root.actionSetScale("1.25")
                    }
                    Keys.onPressed: (event) => {
                        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter || event.key === Qt.Key_Space) {
                            root.actionSetScale("1.25")
                            event.accepted = true
                        }
                    }
                }

                Rectangle {
                    id: btn150
                    width: 104
                    height: 36
                    radius: 8
                    activeFocusOnTab: true
                    KeyNavigation.left: btn125
                    KeyNavigation.down: btn165
                    KeyNavigation.up: btnClose

                    color: activeFocus || mouse150.containsMouse ? Qt.alpha(themeColors.accentBg, 0.25) : Qt.alpha(themeColors.accentBg, 0.15)
                    border.color: activeFocus ? themeColors.accentBg : Qt.alpha(themeColors.accentBg, 0.5)
                    border.width: activeFocus ? 2 : 1
                    
                    Text {
                        anchors.centerIn: parent
                        text: "150%"
                        color: themeColors.accentBg
                        font.pixelSize: 14
                        font.bold: true
                    }
                    MouseArea {
                        id: mouse150
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true
                        onClicked: root.actionSetScale("1.5")
                    }
                    Keys.onPressed: (event) => {
                        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter || event.key === Qt.Key_Space) {
                            root.actionSetScale("1.5")
                            event.accepted = true
                        }
                    }
                }
            }

            // Секція герцовки
            Text {
                text: "Частота оновлення"
                color: Qt.alpha(themeColors.windowFg, 0.7)
                font.pixelSize: 13
                Layout.topMargin: 8
            }

            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 12

                Rectangle {
                    id: btn60
                    width: 162
                    height: 36
                    radius: 8
                    activeFocusOnTab: true
                    KeyNavigation.right: btn165
                    KeyNavigation.up: btn100

                    color: activeFocus || mouse60.containsMouse ? Qt.alpha(themeColors.accentBg, 0.25) : Qt.alpha(themeColors.accentBg, 0.15)
                    border.color: activeFocus ? themeColors.accentBg : Qt.alpha(themeColors.accentBg, 0.5)
                    border.width: activeFocus ? 2 : 1
                    
                    Text {
                        anchors.centerIn: parent
                        text: "60 Hz (Економія)"
                        color: themeColors.accentBg
                        font.pixelSize: 14
                        font.bold: true
                    }
                    MouseArea {
                        id: mouse60
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true
                        onClicked: root.actionSetHz("60", "2560x1600@60.000")
                    }
                    Keys.onPressed: (event) => {
                        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter || event.key === Qt.Key_Space) {
                            root.actionSetHz("60", "2560x1600@60.000")
                            event.accepted = true
                        }
                    }
                }

                Rectangle {
                    id: btn165
                    width: 162
                    height: 36
                    radius: 8
                    activeFocusOnTab: true
                    KeyNavigation.left: btn60
                    KeyNavigation.up: btn150

                    color: activeFocus || mouse165.containsMouse ? Qt.alpha(themeColors.accentBg, 0.25) : Qt.alpha(themeColors.accentBg, 0.15)
                    border.color: activeFocus ? themeColors.accentBg : Qt.alpha(themeColors.accentBg, 0.5)
                    border.width: activeFocus ? 2 : 1
                    
                    Text {
                        anchors.centerIn: parent
                        text: "165 Hz (Геймінг)"
                        color: themeColors.accentBg
                        font.pixelSize: 14
                        font.bold: true
                    }
                    MouseArea {
                        id: mouse165
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true
                        onClicked: root.actionSetHz("165", "2560x1600@165.002")
                    }
                    Keys.onPressed: (event) => {
                        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter || event.key === Qt.Key_Space) {
                            root.actionSetHz("165", "2560x1600@165.002")
                            event.accepted = true
                        }
                    }
                }
            }
        }
    }

    function actionSetScale(scale) {
        Quickshell.execDetached(["niri", "msg", "output", "eDP-1", "scale", scale]);
        Qt.quit();
    }
    
    function actionSetHz(label, mode) {
        Quickshell.execDetached(["niri", "msg", "output", "eDP-1", "mode", mode]);
        Quickshell.execDetached(["notify-send", "-a", "Дисплей", "-t", "2000", "🔄 Герцовка", label + " Hz"]);
        Qt.quit();
    }
}