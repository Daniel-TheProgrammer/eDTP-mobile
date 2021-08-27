import 'package:flutter/material.dart';

class RadioEmoji extends StatefulWidget {
  RadioEmoji({
    @required this.value,
    @required this.groupValue,
    @required this.onChange,
  }) : assert(value >= 1 && value <= 5, 'RadioEmoji value out of bound.');

  final int value;
  final int groupValue;
  final Function onChange;
  static final List<String> emojiIndex = ['😠', '😕', '😐', '☺', '😍'];

  @override
  _RadioEmojiState createState() => _RadioEmojiState();
}

class _RadioEmojiState extends State<RadioEmoji>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  String emoji;
  bool isSelected;

  void _handleTap() {
    widget.onChange(widget.value);
    _initializeAnimation();
  }

  void _initializeAnimation() {
    controller.forward();
  }

  void _deinitializeAnimation() {
    controller.value = 0.0;
  }

  @override
  void initState() {
    super.initState();

    emoji = RadioEmoji.emojiIndex[widget.value - 1];

    controller = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.elasticOut,
    );

    controller.addListener(() => setState(() {}));

    isSelected = false;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isSelected = widget.value == widget.groupValue;

    if (isSelected == false) _deinitializeAnimation();

    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(style: BorderStyle.none, width: 1.0),
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        child: Text(
          emoji,
          style: TextStyle(
            color: Colors.black,
            fontSize: animation.value * 10 + 20.0,
          ),
        ),
      ),
      onTap: _handleTap,
    );
  }
}
