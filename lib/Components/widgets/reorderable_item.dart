import 'package:flutter/material.dart';
import 'package:nav_bar/Components/models/nav_bar_item.dart';
import 'package:nav_bar/Components/widgets/condition_widget.dart';
import 'package:nav_bar/scrollable_reorderable_navbar.dart';

/// [Widget] use to catch user interaction with [NavBarItem.widget].
/// It shows the [NavBarItem.name] when [selected] is true.
class ReorderableItem extends StatelessWidget {
  const ReorderableItem({
    Key? key,
    required this.index,
    required this.item,
    required this.onTap,
    required this.animationDuration,
    this.selected = false,
  }) : super(key: key);

  /// Index of the item in the item list
  final int index;

  /// Item that is used as Widget and name
  final NavBarItem item;

  /// Duration of the switcher animation
  final Duration animationDuration;

  /// If true, shows [item.name]
  final bool selected;

  /// Event that is triggered on widget tap
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            runAlignment: WrapAlignment.center,
            alignment: WrapAlignment.center,
            direction: Axis.vertical,
            children: [
              item.widget,
              AnimatedSwitcher(
                  duration: animationDuration,
                  transitionBuilder: (child, animation) =>
                      SizeTransition(sizeFactor: animation, child: child),
                  child: ConditionWidget(
                    appear: selected,
                    key: ValueKey(selected),
                    appearWidgetCallback: () => Text(item.name),
                  )),
            ],
          ),
          onTap: onTap),
    );
  }
}
