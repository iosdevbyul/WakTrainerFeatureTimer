//
//  MultiCircleTimerView.swift
//  WakTrainerFeatureTimer
//
//  Created by COMATOKI on 2026-08-15.
//

import SwiftUI
import Combine

public struct MultiCircleTimerView: View {
    @ObservedObject var timerManager: TimerManager
    
    public init(timerManager: TimerManager) {
        self.timerManager = timerManager
    }
    
    // elapsedTime을 시, 분, 초로 분해
    private var timeComponents: (hours: Int, minutes: Int, seconds: Int) {
        let total = Int(timerManager.elapsedTime)
        let h = (total / 3600) % 24  // 24시간 기준 표기
        let m = (total % 3600) / 60
        let s = total % 60
        return (h, m, s)
    }
    
    public var body: some View {
        HStack(spacing: 15) {
            // 1. 시간 (24시간 기준 1/24씩 차오름)
            CircularProgressRingView(
                value: timeComponents.hours,
                total: 24.0,
                color: .blue
            )
            
            // 2. 분 (60분 기준 1/60씩 차오름)
            CircularProgressRingView(
                value: timeComponents.minutes,
                total: 60.0,
                color: .green
            )
            
            // 3. 초 (60초 기준 1/60씩 차오름)
            CircularProgressRingView(
                value: timeComponents.seconds,
                total: 60.0,
                color: .red
            )
        }
        .padding()
    }
}

struct MultiCircleTimerView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            // 투명 배경 UI를 식별하기 위해 체커보드나 배경색 추가
            Color.white.ignoresSafeArea()
            
            VStack {
                Text("원형 멀티 타이머 (배경 투명)")
                    .font(.headline)
                    .padding()
                
                // 프리뷰용 TimerManager 인스턴스
                MultiCircleTimerView(timerManager: TimerManager())
            }
        }
    }
}

import SwiftUI

// 하나의 원형 타이머 단위를 나타내는 뷰 (시간, 분, 초 공용)
struct CircularProgressRingView: View {
    let value: Int          // 표시할 숫자 (시간, 분, 초)
    let total: Double?       // 최대값 (초: 60.0, 분: 60.0, 시간: 24.0)
    let color: Color         // 프로그래스 링 색상
    
    // 포맷팅된 숫자 스트링 (예: 1 -> "01")
    private var formattedValue: String {
        String(format: "%02d", value)
    }
    
    // 프로그래스 비율 계산 (0.0 ~ 1.0)
    private var progress: Double {
        guard let total = total, total > 0 else { return 1.0 }
        let current = Double(value)
        return current / total
    }

    var body: some View {
        ZStack {
            // 1. 배경 회색 테두리
            Circle()
                .stroke(Color.gray.opacity(0.2), style: StrokeStyle(lineWidth: 6, lineCap: .round))
            
            // 2. 진행도 테두리 (12시 방향부터 시작하도록 -90도 회전)
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(color, style: StrokeStyle(lineWidth: 6, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.linear(duration: 0.2), value: progress)
            
            // 3. 중앙 숫자
            Text(formattedValue)
                .font(.system(size: 24, weight: .bold, design: .monospaced))
                .foregroundColor(.black)
        }
        .frame(width: 80, height: 80)
    }
}
