
# AVApp - Movie Explorer

AVApp uses the MovieDB API to display a list of popular movies, details of a movie, and a search feature to look for any movie you like !

## 📋 Table of Contents

- [Architecture](#architecture)
- [Key Features](#key-features)
- [Installation & Run](#installation--run)
- [Moving Forward](#moving-forward)

---

## :house:  Architecture

This project follows a clean, modular architecture designed for maintainability and testability:

### MVVM + Coordinator Pattern

The application uses **Model-View-ViewModel (MVVM)** combined with the **Coordinator pattern** for navigation:

This separation ensures testability, reusability, and scalability

On top of that, the app uses a revised implementation of the **Clean Archictecture**, so it ensure easy maintainability and responsibility dispatch.

### Dependency Injection

The project implements a **custom dependency injection engine** defined in **Module** 

The decision was made to create custom DI instead of third-party library for several reasons : 
- It reduces app size and potential security vulnerabilities
- We have full control on what is and needs to be done with injection
- It leverages environment system for natural integration
- It is easy to use and to mock

Usage:
```swift
class GetMovieDetailsUseCase: GetMovieDetailsUseCaseProtocol {
    private let movieRepository: any MovieRepositoryProtocol

    init(movieRepository: any MovieRepositoryProtocol = Module.shared.resolve()) {
        self.movieRepository = movieRepository
    }
}
```

### Network Layer with Caching

The networking architecture implements caching strategies to make some requests to be triggered only once.

The benefits are an improved performance, reduced latency, reduced server load and API costs, and better user experience in poor network conditions.

### Localization

The project is fully localized using Swift's native localization system:
For now, the only languages are English and French. But we can easily provide new languages for the app if needed.

---

## 🚀 Key Features

### No Third-Party Dependencies

This project intentionally avoids external dependencies. The language is mature enough to have a project like this not using any third-party dependencies, so we have full understanding and customization of all code, smaller binary, no breaking changes from library updates (expect for Apple frameworks).

### iOS 16.0+

The choice was made to target ios 16.0+ so we can use latest features without putting aside many people (<0.5% people are running below iOS 16)

---

## 💻 Installation & Run

### Prerequisites

- Xcode 15.0 or later
- iOS 16.0 or later
- Swift 5.9+

### Setup

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd <project-directory>
   ```

2. **Configure API Keys**
   
   Create a `Secrets.xcconfig` file in the project:
   ```bash
   touch AVApp/Resources/Secrets.xcconfig
   ```

   Add your API keys:
   ```
   MOVIE_DB_API_KEY = {YOUR_API_KEY}
   ```

   **⚠️ Important**: `Secrets.xcconfig` is in `.gitignore` and should **never** be committed to version control. You need to add it to your project manually. The project will not work without this file

---

## 🚀 Moving Forward

### Planned Improvements

What the next steps should be ?

#### 1. **CI/CD** 
Ensure a CI/CD integration with Github Actions for example. This would trigger the app tests when having merge request and would reduce regressions.

#### 2. **Design System with Theme Management**

Create a centralized theme system that would be used accross the app. So the theme would be centralized and easy to modify

#### 3. **Swift Macros for Dependency Injection**

Migrate to Swift macros for compile-time Dependency Injection. This will avoid boilerplate code and have a nicer and more modern way of using dependency injection 

#### 4. LaunchScreen

Create a LaunchScreen with a call to the MovieDB configuration endpoint. This would ensure the app works based on the api information, and without hard coded value like now.

#### 5. **Backend API Key Management**

Move API keys to backend for enhanced security.  API keys in xcconfig can be extracted from binary and keys can be visible in build logs. This can lead to potential security issues. Using a back-end service to get the API Key could fix this problem

#### 5. **Automated UI Tests**

Create UI Tests to ensure the app navigation works nicely and screen are displayed properly.
