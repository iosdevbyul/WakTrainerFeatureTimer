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
        Text(timerManager.elapsedTime.formattedTimeString)
            .font(font)
            .foregroundColor(textColor)
    }
}
