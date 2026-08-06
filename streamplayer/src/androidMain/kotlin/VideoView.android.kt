package dev.markturnip.streamplayer

import android.content.Context
import android.view.SurfaceView
import androidx.media3.exoplayer.ExoPlayer

/**
 * ExoPlayer video [SurfaceView]. Fills its bounds with no letterboxing;
 * the host owns the outer aspect ratio.
 *
 * Note: this stretches to fill rather than aspect-fitting, unlike iOS's
 * `PlayerLayerView` (`.resizeAspect`, letterboxed). Callers that need matching
 * behavior across platforms must size/crop the layout slot themselves (e.g.
 * fix the aspect ratio in the host layout, as `PlaybackVideoArea` does).
 */
class StreamPlayerVideoView(context: Context) : SurfaceView(context) {
    fun attach(player: ExoPlayer) {
        player.setVideoSurfaceView(this)
    }
}

actual class VideoView(val platformView: android.view.View)

/**
 * Wraps a fresh [StreamPlayerVideoView] bound to this player's [exoPlayer]. Requires
 * [PlatformMediaPlayer.initialize] to have been called first (for [PlatformMediaPlayer.appContext]).
 */
actual fun PlatformMediaPlayer.videoView(): VideoView {
    val surfaceView = StreamPlayerVideoView(PlatformMediaPlayer.appContext)
    surfaceView.attach(exoPlayer)
    return VideoView(surfaceView)
}
