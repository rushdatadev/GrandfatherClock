import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.kcmutils as KCM

KCM.SimpleKCM {
    id: page

    property alias cfg_clockFace: faceCombo.currentValue
    property alias cfg_showSeconds: secondsCheck.checked

    Kirigami.FormLayout {
        QQC2.ComboBox {
            id: faceCombo
            Kirigami.FormData.label: i18n("Clock face:")
            textRole: "label"
            valueRole: "value"
            model: [
                { label: i18n("Big Ben — pre-restoration"),  value: "01-bigben-pre" },
                { label: i18n("Big Ben — post-restoration"), value: "02-bigben-post" },
                { label: i18n("Victorian ornate"),           value: "03-victorian" },
                { label: i18n("Minimal modern"),             value: "04-minimal" },
                { label: i18n("Art Deco"),                   value: "05-artdeco" },
                { label: i18n("Brutalist"),                  value: "06-brutalist" },
                { label: i18n("Skeuomorphic wood + brass"),  value: "07-wood-brass" },
                { label: i18n("Flat geometric"),             value: "08-flat" }
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

        ClockFace {
            Kirigami.FormData.label: i18n("Preview:")
            Layout.preferredWidth: Kirigami.Units.gridUnit * 12
            Layout.preferredHeight: Kirigami.Units.gridUnit * 12
            variant: faceCombo.currentValue
            showSeconds: secondsCheck.checked
            currentTime: previewClock.now

            Timer {
                id: previewClock
                property date now: new Date()
                interval: 1000
                running: true
                repeat: true
                triggeredOnStart: true
                onTriggered: now = new Date()
            }
        }
    }
}
