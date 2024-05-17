import 'dart:io';

import 'converters/pdf_converter/pdf_converter.dart';
import 'converters/svg_converter/svg_converter.dart';
import 'utils/args_parser.dart';

int run(List<String> arguments) {
  try {
    final (String inputFilePath, String outputFilePath) = ArgsParser.parse(arguments);

    final inputFileExtension = inputFilePath.split(".").last.toLowerCase();

    if (inputFileExtension == "pdf") {
      PdfConverter.convert(inputFilePath: inputFilePath, outputFilePath: outputFilePath);
    } else if (inputFileExtension == "svg") {
      SvgConverter.convert(inputFilePath: inputFilePath, outputFilePath: outputFilePath);
    } else {
      stderr.writeln('Input file is not yet supported');
    }

    return 0;
  } catch (e) {
    stderr.writeln('Unexpected exception when producing the image.\nDetails: $e');
    return 1;
  }
}
