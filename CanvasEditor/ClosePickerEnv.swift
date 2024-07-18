//
//  ClosePickerEnv.swift
//  CanvasEditor
//
//  Created by ailu on 2024/7/18.
//

import SwiftUICore

struct DimissPickerKey: EnvironmentKey {
    static let defaultValue: () -> Void = {}
}

extension EnvironmentValues {
    var dismissPicker: () -> Void {
        get { self[DimissPickerKey.self] }
        set { self[DimissPickerKey.self] = newValue }
    }
}
