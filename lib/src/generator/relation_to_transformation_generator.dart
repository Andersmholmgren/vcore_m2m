library relation_to_transformation_generator;

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
class RelationToTransformationGenerator extends Generator {
  final String runnerPath;

  RelationToTransformationGenerator(this.runnerPath);

  Future<String> generate(Element element, BuildStep buildStep) async {
    print('#########: ${element.name} - ${element.runtimeType} - '
        '${buildStep.input.id}');
    return null;

    final result = await Process.run('/usr/local/bin/dart', [runnerPath]);
    print(result.exitCode);
    if (result.exitCode == 0) {
      return result.stdout;
    } else {
      print(result.stderr);
      return null;
    }

//    if (element is! FunctionElement) return null;
//    print('*********: ${element.name}');
//    final FunctionElement fElement = element;
//    print(fElement.returnType.displayName);
//    if (!fElement.returnType.displayName.startsWith('TransformLookup'))
//      return null;
//
//    print('yaaay: ${element.name}');
//
//    print(fElement.enclosingElement.runtimeType);
//    final packageRelationElement = (fElement.enclosingElement
//            as CompilationUnitElement)
//        .accessors
//        .firstWhere(
//            (a) => a.isGetter && a.returnType.displayName == 'PackageRelation');
//
////    fElement.enclosingElement.
//
//    print(packageRelationElement);
//
//    packageRelationElement.

    /**
     * TODO: we have packageRelationElement but we really need it's runtime value
     * not source. Is that possible???
     *
     * I doubt it. Likely need something more explicitly. Like a generator that
     * is triggered by changes to the model but is wired up with the model.
     *
     * But how does that generator get the model? Likely needs a model factory
     *
     * So how do we get it triggered correctly???
     *
     *
     */

    return "yay";
//    final package = convert(element);
//
////    new VCoreCodeGenerator().generatePackage(package, stdout);
//
////    print('XXXXX');
//    print(package);
////    print('YYYYY');
//    var _json = new JsonEncoder.withIndent(' ');
//
////    print(_json.convert(serializers.serialize(package.classifiers.first)));
////
////    print(_json.convert(serializers.serialize(package)));
////
////    return "Package _\$vCoreModelPackage = "
////        "serializers.deserialize(${_json.convert(serializers.serialize(package))});";
//
//    final sb = new StringBuffer();
//    new VCoreModelAsCodeSerialiser().serialise(package, sb);
//    print(sb.toString());
//    return sb.toString();
  }
}
