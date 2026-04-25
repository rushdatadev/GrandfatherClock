import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Kirigami.FormLayout {
    id: page

    property alias cfg_clockFace: faceCombo.currentValue
    property alias cfg_showSeconds: secondsCheck.checked

    QQC2.ComboBox {
        id: faceCombo
        Kirigami.FormData.label: i18n("Clock face:")
        textRole: "label"
        valueRole: "value"
        model: [
            { label: i18n("Default (vector)"), value: "default" }
        ]
        Component.onCompleted: {
            for (let i = 0; i < model.length; i++) {
                if (model[i].value === cfg_clockFace) {
                    currentIndex = i
                    break
                }
            }
        }
    }

    QQC2.CheckBox {
        id: secondsCheck
        Kirigami.FormData.label: i18n("Second hand:")
        text: i18n("Show the second hand")
    }

    QQC2.Label {
        Kirigami.FormData.label: i18n("Note:")
        text: i18n("Additional clock face styles will be added once reference photos are integrated.")
        wrapMode: Text.Wrap
        Layout.preferredWidth: Kirigami.Units.gridUnit * 20
    }
}
