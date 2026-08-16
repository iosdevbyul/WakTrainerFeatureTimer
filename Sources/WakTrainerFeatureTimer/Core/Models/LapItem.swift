//
//  LapItem.swift
//  WakTrainerFeatureTimer
//
//  Created by COMATOKI on 2026-08-16.
//

import Foundation

// 랩 타임 데이터 모델
public struct LapItem: Identifiable, Equatable, Sendable {
    public let id = UUID()
    public let lapNumber: Int
    public let lapTime: TimeInterval      // 이번 랩 동안 걸린 시간
    public let displayTime: TimeInterval  // 랩을 누른 시점의 전체 경과 시간
}
