import Combine
import Foundation
import AVFoundation

public protocol StreamPlayerType {
    var state: AnyPublisher<StreamPlayerState, Never> { get }
    var playbackState: AnyPublisher<StreamPlayerPlaybackState, Never> { get }
    var playProgress: AnyPublisher<Progress, Never> { get }
    var isPlaying: AnyPublisher<Bool, Never> { get }
    var didPlayToEndTime: AnyPublisher<NowPlayingInfo?, Never> { get }

    // Rename load media?
    func play(url: URL)
    func play(url: URL, at position: NSNumber?)
    func play(url: URL, at position: NSNumber?, info: NowPlayingInfo?)

    func play()
    func pause()
    func stop()
    func togglePlaying()

    func skip(_ delta: Double)
    func seek(position: TimeInterval)
}

public struct Progress {
    public let id: Int
    // TODO: Rename elapsed time to indicate it's the time in seconds rather than floating point
    public let progress: TimeInterval
    public let duration: TimeInterval
}
