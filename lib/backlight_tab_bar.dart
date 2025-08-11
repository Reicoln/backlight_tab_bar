import 'package:flutter/material.dart';

/// A customizable and animated tab bar widget with a "backlight" effect
/// for the selected item.
///
/// [BacklightTabBar] provides a bottom navigation bar where the active tab
/// features a top border and a gradient background, creating a glowing effect.
///
/// ### Example:
/// ```dart
/// BacklightTabBar(
///   currentIndex: _selectedIndex,
///   onTap: (index) => setState(() => _selectedIndex = index),
///   items: [
///     BacklightTabBarItem(
///       unselectedIcon: Icons.home_outlined,
///       selectedIcon: Icons.home,
///       title: Text('Home'),
///     ),
///     BacklightTabBarItem(
///       unselectedIcon: Icons.search,
///       selectedIcon: Icons.search_sharp,
///       title: Text('Search'),
///     ),
///   ],
/// )
/// ```
class BacklightTabBar extends StatelessWidget {
  /// The index of the currently selected tab.
  final int currentIndex;

  /// The list of [BacklightTabBarItem]s to display in the tab bar.
  final List<BacklightTabBarItem> items;

  /// The callback function that is called when a tab is tapped.
  /// It passes the index of the tapped tab.
  final ValueChanged<int> onTap;

  /// The height of the tab bar.
  ///
  /// Defaults to `70.0`.
  final double height;

  /// The background color of the tab bar.
  ///
  /// Defaults to `const Color(0xFF191919)`.
  final Color backgroundColor;

  /// The duration of the animation when switching between tabs.
  ///
  /// Defaults to `const Duration(milliseconds: 400)`.
  final Duration duration;

  /// The animation curve used for the tab transition.
  ///
  /// Defaults to `Curves.linear`.
  final Curve curve;

  /// The elevation of the widget, which determines the shadow.
  ///
  /// Defaults to `8.0`.
  final double elevation;

  /// The padding around the entire tab bar.
  ///
  /// Defaults to `EdgeInsets.zero`.
  final EdgeInsets padding;

  /// Creates a [BacklightTabBar] widget.
  ///
  /// The [currentIndex], [items], and [onTap] parameters are required.
  BacklightTabBar({
    super.key,
    required this.currentIndex,
    required this.items,
    required this.onTap,
    this.height = 70,
    this.backgroundColor = const Color(0xFF191919),
    this.duration = const Duration(milliseconds: 400),
    this.curve = Curves.linear,
    this.elevation = 8,
    this.padding = EdgeInsets.zero,
  })  : assert(items.isNotEmpty, 'The items list cannot be empty.'),
        assert(currentIndex >= 0 && currentIndex < items.length,
            'The currentIndex must be within the bounds of the items list.');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Material(
        color: backgroundColor,
        elevation: elevation,
        child: SizedBox(
          height: height,
          child: Row(
            children: List.generate(
              items.length,
              (index) => Expanded(
                child: _BacklightTabItemWidget(
                  item: items[index],
                  selected: currentIndex == index,
                  height: height,
                  duration: duration,
                  curve: curve,
                  onTap: () => onTap(index),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// An internal private widget representing a single item in the tab bar.
class _BacklightTabItemWidget extends StatelessWidget {
  final BacklightTabBarItem item;
  final bool selected;
  final double height;
  final Duration duration;
  final Curve curve;
  final VoidCallback onTap;

  const _BacklightTabItemWidget({
    required this.item,
    required this.selected,
    required this.height,
    required this.duration,
    required this.curve,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        onTap: onTap,
highlightColor: item.highlightColor.withValues(alpha: 0.6),
splashColor: item.splashColor.withValues(alpha: 0.4),
hoverColor: item.hoverColor.withValues(alpha: 0.6),
        child: AnimatedContainer(
          height: height,
          duration: duration,
          curve: curve,
          transform: Matrix4.identity()
            ..scale(selected ? item.selectedScale : 1.0),
          decoration: BoxDecoration(
            border: selected
                ? Border(
                    top: BorderSide(
                      color: item.borderColor,
                      width: item.borderWidth,
                    ),
                  )
                : const Border(
                    top: BorderSide(color: Colors.transparent, width: 0),
                  ),
            gradient: selected
                ? LinearGradient(
                    colors: [
                      item.backgroundShadowColor.withValues(alpha: 0.5),
                      Colors.transparent,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )
                : const LinearGradient(
                    colors: [Colors.transparent, Colors.transparent],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                selected ? item.selectedIcon : item.unselectedIcon,
                size: selected ? item.size : item.size - 5,
                color: selected
                  ? item.selectedIconColor
                  : item.unselectedIconColor.withValues(alpha: 0.5),
              ),
              if ((item.showTextAlways || selected) && item.title != null) ...[
                const SizedBox(height: 4),
                _buildTitleWidget(item.title!, selected,
                    item.selectedTitleColor, item.unselectedTitleColor),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the title widget, applying the correct color based on the `selected` state.
  Widget _buildTitleWidget(Widget title, bool selected, Color? selectedColor,
      Color? unselectedColor) {
    if (title is Text) {
      final Text originalText = title;
      final TextStyle? originalStyle = originalText.style;
      final Color? colorToApply = selected ? selectedColor : unselectedColor;

      // Return a new Text widget with the applied color,
      // preserving all other properties of the original Text.
      return Text(
        originalText.data ?? '',
        key: originalText.key,
        style:
            (originalStyle ?? const TextStyle()).copyWith(color: colorToApply),
        strutStyle: originalText.strutStyle,
        textAlign: originalText.textAlign,
        textDirection: originalText.textDirection,
        locale: originalText.locale,
        softWrap: originalText.softWrap,
        overflow: originalText.overflow,
        textScaleFactor: originalText.textScaleFactor,
        maxLines: originalText.maxLines,
        semanticsLabel: originalText.semanticsLabel,
        textWidthBasis: originalText.textWidthBasis,
        textHeightBehavior: originalText.textHeightBehavior,
      );
    } else {
      // If the title is not a Text widget, return it as is.
      return title;
    }
  }
}

/// A data model for a single item in the [BacklightTabBar].
///
/// This class holds all styling and behavioral information for one tab,
/// including icons, colors, text, and animations.
class BacklightTabBarItem {
  /// The icon for the unselected state.
  ///
  /// Defaults to `Icons.star_border_outlined`.
  final IconData unselectedIcon;

  /// The icon for the selected state.
  ///
  /// Defaults to `Icons.star`.
  final IconData selectedIcon;

  /// The base size of the icon. The size for an unselected icon will be `size - 5`.
  ///
  /// Defaults to `30.0`.
  final double size;

  /// The color of the icon in its selected state.
  ///
  /// Defaults to `Colors.white`.
  final Color selectedIconColor;

  /// The color of the icon in its unselected state.
  ///
  /// Defaults to `Colors.white54`.
  final Color unselectedIconColor;

  /// The highlight color when the item is held down.
  ///
  /// Defaults to `Colors.transparent`.
  final Color highlightColor;

  /// The splash color when the item is tapped.
  ///
  /// Defaults to `Colors.transparent`.
  final Color splashColor;

  /// The color when a pointer is hovering over the item.
  ///
  /// Defaults to `Colors.transparent`.
  final Color hoverColor;

  /// The color of the top border on the selected item.
  ///
  /// Defaults to `const Color(0xFF6c5ce7)`.
  final Color borderColor;

  /// The width of the top border on the selected item.
  ///
  /// Defaults to `3.0`.
  final double borderWidth;

  /// The color for the "backlight" gradient on the selected item.
  ///
  /// Defaults to `const Color(0xFF6c5ce7)`.
  final Color backgroundShadowColor;

  /// The title widget, typically a [Text], displayed below the icon.
  ///
  /// Can be `null` if no title is needed.
  final Widget? title;

  /// The color of the title in its selected state.
  ///
  /// If `null`, the color will not be changed.
  final Color? selectedTitleColor;

  /// The color of the title in its unselected state.
  ///
  /// If `null`, the color will not be changed.
  final Color? unselectedTitleColor;

  /// If `true`, the [title] will always be shown.
  /// If `false`, it will only be visible for the selected tab.
  ///
  /// Defaults to `false`.
  final bool showTextAlways;

  /// The scale factor applied to the item when it is selected.
  /// A value of `1.0` means no scaling.
  ///
  /// Defaults to `1.0`.
  final double selectedScale;

  /// Creates a configuration for a [BacklightTabBar] item.
  const BacklightTabBarItem({
    this.unselectedIcon = Icons.star_border_outlined,
    this.selectedIcon = Icons.star,
    this.size = 30,
    this.selectedIconColor = Colors.white,
    this.unselectedIconColor = Colors.white54,
    this.highlightColor = Colors.transparent,
    this.splashColor = Colors.transparent,
    this.hoverColor = Colors.transparent,
    this.borderColor = const Color(0xFF6c5ce7),
    this.borderWidth = 3,
    this.backgroundShadowColor = const Color(0xFF6c5ce7),
    this.title,
    this.selectedTitleColor,
    this.unselectedTitleColor,
    this.showTextAlways = false,
    this.selectedScale = 1.0,
  })  : assert(size >= 7, 'The icon size must be >= 7.'),
        assert(borderWidth >= 1, 'The border width must be >= 1.');
}