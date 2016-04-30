import 'package:built_value_generator/built_value_generator.dart';
import 'package:built_json_generator/built_json_generator.dart';

import 'package:source_gen/source_gen.dart';

/// Example of how to use source_gen with [BuiltValueGenerator].
///
/// All you need is to import the generators you want and call [build].
void main(List<String> args) {
  build(args, [new BuiltJsonGenerator(), new BuiltValueGenerator()],
    librarySearchPaths: ['lib/src/model'])
    .then((result) => print(result));
}
