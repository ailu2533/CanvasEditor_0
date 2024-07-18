//
//  BackgroundViewModel.swift
//  CanvasEditor
//
//  Created by ailu on 2024/7/18.
//

import Foundation
import LemonUtils
import SwiftUI

@Observable
class BackgroundViewModel {
    var pickerKind: BackgroundKind = .macaronColors

    var kind: BackgroundKind = .macaronColors
    var color: String = ColorSets.macaronColors.first!
    var colors: [String] = []

    /// Returns a SwiftUI view for the background based on the current settings.
    @ViewBuilder
    public func backgroundView() -> some View {
        switch kind {
        case .morandiColors, .macaronColors:
            Color(hex: color) ?? Color.white
        case .linearGradient:
            if !colors.isEmpty {
                colorHexArrToLinearGradient(colorHexArray: colors)
            } else {
                Color.white
            }
        }
    }

    /// Converts an array of color hex strings into a LinearGradient.
    func colorHexArrToLinearGradient(colorHexArray: [String]) -> LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: colorHexArray.map { Color(hex: $0) ?? Color.clear }),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}
