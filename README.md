# Income Dashboard

Flutter-based income tracking dashboard. The app lives under `wealth/income_tracker` and uses
Bloc for state management, Firebase Core for backend wiring, and `fl_chart` for charts.

## Features
- Income dashboard UI built with Flutter.
- Charting via `fl_chart`.
- Internationalization utilities via `intl`.
- Unique IDs via `uuid`.
- Bloc-based state management.

## Requirements
- Flutter SDK installed.
- Dart SDK compatible with `^3.9.2` (see `wealth/income_tracker/pubspec.yaml`).

## Getting started
```bash
cd wealth/income_tracker
flutter pub get
flutter run
```

## Project layout
- `wealth/income_tracker/lib` — Flutter application source.
- `wealth/income_tracker/packages/assert_repository` — local package dependency.
- `ReactApp/` — separate React project (if applicable to your workflow).

## Notes
- If you plan to use Firebase, ensure you add platform-specific Firebase config files
  (e.g., `google-services.json` / `GoogleService-Info.plist`) for your targets.
