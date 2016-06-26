String template(
        String sourceModelPackage,
        String packageRelationPackage,
        String fromPackageName,
        String toPackageName,
        String perClassRelation(
            String b(String className, String fromName, String toName,
                [String transformField(String b(String f, String t)),
                String mapProperties()])),
        String perRequiredAbstractToConcreteTransform(
            String b(String fromName, String toName,
                String perSubTypeTransform(String b(String f, String t)))),
        String perCustomTransform(
            String b(String fromName, String toName, String fromPathSegments,
                String toPathSegments))) =>
    '''
import 'package:vcore/vcore.dart';
import 'package:vcore_m2m/vcore_m2m.dart';
import 'package:built_collection/built_collection.dart';
import 'package:option/option.dart';
import 'package:logging/logging.dart';

import '$sourceModelPackage';
import '$packageRelationPackage' as relations;

final _log = new Logger('${_uncapitalise(fromPackageName)}To${_capitalise(toPackageName)}Relation');

${perClassRelation((String className, String fromName, String toName,
      [String transformField(String b(String f, String t)),
      String mapProperties()]) =>
  '''
class $className extends AbstractTransformation<$fromName,
    ${fromName}Builder, $toName, ${toName}Builder> {
  ${transformField((f, t) => '''
  final Transform<$f, $t> ${_uncapitalise(f)}To${t}Transform;
  ''')}
  $className($fromName from, TransformationContext context
  ${transformField((f, t) => '''
      , this.${_uncapitalise(f)}To${t}Transform''')})
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
    return ($fromName ${_uncapitalise(fromName)}) => new ${fromName}To${toName}Transformation(${_uncapitalise(fromName)}, this
  ${transformField((f, t) => '''
      , _create${f}To${t}Transform()''')})
        .transform();
  }
''')}

${perRequiredAbstractToConcreteTransform((String fromName, String toName,
      String perSubTypeTransform(String b(String f, String t))) =>
'''
  Transform<$fromName, $toName> _create${fromName}To${toName}Transform() {
${perSubTypeTransform((String f, String t) =>
'''
    final ${_uncapitalise(f)}To${t}Transformation =
        _create${f}To${t}Transform();
''')}
    return ($fromName ${_uncapitalise(fromName)}) {
${perSubTypeTransform((String f, String t) =>
'''
      if (${_uncapitalise(fromName)} is $f) {
        return ${_uncapitalise(f)}To${t}Transformation(${_uncapitalise(fromName)} as $f);
      }''')}
 else {
        throw new StateError(
            "No transform from \${${_uncapitalise(fromName)}.runtimeType} to $toName");
      }
    };
  }
''')}

${perCustomTransform((String fromName, String toName,
      String fromPathSegments,String toPathSegments) =>
'''
  Transform<$fromName, $toName> _create${fromName}To${toName}Transform() {
    // TODO: should cache these lookups
    final classRelation = packageRelation.classifierRelations.firstWhere(
            (cr) => cr.from.name == '$fromName' && cr.to.name == '$toName')
        as ValueClassRelation;

    final propertyRelation = classRelation.propertyRelations.firstWhere((pr) =>
        pr.from.path == new BuiltList<String>($fromPathSegments) &&
        pr.to.path == new BuiltList<String>($toPathSegments));

    return propertyRelation.transform.forwards as Transform<$fromName, $toName>;
  }

''')}

}
''';

// TODO: these should be in a util
String _capitalise(String s) =>
    s.substring(0, 1).toUpperCase() + s.substring(1);

String _uncapitalise(String s) =>
    s.substring(0, 1).toLowerCase() + s.substring(1);
