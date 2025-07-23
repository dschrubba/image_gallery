import 'package:flutter/material.dart';

typedef PullActionCallback = void Function(Direction direction, BuildContext context);

enum Direction { up, down, left, right }

class ElasticPullWrapper extends StatefulWidget {
  final Widget child;
  final PullActionCallback onThresholdExceeded;
  final double threshold;
  final double maxOffset;
  final double deltaFactor;

  const ElasticPullWrapper({
    super.key,
    required this.child,
    required this.onThresholdExceeded,
    this.threshold = 100.0,
    this.maxOffset = 150.0,
    this.deltaFactor = 1.0
  });

  @override
  State<ElasticPullWrapper> createState() => _ElasticPullWrapperState();
}

class _ElasticPullWrapperState extends State<ElasticPullWrapper> with SingleTickerProviderStateMixin {
  BuildContext? _buildContext;
  Offset _offset = Offset.zero;
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = _controller.drive(
      Tween(begin: Offset.zero, end: Offset.zero),
    );

    _controller.addListener(() {
      setState(() {
        _offset = _animation.value;
      });
    });
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    setState(() {
      Offset delta = _offset + details.delta * widget.deltaFactor;
      double dx = (delta.dx.abs() > delta.dy.abs()) ? delta.dx.clamp(-widget.maxOffset, widget.maxOffset) : 0;
      double dy = (delta.dy.abs() > delta.dx.abs()) ? delta.dy.clamp(-widget.maxOffset, widget.maxOffset) : 0;
      _offset = Offset(dx, dy);
    });
  }

  void _handlePanEnd(DragEndDetails details) {
    Direction? triggeredDirection;

    if (_offset.dy.abs() > _offset.dx.abs()) {
      if (_offset.dy > widget.threshold) {
        triggeredDirection = Direction.down;
      } else if (_offset.dy < -widget.threshold) {
        triggeredDirection = Direction.up;
      }
    } else {
      if (_offset.dx > widget.threshold) {
        triggeredDirection = Direction.right;
      } else if (_offset.dx < -widget.threshold) {
        triggeredDirection = Direction.left;
      }
    }

    if (triggeredDirection != null) {
      widget.onThresholdExceeded(triggeredDirection, _buildContext!);
    }

    // Animate back to zero
    _animation = _controller.drive(
      Tween(begin: _offset, end: Offset.zero),
    );
    _controller.reset();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _buildContext = context;
    return GestureDetector(
      onPanUpdate: _handlePanUpdate,
      onPanEnd: _handlePanEnd,
      child: Transform.translate(
        offset: _offset,
        child: widget.child,
      ),
    );
  }
}
