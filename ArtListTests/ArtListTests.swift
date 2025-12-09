//
//  ArtListTests.swift
//  ArtListTests
//
//  Created by Alberto Garza on 09.12.25.
//

import XCTest
import SwiftData
@testable import ArtList

@MainActor
final class ArtListTests: XCTestCase {

    private var repository: ArtRepository!
    
    override func setUp() {
        
        super.setUp()
        
        let container = try! ModelContainer(for: SavedArts.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        
        let modelContext = ModelContext(container)
        repository = ArtRepository(modelContext: modelContext)
    }
    
    override func tearDown() {
        
        repository = nil
        
        super.tearDown()
    }
    
    // Save Art Tests
    func testSaveArt_InsertsIntoContext() {
        
        let artwork = Artworks(
            id: 1,
            title: "Test Title",
            image: "test.jpg"
            )
        
        repository.saveArt(artwork)
        
        let savedArts = repository.fetchAllSavedArts()
        XCTAssertEqual(savedArts.count, 1)
        XCTAssertEqual(savedArts.first?.title, "Test Title")
        
    }
    
    
    
    // Fetch All Arts Tests
    func testFetchAllSavedArts_ReturnsEmptyArray() {
        
        let result = repository.fetchAllSavedArts()
        
        XCTAssertTrue(result.isEmpty)
    }
    
    
    
    func testFetchAllSavedArts_ReturnsSavedArts() {
        
        let artwork = Artworks(
            id: 1,
            title: "Test Title",
            image: "test.jpg"
        )
        
        repository.saveArt(artwork)
        
        let result = repository.fetchAllSavedArts()
        
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.title, "Test Title")
        
    }
    
    
    // Delete
    func testDeleteArts_RemovesFromContext() {
        
        let artwork = Artworks(
            id: 1,
            title: "Test Title",
            image: "test.jpg"
        )
        
        repository.saveArt(artwork)
        let savedArts = repository.fetchAllSavedArts().first!
        
        repository.deleteArts(savedArts)
        
        let results = repository.fetchAllSavedArts()
        XCTAssertTrue(results.isEmpty)
    }
    
    
    // Delete All ArtWork
    func testDeleteAllArts_RemovesAllItems() {
        
        let artwork1 = Artworks(
            id: 1,
            title: "Test Title 1",
            image: "test.jpg"
        )
        
        let artwork2 = Artworks(
            id: 2,
            title: "Test Title 2",
            image: "test.jpg"
        )
        
        repository.saveArt(artwork1)
        repository.saveArt(artwork2)
        
        repository.deleteAllArts()
        
        let results = repository.fetchAllSavedArts()
        XCTAssertTrue(results.isEmpty)
    }
    
    
    // Testing for Star ratings
    func testStarArtwork_AddStarToTitle() {
        
        let artwork = Artworks(
            id: 1,
            title: "Test Title",
            image: "test.jpg"
        )
        
        repository.saveArt(artwork)
        let savedArts = repository.fetchAllSavedArts().first!
        
        repository.starArts(savedArts)
        
        let updatedArtwork = repository.fetchAllSavedArts().first!
        XCTAssertEqual(updatedArtwork.title, "⭐Test Title")
    }
    
    
    
    func testStarsArts_WithNilTitle() {
        
        let artwork = Artworks(
            id: 1,
            title: nil,
            image: "test.jpg"
        )
        
        repository.saveArt(artwork)
        let savedArts = repository.fetchAllSavedArts().first!
        
        repository.starArts(savedArts)
        
        let results = repository.fetchAllSavedArts().first!
        XCTAssertEqual(results.title, "⭐No Title")
    }

}
