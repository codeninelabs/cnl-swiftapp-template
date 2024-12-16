//
//  Entity.swift
//  <project_name>
//
//  Created by Kevin Armstrong on 12/5/24.
//

import Foundation
import SwiftData

@Model
class Entity: Identifiable {
    @Attribute(.unique) var id: UUID = UUID()
    var label: String
    var date: Date
    
    init(label: String, date: Date) {
        self.id = UUID()
        self.label = label
        self.date = date
    }
}
