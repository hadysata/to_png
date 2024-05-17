import 'dart:io';

class SvgConverter {
  static void convert({required String inputFilePath, required String outputFilePath}) async {
    if (!await isSvgExportInstalled()) {
      stderr.writeln('svgexport is not installed. Please install it to use this feature.');
      return;
    }

  final result = await Process.run('svgexport', [inputFilePath, outputFilePath, '1x']);
  if (result.exitCode != 0) {
    print('Error converting SVG to PNG: ${result.stderr}');
    throw Exception('Failed to convert SVG to PNG');
  }
    stderr.writeln('Conversion successful, output saved to $outputFilePath');
  }

static Future<bool> isSvgExportInstalled() async {
  try {
    final result = await Process.run('svgexport', ['--version']);
    return result.exitCode == 0;
  } catch (_) {
    return false;
  }
}
}
