//
//  CapsuleButtonStyle.swift
//  CanvasEditor
//
//  Created by ailu on 2024/7/18.
//

import SwiftUI

struct CapsuleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .fontWeight(.semibold)
            .font(.subheadline)
            .foregroundColor(.primary)
            .padding(.horizontal, 8)
            .padding(.vertical, 6)
            .background(Color(.systemGray6))
            .clipShape(Capsule())
            .opacity(configuration.isPressed ? 0.5 : 1) // 添加按下效果
    }
}
