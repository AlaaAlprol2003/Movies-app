# Movies App

A feature-rich Flutter mobile application for discovering, browsing, and managing movies. Users can register/login, explore movies by genre, search, view detailed information, manage watchlists and history, and personalize their profile.

## Key Features

- **🎨 Splash Screen**: Custom splash screen displayed on app launch for a polished user experience.
- **🚀 Onboarding Screens**: Interactive onboarding flow for first-time users with smooth page transitions.
- **🔐 Authentication**: Secure registration, login, forgot password, and reset password flows powered by Bloc state management.
- **🎬 Movie Browsing**: Home tab with carousels, categorized movie lists, genre-based browsing, and powerful search functionality.
- **📽️ Movie Details**: Comprehensive movie page including cast, screenshots, genres, ratings, runtime, description, and similar movie suggestions.
- **👤 Profile Management**: Edit personal info (name, phone, avatar, email), view watchlist and viewing history, change password, logout, and delete account.
- **🔖 Watchlist & History**: Add/remove movies to watchlist (server-side), track viewing history locally using Hive.
- **🌍 Multi-Language Support**: English and Arabic with an animated language toggle switch.
- **📱 Responsive Design**: Fully adaptive UI using `flutter_screenutil`.
- **⚠️ Error Handling & Feedback**: Graceful error states and toast notifications for better UX.
## Architecture

This project follows **Clean Architecture** principles end-to-end, ensuring separation of concerns, testability, and maintainability:


## 🏗 Architecture & Design Patterns

The project is built with a focus on scalability and testability, utilizing:

- **Clean Architecture**: Strict separation of concerns (Data, Domain, and Presentation layers).
- **Domain-Driven Design (DDD)**: Pure Dart entities and use cases independent of frameworks.
- **Repository Pattern**: Abstracting data sources (Remote API vs Local Storage).
- **Dependency Inversion**: All dependencies flow inward to the core domain.



---

## 🛠 Tech Stack & Technologies Used

| Category | Technology / Package | Purpose |
| :--- | :--- | :--- |
| **Language** | Dart | Core programming language |
| **Framework** | Flutter | Cross-platform UI framework |
| **State Management** | `flutter_bloc` + `Provider` | BLoC for business logic, Provider for UI state |
| **Dependency Injection**| `injectable` + `get_it` | Automated and clean DI setup |
| **Networking** | `Dio` | HTTP client with interceptors & error handling |
| **Local Storage** | `Hive` & `SharedPreferences` | Fast NoSQL for history & lightweight key-value for auth |
| **Responsive Design** | `flutter_screenutil` | Pixel-perfect UI across different screen sizes |
| **Utilities** | `url_launcher`, `google_fonts` | External links and enhanced typography |
| **Code Generation** | `build_runner` | Generating DI and Hive adapters |

---


### Prerequisites
* Flutter SDK (3.0+ recommended)
* Dart SDK
* Android Studio / VS Code

