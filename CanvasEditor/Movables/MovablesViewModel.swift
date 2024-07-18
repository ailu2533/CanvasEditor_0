//
//  MovablesViewModel.swift
//  CanvasEditor
//
//  Created by ailu on 2024/7/18.
//

import Foundation
import SwiftMovable
import UIKit

@Observable
class MovablesViewModel {
    var images: [MovableImage] = [MovableImage(uuid: UUID(), image: UIImage(systemName: "arrowshape.down")!)]
}
