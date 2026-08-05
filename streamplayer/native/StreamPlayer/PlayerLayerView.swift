import AVFoundation
import UIKit

/// A UIView whose backing layer is an AVPlayerLayer bound to a given AVPlayer.
/// Create one per PlatformMediaPlayer instance and embed it in your view hierarchy.
public final class PlayerLayerView: UIView {
    public override class var layerClass: AnyClass { AVPlayerLayer.self }

    private var playerLayer: AVPlayerLayer { layer as! AVPlayerLayer }

    @objc public init(player: AVPlayer) {
        super.init(frame: .zero)
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspect
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) not supported") }
}
