import Foundation
import Combine
import WakTrainerCoreModels

public final class TimerManager: TimerManagerProtocol, @unchecked Sendable {
    @Published public private(set) var elapsedTime: TimeInterval = 0
    @Published public private(set) var isRunning: Bool = false
    
    private var timerSubscription: AnyCancellable?
    private var startDate: Date?
    private var accumulatedTime: TimeInterval = 0 // 일시정지 전까지 누적된 시간

    public init() {}
    
    public func start() {
        guard !isRunning else { return }
        isRunning = true
        
        // 기준 시작 시각 저장
        startDate = Date()
        
        timerSubscription = Timer.publish(every: 0.1, on: .main, in: .common) // 화면 갱신용
            .autoconnect()
            .sink { [weak self] _ in
                self?.updateElapsedTime()
            }
    }
    
    public func pause() {
        guard isRunning else { return }
        isRunning = false
        
        // 현재까지 흐른 시간을 누적에 합산
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
    }
    
    private func updateElapsedTime() {
        guard let startDate = startDate else { return }
        // (현재 시각 - 시작 시각) + 이전 누적 시간
        elapsedTime = accumulatedTime + Date().timeIntervalSince(startDate)
    }
}
