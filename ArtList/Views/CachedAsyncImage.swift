// CachedAsyncImage.swift - FIXED VERSION
import SwiftUI


struct CachedAsyncImage: View {
    let urlString: String?
    let placeholder: Image
    let errorImage: Image
    
    @State private var image: UIImage? = nil
    @State private var isLoading = false
    
    // Add properties for customization
    private var frameHeight: CGFloat = 200
    private var cornerRadius: CGFloat = 10
    
    
    init(urlString: String?,
         placeholder: Image = Image(systemName: "photo"),
         errorImage: Image = Image(systemName: "exclamationmark.triangle")) {
        self.urlString = urlString
        self.placeholder = placeholder
        self.errorImage = errorImage
    }
    
    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: frameHeight)
                    .cornerRadius(cornerRadius)
            } else if isLoading {
                placeholder
                    .resizable()
                    .scaledToFit()
                    .frame(height: frameHeight)
                    .cornerRadius(cornerRadius)
                    .overlay(ProgressView())
            } else {
                placeholder
                    .resizable()
                    .scaledToFit()
                    .frame(height: frameHeight)
                    .cornerRadius(cornerRadius)
            }
        }
        .onAppear {
            loadImage()
        }
        .onChange(of: urlString) { _ in
            loadImage()
        }
    }
    
    // MARK: - Customization Methods
    // These allow you to customize from outside
    func frame(height: CGFloat) -> Self {
        var view = self
        view.frameHeight = height
        return view
    }
    
    func cornerRadius(_ radius: CGFloat) -> Self {
        var view = self
        view.cornerRadius = radius
        return view
    }
    
    private func loadImage() {
        guard let urlString = urlString, !urlString.isEmpty else {
            return
        }
        
        // 1. Check cache first
        if let cachedImage = ImageCache.shared.getImage(for: urlString) {
            self.image = cachedImage
            return
        }
        
        // 2. If not in cache, download
        isLoading = true
        
        guard let url = URL(string: urlString) else {
            isLoading = false
            return
        }
        
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                
                if let downloadedImage = UIImage(data: data) {
                    // Save to cache
                    ImageCache.shared.saveImage(downloadedImage, for: urlString)
                    
                    // Update on main thread
                    await MainActor.run {
                        self.image = downloadedImage
                        self.isLoading = false
                    }
                }
            } catch {
                print("Error loading image: \(error)")
                await MainActor.run {
                    self.isLoading = false
                }
            }
        }
    }
}
