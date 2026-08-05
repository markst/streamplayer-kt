package dev.markturnip.streamplayer

import android.content.Context
import android.view.SurfaceView
import androidx.media3.exoplayer.ExoPlayer

/**
 * A SurfaceView that binds to an ExoPlayer for video rendering.
 * Created once per PlatformMediaPlayer instance; attach before playback begins.
 */
class StreamPlayerVideoView(context: Context) : SurfaceView(context) {
    fun attach(player: ExoPlayer) {
        player.setVideoSurfaceView(this)
    }
}

actual class VideoView(val platformView: android.view.View)

actual fun PlatformMediaPlayer.videoView(): VideoView {
    val surfaceView = StreamPlayerVideoView(PlatformMediaPlayer.appContext)
    surfaceView.attach(exoPlayer)
    return VideoView(surfaceView)
}
