//
//  ImageCache.swift
//  ArtList
//
//  Created by Alberto Garza on 09.12.25.
//

// ImageCache.swift
import Foundation
import UIKit

class ImageCache {
    

    // 1. Create a shared instance (Singleton)
    static let shared = ImageCache()
    
    // 2. Create two caches: one in memory (fast), one on disk (persistent)
    private let memoryCache = NSCache<NSString, UIImage>()
    private let diskCacheDirectory: URL
    
    // 3. Add cache statistics tracking
    private var memoryHitCount = 0
    private var diskHitCount = 0
    private var missCount = 0
    private var saveCount = 0
    
    
    // 4. Private initializer
    private init() {
        // Create cache directory if it doesn't exist
        let fileManager = FileManager.default
        let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        diskCacheDirectory = cacheDirectory.appendingPathComponent("ArtImages")
        
        do {
            try fileManager.createDirectory(at: diskCacheDirectory, withIntermediateDirectories: true)
        } catch {
            print("Error creating cache directory: \(error)")
        }
    }
    
    
    // 5. Get image from cache
    func getImage(for urlString: String) -> UIImage? {
        // First check memory cache
        if let cachedImage = memoryCache.object(forKey: urlString as NSString) {
            memoryHitCount += 1
            print("✅ Loaded from MEMORY cache: \(urlString)")
            return cachedImage
        }
        
        // Then check disk cache
        if let diskImage = loadFromDisk(urlString: urlString) {
            diskHitCount += 1
            print("✅ Loaded from DISK cache: \(urlString)")
            // Store in memory cache for next time
            memoryCache.setObject(diskImage, forKey: urlString as NSString)
            return diskImage
        }
        
        missCount += 1
        print("❌ Not in cache: \(urlString)")
        return nil
    }
    
    // 6. Save image to cache
    func saveImage(_ image: UIImage, for urlString: String) {
        // Save to memory cache
        memoryCache.setObject(image, forKey: urlString as NSString)
        saveCount += 1
        // Save to disk cache (in background)
        DispatchQueue.global(qos: .utility).async {
            self.saveToDisk(image: image, urlString: urlString)
        }
    }
    
    // 7. Helper to save to disk
    private func saveToDisk(image: UIImage, urlString: String) {
        guard let data = image.jpegData(compressionQuality: 0.8) else { return }
        
        // Create a filename from the URL
        let filename = urlString.replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: ":", with: "_")
        let fileURL = diskCacheDirectory.appendingPathComponent(filename)
        
        do {
            try data.write(to: fileURL)
            print("💾 Saved to disk cache: \(filename)")
        } catch {
            print("Error saving to disk: \(error)")
        }
    }
    
    // 8. Helper to load from disk
    private func loadFromDisk(urlString: String) -> UIImage? {
        let filename = urlString.replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: ":", with: "_")
        let fileURL = diskCacheDirectory.appendingPathComponent(filename)
        
        guard let data = try? Data(contentsOf: fileURL),
              let image = UIImage(data: data) else {
            return nil
        }
        return image
    }
    
    // 9. Clear cache (optional)
    func clearCache() {
        memoryCache.removeAllObjects()
        
        let fileManager = FileManager.default
        do {
            let files = try fileManager.contentsOfDirectory(at: diskCacheDirectory,
                                                            includingPropertiesForKeys: nil)
            for file in files {
                try fileManager.removeItem(at: file)
            }
            
            // Reset statistics
            memoryHitCount = 0
            diskHitCount = 0
            missCount = 0
            saveCount = 0
            
            print("🧹 Cache cleared")
        } catch {
            print("Error clearing cache: \(error)")
        }
    }
    
    
    // 10. NEW: Get cache statistics
    func getStats() -> String {
        let totalRequests = memoryHitCount + diskHitCount + missCount
        
        guard totalRequests > 0 else {
            return "Cache Stats: No requests yet"
        }
        
        let hitRate = Double(memoryHitCount + diskHitCount) / Double(totalRequests) * 100
        let memoryHitRate = Double(memoryHitCount) / Double(totalRequests) * 100
        let diskHitRate = Double(diskHitCount) / Double(totalRequests) * 100
        
        return """
            📊 Cache Statistics:
            • Total Requests: \(totalRequests)
            • Memory Hits: \(memoryHitCount) (\(String(format: "%.1f", memoryHitRate))%)
            • Disk Hits: \(diskHitCount) (\(String(format: "%.1f", diskHitRate))%)
            • Misses: \(missCount) (\(String(format: "%.1f", 100 - hitRate))%)
            • Overall Hit Rate: \(String(format: "%.1f", hitRate))%
            • Images Saved: \(saveCount)
            """
    }
    
    // 11. NEW: Print statistics (for debugging)
    private func printStats() {
        let total = memoryHitCount + diskHitCount + missCount
        if total > 0 && total % 5 == 0 { // Print every 5 requests
            print(getStats())
        }

    }
    
    // 12. NEW: Get raw statistics for UI display
    func getRawStats() -> (memoryHits: Int, diskHits: Int, misses: Int, saves: Int) {
        return (memoryHitCount, diskHitCount, missCount, saveCount)
    }
    
    // 13. NEW: Reset statistics (optional)
    func resetStats() {
        memoryHitCount = 0
        diskHitCount = 0
        missCount = 0
        saveCount = 0
        print("📊 Statistics reset")
    }
}
