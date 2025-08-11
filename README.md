# Backlight Tab Bar ✨
<!-- 
[![pub package](https://img.shields.io/pub/v/backlight_tab_bar.svg)](https://pub.dev/packages/backlight_tab_bar)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) -->

**BacklightTabBar** is a fully customizable Flutter bottom navigation bar with smooth animations, highlight effects, and flexible UI settings.

---

<!-- ## 📸 Preview -->

<!-- *(Add your GIF or image here)*  
Example:  
![Preview](https://your-preview-image-link.gif) -->

---

## 🚀 Installation

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  backlight_tab_bar: ^0.0.2
```

Import it in your Dart file:

```dart
import 'package:backlight_tab_bar/backlight_tab_bar.dart';
```

---

## 💻 Example

```dart
import 'package:flutter/material.dart';
import 'package:backlight_tab_bar/backlight_tab_bar.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Tab index: $_currentIndex"),
      ),
      bottomNavigationBar: BacklightTabBar(
        currentIndex: _currentIndex,
        items: [
          BacklightTabBarItem(
            unselectedIcon: Icons.home_outlined,
            selectedIcon: Icons.home,
            title: Text("Home"),
            borderColor: Colors.blue,
            backgroundShadowColor: Colors.blue,
            selectedIconColor: Colors.blue,
            selectedTitleColor: Colors.blue,
          ),
          BacklightTabBarItem(
            unselectedIcon: Icons.search_outlined,
            selectedIcon: Icons.search,
            title: Text("Search"),
            borderColor: Colors.green,
            backgroundShadowColor: Colors.green,
            selectedIconColor: Colors.green,
            selectedTitleColor: Colors.green,
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
```

---

## ⚙️ Parameters

### **BacklightTabBar**
| Parameter         | Type                  | Default                       | Description |
|-------------------|----------------------|--------------------------------|-------------|
| `currentIndex`    | `int`                | —                              | Current selected tab index |
| `items`           | `List<BacklightTabBarItem>` | —                        | List of navigation items |
| `onTap`           | `ValueChanged<int>`  | —                              | Callback when a tab is tapped |
| `height`          | `double`             | `70`                           | Height of the bar |
| `backgroundColor` | `Color`              | `Color(0xFF191919)`            | Background color |
| `duration`        | `Duration`           | `400ms`                        | Animation duration |
| `curve`           | `Curve`              | `Curves.linear`                | Animation curve |
| `elevation`       | `double`             | `8`                            | Material elevation |
| `padding`         | `EdgeInsets`         | `EdgeInsets.zero`              | Outer padding |

---

### **BacklightTabBarItem**
| Parameter               | Type        | Default           | Description |
|-------------------------|-------------|-------------------|-------------|
| `unselectedIcon`        | `IconData`  | `Icons.star_border_outlined` | Icon when unselected |
| `selectedIcon`          | `IconData`  | `Icons.star`      | Icon when selected |
| `size`                  | `double`    | `30`              | Icon size |
| `selectedIconColor`     | `Color`     | `Colors.white`    | Color for selected icon |
| `unselectedIconColor`   | `Color`     | `Colors.white54`  | Color for unselected icon |
| `highlightColor`        | `Color`     | `Colors.transparent` | Highlight color on tap |
| `splashColor`           | `Color`     | `Colors.transparent` | Splash color |
| `hoverColor`            | `Color`     | `Colors.transparent` | Hover color (Web/Desktop) |
| `borderColor`           | `Color`     | `Color(0xFF6c5ce7)` | Top border color when selected |
| `borderWidth`           | `double`    | `3`               | Top border width |
| `backgroundShadowColor` | `Color`     | `Color(0xFF6c5ce7)` | Background gradient highlight color |
| `title`                 | `Widget?`   | `null`            | Title text or widget |
| `selectedTitleColor`    | `Color?`    | `null`            | Title color when selected |
| `unselectedTitleColor`  | `Color?`    | `null`            | Title color when unselected |
| `showTextAlways`        | `bool`      | `false`           | Always show text or only when selected |
| `selectedScale`         | `double`    | `1.0`             | Scale when selected |

---

## 📝 License
This package is licensed under the [MIT License](LICENSE).
