library relation_to_transformation_generator;

import 'dart:async';
import 'dart:io';

import 'package:analyzer/src/generated/element.dart';
import 'package:source_gen/source_gen.dart';
//import 'package:vcore_generator/src/dart_source_to_vcore.dart';
import 'package:vcore_generator/vcore_generator.dart';
import 'package:vcore/vcore.dart';
import 'dart:convert';
//import 'package:vcore_generator/src/vcore_model_as_code_serialiser.dart';
import 'package:vcore_m2m/src/model/transform.dart';

/// Generates a [TransformLookup] from a [PackageRelation]
///
class RelationToTransformationGenerator extends Generator {
  Future<String> generate(Element element) async {
    if (element is! LibraryElement) return null;

    // TODO(moi): better way of checking for top level declaration.
    if (!element.definingCompilationUnit.accessors
        .any((element) => element.returnType.displayName == 'TransformLookup'))
      return null;

    print('yaaay: ${element.name}');
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
