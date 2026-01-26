# Income Dashboard

Flutter-based income tracking dashboard. The app lives under `wealth/income_tracker` and uses
Bloc for state management, Firebase Core for backend wiring, and `fl_chart` for charts.

## Features
- Income dashboard UI built with Flutter.
- Add income methods
- Add asserts
- Add liabilities.
- Show charts

![Uploading Screenshot 2026-01-26 224844.png…]()

<img width="489" height="936" alt="Screenshot 2026-01-26 224856" src="https://github.com/user-attachments/assets/1a5616d5-6680-4f8d-94e8-586efeda5a1a" />

<img width="486" height="939" alt="Screenshot 2026-01-26 224904" src="https://github.com/user-attachments/assets/9fb5313b-1eb0-4ca6-98ce-1d1b2ddb4c5d" />
<img width="492" height="939" alt="Screenshot 2026-01-26 224933" src="https://github.com/user-attachments/assets/bafd8151-e4db-472c-b6cc-0829fabae9bd" />

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
