library relation_to_transformation_builder;

import 'dart:async';
import 'dart:io';

import 'package:build/build.dart';
import 'package:dart_style/src/dart_formatter.dart';
import 'package:vcore_m2m/src/model/relation.dart';
import 'package:vcore_m2m/src/model/transform.dart';

/// Generates a [TransformLookup] from a [PackageRelation]
///
class RelationToTransformationBuilder extends Builder {
  final AssetId relationAssetId;
  final String runnerPath;
  final bool isForwards;
  String get _extension => isForwards ? '.g.forwards.dart' : '.g.reverse.dart';
  AssetId get _outputId => relationAssetId.changeExtension(_extension);

  RelationToTransformationBuilder(
      this.relationAssetId, this.runnerPath, this.isForwards);

  @override
  Future build(BuildStep buildStep) async {
    print('#### ${buildStep.input.id}');

    final source = await _generateFormattedSource(buildStep);
    if (source == null || source.isEmpty) return null;

//    print('#### generated source $source');

    final output = new Asset(_outputId, source);
    buildStep.writeAsString(output);
  }

  Future<String> _generateFormattedSource(BuildStep buildStep) async {
    final source = await _generateSource();
    if (source == null || source.isEmpty) return null;

//    return source;
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
    print('####### exit code: ${result.exitCode}');
    if (result.exitCode == 0) {
      return result.stdout;
    } else {
      print('####### stderr: ${result.stderr}');
      return null;
    }
  }

  @override
  List<AssetId> declareOutputs(AssetId inputId) => [_outputId];
}
