import 'package:flutter/material.dart';

class EaseInWidget extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final BorderRadius? borderRadius;

  const EaseInWidget({
    Key? key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.borderRadius,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EaseInWidgetState();
}

class _EaseInWidgetState extends State<EaseInWidget>
    with TickerProviderStateMixin<EaseInWidget> {
  late AnimationController _controller;
  late Animation<double> easeInAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(
          milliseconds: 50,
        ),
        value: 1.0);
    easeInAnimation = Tween(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: widget.onLongPress,
      key: UniqueKey(),
      borderRadius: widget.borderRadius,
      onTap: () {
        if (widget.onTap == null) {
          return;
        }
        _controller.forward().then((val) {
          _controller.reverse().then((val) {
            widget.onTap!();
          });
        });
      },
      child: ScaleTransition(
        scale: easeInAnimation,
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
