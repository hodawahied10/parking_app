
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuccessAnimation extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 190.h,
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(
          begin: 0,
          end: 1,
        ),
        duration: const Duration(milliseconds: 1800),
        curve: Curves.easeOutCubic,
        builder: (context, value, child) {
          return Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              
              Transform.scale(
                scale: 0.6 + (value * 1.4),
                child: Opacity(
                  opacity: value < 0.7
                      ? 0.35
                      : (1 - value) * 1.2,
                  child: Container(
                    width: 105.w,
                    height: 105.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.green.withValues(alpha: 0.5),
                        width: 3.w,
                      ),
                    ),
                  ),
                ),
              ),

             
              ...List.generate(
                32,
                (index) {
                  final random = math.Random(index);

                  final angle =
                      (index / 32) * 2 * math.pi;

                  final maxDistance =
                      70 + random.nextDouble() * 65;

                  final distance =
                      maxDistance * value;

                  final x =
                      math.cos(angle) * distance;

                
                  final y =
                      math.sin(angle) * distance -
                      (45 * math.sin(value * math.pi));

                  final rotation =
                      (index % 2 == 0 ? 1 : -1) *
                      value *
                      (math.pi * 4);

                  final opacity =
                      value < 0.65
                          ? 1.0
                          : (1 - value) / 0.35;

                  final size =
                      5 + random.nextDouble() * 6;

                  final shape =
                      index % 4;

                  return Transform.translate(
                    offset: Offset(x, y),
                    child: Transform.rotate(
                      angle: rotation,
                      child: Opacity(
                        opacity: opacity.clamp(0.0, 1.0),
                        child: _ConfettiPiece(
                          size: size,
                          shape: shape,
                          color: _confettiColor(index),
                        ),
                      ),
                    ),
                  );
                },
              ),

             
              Transform.scale(
                scale: _checkScale(value),
                child: Container(
                  width: 90.w,
                  height: 90.w,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: Transform.scale(
                    scale: _checkScale(value),
                    child: Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 52.sp,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  double _checkScale(double value) {
    if (value < 0.18) {
      return 0.5 + (value / 0.18) * 0.5;
    }

    if (value < 0.30) {
      return 1.0 + ((value - 0.18) / 0.12) * 0.12;
    }

    return 1.12 -
        ((value - 0.30) / 0.70) * 0.12;
  }

  Color _confettiColor(int index) {
    const colors = [
      Colors.green,
      Colors.amber,
      Colors.blue,
      Colors.orange,
      Colors.pink,
      Colors.purple,
      Colors.teal,
    ];

    return colors[index % colors.length];
  }
}

class _ConfettiPiece extends StatelessWidget {
  final double size;
  final int shape;
  final Color color;

  const _ConfettiPiece({
    required this.size,
    required this.shape,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (shape == 0) {
      return Icon(
        Icons.star_rounded,
        size: size * 1.5,
        color: color,
      );
    }

    if (shape == 1) {
      return Container(
        width: size,
        height: size * 1.8,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(2.r),
        ),
      );
    }

    if (shape == 2) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      );
    }

    return Container(
      width: size * 1.5,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(3.r),
      ),
    );
  }
}
