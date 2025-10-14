# iOS Project

A modern iOS application built with Swift and SwiftUI, showcasing best practices in architecture, dependency injection, and scalable design patterns.

## 📋 Table of Contents

- [Architecture](#architecture)
- [Key Features](#key-features)
- [Installation & Run](#installation--run)
- [Project Structure](#project-structure)
- [Design Decisions](#design-decisions)
- [Moving Forward](#moving-forward)

---

## 🏗 Architecture

This project follows a clean, modular architecture designed for maintainability and testability:

### MVVM + Coordinator Pattern

The application uses **Model-View-ViewModel (MVVM)** combined with the **Coordinator pattern** for navigation:

- **Models**: Pure data structures representing business entities
- **Views**: SwiftUI views that observe ViewModels and render UI
- **ViewModels**: Contain presentation logic, manage state, and coordinate between services
- **Coordinators**: Handle all navigation logic, decoupling views from navigation decisions

This separation ensures:
- **Testability**: ViewModels can be tested in isolation
- **Reusability**: Views and ViewModels are decoupled from navigation
- **Scalability**: Adding new flows doesn't require modifying existing views

### Dependency Injection

The project implements a **custom dependency injection engine** using Swift property wrappers and SwiftUI's environment system:

```swift
@propertyWrapper
struct Injected<T> {
    @Environment(\.container) private var container
    var wrappedValue: T { container.resolve(T.self) }
}
```

**Why custom DI instead of third-party libraries?**
- **Zero external dependencies**: Reduces app size and potential security vulnerabilities
- **Full control**: Customized to project needs without framework overhead
- **SwiftUI-native**: Leverages environment system for natural integration
- **Easy mocking**: One-line mock injection for previews and tests

Usage:
```swift
class UserViewModel: ObservableObject {
    @Injected var networkService: NetworkServiceProtocol
    @Injected var storageService: StorageServiceProtocol
}
```

### Network Layer with Caching

The networking architecture implements intelligent caching strategies:

```swift
protocol NetworkServiceProtocol {
    func fetch<T: Decodable>(_ endpoint: Endpoint, 
                            cachePolicy: CachePolicy) async throws -> T
}

enum CachePolicy {
    case cacheFirst      // Return cached data if available
    case networkFirst    // Always fetch fresh data, cache as backup
    case networkOnly     // Never use cache
    case cacheOnly       // Only use cache, fail if unavailable
}
```

**Cache Implementation:**
- **Memory cache**: Fast in-memory storage for frequently accessed data
- **Disk cache**: Persistent storage with expiration policies
- **Cache invalidation**: Automatic cleanup of stale data
- **Request deduplication**: Prevents redundant network calls

Benefits:
- Improved performance and reduced latency
- Offline capability for cached resources
- Reduced server load and API costs
- Better user experience in poor network conditions

### Coordinator Pattern

Navigation is centralized through coordinators:

```swift
protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    func start()
}

class AppCoordinator: Coordinator {
    func showUserProfile(user: User) { /* ... */ }
    func showSettings() { /* ... */ }
}
```

**Benefits:**
- Views don't know about navigation
- Deep linking is centralized
- Easy to test navigation flows
- Simplifies A/B testing different flows

### Localization

The project is fully localized using Swift's native localization system:

- **Localizable.strings**: All user-facing strings are externalized
- **String catalogs** (Xcode 15+): Modern localization with compile-time safety
- **Plural rules**: Proper handling of pluralization across languages
- **RTL support**: Full right-to-left language support

```swift
extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}

// Usage
Text("welcome_message".localized)
```

---

## 🚀 Key Features

### No Third-Party Dependencies

This project intentionally avoids external dependencies:

**Rationale:**
- **Security**: No risk of supply chain attacks or malicious packages
- **Stability**: No breaking changes from library updates
- **Performance**: Optimized implementations for specific needs
- **Control**: Full understanding and customization of all code
- **Maintenance**: No dependency version conflicts or deprecations
- **App Size**: Smaller binary without unnecessary framework code

**Native Alternatives Used:**
- URLSession + async/await instead of Alamofire
- Custom DI instead of Swinject or Resolver
- Native Combine/async-await instead of RxSwift
- SwiftUI navigation instead of third-party routers

### Protocol-Oriented Design

All services are protocol-based for flexibility:

```swift
protocol NetworkServiceProtocol { }
protocol StorageServiceProtocol { }
protocol AnalyticsServiceProtocol { }
```

This enables:
- Easy mocking for tests and previews
- Swapping implementations without changing consumers
- Better encapsulation and abstraction

---

## 💻 Installation & Run

### Prerequisites

- Xcode 15.0 or later
- iOS 17.0 or later
- Swift 5.9+

### Setup

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd <project-directory>
   ```

2. **Configure API Keys**
   
   Create a `Secrets.xcconfig` file in the project root:
   ```bash
   touch Secrets.xcconfig
   ```

   Add your API keys:
   ```
   API_KEY = your_api_key_here
   BASE_URL = https://api.example.com
   ```

   **⚠️ Important**: `Secrets.xcconfig` is in `.gitignore` and should **never** be committed to version control.

3. **Link Configuration**
   
   Ensure `Secrets.xcconfig` is set in your target's build settings:
   - Select your target
   - Go to Build Settings
   - Search for "Configuration"
   - Set `Secrets.xcconfig` for Debug and Release

4. **Access in Code**
   ```swift
   enum Config {
       static var apiKey: String {
           Bundle.main.infoDictionary?["API_KEY"] as? String ?? ""
       }
   }
   ```

5. **Run the project**
   ```bash
   open Project.xcodeproj
   # or
   xed .
   ```

   Then press `⌘ + R` to build and run.

---

## 📁 Project Structure

```
Project/
├── App/
│   ├── AppDelegate.swift
│   └── DIEngineApp.swift
├── Core/
│   ├── DependencyInjection/
│   │   ├── DependencyContainer.swift
│   │   ├── Injected.swift
│   │   └── DependencyRegistrar.swift
│   ├── Networking/
│   │   ├── NetworkService.swift
│   │   ├── Endpoint.swift
│   │   ├── CachePolicy.swift
│   │   └── NetworkError.swift
│   └── Coordinator/
│       ├── Coordinator.swift
│       └── AppCoordinator.swift
├── Features/
│   ├── User/
│   │   ├── Views/
│   │   ├── ViewModels/
│   │   └── Models/
│   └── Settings/
│       ├── Views/
│       ├── ViewModels/
│       └── Models/
├── Services/
│   ├── Storage/
│   ├── Analytics/
│   └── Auth/
├── Resources/
│   ├── Localization/
│   │   ├── en.lproj/
│   │   └── fr.lproj/
│   └── Assets.xcassets
└── Tests/
    ├── UnitTests/
    └── UITests/
```

---

## 🎯 Design Decisions

### Why Custom Implementations?

1. **Dependency Injection**: Native SwiftUI integration, zero overhead
2. **Networking**: URLSession is mature and performant enough
3. **Navigation**: Coordinator pattern provides enough structure
4. **Caching**: Custom implementation tailored to specific needs

### Architecture Principles

- **SOLID principles**: Single responsibility, dependency inversion
- **Protocol-first design**: All dependencies behind protocols
- **Immutability**: Value types preferred where possible
- **Async/await**: Modern concurrency throughout
- **SwiftUI-first**: Leveraging declarative UI paradigm

### Testing Strategy

- **Unit tests**: ViewModels, services, business logic
- **Integration tests**: Network layer, data persistence
- **UI tests**: Critical user flows
- **Mock injection**: Zero-boilerplate mocking via environment

---

## 🚀 Moving Forward

### Planned Improvements

#### 1. **Design System with Theme Management**

Create a centralized theme system:

```swift
struct Theme {
    struct Colors {
        static let primary = Color("Primary")
        static let secondary = Color("Secondary")
        static let background = Color("Background")
    }
    
    struct Typography {
        static let heading = Font.system(size: 24, weight: .bold)
        static let body = Font.system(size: 16)
    }
    
    struct Spacing {
        static let small: CGFloat = 8
        static let medium: CGFloat = 16
        static let large: CGFloat = 24
    }
}
```

**Benefits:**
- Consistent design across the app
- Easy theme switching (light/dark/custom)
- Centralized design token management
- Simplified designer-developer handoff

#### 2. **Accessibility First**

Enhance accessibility support:

- **VoiceOver**: Comprehensive labels and hints
- **Dynamic Type**: Support all text size categories
- **Color Contrast**: WCAG 2.1 AA compliance minimum
- **Reduced Motion**: Respect motion preferences
- **Testing**: Accessibility audits using Xcode tools

```swift
Text("welcome")
    .accessibilityLabel("Welcome message")
    .accessibilityHint("Tap to continue")
    .dynamicTypeSize(...large)
```

#### 3. **Comprehensive Testing (70%+ Coverage)**

Establish robust test coverage:

- **Unit Tests**: All ViewModels and business logic
- **Integration Tests**: Network and storage layers
- **Snapshot Tests**: UI regression detection
- **Performance Tests**: Load time and memory benchmarks
- **CI/CD**: Automated testing on every PR

**Target Coverage:**
- ViewModels: 90%+
- Services: 85%+
- Overall: 70%+

#### 4. **Enhanced Error Management**

Implement sophisticated error handling:

```swift
enum AppError: LocalizedError {
    case network(NetworkError)
    case storage(StorageError)
    case business(BusinessError)
    
    var errorDescription: String? { /* localized messages */ }
    var recoverySuggestion: String? { /* user actions */ }
}

protocol ErrorHandler {
    func handle(_ error: AppError)
    func present(_ error: AppError, retry: @escaping () -> Void)
}
```

**Features:**
- User-friendly error messages
- Retry mechanisms
- Error analytics tracking
- Graceful degradation

#### 5. **Swift Macros for Dependency Injection**

Migrate to Swift macros (Swift 5.9+) for compile-time DI:

```swift
@attached(member)
@attached(memberAttribute)
macro Injectable() = #externalMacro(module: "DIEngineMacros", type: "InjectableMacro")

@Injectable
class UserViewModel: ObservableObject {
    // Automatically generates injection code at compile time
    let networkService: NetworkServiceProtocol
    let storageService: StorageServiceProtocol
}
```

**Advantages:**
- Zero runtime overhead
- Compile-time safety
- Better autocomplete
- Cleaner generated code
- Easier refactoring

#### 6. **Backend API Key Management**

Move API keys to backend for enhanced security:

**Current Risk:**
- API keys in xcconfig can be extracted from binary
- Keys visible in build logs
- Potential for key rotation issues

**Proposed Solution:**

```swift
protocol AuthService {
    func fetchAPICredentials() async throws -> APICredentials
}

struct APICredentials {
    let token: String
    let expiresAt: Date
}

class SecureNetworkService: NetworkServiceProtocol {
    @Injected var authService: AuthService
    
    func fetch<T>(_ endpoint: Endpoint) async throws -> T {
        let credentials = try await authService.fetchAPICredentials()
        // Use credentials.token for authenticated requests
    }
}
```

**Security Benefits:**
- Keys never stored in app binary
- Token rotation without app updates
- Centralized key revocation
- Rate limiting per user
- Audit trails for API usage

**Implementation Steps:**
1. Create secure token exchange endpoint
2. Implement certificate pinning
3. Add biometric authentication for sensitive operations
4. Use Keychain for credential storage
5. Implement token refresh logic

---

## 📝 Contributing

When contributing, ensure:
- Code follows existing architecture patterns
- All new features include unit tests
- SwiftLint passes without warnings
- API keys remain in `Secrets.xcconfig`
- Localization strings are added for all text

---

## 📄 License

[Your License Here]

---

## 👥 Team

[Your Team Information]

---

**Note**: This README reflects the current architecture and planned improvements. As the project evolves, this document will be updated to reflect new patterns and decisions.
