import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/styles.dart';

class BarItem extends ConsumerStatefulWidget {
  const BarItem(
      {super.key,
      required this.title,
      required this.onTap,
      this.isActive = false,
      this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      this.icon});
  final String title;
  final VoidCallback onTap;
  final bool isActive;
  final IconData? icon;
  final EdgeInsetsGeometry padding;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BarItemState();
}

class _BarItemState extends ConsumerState<BarItem> {
  bool onHover = false;
  @override
  Widget build(BuildContext context) {
    var styles = Styles(context);
    return InkWell(
        onTap: widget.onTap,
        onHover: (value) {
          setState(() {
            onHover = value;
          });
        },
        child: Container(
            padding: widget.padding,
            height: 60,
            child: styles.smallerThanTablet
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      widget.isActive
                          ? Container(
                              width: 5,
                              height: 20,
                              color: Colors.white,
                            )
                          : Container(
                              width: 5,
                              height: 20,
                              color: onHover
                                  ? Colors.white70
                                  : Colors.transparent),
                      const SizedBox(width: 5),
                      if (widget.icon != null)
                        Icon(
                          widget.icon,
                          color: widget.isActive
                              ? Colors.white
                              : onHover
                                  ? Colors.white70
                                  : Colors.white54,
                        ),
                      const SizedBox(width: 5),
                      Text(
                        widget.title,
                        style: TextStyle(
                          color: widget.isActive
                              ? Colors.white
                              : onHover
                                  ? Colors.white70
                                  : Colors.white54,
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          if (widget.icon != null)
                            Icon(
                              widget.icon,
                              color: widget.isActive
                                  ? Colors.white
                                  : onHover
                                      ? Colors.white70
                                      : Colors.white54,
                            ),
                          if (widget.icon != null) const SizedBox(width: 5),
                          Text(
                            widget.title,
                            style: TextStyle(
                              fontSize: widget.isActive ? 18 : 16,
                              letterSpacing: 1.5,
                              color: widget.isActive
                                  ? Colors.white
                                  : onHover
                                      ? Colors.white70
                                      : Colors.white54,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      if (widget.isActive)
                        Container(
                          width: 30,
                          height: 5,
                          color: Colors.white,
                        )
                    ],
                  )));
  }
}
