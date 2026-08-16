//
//  SimpleTextTimerView.swift
//  WakTrainerFeatureTimer
//
//  Created by COMATOKI on 2026-08-16.
//

import SwiftUI

public struct SimpleTextTimerView: View {
    @ObservedObject var timerManager: TimerManager
    
    // 커스텀 설정을 위한 프로퍼티 (기본값 지정)
    var font: Font
    var textColor: Color
    
    public init(
        timerManager: TimerManager,
        font: Font = .system(size: 20, weight: .semibold, design: .monospaced),
        textColor: Color = .primary
    ) {
        self.timerManager = timerManager
        self.font = font
        self.textColor = textColor
    }
    
    public var body: some View {
        Text(formattedTime(timerManager.elapsedTime))
            .font(font)
            .foregroundColor(textColor)
    }
    
    // 초 단위를 MM:ss 또는 HH:mm:ss로 변환
    private func formattedTime(_ totalSeconds: TimeInterval) -> String {
        let total = Int(totalSeconds)
        let hours = total / 3600
        let minutes = (total % 3600) / 60
        let seconds = total % 60
        
        if hours > 0 {
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        } else {
            return String(format: "%02d:%02d", minutes, seconds)
        }
    }
}
