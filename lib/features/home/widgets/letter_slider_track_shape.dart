import 'dart:math';

import 'package:flutter/material.dart';

class LetterSliderTrackShape extends SliderTrackShape {
  LetterSliderTrackShape({
    required this.lettersList,
  });

  final List<String> lettersList;

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    const double trackHeight = 40.0;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;

    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isEnabled = false,
    bool isDiscrete = false,
    required TextDirection textDirection,
  }) {
    if (sliderTheme.trackHeight == null ||
        sliderTheme.activeTrackColor == null ||
        sliderTheme.inactiveTrackColor == null) {
      return;
    }

    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
    );

    final List<String> alphabet = lettersList;

    final double letterSpacing = trackRect.width / (alphabet.length - 1);

    final TextPainter textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    for (int i = 0; i < alphabet.length; i++) {
      final String letter = alphabet[i];
      final double letterX = trackRect.left + (i * letterSpacing);
      final double letterY = trackRect.top + trackRect.height / 2;

      textPainter.text = TextSpan(
        text: letter,
        style: TextStyle(
          color: sliderTheme.activeTrackColor,
          fontSize: 14.0,
        ),
      );

      textPainter.layout();

      context.canvas.save();
      context.canvas.translate(letterX, letterY);
      context.canvas.rotate(-90 * pi / 180);
      textPainter.paint(
        context.canvas,
        Offset(-textPainter.width / 2, -textPainter.height / 2),
      );
      context.canvas.restore();
    }
  }
}

class CustomThumbShape extends SliderComponentShape {
  final double thumbRadius;
  final String letter;

  CustomThumbShape({this.thumbRadius = 20.0, required this.letter});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(thumbRadius * 2, thumbRadius * 2);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    // final Canvas canvas = context.canvas;

    // final Paint thumbPaint = Paint()
    //   ..color = Colors.transparent
    //   ..style = PaintingStyle.fill;

    // double adjustedRadius = thumbRadius * 0.8;

    // canvas.drawCircle(center, adjustedRadius, thumbPaint);

    // final TextStyle textStyle = TextStyle(
    //   color: Colors.deepPurple,
    //   fontSize: thumbRadius,
    //   fontWeight: FontWeight.bold,
    // );

    // final TextSpan textSpan = TextSpan(
    //   text: letter,
    //   style: textStyle,
    // );

    // final TextPainter textPainter = TextPainter(
    //   text: textSpan,
    //   textDirection: textDirection,
    // );
    // textPainter.layout();

    // canvas.save();
    // canvas.translate(center.dx, center.dy);
    // canvas.rotate(-90 * 3.1416 / 180);

    // textPainter.paint(
    //   canvas,
    //   Offset(
    //     -textPainter.width / 2,
    //     -textPainter.height / 2,
    //   ),
    // );
    // canvas.restore();
  }
}
