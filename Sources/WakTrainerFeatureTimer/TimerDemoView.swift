//
//  TimerDemoView.swift
//  WakTrainerFeatureTimer
//
//  Created by COMATOKI on 2026-08-16.
//

import SwiftUI

struct TimerDemoView: View {
    @StateObject private var timerManager = TimerManager()
    
    var body: some View {
        VStack(spacing: 20) {
            // 1. 기본 스타일 사용 (시스템 폰트 20pt, 고정 폭 디자인)
            SimpleTextTimerView(timerManager: timerManager)
            
            // 2. 커스텀 스타일 (큰 글씨, 빨간색)
            SimpleTextTimerView(
                timerManager: timerManager,
                font: .system(size: 36, weight: .bold, design: .monospaced),
                textColor: .red
            )
        }
    }
}
