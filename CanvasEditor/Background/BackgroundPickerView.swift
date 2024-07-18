//
//  BackgroundPickerView.swift
//  CanvasEditor
//
//  Created by ailu on 2024/7/18.
//

import Foundation
import HorizontalPicker
import LemonUtils
import SwiftUI

struct BackgroundPickerView: View {
    @Bindable var viewModel: BackgroundViewModel
    @Environment(\.dismissPicker) private var dismissPicker

    var body: some View {
        VStack(spacing: 8) {
            pickerHeader
            pickerContent
        }
    }

    private var pickerHeader: some View {
        HStack {
            HorizontalSelectionPicker(items: BackgroundKind.allCases, selectedItem: $viewModel.pickerKind) { backgroundKind in
                Text(backgroundKind.text).tag(backgroundKind)
            }
            Spacer()
            Button("收起", action: dismissPicker)
                .buttonStyle(CapsuleButtonStyle())
                .padding(.trailing, 16)
        }
    }

    @ViewBuilder
    private var pickerContent: some View {
        switch viewModel.pickerKind {
        case .morandiColors, .macaronColors:
            colorPicker(for: viewModel.pickerKind)
        case .linearGradient:
            linearGradientPicker
        }
    }

    private func colorPicker(for kind: BackgroundKind) -> some View {
        ColorPickerView2(
            selection: Binding(
                get: { viewModel.color },
                set: { newColor in
                    viewModel.color = newColor
                    viewModel.colors = []
                    viewModel.kind = kind
                }
            ),
            colorSet: kind == .morandiColors ? ColorSets.morandiColors : ColorSets.macaronColors
        )
    }

    private var linearGradientPicker: some View {
        LinearGradientPicker(
            selection: Binding(
                get: { viewModel.colors },
                set: { newColors in
                    viewModel.colors = newColors
                    viewModel.color = ""
                    viewModel.kind = .linearGradient
                }
            )
        )
    }
}