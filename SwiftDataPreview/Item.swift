//
//  Item.swift
//  SwiftDataPreview
//
//  Created by Arne Gockeln on 17.10.23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
