import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Kirigami.FormLayout {
    id: page

    property alias cfg_chimeInterval: intervalCombo.currentValue
    property alias cfg_bellCount: bellCountCheck.checked
    property alias cfg_volume: volumeSlider.value
    property alias cfg_muted: muteCheck.checked

    QQC2.ComboBox {
        id: intervalCombo
        Kirigami.FormData.label: i18n("Chime interval:")
        textRole: "label"
        valueRole: "value"
        model: [
            { label: i18n("Hourly"), value: "hourly" },
            { label: i18n("Half-hourly"), value: "half" },
            { label: i18n("Quarterly (Westminster)"), value: "quarterly" }
        ]
        Component.onCompleted: {
            for (let i = 0; i < model.length; i++) {
                if (model[i].value === cfg_chimeInterval) {
                    currentIndex = i
                    break
                }
            }
        }
    }

    QQC2.CheckBox {
        id: bellCountCheck
        Kirigami.FormData.label: i18n("Bell count:")
        text: i18n("Toll the bell once per hour number (e.g. 3 tolls at 3 o'clock)")
    }

    RowLayout {
        Kirigami.FormData.label: i18n("Volume:")
        QQC2.Slider {
            id: volumeSlider
            from: 0.0
            to: 1.0
            stepSize: 0.05
            value: 0.7
            Layout.preferredWidth: Kirigami.Units.gridUnit * 12
        }
        QQC2.Label {
            text: Math.round(volumeSlider.value * 100) + "%"
        }
    }

    QQC2.CheckBox {
        id: muteCheck
        Kirigami.FormData.label: i18n("Mute:")
        text: i18n("Silence all chimes")
    }
}
