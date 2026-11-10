# Workout App

A workout tracking app built with Flutter. Create workouts, add exercises, and keep everything synced to your account in the cloud.

<!-- Screenshots coming soon -->

## Features

- Sign up and log in with email and password (Firebase Authentication)
- Each user has their own workouts, stored in Cloud Firestore
- Create, edit and delete workouts
- Add exercises with muscle group, sets, reps and weight
- Reorder exercises with drag and drop
- Filter exercises by muscle group
- Search exercises by name (with debounce)
- Form validation, with the keyboard moving from one field to the next
- Light and dark theme, saved on the device (SharedPreferences)

## Architecture

The app follows MVVM, and each layer has a single job:

```
Page → Controller → Service → Firestore / Hive
            │
            └→ Notifier → Page rebuilds
```

- **Models**: `Treino` (workout) and `Exercicio` (exercise), with `fromJson`, `toJson` and `copyWith`
- **Notifiers**: `ValueNotifier`s that hold the app state and rebuild the screen when it changes
- **Controllers**: the only layer the pages talk to. They call the Services and update the Notifiers
- **Services**: the only layer that talks to Firebase, Hive or SharedPreferences
- **Dependency injection**: GetIt

Storage sits behind an abstract `StorageService` with two implementations: Hive (local) and Firestore (cloud). Switching between them takes one line in the service locator.

## Tech stack

Flutter · Dart · Firebase Authentication · Cloud Firestore · Hive · SharedPreferences · GetIt · uuid

## Getting started

```bash
git clone https://github.com/davibispo12/Workout-App.git
cd Workout-App
flutter pub get
flutter run -d chrome
```

The app is connected to my Firebase project. To use your own, create a Firebase project and run `flutterfire configure`.

## Next steps

```bash
git clone https://github.com/davibispo12/Workout-App.git
cd Workout-App
flutter pub get
flutter run -d chrome
```

The app is connected to my Firebase project. To use your own, create a Firebase project and run `flutterfire configure`.

## Next steps

- History and Progress tabs (they show "coming soon" for now)
- Weight progress chart
- Rest timer between sets
- Unit tests