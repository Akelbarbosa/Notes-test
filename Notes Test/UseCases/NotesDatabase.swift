//
//  NotesDatabase.swift
//  Notes Test
//
//  Created by Akel Barbosa on 28/03/24.
//

import Foundation
import SwiftData

enum DatabaseError: Error {
    case errorInsert
    case errorFetch
    case errorUpdate
    case errorRemove
}

protocol NotesDatabaseProtocol {
    
    func insert(note: Note) throws
    func fetchAll() throws -> [Note]
    func remove(identifier: UUID) throws
    func update(id: UUID, title: String, text: String?) throws
}

class NotesDatabase: NotesDatabaseProtocol {
    static let shared = NotesDatabase()
    
    @MainActor
    
    var container: ModelContainer = setupContainer(inMemory: false)
    
    @MainActor
    static func setupContainer(inMemory: Bool) -> ModelContainer {
        do {
            let container = try ModelContainer(for: Note.self, configurations: ModelConfiguration(isStoredInMemoryOnly: inMemory))
            container.mainContext.autosaveEnabled = true
            return container
            
        } catch  {
            print("Error: \(error.localizedDescription)")
            fatalError("Database can't be created")
        }
    }
    
    @MainActor
    func insert(note: Note) throws {
        container.mainContext.insert(note)
        
        do {
            try container.mainContext.save()
        } catch {
            print("Error: \(error.localizedDescription)")
            throw DatabaseError.errorInsert
        }
    }
    
    
    @MainActor
    func fetchAll() throws -> [Note] {
        let fetchDescriptor = FetchDescriptor<Note>(sortBy: [SortDescriptor<Note>(\.createAt)])
        
        do {
            return try container.mainContext.fetch(fetchDescriptor)
        } catch {
            print("Error: \(error.localizedDescription)")
            throw DatabaseError.errorFetch
        }
    }
    
    @MainActor
    func remove(identifier: UUID) throws {
        let notePredicate = #Predicate<Note> {
            $0.identifier == identifier
        }
        
        var fetchDescriptor = FetchDescriptor<Note>(predicate: notePredicate)
        fetchDescriptor.fetchLimit = 1
        
        do {
            guard let deleteNote = try container.mainContext.fetch(fetchDescriptor).first else {
                throw DatabaseError.errorRemove
            }
            
            container.mainContext.delete(deleteNote)
            try container.mainContext.save()
        } catch {
            print("Error: remove note has failded")
            throw DatabaseError.errorRemove
        }
    }
    
    @MainActor
    func update(id: UUID, title: String, text: String?) throws {
        let notePredicate = #Predicate<Note> {
            $0.identifier == id
        }
        
        var fetchDescriptor = FetchDescriptor<Note>(predicate: notePredicate)
        fetchDescriptor.fetchLimit = 1
        
        do {
            guard let updateNote = try container.mainContext.fetch(fetchDescriptor).first else {
                throw DatabaseError.errorUpdate
            }
            
            updateNote.title = title
            updateNote.text = text
            
            try container.mainContext.save()
        } catch {
            print("Error: update note has failed")
            throw DatabaseError.errorUpdate
        }
    }
    
    
    
}
