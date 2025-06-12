import 'dart:math' as math;
import 'package:flutter/widgets.dart';

extension AppSize on num {
  // Calculates height percentage based on the device's screen height
  double get h {
    final view = WidgetsBinding.instance.platformDispatcher.views.first;
    return this * MediaQueryData.fromView(view).size.height / 100;
  }

  // Calculates width percentage based on the device's screen width
  double get w {
    final view = WidgetsBinding.instance.platformDispatcher.views.first;
    return this * MediaQueryData.fromView(view).size.width / 100;
  }

  // Calculates dp (Density pixels) for width, height, margin, padding, etc.
  double get dp {
    final view = WidgetsBinding.instance.platformDispatcher.views.first;
    final width = MediaQueryData.fromView(view).size.width;
    final height = MediaQueryData.fromView(view).size.height;
    final pixelRatio = MediaQueryData.fromView(view).devicePixelRatio;

    return (math.log(width * height * pixelRatio) / math.log(2) / 20 * this)
        .abs();
  }

  // Calculates sp (Scalable pixels) for text scaling based on screen size and device dimensions
  double get sp {
    final view = WidgetsBinding.instance.platformDispatcher.views.first;
    final mediaQuery = MediaQueryData.fromView(view);
    return mediaQuery.textScaler.scale(
      (math.min(mediaQuery.size.width / 390.0, mediaQuery.size.height / 844.0) *
              (mediaQuery.size.width / 390.0)) *
          this,
    );
  }
}
