# Topic 12 - Study Planner

A small Flutter Web application demonstrating Provider, ChangeNotifier, Clean Code and MVVM.

## Run locally

```bash
flutter pub get
flutter run -d chrome
```

## Run tests

```bash
flutter test
```

## Build for web

```bash
flutter build web --release
```

## Project structure

```text
lib/
  data/repositories/study_repository.dart
  domain/models/study_task.dart
  presentation/viewmodels/study_view_model.dart
  presentation/viewmodels/theme_view_model.dart
  presentation/views/study_page.dart
  main.dart
test/
  study_view_model_test.dart
  study_page_test.dart
```

## Demo features

- Add a study task with a title and subject.
- Filter tasks by subject.
- Mark tasks complete or incomplete.
- Automatically calculate completed count and progress.
- Switch between light and dark themes.

## Provider concepts

- `MultiProvider` and `ChangeNotifierProvider`: register ViewModels.
- `context.watch`: rebuild UI when state changes.
- `context.read`: call ViewModel actions.
- `Consumer`: rebuild the app when the theme changes.
- `Selector`: rebuild only progress widgets when progress changes.

Sample tasks are stored in memory and reset when the app restarts. This keeps the demo focused on state management.
