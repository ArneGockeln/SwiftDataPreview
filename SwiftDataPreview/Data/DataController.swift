//
//  DataController.swift
//  SwiftDataPreview
//
//  Created by Arne Gockeln on 17.10.23.
//

import SwiftUI
import SwiftData

/// A singleton data controller to serve the ModelContainer and ModelContext Data
class DataController {
    /// Singleton
    static let shared = DataController()
    
    /// hold the model container
    private var modelContainer: ModelContainer? = nil
    
    /// Changed access level
    private init() {}
    
    /// Create a ModelContainer to use in memory for preview or store in production
    /// - Parameter inMemory: Set to true to store in memory
    /// - Returns: ModelContainer for Spaceship and SpaceshipPart
    public func sharedModelContainer(inMemory: Bool = false) -> ModelContainer {
        if self.modelContainer != nil {
            return self.modelContainer!
        }
        
        do {
            let schema = Schema([Spaceship.self, SpaceshipPart.self])
            let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: inMemory)
            self.modelContainer = try ModelContainer(for: schema, configurations: [config])
            
            /// Create demo data when running in Xcode debug mode (build and run)
            #if DEBUG
            do {
                Task {
                    @MainActor in
                    DataController.shared.createShips()
                }
            }
            #endif
            
            return self.modelContainer!
        } catch {
            fatalError("Failed to create \(inMemory ? "previewContainer" : "modelContainer") for: \(error.localizedDescription)")
        }
    }
        
    /// Don't repeat yourself and create a list of Spaceship parts
    public let parts: [String] = ["Engine", "Cockpit", "Thrusters", "Weapons", "Cargo", "Shields"]
        
    /// Create a list of spaceships with parts attached
    /// - Parameter modelContext: The ModelContext to create data in
    @MainActor
    private func createShips() {
        let modelContext = self.modelContainer!.mainContext
        
        /// Create a shuttle
        let shuttle = Spaceship(name: "Delta Flyer")
        modelContext.insert(shuttle)
        
        /// Create a ship
        let ship = Spaceship(name: "Enterprise NX-01")
        modelContext.insert(ship)
        
        /// Create parts
        let parts = DataController.shared.parts
        for name in parts {
            /// Create part by name
            let part = SpaceshipPart(name: name)
            /// Add to model context
            modelContext.insert(part)
            
            /// Add relationships
            part.ships.append(ship)
            if name != "Weapons" && name != "Cargo" {
                part.ships.append(shuttle)
            }
        }
    }
        
    /// Create a single spaceship for preview
    /// - Parameter modelContext: The ModelContext to create the data in
    /// - Returns: A Spaceship object with parts attached
    public func createPreviewShip(in modelContext: ModelContext) -> Spaceship {
        let ship = Spaceship(name: "Enterprise NX-01")
        modelContext.insert(ship)
        
        let parts = DataController.shared.parts
        for name in parts {
            /// Create part by name
            let part = SpaceshipPart(name: name)
            /// Add to model context
            modelContext.insert(part)
            
            /// Add relationships
            part.ships.append(ship)
        }
        
        return ship
    }
}
