import QtQuick
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore
import org.kde.kirigami as Kirigami

PlasmoidItem {
    id: root

    property date currentTime: new Date()

    Plasmoid.backgroundHints: PlasmaCore.Types.NoBackground

    Timer {
        id: tickTimer
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            const now = new Date()
            root.currentTime = now
            chimeEngine.tick(now)
        }
    }

    ChimeEngine {
        id: chimeEngine
        volume: Plasmoid.configuration.muted ? 0 : Plasmoid.configuration.volume
        chimeInterval: Plasmoid.configuration.chimeInterval
        bellCount: Plasmoid.configuration.bellCount
        hourChime: Plasmoid.configuration.hourChime
        quarterChimeSet: Plasmoid.configuration.quarterChimeSet
    }

    compactRepresentation: ClockFace {
        currentTime: root.currentTime
        showSeconds: Plasmoid.configuration.showSeconds
        Layout.minimumWidth: Kirigami.Units.gridUnit * 4
        Layout.minimumHeight: Kirigami.Units.gridUnit * 4
        MouseArea {
            anchors.fill: parent
            onClicked: root.expanded = !root.expanded
        }
    }

    fullRepresentation: FullRepresentation {
        currentTime: root.currentTime
        chimeEngine: chimeEngine
    }

    Plasmoid.toolTipMainText: i18n("Grandfather Clock")
    Plasmoid.toolTipSubText: Qt.formatTime(currentTime, "h:mm AP")
}
