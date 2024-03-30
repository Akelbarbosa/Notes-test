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
    var databaseError: DatabaseError?
    
    var createNoteUseCase: CreateNoteProtocol
    var fetchAllUseCase: FetchAllNotesProtocol
    var removeNoteUseCase: DeleteNoteProtocol
    var updateNoteUseCase: UpdateNoteProtocol
    
    init(notes: [Note] = [],
         createNoteUseCase: CreateNoteProtocol = CreateNoteUseCase(),
         fetchAllUseCase: FetchAllNotesProtocol = FetchAllNotesUseCase(),
         removeNoteUseCase: DeleteNoteProtocol = DeleteNoteUseCase(),
         updateNoteUseCase: UpdateNoteProtocol = UpdateNoteUseCase()){
        self.notes = notes
        self.createNoteUseCase = createNoteUseCase
        self.fetchAllUseCase = fetchAllUseCase
        self.removeNoteUseCase = removeNoteUseCase
        self.updateNoteUseCase = updateNoteUseCase
        fetchAllNotes()
    }
    
    //MARK: - Methods
    func createNoteWith(title: String, text: String) {
        do {
            try createNoteUseCase.createNoteWith(title: title, text: text)
            fetchAllNotes()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func fetchAllNotes() {
        do {
            notes = try fetchAllUseCase.fetchAll()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func updateNoteWith(id: UUID, newTitle: String, newText: String) {
        do {
            try updateNoteUseCase.updateNoteWith(id: id, title: newTitle, text: newText)
        } catch  {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func removeNoteWith(id: UUID) {
        do {
            try removeNoteUseCase.deleteNoteWith(id: id)
            fetchAllNotes()
        } catch let error as DatabaseError {
            databaseError = error
        } catch  {
            print("Error: \(error.localizedDescription)")
        }
        
    }
}
