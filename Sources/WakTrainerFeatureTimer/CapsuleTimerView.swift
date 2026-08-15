//
//  CapsuleTimerView.swift
//  WakTrainerFeatureTimer
//
//  Created by COMATOKI on 2026-08-14.
//

import SwiftUI
import Combine

public struct CapsuleTimerView: View {
    @ObservedObject var timerManager: TimerManager
    
    // 외부에서 주입 가능한 텍스트 색상 (기본값: 검은색)
    var textColor: Color
    
    public init(timerManager: TimerManager, textColor: Color = .black) {
        self.timerManager = timerManager
        self.textColor = textColor
    }
    
    public var body: some View {
        Text(formattedTime(timerManager.elapsedTime))
            .font(.system(size: 18, weight: .bold, design: .monospaced))
            .foregroundColor(textColor)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(Color.white)
            .clipShape(Capsule())
            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
    
    // 초 단위를 MM:ss 또는 HH:mm:ss 형식으로 변환
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

struct CapsuleTimerView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.gray.opacity(0.2).ignoresSafeArea() // 흰색 캡슐 식별용 배경
            
            VStack(spacing: 20) {
                // 1. 기본 검은색 텍스트
                CapsuleTimerView(timerManager: TimerManager())
                
                // 2. 외부에서 노란색 텍스트 주입
//                CapsuleTimerView(timerManager: TimerManager(), textColor: .yellow)
            }
        }
    }
}
