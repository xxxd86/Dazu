import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
Future<Uint8List?> convertImageProviderToUint8List(ImageProvider imageProvider) async {
  Completer<Uint8List> completer = Completer();

  final listener = ImageStreamListener((ImageInfo info, bool synchronousCall) async {
    final byteData = await info.image.toByteData(format: ImageByteFormat.png);
    completer.complete(byteData!.buffer.asUint8List());
  });

  final stream = imageProvider.resolve(ImageConfiguration.empty);
  stream.addListener(listener);

  return completer.future;
}
Future<ByteData> convertImageProviderToByteData(ImageProvider imageProvider) async {
  final assetPath = imageProvider is AssetImage ? imageProvider.assetName : null;
  if (assetPath != null) {
    return await rootBundle.load(assetPath);
  } else {
    throw Exception('Unsupported ImageProvider: $imageProvider');
  }
}

Future<void> saveImageToAssets(ImageProvider imageProvider) async {
  // Convert ImageProvider to Uint8List
  final ByteData byteData = await convertImageProviderToByteData(imageProvider);
  final Uint8List imageData = byteData.buffer.asUint8List();

  // Compress image data to PNG format
  final Uint8List compressedImageData = await FlutterImageCompress.compressWithList(
    imageData,
    format: CompressFormat.png,
  );

  // Get the temporary directory of the application
  final Directory tempDir = await getTemporaryDirectory();
  final String tempPath = tempDir.path;

  // Write the PNG data to a temporary file
  final File tempFile = File('$tempPath/image.png');
  await tempFile.writeAsBytes(compressedImageData);

  // Copy the temporary file to the assets folder
  final String assetsPath = 'assets/images/image.png';
  final File assetsFile = File(assetsPath);
  await tempFile.copy(assetsFile.path);

  // Refresh the Flutter engine to load the new assets file
  await ServicesBinding.instance!.defaultBinaryMessenger.handlePlatformMessage(
    'flutter/assets',
    const StandardMethodCodec().encodeMethodCall(
      MethodCall('evict', assetsPath),
    ),
        (ByteData? data) {},
  );
}
