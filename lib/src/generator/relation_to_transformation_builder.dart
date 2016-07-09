library relation_to_transformation_builder;

import 'dart:async';
import 'dart:io';

import 'package:source_gen/source_gen.dart';
//import 'package:vcore_generator/src/dart_source_to_vcore.dart';
import 'package:vcore_generator/vcore_generator.dart';
import 'package:vcore/vcore.dart';
import 'dart:convert';
//import 'package:vcore_generator/src/vcore_model_as_code_serialiser.dart';
import 'package:vcore_m2m/src/model/transform.dart';
import 'package:build/build.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:vcore_m2m/src/model/relation.dart';

/// Generates a [TransformLookup] from a [PackageRelation]
///
class RelationToTransformationBuilder extends Builder {
  final String runnerPath;
  final bool isForwards;
  String get _extension => isForwards ? '.g.forwards.dart' : '.g.reverse.dart';

  RelationToTransformationBuilder(this.runnerPath, this.isForwards);

  @override
  Future build(BuildStep buildStep) {
    print('#### ${buildStep.input.id}');
//    buildStep.
//    return null;

//    final result = await Process.run('/usr/local/bin/dart', [runnerPath]);
//    print(result.exitCode);
//    if (result.exitCode == 0) {
//      return result.stdout;
//    } else {
//      print(result.stderr);
//      return null;
//    }

//  var formatter = new DartFormatter();
//  try {
//  genPartContent = formatter.format(genPartContent);
//  } catch (e, stack) {
//  buildStep.logger.severe(
//  """Error formatting the generated source code.
//This may indicate an issue in the generated code or in the formatter.
//Please check the generated code and file an issue on source_gen
//if approppriate.""",
//  e,
//  stack);
//  }
//
//  var outputId = _generatedFile(buildStep.input.id);
//  var output = new Asset(outputId, '$_topHeader$genPartContent');
//  buildStep.writeAsString(output);

  }

  @override
  List<AssetId> declareOutputs(AssetId inputId) =>
      [inputId.changeExtension(_extension)];
}
