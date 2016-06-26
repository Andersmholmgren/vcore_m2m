String template(
        String lower(String s),
        String perClassRelation(
            String b(String className, String fromName, String toName,
                [String transformField(String b(String f, String t)),
                String mapProperties()])),
        String perRequiredAbstractToConcreteTransform(
            String b(String fromName, String toName,
                String perAvailableTransform(String b(String f, String t))))) =>
    '''
import 'package:jason_schemer/src/models/schema.dart';
import 'package:vcore/vcore.dart';
import 'package:vcore_m2m/vcore_m2m.dart';
import 'package:built_collection/built_collection.dart';
import 'package:option/option.dart';
import 'package:logging/logging.dart';
import 'package:jason_schemer/src/m2m/schema_to_vcore.dart' as relations;

final _log = new Logger('schemaTovcoreRelation');

${perClassRelation((String className, String fromName, String toName,
      [String transformField(String b(String f, String t)),
      String mapProperties()]) =>
  '''
class $className extends AbstractTransformation<$fromName,
    ${fromName}Builder, $toName, ${toName}Builder> {
  ${transformField((f, t) => '''
  final Transform<$f, $t> ${lower(f)}To${t}Transform;
  ''')}
  $className($fromName from, TransformationContext context
  ${transformField((f, t) => '''
      , this.${lower(f)}To${t}Transform''')})
      : super(from, context, new ${toName}Builder());

  @override
  void mapProperties() {
    _log.finer(() => 'mapProperties for $fromName');

    ${mapProperties()}
  }
}
''')}


Option<Transform/*<F, T>*/ > lookupTransform/*<F, T>*/(
    Type fromType, Type toType) {
  return new _TransformationContext(relations.rootPackageRelation)
      .lookupTransform/*<F, T>*/(fromType, toType);
}

class _TransformationContext extends BaseTransformationContext {
  final PackageRelation packageRelation;

  _TransformationContext(this.packageRelation) {
    transformers = (new MapBuilder<TransformKey, TransformFactory>()
${perClassRelation((String className, String fromName, String toName, _, __) =>
'''
          ..[new TransformKey((b) => b
            ..from = $fromName
            ..to = $toName)] = _create${fromName}To${toName}Transform
''')})
        .build();
  }

${perClassRelation((String className, String fromName, String toName,
      [String transformField(String b(String f, String t)), __]) =>
    '''
  Transform<$fromName, $toName> _create${fromName}To${toName}Transform() {
    return ($fromName ${lower(fromName)}) => new ${fromName}To${toName}Transformation(${lower(fromName)}, this
  ${transformField((f, t) => '''
      , _create${f}To${t}Transform()''')})
        .transform();
  }
''')}

${perRequiredAbstractToConcreteTransform((String fromName, String toName,
      String perAvailableTransform(String b(String f, String t))) =>
'''
  Transform<$fromName, $toName> _create${fromName}To${toName}Transform() {
${perAvailableTransform((String f, String t) =>
'''
    final ${lower(f)}To${t}Transformation =
        _create${f}To${t}Transform();
''')}
    return ($fromName ${lower(fromName)}) {
${perAvailableTransform((String f, String t) =>
'''
      if (${lower(fromName)} is $f) {
        return ${lower(f)}To${t}Transformation(${lower(fromName)} as $f);
      }''')}
 else {
        throw new StateError(
            "No transform from \${$fromName.runtimeType} to $toName");
      }
    };
  }
''')}

  Transform<Uri, String> _createUriToStringTransform() {
    // TODO: should cache these lookups
    final classRelation = packageRelation.classifierRelations.firstWhere(
            (cr) => cr.from.name == 'Schema' && cr.to.name == 'Package')
        as ValueClassRelation;

    final propertyRelation = classRelation.propertyRelations.firstWhere((pr) =>
        pr.from.path == new BuiltList<String>(['id']) &&
        pr.to.path == new BuiltList<String>(['name']));

    return propertyRelation.transform.forwards as Transform<Uri, String>;
  }

  Transform<Uri, String> _createUriToStringTransform() {
    // TODO: should cache these lookups
    final classRelation = packageRelation.classifierRelations.firstWhere(
            (cr) => cr.from.name == 'Schema' && cr.to.name == 'ValueClass')
        as ValueClassRelation;

    final propertyRelation = classRelation.propertyRelations.firstWhere((pr) =>
        pr.from.path == new BuiltList<String>(['id']) &&
        pr.to.path == new BuiltList<String>(['name']));

    return propertyRelation.transform.forwards as Transform<Uri, String>;
  }
}

''';
