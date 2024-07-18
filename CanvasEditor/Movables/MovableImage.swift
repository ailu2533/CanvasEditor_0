//
//  MovableImage.swift
//  CanvasEditor
//
//  Created by ailu on 2024/7/18.
//

import Foundation
import SwiftMovable
import UIKit

class MovableImage: MovableObject, Hashable {
    var image: UIImage

    static func == (lhs: MovableImage, rhs: MovableImage) -> Bool {
        return lhs.id == rhs.id
    }

    init(uuid: UUID, image: UIImage) {
        self.image = image
        super.init(id: uuid, pos: .zero)
    }

    required init(from decoder: Decoder) throws {
        // 不解码 image
        image = UIImage()
        try super.init(from: decoder)
    }

    private enum CodingKeys: CodingKey {
        // 不包括 image
    }

    override func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
