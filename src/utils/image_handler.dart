import 'dart:io';

import 'package:image/image.dart';

class ImageHandler {
  static Image getImage(String path) {
    return decodeImage(File(path).readAsBytesSync())!;
  }

  static void writeImage({required String outputPath, required Image image}) {
    File(outputPath).writeAsBytesSync(encodePng(image));
  }
}
