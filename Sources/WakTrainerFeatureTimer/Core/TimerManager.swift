import Foundation
import Combine
import WakTrainerCoreModels

// 타이머의 세부 상태
public enum TimerState {
    case idle
    case running
    case paused
}

public final class TimerManager: ObservableObject, TimerManagerProtocol, @unchecked Sendable {
    @Published public private(set) var elapsedTime: TimeInterval = 0
    @Published public private(set) var state: TimerState = .idle
    @Published public private(set) var laps: [LapItem] = []
    
    // MARK: - TimerManagerProtocol 준수
    public var isRunning: Bool {
        state == .running
    }
    
    private var timerSubscription: AnyCancellable?
    private var startDate: Date?
    private var accumulatedTime: TimeInterval = 0
    private var lastLapTime: TimeInterval = 0
    
    public init() {}
    
    public func start() {
        guard state != .running else { return }
        state = .running
        
        startDate = Date()
        
        timerSubscription = Timer.publish(every: 0.05, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.updateElapsedTime()
            }
    }
    
    public func pause() {
        guard state == .running else { return }
        state = .paused
        
        if let startDate = startDate {
            accumulatedTime += Date().timeIntervalSince(startDate)
        }
        startDate = nil
        
        timerSubscription?.cancel()
        timerSubscription = nil
    }
    
    // Protocol 요구사항: stop()
    public func stop() {
        if state == .running {
            timerSubscription?.cancel()
            timerSubscription = nil
            startDate = nil
        }
        
        state = .idle
        accumulatedTime = 0
        elapsedTime = 0
        lastLapTime = 0
        laps.removeAll()
    }
    
    // 데모 편의용 Alias (reset -> stop)
    public func reset() {
        stop()
    }
    
    // 랩 기록 메서드
    public func recordLap() {
        guard state == .running else { return }
        
        let currentTotal = elapsedTime
        let currentLapDuration = currentTotal - lastLapTime
        let lapNumber = laps.count + 1
        
        let newLap = LapItem(
            lapNumber: lapNumber,
            lapTime: currentLapDuration,
            displayTime: currentTotal
        )
        
        laps.insert(newLap, at: 0)
        lastLapTime = currentTotal
    }
    
    private func updateElapsedTime() {
        guard let startDate = startDate else { return }
        elapsedTime = accumulatedTime + Date().timeIntervalSince(startDate)
    }
}
