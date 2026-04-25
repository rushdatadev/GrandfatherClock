import QtQuick
import org.kde.plasma.configuration

ConfigModel {
    ConfigCategory {
        name: i18n("General")
        icon: "configure"
        source: "../ui/ConfigGeneral.qml"
    }
    ConfigCategory {
        name: i18n("Chimes")
        icon: "audio-volume-high"
        source: "../ui/ConfigChimes.qml"
    }
    ConfigCategory {
        name: i18n("Appearance")
        icon: "preferences-desktop-theme"
        source: "../ui/ConfigAppearance.qml"
    }
}
