//
//  ContentView.swift
//  SwiftDataPreview
//
//  Created by Arne Gockeln on 17.10.23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) 
    private var modelContext
    
    @Query(sort: \Spaceship.name, order: .forward)
    private var ships: [Spaceship]
    
    @State
    private var selectedShip: Spaceship? = nil
    
    var body: some View {
        NavigationSplitView {
            /// List all ships in sidebar
            List(selection: $selectedShip) {
                ForEach(ships, id: \.id) { ship in
                    NavigationLink(ship.name, value: ship)
                }
            }
        } detail: {
            if let selectedShip {
                /// List ship parts
                SpaceshipView(ship: selectedShip)
            } else {
                Text("Select a ship")
            }
        }
        .onAppear {
            if selectedShip == nil {
                selectedShip = ships.first
            }
        }
    }
}

#Preview("Light") {
    /// Create the in memory container
    let container = DataController.shared.sharedModelContainer(inMemory: true)
    /// Return view with custom container
    return ContentView()
        .modelContainer(container)
        .preferredColorScheme(.light)
}

#Preview("Dark") {
    /// Create the in memory container
    let container = DataController.shared.sharedModelContainer(inMemory: true)
    /// Return view with custom container
    return ContentView()
        .modelContainer(container)
        .preferredColorScheme(.dark)
}
