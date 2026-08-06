package dev.markturnip.streamplayer

/**
 * Opaque handle to a platform-native video surface (Android [android.view.SurfaceView],
 * iOS `AVPlayerLayer`-backed `UIView`) bound to a [PlatformMediaPlayer]'s underlying
 * player. Expose the platform view (e.g. via a `platformView` property on the actual
 * declaration) to embed it in host UI, as `streamplayer-compose`'s `VideoPlayer` does
 * with `AndroidView`/`UIKitView`.
 *
 * Scaling behavior is platform-specific: see each actual [videoView] implementation.
 */
expect class VideoView

/**
 * Creates a video surface for this player. Call once per [PlatformMediaPlayer]
 * instance — each call creates a new native view — and keep the result around
 * for the player's lifetime rather than re-creating it on every use.
 */
expect fun PlatformMediaPlayer.videoView(): VideoView
