//
//  ViewModel.swift
//  Notes Test
//
//  Created by Akel Barbosa on 24/03/24.
//

import Foundation
import Observation

@Observable
class ViewModel {
    var notes: [Note]
    
    init(notes: [Note] = []) {
        self.notes = notes
    }
    
    //MARK: - Methods
    func createNoteWith(title: String, text: String) {
        let note: Note = .init(title: title, text: text, createAt: .now)
        notes.append(note)
    }
    
    func updateNoteWith(id: UUID, newTitle: String, newText: String) {
        if let index = notes.firstIndex(where: { $0.id == id}) {
            let updateNote =  Note(id: id, title: newTitle, text: newText, createAt: notes[index].createAt)
            notes[index] = updateNote
        }
    }
    
    func removeNoteWith(id: UUID) {
        notes.removeAll(where: { $0.id == id})
        
    }
}
