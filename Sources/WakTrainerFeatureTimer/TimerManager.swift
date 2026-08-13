import Foundation
import Combine
import WakTrainerCoreModels

public final class TimerManager: TimerManagerProtocol, @unchecked Sendable {
    @Published public private(set) var elapsedTime: TimeInterval = 0
    @Published public private(set) var isRunning: Bool = false
    
    private var timerSubscription: AnyCancellable?
    
    public init() {}
    
    public func start() {
        guard !isRunning else { return }
        isRunning = true
        
        timerSubscription = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.elapsedTime += 1
            }
    }
    
    public func pause() {
        isRunning = false
        timerSubscription?.cancel()
        timerSubscription = nil
    }
    
    public func stop() {
        pause()
        elapsedTime = 0
    }
}
