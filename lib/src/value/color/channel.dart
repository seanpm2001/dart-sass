// Copyright 2022 Google Inc. Use of this source code is governed by an
// MIT-style license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:meta/meta.dart';

/// Metadata about a single channel in a known color space.
///
/// {@category Value}
@sealed
class ColorChannel {
  /// The alpha channel that's shared across all colors.
  static const alpha = LinearChannel('alpha', 0, 1);

  /// The channel's name.
  final String name;

  /// Whether this is a polar angle channel, which represents (in degrees) the
  /// angle around a circle.
  ///
  /// This is true if and only if this is not a [LinearChannel].
  final bool isPolarAngle;

  /// @nodoc
  @internal
  const ColorChannel(this.name, {required this.isPolarAngle});
}

/// Metadata about a color channel with a linear (as opposed to polar) value.
///
/// {@category Value}
@sealed
class LinearChannel extends ColorChannel {
  /// The channel's minimum value.
  ///
  /// Unless this color space is strictly bounded, this channel's values may
  /// still be below this minimum value. It just represents a limit to reference
  /// when specifying channels by percentage, as well as a boundary for what's
  /// considered in-gamut if the color space has a bounded gamut.
  final double min;

  /// The channel's maximum value.
  ///
  /// Unless this color space is strictly bounded, this channel's values may
  /// still be above this maximum value. It just represents a limit to reference
  /// when specifying channels by percentage, as well as a boundary for what's
  /// considered in-gamut if the color space has a bounded gamut.
  final double max;

  /// @nodoc
  @internal
  const LinearChannel(String name, this.min, this.max)
      : super(name, isPolarAngle: false);
}
