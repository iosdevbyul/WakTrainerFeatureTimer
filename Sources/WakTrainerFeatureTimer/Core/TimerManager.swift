import Foundation
import Combine
import WakTrainerCoreModels

public final class TimerManager: ObservableObject, TimerManagerProtocol, @unchecked Sendable {
    @Published public private(set) var elapsedTime: TimeInterval = 0
    @Published public private(set) var isRunning: Bool = false
    @Published public private(set) var laps: [LapItem] = []
    
    private var timerSubscription: AnyCancellable?
    private var startDate: Date?
    private var accumulatedTime: TimeInterval = 0
    
    private var lastLapTime: TimeInterval = 0 // 직전 랩 찍었을 때의 elapsedTime
    
    public init() {}
    
    public func start() {
        guard !isRunning else { return }
        isRunning = true
        
        startDate = Date()
        
        timerSubscription = Timer.publish(every: 0.05, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.updateElapsedTime()
            }
    }
    
    public func pause() {
        guard isRunning else { return }
        isRunning = false
        
        if let startDate = startDate {
            accumulatedTime += Date().timeIntervalSince(startDate)
        }
        startDate = nil
        
        timerSubscription?.cancel()
        timerSubscription = nil
    }
    
    public func stop() {
        pause()
        accumulatedTime = 0
        elapsedTime = 0
        lastLapTime = 0
        laps.removeAll()
    }
    
    // 랩 타임 추가
    public func addLap() {
        guard isRunning else { return }
        
        let currentTotal = elapsedTime
        let currentLapDuration = currentTotal - lastLapTime
        let lapNumber = laps.count + 1
        
        let newLap = LapItem(
            lapNumber: lapNumber,
            lapTime: currentLapDuration,
            displayTime: currentTotal
        )
        
        // 최신 랩이 위에 오도록 맨 앞에 추가
        laps.insert(newLap, at: 0)
        lastLapTime = currentTotal
    }
    
    private func updateElapsedTime() {
        guard let startDate = startDate else { return }
        elapsedTime = accumulatedTime + Date().timeIntervalSince(startDate)
    }
}
