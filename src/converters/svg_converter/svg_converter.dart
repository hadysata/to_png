import 'dart:io';

class SvgConverter {
  static void convert({required String inputFilePath, required String outputFilePath, required int scale}) async {
    if (!await isSvgExportInstalled()) {
      stderr.writeln(
          'svgexport is not installed. Please install it to use this feature: https://www.npmjs.com/package/svgexport');
      return;
    }

    final result = await Process.run('svgexport', [inputFilePath, outputFilePath, '${scale}x']);
    if (result.exitCode != 0) {
      throw Exception('Error converting SVG to PNG: ${result.stderr}');
    }
  }

  static Future<bool> isSvgExportInstalled() async {
    try {
      final result = await Process.run('svgexport', ['-h']);
      return result.exitCode == 0;
    } catch (_) {
      return false;
    }
  }
}
