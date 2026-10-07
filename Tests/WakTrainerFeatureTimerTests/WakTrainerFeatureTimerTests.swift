import Testing

@testable import WakTrainerFeatureTimer

@Suite("TimerManager restore")
struct TimerManagerRestoreTests {

    @Test("restore places a persisted timer into paused state")
    func restoreElapsedTime() {
        let timer = TimerManager()

        timer.restore(
            elapsedTime: 321
        )

        #expect(timer.elapsedTime == 321)
        #expect(timer.state == .paused)
        #expect(!timer.isRunning)
        #expect(timer.laps.isEmpty)
    }

    @Test("restored timer can resume and reset")
    func restoredTimerCanResumeAndReset() {
        let timer = TimerManager()

        timer.restore(
            elapsedTime: 120
        )

        timer.start()

        #expect(timer.state == .running)
        #expect(timer.isRunning)

        timer.stop()

        #expect(timer.state == .idle)
        #expect(timer.elapsedTime == 0)
        #expect(timer.laps.isEmpty)
    }

    @Test("zero restore remains paused for persisted sessions")
    func zeroRestoreRemainsPaused() {
        let timer = TimerManager()

        timer.restore(
            elapsedTime: -10
        )

        #expect(timer.state == .paused)
        #expect(timer.elapsedTime == 0)
    }
}
