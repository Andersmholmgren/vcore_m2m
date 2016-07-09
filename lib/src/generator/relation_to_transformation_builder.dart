library relation_to_transformation_builder;

import 'dart:async';
import 'dart:io';

import 'package:build/build.dart';
import 'package:dart_style/src/dart_formatter.dart';
import 'package:vcore_m2m/src/model/relation.dart';
import 'package:vcore_m2m/src/model/transform.dart';
//import 'package:vcore_generator/src/dart_source_to_vcore.dart';
//import 'package:vcore_generator/src/vcore_model_as_code_serialiser.dart';

/// Generates a [TransformLookup] from a [PackageRelation]
///
class RelationToTransformationBuilder extends Builder {
  final String runnerPath;
  final bool isForwards;
  String get _extension => isForwards ? '.g.forwards.dart' : '.g.reverse.dart';

  RelationToTransformationBuilder(this.runnerPath, this.isForwards);

  @override
  Future build(BuildStep buildStep) async {
    print('#### ${buildStep.input.id}');

    final source = await _generateFormattedSource(buildStep);
    if (source == null || source.isEmpty) return null;

    final output = new Asset(_outputId(buildStep.input.id), source);
    buildStep.writeAsString(output);
  }

  Future<String> _generateFormattedSource(BuildStep buildStep) async {
    final source = await _generateSource();
    if (source == null || source.isEmpty) return null;

    return _format(source, buildStep);
  }

  Future<String> _format(String source, BuildStep buildStep) async {
    var formatter = new DartFormatter();
    try {
      return formatter.format(source);
    } catch (e, stack) {
      buildStep.logger.severe(
          """Error formatting the generated source code.
This may indicate an issue in the generated code or in the formatter.
Please check the generated code and file an issue on vcore_m2m
if approppriate.""",
          e,
          stack);

      return null;
    }
  }

  Future<String> _generateSource() async {
    final result = await Process.run('/usr/local/bin/dart', [runnerPath]);
    print(result.exitCode);
    if (result.exitCode == 0) {
      return result.stdout;
    } else {
      print(result.stderr);
      return null;
    }
  }

  @override
  List<AssetId> declareOutputs(AssetId inputId) => [_outputId(inputId)];

  AssetId _outputId(AssetId inputId) => inputId.changeExtension(_extension);
}
