# FlutterDemo

A Flutter assignment app with a dark-themed travel / booking UI: home listings, property details (glassmorphism), date picker, and a settings-style menu. State is managed with **BLoC (Cubit)** and the app shell uses **GetX** (`GetMaterialApp`, snackbars).

**Repository:** [github.com/Sunny-Chaudhary09/FlutterDemo](https://github.com/Sunny-Chaudhary09/FlutterDemo)

## Features

| Tab | Screen | Description |
|-----|--------|-------------|
| 1 | **Home** | Search bar + listing cards (Toronto, ratings, cost, distance, dates) |
| 2 | **Details** | Hero image, glass card, host info, stats, location, Book Now |
| 3 | **Favorites** | Date selection calendar (glass UI), stay summary, bottom price bar + **Next** |
| 4 | **Messages** | Settings / menu layout (profile, account, hosting, dark mode toggle) |

- Custom **bottom navigation** (navy bar, rounded top corners, 4 icons)
- **flutter_bloc** + **equatable** for navigation, calendar, and settings state
- **get** for `GetMaterialApp` and `Get.snackbar` on the date screen

## Project structure

```
lib/
├── main.dart                 # AppRoot (MultiBlocProvider) + GetMaterialApp
├── cubit/
│   ├── navigation_cubit.dart
│   ├── favorites_cubit.dart
│   └── messages_cubit.dart
├── screens/
│   ├── main_screen.dart
│   ├── home_screen.dart
│   ├── details_screen.dart
│   ├── favorites_screen.dart
│   └── messages_screen.dart
├── widgets/
│   └── custom_widgets.dart
└── services/
    └── NativeChannel.dart    # Optional Android method channel (if used)
```

## Requirements

- [Flutter](https://docs.flutter.dev/get-started/install) (SDK ^3.10.1)
- Android Studio / Xcode (for mobile targets) or Chrome (for web)

## Getting started

```bash
git clone https://github.com/Sunny-Chaudhary09/FlutterDemo.git
cd FlutterDemo
flutter pub get
flutter run
```

### Useful commands

| Command | Description |
|---------|-------------|
| `flutter pub get` | Install dependencies |
| `flutter analyze` | Static analysis |
| `flutter test` | Run widget tests |
| `flutter build apk` | Android release build |

## Dependencies

- `flutter_bloc` — Cubits for UI state  
- `equatable` — Value equality for states  
- `get` — Material app wrapper & GetX utilities  
- `cupertino_icons`

## Assets

Images are under `assets/` (`image1.jpeg`, `image2.jpg`) and registered in `pubspec.yaml`.

## License

This project is for educational / assignment use unless otherwise specified.

---

**Author:** Sunny Chaudhary ([@Sunny-Chaudhary09](https://github.com/Sunny-Chaudhary09))
