# FlutterDemo

A Flutter assignment app using **Clean Architecture**: domain (entities, repositories, use cases), data (datasources, repository implementations), and presentation (pages, Cubits). State management with **flutter_bloc**; **GetX** for `GetMaterialApp` and snackbars.

**Repository:** [github.com/Sunny-Chaudhary09/FlutterDemo](https://github.com/Sunny-Chaudhary09/FlutterDemo)

---

## Project structure

```
lib/
├── main.dart                    # Entry: Injector.init(), MultiBlocProvider, GetMaterialApp
├── injection_container.dart     # DI: wires data → repos → use cases; creates FavoritesCubit, MessagesCubit
│
├── core/                        # Shared app primitives
│   ├── error/
│   │   └── failures.dart
│   └── usecases/
│       └── usecase.dart         # UseCase<T, Params>, NoParams
│
├── app/
│   └── main_shell.dart          # Bottom nav + IndexedStack (Home, Details, Favorites, Messages)
│
├── features/
│   ├── navigation/
│   │   └── presentation/
│   │       └── cubit/
│   │           └── navigation_cubit.dart    # Tab index (0–3)
│   │
│   ├── home/
│   │   └── presentation/
│   │       └── pages/
│   │           └── home_page.dart            # Search bar + listing cards
│   │
│   ├── details/
│   │   └── presentation/
│   │       └── pages/
│   │           └── details_page.dart        # Hero image, glass card, Book Now
│   │
│   ├── favorites/                            # Full Clean Architecture
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── calendar_selection.dart
│   │   │   ├── repositories/
│   │   │   │   └── calendar_repository.dart
│   │   │   └── usecases/
│   │   │       ├── get_calendar_selection.dart
│   │   │       ├── go_to_previous_month.dart
│   │   │       └── go_to_next_month.dart
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── calendar_local_datasource.dart
│   │   │   └── repositories/
│   │   │       └── calendar_repository_impl.dart
│   │   └── presentation/
│   │       ├── cubit/
│   │       │   └── favorites_cubit.dart
│   │       └── pages/
│   │           └── favorites_page.dart       # Date picker, stay summary, Next (Get.snackbar)
│   │
│   └── messages/                             # Full Clean Architecture
│       ├── domain/
│       │   ├── entities/
│       │   │   └── user_ui_settings.dart
│       │   ├── repositories/
│       │   │   └── settings_repository.dart
│       │   └── usecases/
│       │       ├── get_user_ui_settings.dart
│       │       └── set_dark_mode.dart
│       ├── data/
│       │   ├── datasources/
│       │   │   └── settings_local_datasource.dart
│       │   └── repositories/
│       │       └── settings_repository_impl.dart
│       └── presentation/
│           ├── cubit/
│           │   └── messages_cubit.dart
│           └── pages/
│               └── messages_page.dart        # Settings menu, dark mode toggle
│
├── shared/
│   └── widgets/
│       └── custom_widgets.dart               # CustomSearchBar, CustomBottomNavBar, CustomCard
│
├── services/
│   └── NativeChannel.dart                    # Android MethodChannel (optional)
│
└── native_android_view.dart                  # Platform view (optional)
```

**Dependency rule:** Presentation depends on Domain (use cases, entities). Data implements Domain repositories. Domain has no Flutter imports.

---

## Features

| Tab | Screen | Description |
|-----|--------|-------------|
| 1 | **Home** | Search bar (“Where to?”) + listing cards (Toronto, cost, distance, dates) |
| 2 | **Details** | Hero image, glassmorphism card, host info, stats, location, Book Now button |
| 3 | **Favorites** | Date selection calendar (glass UI), stay summary, price bar, Next → Get.snackbar |
| 4 | **Messages** | Settings-style menu: profile, Account/Hosting/More sections, Dark Mode switch |

---

## Requirements

- Flutter SDK (e.g. 3.10+)
- Dart 3.x
- Android Studio / Xcode for mobile; or Chrome for web

---

## Getting started

```bash
git clone https://github.com/Sunny-Chaudhary09/FlutterDemo.git
cd FlutterDemo
flutter pub get
flutter run
```

### Run from Android Studio

1. **File → Open** → select the `FlutterDemo` folder (root with `pubspec.yaml`).
2. Set **Flutter SDK path** if needed: **Settings → Languages & Frameworks → Flutter**.
3. Choose a device (emulator or connected device) in the toolbar.
4. Click **Run** (▶).

---

## Commands

| Command | Description |
|---------|-------------|
| `flutter pub get` | Install dependencies |
| `flutter clean` | Clear build cache |
| `flutter run` | Run on selected device |
| `flutter build apk` | Build Android release APK |
| `flutter test` | Run tests |

---

## Dependencies

- **flutter_bloc** – Cubits for state
- **equatable** – Value equality for entities/states
- **get** – GetMaterialApp, snackbars
- **cupertino_icons** – iOS-style icons

---

## Assets

- `assets/image1.jpeg`, `assets/image2.jpg` (declared in `pubspec.yaml`)

---

## License

Educational / assignment use unless otherwise stated.

**Author:** Sunny Chaudhary · [@Sunny-Chaudhary09](https://github.com/Sunny-Chaudhary09)
