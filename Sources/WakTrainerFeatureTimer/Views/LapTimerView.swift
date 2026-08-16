//
//  LapTimerView.swift
//  WakTrainerFeatureTimer
//
//  Created by COMATOKI on 2026-08-16.
//

import SwiftUI

public struct LapTimerView: View {
    @StateObject private var timerManager = TimerManager()
    
    public init() {}
    
    // 최단/최장 랩 계산용
    private var minLapTime: TimeInterval? {
        timerManager.laps.map(\.lapTime).min()
    }
    private var maxLapTime: TimeInterval? {
        // 랩이 2개 이상일 때만 최장 랩 표시
        guard timerManager.laps.count >= 2 else { return nil }
        return timerManager.laps.map(\.lapTime).max()
    }
    
    public var body: some View {
        VStack(spacing: 24) {
            // 1. 메인 시간 디스플레이
            Text(timerManager.elapsedTime.formattedTimeString)
                .font(.system(size: 54, weight: .thin, design: .monospaced))
                .padding(.top, 40)
            
            // 2. 조작 버튼 영역
            HStack(spacing: 40) {
                // 좌측 버튼: 랩 타임 또는 재설정
                Button(action: leftButtonAction) {
                    Text(leftButtonTitle)
                        .font(.headline)
                        .frame(width: 80, height: 80)
                        .background(Color.gray.opacity(0.2))
                        .foregroundColor(.primary)
                        .clipShape(Circle())
                }
                .disabled(!timerManager.isRunning && timerManager.elapsedTime == 0)
                
                // 우측 버튼: 시작 또는 일시정지
                Button(action: rightButtonAction) {
                    Text(timerManager.isRunning ? "일시정지" : "시작")
                        .font(.headline)
                        .frame(width: 80, height: 80)
                        .background(timerManager.isRunning ? Color.red.opacity(0.2) : Color.green.opacity(0.2))
                        .foregroundColor(timerManager.isRunning ? .red : .green)
                        .clipShape(Circle())
                }
            }
            
            Divider()
                .padding(.horizontal)
            
            // 3. 랩 타임 리스트
            List {
                ForEach(timerManager.laps) { lap in
                    HStack {
                        Text("구간 \(lap.lapNumber)")
                            .font(.system(.body, design: .monospaced))
                        
                        Spacer()
                        
                        Text(formattedLapTime(lap.lapTime))
                            .font(.system(.body, design: .monospaced))
                            .foregroundColor(lapColor(for: lap.lapTime))
                    }
                    .listRowBackground(Color.clear)
                }
            }
            .listStyle(.plain)
        }
    }
    
    // 좌측 버튼 타이틀
    private var leftButtonTitle: String {
        if timerManager.isRunning {
            return "구간 기록"
        } else {
            return "재설정"
        }
    }
    
    // 좌측 버튼 동작
    private func leftButtonAction() {
        if timerManager.isRunning {
            timerManager.addLap()
        } else {
            timerManager.stop()
        }
    }
    
    // 우측 버튼 동작
    private func rightButtonAction() {
        if timerManager.isRunning {
            timerManager.pause()
        } else {
            timerManager.start()
        }
    }
    
    // 랩 색상 구분 (최단: 초록색, 최장: 빨간색)
    private func lapColor(for time: TimeInterval) -> Color {
        guard timerManager.laps.count >= 2 else { return .primary }
        if time == minLapTime { return .green }
        if time == maxLapTime { return .red }
        return .primary
    }
    
    // 랩 타임 전용 포맷
    private func formattedLapTime(_ time: TimeInterval) -> String {
        let totalSeconds = Int(time)
        let hundredths = Int((time.truncatingRemainder(dividingBy: 1)) * 100)
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d.%02d", minutes, seconds, hundredths)
    }
}
