//
//  Notes_TestTests.swift
//  Notes TestTests
//
//  Created by Akel Barbosa on 24/03/24.
//

import XCTest
@testable import Notes_Test

final class NoteTest: XCTestCase {

    func testNoteInitialization() {
        // Given or Arrange
        let title = "Test Title"
        let text = "Test Text"
        let date = Date()
        
        //When or Act
        let note = Note(title: title, text: text, createAt: date)
        
        // Then or Assert
        XCTAssertEqual(note.title, title)
        XCTAssertEqual(note.text, text)
        XCTAssertEqual(note.createAt, date)
    }
    
    func testNoteEmptyText() {
        // Given or Arrange
        let title = "Test Title"
        let date = Date()
        
        //When or Act
        let note = Note(title: title, text: nil, createAt: date)
        
        // Then or Assert
        XCTAssertEqual(note.getText, "", "The text should be empty")
    }

}
