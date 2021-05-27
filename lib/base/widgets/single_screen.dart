// Copyright 2021 Chatura Dilan Perera. All rights reserved.
// Use of this source code is governed by a MIT license

import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';

abstract class SingleScreen<T> extends GetView<T> {
  T get controller => GetInstance().find<T>(tag: tag);
  @override
  Widget build(BuildContext context) {
    return FocusDetector(
      onVisibilityGained: onStart,
      onVisibilityLost: onStop,
      child: create(),
    );
  }

  Widget create();

  void onStart() {}

  void onStop() {}
}
