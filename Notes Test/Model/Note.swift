//
//  Note.swift
//  Notes Test
//
//  Created by Akel Barbosa on 24/03/24.
//

import Foundation

struct Note: Identifiable, Hashable {
    let id: UUID
    let title: String
    let text: String?
    let createAt: Date
    
    var getText: String {
        text ?? ""
    }
    
    init(id: UUID = UUID(), title: String, text: String?, createAt: Date) {
        self.id = id
        self.title = title
        self.text = text
        self.createAt = createAt
    }
}
