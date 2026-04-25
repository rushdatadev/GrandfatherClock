import QtQuick
import QtMultimedia

Item {
    id: engine

    property real volume: 0.7
    property string chimeInterval: "hourly"
    property bool bellCount: true
    property string hourChime: "Grandfather"
    property string quarterChimeSet: "Westminister"

    readonly property url soundsDir: Qt.resolvedUrl("../sounds/")

    property var queue: []
    property int lastChimedMinute: -1

    AudioOutput {
        id: audioOut
        volume: engine.volume
    }

    MediaPlayer {
        id: player
        audioOutput: audioOut
        onPlaybackStateChanged: {
            if (playbackState === MediaPlayer.StoppedState && engine.queue.length > 0) {
                engine.playNext()
            }
        }
        onErrorOccurred: (error, errorString) => {
            console.warn("ChimeEngine playback error:", error, errorString, "for", source)
        }
    }

    function _resolve(name) {
        return soundsDir + name + ".au"
    }

    function playNext() {
        if (queue.length === 0) return
        const next = queue.shift()
        player.source = next
        player.play()
    }

    function _enqueue(name) {
        queue.push(_resolve(name))
        if (player.playbackState !== MediaPlayer.PlayingState) {
            playNext()
        }
    }

    function previewHourly(hour) {
        // Simulate the on-the-hour chime for testing in config UI.
        if (chimeInterval === "quarterly") {
            _enqueue(quarterChimeSet + "4")
        }
        const tolls = bellCount ? ((hour % 12) || 12) : 1
        for (let i = 0; i < tolls; i++) {
            _enqueue(hourChime)
        }
    }

    function previewQuarter(which) {
        // which: 1, 2, or 3
        _enqueue(quarterChimeSet + which)
    }

    function tick(now) {
        const hour = now.getHours()
        const minute = now.getMinutes()
        const second = now.getSeconds()

        if (second !== 0) return
        if (minute === lastChimedMinute) return
        lastChimedMinute = minute

        if (minute === 0) {
            if (chimeInterval === "quarterly") {
                _enqueue(quarterChimeSet + "4")
            }
            const tolls = bellCount ? ((hour % 12) || 12) : 1
            for (let i = 0; i < tolls; i++) {
                _enqueue(hourChime)
            }
        } else if (minute === 30 && (chimeInterval === "half" || chimeInterval === "quarterly")) {
            _enqueue(quarterChimeSet + "2")
        } else if (minute === 15 && chimeInterval === "quarterly") {
            _enqueue(quarterChimeSet + "1")
        } else if (minute === 45 && chimeInterval === "quarterly") {
            _enqueue(quarterChimeSet + "3")
        }
    }
}
