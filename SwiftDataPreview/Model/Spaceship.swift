//
//  Spaceship.swift
//  SwiftDataPreview
//
//  Created by Arne Gockeln on 17.10.23.
//

import Foundation
import SwiftData

@Model
final public class Spaceship {
    @Attribute(.unique)
    public var id: UUID
    public var name: String
    
    @Relationship(inverse: \SpaceshipPart.ships)
    public var parts: [SpaceshipPart] = []
    
    init(name: String?) {
        self.id = UUID()
        self.name = name ?? "A famous ship name"
    }
}
