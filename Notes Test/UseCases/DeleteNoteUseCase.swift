//
//  DeleteNoteUseCase.swift
//  Notes Test
//
//  Created by Akel Barbosa on 29/03/24.
//

import Foundation

protocol DeleteNoteProtocol {
    func deleteNoteWith(id: UUID) throws
}

struct DeleteNoteUseCase: DeleteNoteProtocol {
    var notesDatabase: NotesDatabaseProtocol
    
    init(notesDatabase: NotesDatabaseProtocol = NotesDatabase.shared) {
        self.notesDatabase = notesDatabase
    }
    
    func deleteNoteWith(id: UUID) throws {
        try notesDatabase.remove(identifier: id)
    }
}
