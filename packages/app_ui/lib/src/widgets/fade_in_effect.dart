// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

class FadeInEffect extends StatefulWidget {
  const FadeInEffect({
    super.key,
    // ignore: always_put_required_named_parameters_first
    required this.child,
    this.intervalStart = 0,
    this.keepAlive = false,
  });

  final Widget child;
  final double intervalStart;
  final bool keepAlive;

  @override
  State<FadeInEffect> createState() => _FadeInEffectState();
}

class _FadeInEffectState extends State<FadeInEffect>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late final AnimationController animationController;
  late final Animation<double> opacityAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();

    opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(widget.intervalStart, 1, curve: Curves.easeOut),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FadeTransition(
      opacity: opacityAnimation,
      child: widget.child,
    );
  }

  @override
  bool get wantKeepAlive => widget.keepAlive;
}
