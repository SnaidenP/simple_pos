import 'dart:ui' as ui;
import 'package:image/image.dart' as img;

Future<img.Image> convertFlutterUiToImage(
    ui.Image uiImage, int width, int height) async {
  final uiBytes = await uiImage.toByteData();

  final image = img.Image.fromBytes(
    width: width,
    height: height,
    bytes: uiBytes!.buffer,
    numChannels: 4,
  );

  return image;
}
