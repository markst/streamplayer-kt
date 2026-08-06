package dev.markturnip.streamplayer

import swiftPMImport.dev.markturnip.streamplayer.PlayerLayerView
import kotlinx.cinterop.ExperimentalForeignApi
import platform.UIKit.UIView

actual class VideoView(val platformView: UIView)

/**
 * Wraps a fresh `PlayerLayerView` bound to this player's `avPlayer`. The layer uses
 * `.resizeAspect` (letterboxed, no stretching) — unlike Android's `StreamPlayerVideoView`,
 * which stretches to fill its bounds. Callers relying on identical scaling across
 * platforms must account for this difference in the host layout.
 */
@OptIn(ExperimentalForeignApi::class)
actual fun PlatformMediaPlayer.videoView(): VideoView {
    val view = PlayerLayerView(player = avPlayer)
    return VideoView(view)
}
