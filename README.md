# Match the Pair

Match the Pair is a simple Flutter image-matching game with a clean, colorful UI and lightweight scoring. Tap the cards to shuffle them, try to find a match, and build your streak.

## Features

- Modern Material 3 design
- Animated, polished game screen
- Score, streak, and round tracking
- Random image matching gameplay
- Works across mobile, desktop, and web

## Screenshots

Add screenshots here after you capture a build:

- `images/` for game assets
- A `screenshots/` folder for GitHub images

## Getting Started

### Requirements

- Flutter SDK 3.11 or newer
- Dart 3.11 or newer

### Install

```bash
flutter pub get
```

### Run

```bash
flutter run
```

### Test

```bash
flutter test
```

## How to Play

1. Open the app.
2. Tap either card or the shuffle button.
3. Keep shuffling until both images match.
4. Build your score and streak by finding more matches.

## Project Structure

- `lib/main.dart` - main app, theme, and game logic
- `images/` - image assets used by the game
- `test/widget_test.dart` - basic widget test

## Notes

- The game currently uses local image assets from the `images/` folder.
- If you add or rename assets, update `pubspec.yaml` and the image paths in `lib/main.dart`.
- This project is ready to publish on GitHub as a small portfolio game or starter Flutter demo.
