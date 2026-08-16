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
        Text(timerManager.elapsedTime.formattedTimeString)
            .font(.system(size: 18, weight: .bold, design: .monospaced))
            .foregroundColor(textColor)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(Color.white)
            .clipShape(Capsule())
            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
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
