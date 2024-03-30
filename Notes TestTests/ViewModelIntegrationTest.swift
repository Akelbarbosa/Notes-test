//
//  ViewModelIntegrationTest.swift
//  Notes TestTests
//
//  Created by Akel Barbosa on 28/03/24.
//

import XCTest
@testable import Notes_Test

@MainActor
final class ViewModelIntegrationTest: XCTestCase {
    var sut: ViewModel!
    
    override func setUpWithError() throws {
        let database = NotesDatabase.shared
        database.container = NotesDatabase.setupContainer(inMemory: true)
        
        let createNoteUseCase = CreateNoteUseCase(notesDatabase: database)
        let fetchAllNotesUseCase = FetchAllNotesUseCase(notesDatabase: database)
        
        sut  = ViewModel(createNoteUseCase: createNoteUseCase, fetchAllUseCase: fetchAllNotesUseCase)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testCreateNote() {
        //Given
        sut.createNoteWith(title: "Hello 1", text: "text 1")
        
        //when
        let note = sut.notes.first
        
        // Then
        XCTAssertNotNil(note)
        XCTAssertEqual(note?.title, "Hello 1")
        XCTAssertEqual(note?.text, "text 1")
        XCTAssertEqual(sut.notes.count, 1, "Should be a note in database")
    }
    
    func testCreateTwoNote() {
        //Given
        sut.createNoteWith(title: "Hello 1", text: "text 1")
        sut.createNoteWith(title: "Hello 2", text: "text 2")
        
        //when
        let firstNote = sut.notes.first
        let lastNote = sut.notes.last
        
        // Then
        XCTAssertNotNil(firstNote)
        XCTAssertEqual(firstNote?.title, "Hello 1")
        XCTAssertEqual(firstNote?.text, "text 1")
        
        XCTAssertNotNil(lastNote)
        XCTAssertEqual(lastNote?.title, "Hello 2")
        XCTAssertEqual(lastNote?.text, "text 2")
        
        XCTAssertEqual(sut.notes.count, 2, "Should be a note in database")
    }
    
    func testFetchAllNotes() {
        // Given
        sut.createNoteWith(title: "Hello 1", text: "text 1")
        sut.createNoteWith(title: "Hello 2", text: "text 2")
        
        // When
        let firstNote = sut.notes.first
        let lastNote = sut.notes.last
        
        //Then
        XCTAssertEqual(sut.notes.count, 2, "Should be a note in database")
        
        XCTAssertEqual(firstNote?.title, "Hello 1")
        XCTAssertEqual(firstNote?.text, "text 1")
        
        XCTAssertNotNil(lastNote)
        XCTAssertEqual(lastNote?.title, "Hello 2")
        XCTAssertEqual(lastNote?.text, "text 2")
        
    }
    
    func testUpdateNote() {
        
        //Given
        let title1 = "Test Title 1"
        let text1 = "Test Text 1"
        sut.createNoteWith(title: title1, text: text1)
        
        //When
        guard let note = sut.notes.first else {
            XCTFail()
            return
        }
        
        let newTitle = "New Title"
        let newText = "New Text"
        
        sut.updateNoteWith(id: note.identifier, newTitle: newTitle, newText: newText)
        sut.fetchAllNotes()
        
        XCTAssertEqual(sut.notes.count, 1)
        XCTAssertEqual(sut.notes.first?.title, newTitle)
        XCTAssertEqual(sut.notes.first?.text, newText)
    }
    
    func testRemoveNote() {
        //Given
        let title1 = "Test Title 1"
        let text1 = "Test Text 1"
        sut.createNoteWith(title: title1, text: text1)
        
        //When
        guard let note = sut.notes.first else {
            XCTFail()
            return
        }
        
        // Then
        sut.removeNoteWith(id: note.identifier)
       //sut.fetchAllNotes()
        
        XCTAssertEqual(sut.notes.count, 0)

    }
    
    func testRemoveNoteInDatabaseShouldThrowError() {
        sut.removeNoteWith(id: UUID())
        
        XCTAssertEqual(sut.notes.count, 0)
        XCTAssertNotNil(sut.databaseError)
        XCTAssertEqual(sut.databaseError, DatabaseError.errorRemove)
    }

}
