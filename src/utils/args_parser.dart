import 'package:args/args.dart';

import '../domain/extensions/args_option.dart';

class ArgsParser {
  static (String inputFilePath, String outputFilePath, int scale) parse(List<String> arguments) {
// The flutter tool will invoke this program with two arguments, one for
    // the `--input` option and one for the `--output` option.
    // `--input` is the original asset file that this program should transform.
    // `--output` is where flutter expects the transformation output to be written to.
    final parser = ArgParser()
      ..addOption(ArgsOption.input.name, mandatory: true, abbr: 'i')
      ..addOption(ArgsOption.output.name, mandatory: true, abbr: 'o')
      ..addOption(ArgsOption.scale.name, mandatory: false, abbr: 's', defaultsTo: "1");

    final argResults = parser.parse(arguments);

    return (
      argResults[ArgsOption.input.name],
      argResults[ArgsOption.output.name],
      int.parse(argResults[ArgsOption.scale.name])
    );
  }
}
