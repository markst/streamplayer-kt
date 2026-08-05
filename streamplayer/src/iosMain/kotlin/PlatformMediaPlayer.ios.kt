package dev.markturnip.streamplayer
import swiftPMImport.dev.markturnip.streamplayer.MediaPlayController
import swiftPMImport.dev.markturnip.streamplayer.StreamPlayerStateBuffering
import swiftPMImport.dev.markturnip.streamplayer.StreamPlayerStatePaused
import swiftPMImport.dev.markturnip.streamplayer.StreamPlayerStatePlaying
import swiftPMImport.dev.markturnip.streamplayer.StreamPlayerStateStopped
import kotlinx.cinterop.ExperimentalForeignApi

@OptIn(ExperimentalForeignApi::class)
actual class PlatformMediaPlayer actual constructor() : MediaPlayController() {
    actual fun playItem(mediaPlayerItem: MediaPlayerItem) {
        playWithUrl(mediaPlayerItem.url.toNSURL(), at = null)
    }

    actual fun subscribeState(callback: (PlaybackState) -> Unit) {
        subscribeStateWithCallback { state ->
            when (state) {
                StreamPlayerStatePaused -> callback(PlaybackState.PAUSED)
                StreamPlayerStatePlaying -> callback(PlaybackState.PLAYING)
                StreamPlayerStateStopped -> callback(PlaybackState.STOPPED)
                StreamPlayerStateBuffering -> callback(PlaybackState.BUFFERING)
                else -> {
                    callback(PlaybackState.STOPPED)
                }
            }
        }
    }

    actual fun subscribeProgress(callback: (Progress) -> Unit) {
        subscribeProgressWithCallback { elapsed, duration ->
            callback(Progress(elapsed, duration))
        }
    }
}
