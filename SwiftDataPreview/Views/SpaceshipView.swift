//
//  SpaceshipView.swift
//  SwiftDataPreview
//
//  Created by Arne Gockeln on 17.10.23.
//

import SwiftUI
import SwiftData

struct SpaceshipView: View {
    var ship: Spaceship
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(ship.name)
                .font(.title)
            
            List(ship.parts) { part in
                Text(part.name)
                    .font(.subheadline)
            }
        }
    }
}

#Preview {
    /// Get or create the container in memory
    let container = DataController.shared.sharedModelContainer(inMemory: true)
    /// Create a preview ship in mainContext
    let ship = DataController.shared.createPreviewShip(in: container.mainContext)
    /// Preview the view
    return SpaceshipView(ship: ship)
}
