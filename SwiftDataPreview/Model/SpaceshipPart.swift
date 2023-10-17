//
//  SpaceshipPart.swift
//  SwiftDataPreview
//
//  Created by Arne Gockeln on 17.10.23.
//

import Foundation
import SwiftData

@Model
final public class SpaceshipPart {
    @Attribute(.unique)
    public var id: UUID
    public var name: String
    public var ships: [Spaceship] = []
    
    init(name: String?) {
        self.id = UUID()
        self.name = name ?? String(localized: "Useful Part", table: "Spaceship")
    }
}
