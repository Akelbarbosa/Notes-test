//
//  Mocks.swift
//  Notes TestTests
//
//  Created by Akel Barbosa on 30/03/24.
//

@testable import Notes_Test
import Foundation

var mockDatabase: [Note] = []

struct CreateNoteUseCaseMock: CreateNoteProtocol {
    func createNoteWith(title: String, text: String) throws {
        let note: Note = .init(title: title, text: text, createAt: .now)
        mockDatabase.append(note)
    }
}

struct FetchAllNoteUseCaseMock: FetchAllNotesProtocol {
    func fetchAll() throws -> [Notes_Test.Note] {
        return mockDatabase
    }
}

struct UpdateNoteUseCaseMock: UpdateNoteProtocol {
    func updateNoteWith(id: UUID, title: String, text: String) throws {
        if let index = mockDatabase.firstIndex(where: { $0.identifier == id }) {
            mockDatabase[index].title = title
            mockDatabase[index].text = text
        }
    }
    
}

struct RemoveNoteUseCaseMock: DeleteNoteProtocol {
    func deleteNoteWith(id: UUID) throws {
        mockDatabase.removeAll(where: { $0.identifier == id})
    }
}
