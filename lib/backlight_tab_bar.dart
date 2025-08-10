import 'package:flutter/material.dart';

class BacklightTabBar extends StatelessWidget {
  final int currentIndex;
  final List<BacklightTabBarItem> items;
  final ValueChanged<int> onTap;
  final double height;
  final Color backgroundColor;
  final Duration duration;
  final Curve curve;
  final double elevation;
  final EdgeInsets padding;

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
  })  : assert(items.isNotEmpty),
        assert(currentIndex >= 0 && currentIndex < items.length);

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
        highlightColor: item.highlightColor.withOpacity(0.6),
        splashColor: item.splashColor.withOpacity(0.4),
        hoverColor: item.hoverColor.withOpacity(0.6),
        child: AnimatedContainer(
          height: height,
          duration: duration,
          curve: curve,
          transform: Matrix4.identity()..scale(selected ? item.selectedScale : 1.0),
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
                item.backgroundShadowColor.withOpacity(0.5),
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
                color: selected ? item.selectedIconColor : item.unselectedIconColor.withOpacity(0.5),
              ),
              if ((item.showTextAlways || selected) && item.title != null) ...[
                const SizedBox(height: 4),
                _buildTitleWidget(item.title!, selected, item.selectedTitleColor, item.unselectedTitleColor),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleWidget(
      Widget title, bool selected, Color? selectedColor, Color? unselectedColor) {
    if (title is Text) {
      final Text originalText = title;
      final TextStyle? originalStyle = originalText.style;
      final Color? colorToApply = selected ? selectedColor : unselectedColor;

      return Text(
        originalText.data ?? '',
        key: originalText.key,
        style: (originalStyle ?? const TextStyle()).copyWith(color: colorToApply),
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
      return title;
    }
  }
}

class BacklightTabBarItem {
  final IconData unselectedIcon;
  final IconData selectedIcon;
  final double size;
  final Color selectedIconColor;
  final Color unselectedIconColor;
  final Color highlightColor;
  final Color splashColor;
  final Color hoverColor;
  final Color borderColor;
  final double borderWidth;
  final Color backgroundShadowColor;
  final Widget? title;
  final Color? selectedTitleColor;
  final Color? unselectedTitleColor;
  final bool showTextAlways;
  final double selectedScale;

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
  }) : assert(size >= 7),
        assert(borderWidth >= 1);
}
