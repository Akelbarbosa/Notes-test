//
//  CreateNoteUseCase.swift
//  Notes Test
//
//  Created by Akel Barbosa on 28/03/24.
//

import Foundation

protocol CreateNoteProtocol {
    func createNoteWith(title: String, text: String) throws
}

struct CreateNoteUseCase: CreateNoteProtocol {
    var  notesDatabase: NotesDatabaseProtocol
    
    init(notesDatabase: NotesDatabaseProtocol = NotesDatabase.shared) {
        self.notesDatabase = notesDatabase
    }
    
    func createNoteWith(title: String, text: String) throws {
        let note: Note = .init(identifier: .init(), title: title, text: text, createAt: .now)
        try notesDatabase.insert(note: note)
    }
}
