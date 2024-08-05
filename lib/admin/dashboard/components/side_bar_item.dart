import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SideBarItem extends ConsumerStatefulWidget {
  const SideBarItem(
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
  ConsumerState<ConsumerStatefulWidget> createState() => _SideBarItemState();
}

class _SideBarItemState extends ConsumerState<SideBarItem> {
  bool onHover = false;
  @override
  Widget build(BuildContext context) {
    // var styles = Styles(context);
    return InkWell(
        onTap: widget.onTap,
        onHover: (value) {
          setState(() {
            onHover = value;
          });
        },
        child: Container(
            padding: widget.padding,
            decoration: BoxDecoration(
              color:
                  onHover ? Colors.black.withOpacity(.1) : Colors.transparent,
              border: widget.isActive
                  ? const Border(
                      left: BorderSide(color: Colors.white, width: 10))
                  : null,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
            )));
  }
}
