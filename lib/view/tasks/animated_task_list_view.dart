import 'package:flutter/material.dart';
import 'package:khotwa/view/tasks/task_card.dart';

class AnimatedTaskListView extends StatefulWidget {
  final Size size;
  final double itemHeight;
  final List<TaskCard> tasks;

  const AnimatedTaskListView({
    super.key,
    required this.size,
    required this.itemHeight,
    required this.tasks,
  });

  @override
  State<AnimatedTaskListView> createState() => _AnimatedTaskListViewState();
}

class _AnimatedTaskListViewState extends State<AnimatedTaskListView>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _controller = ScrollController();
  double scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (mounted) {
        setState(() {
          scrollOffset = _controller.offset;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _calculateScale(int index) {
    double itemOffset = index * (widget.itemHeight + 20);
    double diff = (itemOffset - scrollOffset).abs();
    double scale = 1 - (diff / (widget.itemHeight * 4));
    return scale.clamp(0.9, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.separated(
      controller: _controller,
      physics: const BouncingScrollPhysics(),
      itemCount: widget.tasks.length,
      separatorBuilder: (_, __) => const SizedBox(height: 20),
      itemBuilder: (context, index) {
        double scale = _calculateScale(index);
        return Transform.scale(
          scale: scale,
          child: widget.tasks[index],
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
