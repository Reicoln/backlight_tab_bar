# BacklightTabBar

A customizable Flutter tab bar widget with a highlight effect and smooth animations.

![BacklightTabBar Example](https://via.placeholder.com/800x200.png?text=BacklightTabBar+Preview) <!-- Можно заменить на свой скрин -->

## ✨ Features
- Smooth highlight animation when switching tabs
- Customizable colors, height, and text visibility
- Optional always-visible labels
- Easy integration with your app's navigation

---

## 📦 Installation

Add the dependency in your `pubspec.yaml`:

```yaml
dependencies:
  backlight_tab_bar: ^0.0.1
```

## 🚀 Usage

```dart
import 'package:flutter/material.dart';
import 'package:backlight_tab_bar/backlight_tab_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<TabItem> _tabs = const [
    TabItem(
      selectedIcon: Icons.home,
      unselectedIcon: Icons.home_outlined,
      title: 'Home',
    ),
    TabItem(
      selectedIcon: Icons.search,
      unselectedIcon: Icons.search_outlined,
      title: 'Search',
    ),
    TabItem(
      selectedIcon: Icons.person,
      unselectedIcon: Icons.person_outline,
      title: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Page $_currentIndex'),
      ),
      bottomNavigationBar: BacklightTabBar(
        currentIndex: _currentIndex,
        items: _tabs,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        showTextAlways: false,
        height: 60,
        backgroundColor: Colors.white,
        selectedColor: Colors.blueAccent,
        unselectedColor: Colors.grey,
      ),
    );
  }
}
```
## Parameters

| Parameter         | Type                | Default              | Description                            |
| ----------------- | ------------------- | -------------------- | -------------------------------------- |
| `currentIndex`    | `int`               | —                    | The index of the selected tab.         |
| `items`           | `List<TabItem>`     | —                    | List of tab items to display.          |
| `onTap`           | `ValueChanged<int>` | —                    | Callback when a tab is tapped.         |
| `showTextAlways`  | `bool`              | `false`              | Whether to always show the text label. |
| `height`          | `double`            | `56`                 | Height of the tab bar.                 |
| `backgroundColor` | `Color`             | `Colors.transparent` | Background color of the bar.           |
| `selectedColor`   | `Color`             | `Colors.blueAccent`  | Color for the selected tab.            |
| `unselectedColor` | `Color`             | `Colors.grey`        | Color for the unselected tabs.         |


## 📝 License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.
