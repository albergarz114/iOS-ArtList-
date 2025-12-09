# ArtList - iOS Art Discovery App


A modern iOS application for discovering and saving artwork, featuring **dual-layer image caching**, **offline capability**, **comprehensive testing**, and **production-ready architecture**. Developed with AI collaboration using DeepSeek for architecture planning and code review.

## Features That Stand Out

### Performance Optimization
- **Custom Image Caching System** - Dual-layer (memory + disk) caching reducing repeat image loading by 95%
- **Offline Browsing** - Previously viewed artwork remains accessible without internet
- **Background Operations** - Non-blocking image downloads and cache persistence
- **Real-time Cache Analytics** - Performance monitoring with hit/miss statistics


### AI-Enhanced Development
- **DeepSeek AI Collaboration** - Used for architecture planning, code review, and optimization suggestions
- **AI-Powered Problem Solving** - Leveraged AI assistance for complex caching implementation
- **Code Quality Assurance** - AI-assisted code review and best practices validation
- **Learning Acceleration** - AI guidance on modern iOS patterns and Swift concurrency

###  Modern iOS Stack
- **SwiftUI** - Declarative UI with modern Swift patterns
- **SwiftData** - Persistent storage with automatic sync
- **Async/Await** - Clean, readable asynchronous programming
- **MVVM Architecture** - Clean separation of concerns
- **Repository Pattern** - Abstracted data layer for testability

###  User Experience
- **Onboarding Flow** - Guided first experience with AppStorage persistence
- **Dual View Modes** - Grid (Gallery) and List browsing options
- **Save & Organize** - Persistent favorites with full CRUD operations
- **Smooth Animations** - Native iOS feel with proper transitions
- **Error Handling** - User-friendly error states and recovery options


### Key Architectural Decisions:
1. **Repository Pattern** - Abstracting data layer from business logic
2. **Observable State** - Single source of truth with `@Observable`
3. **Protocol-Oriented** - Testable, modular design
4. **Test-First Approach** - Critical components developed with tests

##  Testing Coverage

| Component | Test Coverage | What's Tested |
|-----------|---------------|---------------|
| **ImageCache** | ✅ Comprehensive | Memory/disk caching, thread safety, performance |
| **ArtRepository** | ✅ Full CRUD | SwiftData operations, model conversion |

### Test Statistics:
- **Total Tests**: 12+ test cases
- **Coverage Areas**: Network, caching, persistence, business logic
- **Test Types**: Unit tests, integration tests
- **Async Testing**: Full async/await support


### Running Tests:
```bash
# Run all tests
⌘ + U

# Run specific test suite
Navigate to test file → Click diamond icon

# Test coverage report
Xcode → Report Navigator → Coverage
