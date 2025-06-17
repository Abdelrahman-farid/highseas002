# 📝 HighSeas Animated Todo App
A beautiful and interactive Flutter todo app with sleek animations, a modern UI, and intuitive task management.

---

## 📲 Download the APK
🟢 Try the app on any Android phone by downloading the APK:
[👉 Download APK (v1.0.0)](https://github.com/Abdelrahman-farid/highseas002/releases/download/v1.0.0/app-release.apk)
> ⚠️ You may need to enable "Install from unknown sources" in your phone settings.

---

## ✨ Features

### 🎉 Animations & Effects
- Celebration animation when tasks are completed ("Good Job!" popup)
- Smooth transitions and animated card scaling
- Animated progress bar with percentage display
- Add button with bounce effect and haptic feedback
- Clean sliding animation when deleting tasks

### 🎨 Modern UI Design
- Elegant blue gradient theme
- Card-based layout with elevation and rounded corners
- Visual separation of completed and pending tasks
- Fully responsive across screen sizes
- Clear progress indicators and task counters

### 🔧 Smart Functionality
- Add new tasks via text input or Enter key
- Mark tasks complete with checkbox
- Delete tasks (only when completed)
- Live progress bar updates
- Displays total and completed task stats

---

## 🚀 Getting Started (for developers)

### Requirements
- Flutter SDK (latest version)
- Dart SDK
- Android Studio or VS Code
- Android emulator or physical device

### Installation
1. Clone the repo:
   ```bash
   git clone https://github.com/Abdelrahman-farid/highseas002.git
   cd highseas002
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## 📱 How to Use

### Adding Tasks
1. Type your task in the input field at the bottom
2. Press the blue "+" button or hit Enter
3. Task will appear in the list with animation

### Completing Tasks
1. Tap the checkbox next to any task
2. Watch the celebration animation appear
3. Task will turn green and show strikethrough text
4. Progress bar will update automatically

### Deleting Tasks
1. Complete a task first (tap the checkbox)
2. Delete button will appear on the right
3. Tap the red delete icon to remove the task

### Viewing Progress
- Check the progress bar below the app title
- See completion percentage and task count
- Watch the progress update in real-time

## 🛠️ Technical Details

### Built With
- **Flutter** - UI framework
- **Dart** - Programming language
- **Material Design** - UI components

### Key Dependencies
- `flutter/material.dart` - Material Design widgets
- `flutter/services.dart` - Haptic feedback

### Animation Components Used
- `AnimationController` - Controls animation timing
- `AnimatedContainer` - Smooth property transitions
- `AnimatedBuilder` - Custom animation rebuilding
- `Transform.scale` - Scaling animations
- `Tween<double>` - Animation value interpolation
- `CurvedAnimation` - Natural animation curves

### File Structure
```
lib/
├── main.dart
└── todolist.dart  (or your widget file)
```

## 🎯 Features Breakdown

### Core Functionality
- ✅ Add new tasks
- ✅ Mark tasks as complete/incomplete
- ✅ Delete completed tasks
- ✅ View task progress
- ✅ Persistent task list during session

### Animations
- ✅ Task completion celebration
- ✅ Smooth card transitions
- ✅ Button press feedback
- ✅ Progress bar animation
- ✅ Delete button slide-in

### UI/UX Enhancements
- ✅ Modern card design
- ✅ Color-coded task states
- ✅ Haptic feedback
- ✅ Responsive layout
- ✅ Clean typography

## 🔧 Customization

### Changing Colors
Update these color values in the code:
```dart
// Main theme color
backgroundColor: Colors.blue

// Completed task color
color: Colors.green[100]

// Progress indicator color
valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)
```

### Adjusting Animations
Modify animation duration:
```dart
// Celebration animation speed
duration: const Duration(milliseconds: 1500)

// Container transition speed
duration: const Duration(milliseconds: 300)
```

### Adding New Features
The code is structured to easily add:
- Task categories
- Due dates
- Priority levels
- Task editing
- Data persistence

## 🐛 Troubleshooting

### App Won't Run
1. Check Flutter version: `flutter --version`
2. Clean project: `flutter clean`
3. Get dependencies: `flutter pub get`
4. Restart IDE and emulator

### Animation Issues
- Ensure your State class includes `with TickerProviderStateMixin`
- Check that all AnimationControllers are properly disposed
- Verify Flutter version supports used widgets

### Common Errors
- **Controller disposed error**: Make sure `dispose()` method is implemented
- **Null reference error**: Check for proper null safety handling
- **Widget not found**: Ensure all imports are correct

## 📚 Learning Resources

### Flutter Animation Tutorials
- [Flutter Official Animation Tutorial](https://flutter.dev/docs/development/ui/animations)
- [Animation and Motion Widgets](https://flutter.dev/docs/development/ui/widgets/animation)

### Flutter Documentation
- [Widget Catalog](https://flutter.dev/docs/development/ui/widgets)
- [Material Design Components](https://flutter.dev/docs/development/ui/material)

## 🤝 Contributing

Feel free to contribute by:
1. Reporting bugs
2. Suggesting new features
3. Improving code quality
4. Adding more animations
5. Enhancing UI design

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 👨‍💻 Author

Created with ❤️ using Flutter

---

### 🎉 Enjoy your beautiful animated todo app!

*Happy coding!* 🚀
