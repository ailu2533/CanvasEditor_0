//
//  BackgroundKind.swift
//  CanvasEditor
//
//  Created by ailu on 2024/7/18.
//

import Foundation
import SwiftUICore

public enum BackgroundKind: Int, CaseIterable, Codable, Identifiable {
    case linearGradient
    case macaronColors
    case morandiColors

    public var id: Self {
        self
    }

    var text: LocalizedStringKey {
        switch self {
        case .morandiColors:
            return "莫兰迪色"
        case .macaronColors:
            return "马卡龙色"
        case .linearGradient:
            return "渐变色"
        }
    }
}

