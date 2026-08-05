package dev.markturnip.streamplayer

import swiftPMImport.dev.markturnip.streamplayer.PlayerLayerView
import kotlinx.cinterop.ExperimentalForeignApi
import platform.UIKit.UIView

actual class VideoView(val platformView: UIView)

@OptIn(ExperimentalForeignApi::class)
actual fun PlatformMediaPlayer.videoView(): VideoView {
    val view = PlayerLayerView(player = avPlayer)
    return VideoView(view)
}
