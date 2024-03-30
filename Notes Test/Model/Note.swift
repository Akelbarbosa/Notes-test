//
//  Note.swift
//  Notes Test
//
//  Created by Akel Barbosa on 24/03/24.
//

import Foundation
import SwiftData

@Model
class Note: Identifiable, Hashable {
    @Attribute(.unique) let identifier: UUID
    var title: String
    var text: String?
    var createAt: Date
    
    var getText: String {
        text ?? ""
    }
    
    init(identifier: UUID = UUID(), title: String, text: String?, createAt: Date) {
        self.identifier = identifier
        self.title = title
        self.text = text
        self.createAt = createAt
    }
}
