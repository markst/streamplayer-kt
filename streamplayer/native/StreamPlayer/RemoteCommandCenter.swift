import Foundation
import MediaPlayer

class RemoteCommandCenter {
    
    private var streamPlayer: StreamPlayerType
    @Published
    private var state: StreamPlayerState = .stopped
    
    // MARK: - Init
    
    init(streamPlayer: StreamPlayerType) {
        self.streamPlayer = streamPlayer
        self.streamPlayer.state.assign(to: &$state)

        setupRemoteCommandCenter()
    }
    
    deinit {
        let remoteCommandCenter = MPRemoteCommandCenter.shared()
        remoteCommandCenter.togglePlayPauseCommand.removeTarget(self)
        remoteCommandCenter.playCommand.removeTarget(self)
        remoteCommandCenter.pauseCommand.removeTarget(self)
        remoteCommandCenter.stopCommand.removeTarget(self)
        remoteCommandCenter.skipForwardCommand.removeTarget(self)
        remoteCommandCenter.skipBackwardCommand.removeTarget(self)
        remoteCommandCenter.changePlaybackPositionCommand.removeTarget(self)
        
        UIApplication.shared.endReceivingRemoteControlEvents()
    }
    
    func setupRemoteCommandCenter() {
        UIApplication.shared.beginReceivingRemoteControlEvents() /// Required for `MPNowPlayingInfoCenter`

        let remoteCommandCenter = MPRemoteCommandCenter.shared()
        remoteCommandCenter.togglePlayPauseCommand.isEnabled = true
        remoteCommandCenter.togglePlayPauseCommand.addTarget { [streamPlayer] _ -> MPRemoteCommandHandlerStatus in
            streamPlayer.togglePlaying()
            return .success
        }
        remoteCommandCenter.playCommand.isEnabled = true
        remoteCommandCenter.playCommand.addTarget { [streamPlayer] event -> MPRemoteCommandHandlerStatus in
            if self.state != .playing {
                streamPlayer.play()
                return .success
            } else {
                return .noActionableNowPlayingItem
            }
        }
        remoteCommandCenter.pauseCommand.isEnabled = true
        remoteCommandCenter.pauseCommand.addTarget { [streamPlayer] event -> MPRemoteCommandHandlerStatus in
            if self.state == .playing {
                streamPlayer.pause()
                return .success
            } else {
                return .noActionableNowPlayingItem
            }
        }
        remoteCommandCenter.stopCommand.isEnabled = true
        remoteCommandCenter.stopCommand.addTarget { [streamPlayer] _ -> MPRemoteCommandHandlerStatus in
            streamPlayer.stop()
            return .success
        }
        
        remoteCommandCenter.skipForwardCommand.isEnabled = true
        remoteCommandCenter.skipForwardCommand.preferredIntervals = [30]
        remoteCommandCenter.skipForwardCommand.addTarget { [streamPlayer] (event) -> MPRemoteCommandHandlerStatus in
            if let interval = (event as? MPSkipIntervalCommandEvent)?.interval {
                streamPlayer.skip(interval)
                return .success
            }
            return .commandFailed
        }
        
        remoteCommandCenter.skipBackwardCommand.isEnabled = true
        remoteCommandCenter.skipBackwardCommand.preferredIntervals = [30]
        remoteCommandCenter.skipBackwardCommand.addTarget { [streamPlayer] (event) -> MPRemoteCommandHandlerStatus in
            if let interval = (event as? MPSkipIntervalCommandEvent)?.interval {
                streamPlayer.skip(-interval)
                return .success
            }
            return .commandFailed
        }
        
        remoteCommandCenter.changePlaybackPositionCommand.isEnabled = true
        remoteCommandCenter.changePlaybackPositionCommand.addTarget { [streamPlayer] (event) -> MPRemoteCommandHandlerStatus in
            if let positionTime = (event as? MPChangePlaybackPositionCommandEvent)?.positionTime {
                streamPlayer.seek(position: positionTime)
                return .success
            }
            return .commandFailed
        }
    }
    
    /// Toggle the skip buttons visibility, such as when live stream.
    func skip(enabled: Bool) {
        let remoteCommandCenter = MPRemoteCommandCenter.shared()
        remoteCommandCenter.skipForwardCommand.isEnabled = enabled
        remoteCommandCenter.skipBackwardCommand.isEnabled = enabled
    }
}
