import 'package:args/args.dart';

final inputOptionName = 'input';
final outputOptionName = 'output';

class ArgsParser {
  static (String inputFilePath, String outputFilePath) parse(List<String> arguments) {
// The flutter tool will invoke this program with two arguments, one for
    // the `--input` option and one for the `--output` option.
    // `--input` is the original asset file that this program should transform.
    // `--output` is where flutter expects the transformation output to be written to.
    final parser = ArgParser()
      ..addOption(inputOptionName, mandatory: true, abbr: 'i')
      ..addOption(outputOptionName, mandatory: true, abbr: 'o');

    final argResults = parser.parse(arguments);

    return (argResults[inputOptionName], argResults[outputOptionName]);
  }
}
