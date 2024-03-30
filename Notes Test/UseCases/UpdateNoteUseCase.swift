//
//  UpdateNoteUseCase.swift
//  Notes Test
//
//  Created by Akel Barbosa on 29/03/24.
//

import Foundation

protocol UpdateNoteProtocol {
    func updateNoteWith(id: UUID, title: String, text: String) throws
}

struct UpdateNoteUseCase: UpdateNoteProtocol {
    var notesDatabase: NotesDatabaseProtocol

    
    init(notesDatabase: NotesDatabaseProtocol = NotesDatabase.shared) {
        self.notesDatabase = notesDatabase

    }
    
    func updateNoteWith(id: UUID, title: String, text: String) throws {
        try notesDatabase.update(id: id, title: title, text: text)
    }
}
