//
//  PersistenceService.swift
//  <project_name>
//
//  Created by Kevin Armstrong on 12/14/24.
//


import SwiftData

class PersistenceService {
    static let shared = PersistenceService()
    
    let modelContainer: ModelContainer
    
    private init() {
        let schema = Schema([Entity.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    @MainActor
    var modelContext: ModelContext {
        modelContainer.mainContext
    }
}
