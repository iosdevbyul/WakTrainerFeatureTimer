//
//  TimeInterval+Format.swift
//  WakTrainerFeatureTimer
//
//  Created by COMATOKI on 2026-08-16.
//

// Extensions/TimeInterval+Format.swift
import Foundation

extension TimeInterval {
    /// 초 단위를 "MM:ss" 또는 "HH:mm:ss" 포맷으로 변환합니다.
    public var formattedTimeString: String {
        let totalSeconds = Int(self)
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        
        if hours > 0 {
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        } else {
            return String(format: "%02d:%02d", minutes, seconds)
        }
    }
    
    /// 스톱워치/랩타임용 "00:00.00" 밀리초 포함 포맷으로 변환합니다.
    public var formattedStopwatchString: String {
        let totalSeconds = Int(self)
        let hundredths = Int((self.truncatingRemainder(dividingBy: 1)) * 100)
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        
        if hours > 0 {
            return String(format: "%02d:%02d:%02d.%02d", hours, minutes, seconds, hundredths)
        } else {
            return String(format: "%02d:%02d.%02d", minutes, seconds, hundredths)
        }
    }
}
