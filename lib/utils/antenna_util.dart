// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AntennaUtil {
  static const platform = MethodChannel('com.example.ai_decoder_app/antenna');

  Future<void> toggleEarphoneAntenna(
      BuildContext context, bool useEarphones) async {
    try {
      await platform.invokeMethod(
          'toggleEarphoneAntenna', {'useEarphones': useEarphones});
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text("Failed to toggle earphone antenna: '${e.message}'.")),
      );
    }
  }

  Future<void> optimizeSignal(BuildContext context, double frequency) async {
    try {
      await platform.invokeMethod('optimizeSignal', {'frequency': frequency});
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to optimize signal: '${e.message}'.")),
      );
    }
  }
}
