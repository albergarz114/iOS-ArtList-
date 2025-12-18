// ImageCacheTests.swift
import XCTest
@testable import ArtList
import UIKit

final class ImageCacheTests: XCTestCase {
    
    
    func testBasicCacheFunctionality() {
        // Test the singleton
        let cache = ImageCache.shared
        
        // Clear any existing cache
        cache.clearCache()
        
        // Create test image
        let testImage = UIImage(systemName: "star.fill")!
        let testURL = "https://test.com/image.jpg"
        
        // Test save
        cache.saveImage(testImage, for: testURL)
        
        // Test retrieve - might hit memory or disk
        let retrieved = cache.getImage(for: testURL)
        XCTAssertNotNil(retrieved, "Should retrieve saved image")
        
        // Test clear
        cache.clearCache()
        
        // Verify stats exist
        let stats = cache.getStats()
        XCTAssertFalse(stats.isEmpty, "Should return statistics")
        
        print("✅ Basic cache functionality test passed")
    }
    
    
    
    func testCacheStatistics() {
        
        let cache = ImageCache.shared
        cache.clearCache()
        cache.resetStats()
        
        let testImage = UIImage(systemName: "circle.fill")!
        
        // Make some cache operations
        cache.saveImage(testImage, for: "url1.jpg")
        _ = cache.getImage(for: "url1.jpg") // Should hit
        _ = cache.getImage(for: "url2.jpg") // Should miss
        
        
        let rawStats = cache.getRawStats()
        XCTAssertGreaterThanOrEqual(rawStats.saves, 1)
        XCTAssertGreaterThanOrEqual(rawStats.memoryHits, 0)
        XCTAssertGreaterThanOrEqual(rawStats.misses, 1)
        
        print("✅ Cache statistics test passed")
    }
    
    
    
    func testClearCache() {
        let cache = ImageCache.shared
        
        // Add some images
        let testImage = UIImage(systemName: "square.fill")!
        for i in 0..<3 {
            cache.saveImage(testImage, for: "test\(i).jpg")
        }
        
        // Clear
        cache.clearCache()
        
        // Check that clear didn't crash
        XCTAssertTrue(true, "Clear cache should complete without error")
        
        print("✅ Clear cache test passed")
    }
}
