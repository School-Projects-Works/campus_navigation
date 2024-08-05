import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/styles.dart';

class DashBoardItem extends ConsumerStatefulWidget {
  const DashBoardItem(
      {super.key,
      required this.icon,
      required this.title,
      required this.itemCount,
      required this.color,
      required this.onTap});
  final IconData icon;
  final String title;
  final int itemCount;
  final Color color;
  final VoidCallback onTap;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashBoardItemState();
}

class _DashBoardItemState extends ConsumerState<DashBoardItem> {
  bool onHaver = false;
  @override
  Widget build(BuildContext context) {
    var styles = Styles(context);
    return Padding(
      padding: const EdgeInsets.all(12),
      child: InkWell(
        onTap: widget.onTap,
        onHover: (value) {
          setState(() {
            onHaver = value;
          });
        },
        child: Container(
          width: styles.isMobile
              ? double.infinity
              : styles.isTablet
                  ? styles.width * 0.28
                  : styles.width * 0.2,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          decoration: BoxDecoration(
            color: onHaver ? widget.color.withOpacity(.9) : widget.color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              //icon
              Icon(
                widget.icon,
                size: 50,
                color: Colors.white,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.title,
                    maxLines: 1,
                    style: styles.subtitle(
                      
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.itemCount.toString(),
                    style: styles.title(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
