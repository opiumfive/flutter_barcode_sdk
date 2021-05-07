import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_sdk/barcode_result.dart';

class FlutterBarcodeSdk {
  static const int IF_UNKNOWN = -1;
  static const int IF_YUV420 = 0;
  static const int IF_BRGA8888 = 1;

  static const MethodChannel _channel =
      const MethodChannel('flutter_barcode_sdk');

  /// Returns a [String] containing the version of the platform.
  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  /// Set Dynamsoft Barcode Reader License Key
  /// Apply for a 30-day FREE trial license: https://www.dynamsoft.com/customer/license/trialLicense
  Future<void> setLicense(String license) async {
    await _channel.invokeMethod('setLicense', {'license': license});
  }

  /// Decodes barcodes from an image file.
  Future<List<BarcodeResult>> decodeFile(String filename) async {
    List<Map<dynamic, dynamic>> ret = List<Map<dynamic, dynamic>>.from(
        await _channel.invokeMethod('decodeFile', {'filename': filename}));
    return convertResults(ret);
  }

  /// Decodes barcodes from bytes of an image file.
  Future<List<BarcodeResult>> decodeFileBytes(Uint8List bytes) async {
    assert(bytes.isNotEmpty);
    List<Map<dynamic, dynamic>> ret = List<Map<dynamic, dynamic>>.from(
        await _channel.invokeMethod('decodeFileBytes', {'bytes': bytes}));
    return convertResults(ret);
  }

  /// Decodes barcodes from an image buffer.
  ///
  /// E.g. [CameraImage]
  Future<List<BarcodeResult>> decodeImageBuffer(
      Uint8List bytes, int width, int height, int stride, int format) async {
    List<Map<dynamic, dynamic>> ret = List<Map<dynamic, dynamic>>.from(
        await _channel.invokeMethod('decodeImageBuffer', {
      'bytes': bytes,
      'width': width,
      'height': height,
      'stride': stride,
      'format': format
    }));
    return convertResults(ret);
  }

  /// Decodes barcodes from webcam stream.
  /// Web only!
  Future<void> decodeVideo() async {
    await _channel.invokeMethod('decodeVideo');
  }
}
