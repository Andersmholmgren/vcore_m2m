library transformer_meta;

import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:option/option.dart';
import 'package:vcore/vcore.dart';

part 'transformer_meta.g.dart';

abstract class PackageTransformationMetaModel
    implements
        Built<PackageTransformationMetaModel,
            PackageTransformationMetaModelBuilder> {
  TransformationContextMetaModel get context;
  Uri get packageRelationPackageUri;
  Uri get sourceModelPackageUri;
  String get fromPackageName;
  String get toPackageName;

  PackageTransformationMetaModel._();

  factory PackageTransformationMetaModel(
          [updates(PackageTransformationMetaModelBuilder b)]) =
      _$PackageTransformationMetaModel;

  void generate(StringSink sink) {
    sink.writeln('''
import 'package:vcore/vcore.dart';
import 'package:vcore_m2m/vcore_m2m.dart';
import 'package:built_collection/built_collection.dart';
import 'package:option/option.dart';
import 'package:logging/logging.dart';

import '${sourceModelPackageUri.toString()}';
import '${packageRelationPackageUri.toString()}' as relations;

final _log = new Logger('${_unCapitalise(fromPackageName)}To${_capitalise(toPackageName)}Relation');
''');

    context.transformations.forEach((t) {
      t.generate(sink);
    });

    context.generate(sink);
  }
}

abstract class PackageTransformationMetaModelBuilder
    implements
        Builder<PackageTransformationMetaModel,
            PackageTransformationMetaModelBuilder> {
  TransformationContextMetaModelBuilder context =
      new TransformationContextMetaModelBuilder();
  Uri packageRelationPackageUri;
  Uri sourceModelPackageUri;
  String fromPackageName;
  String toPackageName;

  PackageTransformationMetaModelBuilder._();

  factory PackageTransformationMetaModelBuilder() =
      _$PackageTransformationMetaModelBuilder;
}

/// meta model for a [AbstractTransformation]
abstract class TransformationMetaModel
    implements Built<TransformationMetaModel, TransformationMetaModelBuilder> {
  String get fromTypeName;
  String get toTypeName;
  BuiltList<TransformMetaModel> get requiredTransforms =>
      new BuiltList<TransformMetaModel>(
          propertyTransforms.expand((pt) => pt.transform));

  BuiltSet<PropertyTransform> get propertyTransforms;

  TransformationMetaModel._();

  factory TransformationMetaModel([updates(TransformationMetaModelBuilder b)]) =
      _$TransformationMetaModel;

  void generate(StringSink sink) {
    final className = "${fromTypeName}To${toTypeName}Transformation";
    sink.writeln('''
class $className extends AbstractTransformation<$fromTypeName,
    ${fromTypeName}Builder, $toTypeName, ${toTypeName}Builder> {
  ${_transformField((f, t) => '''
  final Transform<$f, $t> ${_unCapitalise(f)}To${t}Transform;
  ''')}
  $className($fromTypeName from, TransformationContext context
  ${_transformField((f, t) => '''
      , this.${_unCapitalise(f)}To${t}Transform''')})
      : super(from, context, new ${toTypeName}Builder());

  @override
  void mapProperties() {
    _log.finer(() => 'mapProperties for $fromTypeName');

    ${_mapProperties()}
  }
}
''');
  }

  String _transformField(String b(String f, String t)) =>
      requiredTransforms.map((f) => b(f.fromName, f.toName)).join('\n');

  String _mapProperties() =>
      propertyTransforms.map((p) => p.toSourceString()).join('\n\n');
}

abstract class TransformationMetaModelBuilder
    implements
        Builder<TransformationMetaModel, TransformationMetaModelBuilder> {
  String fromTypeName;
  String toTypeName;
  SetBuilder<PropertyTransformBuilder> propertyTransforms =
      new SetBuilder<PropertyTransformBuilder>();

  TransformationMetaModelBuilder._();

  factory TransformationMetaModelBuilder() = _$TransformationMetaModelBuilder;
}

abstract class TransformMetaModel
    implements Built<TransformMetaModel, TransformMetaModelBuilder> {
  String get fromName;
  String get toName;

  String get variableName => '${_unCapitalise(fromName)}To${toName}Transform';

  TransformMetaModel._();

  factory TransformMetaModel([updates(TransformMetaModelBuilder b)]) =
      _$TransformMetaModel;
}

abstract class TransformMetaModelBuilder
    implements Builder<TransformMetaModel, TransformMetaModelBuilder> {
  String fromName;
  String toName;

  TransformMetaModelBuilder._();

  factory TransformMetaModelBuilder() = _$TransformMetaModelBuilder;
}

abstract class PropertyTransform
    implements Built<PropertyTransform, PropertyTransformBuilder> {
  Classifier get fromSimpleType;
  Classifier get toSimpleType;
  String get fromTypeName => fromSimpleType.name;
  String get toTypeName => toSimpleType.name;
  BuiltList<String> get fromPathSegments;
  BuiltList<String> get toPathSegments;
  bool get converterRequired => fromTypeName != toTypeName;

  Option<TransformMetaModel> get transform => converterRequired
      ? new Some(new TransformMetaModel((b) {
          b
            ..fromName = fromTypeName
            ..toName = toTypeName;
        }))
      : const None();

  Option<String> get transformName =>
      transform.map((t) => t.variableName) as Option<String>;

  bool get hasCustomTransform;
  bool get isCollection;
  bool get requiresToBuilder;
  bool get isAbstract;

  PropertyTransform._();

  factory PropertyTransform([updates(PropertyTransformBuilder b)]) =
      _$PropertyTransform;

  String toSourceString() =>
      isCollection ? _toCollectionString() : _toSingleString();

  String get _toPath => 'toBuilder.${toPathSegments.join('.')}';
  String get _fromPath => 'from.${fromPathSegments.join('?.')}';
  String pathExpression(BuiltList<String> path) =>
      '${[path.map((s) => "'$s'").join(', ')]}';

  String get fromPathExpression => pathExpression(fromPathSegments);
  String get toPathExpression => pathExpression(toPathSegments);

  String _possiblyTransformed(String varName) =>
      transformName.map((tn) => '$tn($varName)').getOrElse(() => varName);

  String _toSingleString() => "$_toPath = ${_possiblyTransformed(_fromPath)};";

  String get _possiblyToBuilder => requiresToBuilder ? '?.toBuilder()' : '';

  String _toCollectionString() {
    return '''
    if ($_fromPath != null) {
      $_fromPath.forEach((e) {
        $_toPath.add(${_possiblyTransformed('e')}$_possiblyToBuilder);
      });
    }
    ''';
  }
}

abstract class PropertyTransformBuilder
    implements Builder<PropertyTransform, PropertyTransformBuilder> {
  Classifier fromSimpleType;
  Classifier toSimpleType;
  BuiltList<String> fromPathSegments;
  BuiltList<String> toPathSegments;
  bool hasCustomTransform;
  bool isCollection;
  bool requiresToBuilder;
  bool isAbstract;

  PropertyTransformBuilder._();

  factory PropertyTransformBuilder() = _$PropertyTransformBuilder;
}

abstract class TransformationContextMetaModel
    implements
        Built<TransformationContextMetaModel,
            TransformationContextMetaModelBuilder> {
  BuiltSet<TransformationMetaModel> get transformations;
  BuiltSet<AbstractTypeMapping> get abstractTypeMappings;

  TransformationContextMetaModel._();

  factory TransformationContextMetaModel(
          [updates(TransformationContextMetaModelBuilder b)]) =
      _$TransformationContextMetaModel;

  void generate(StringSink sink) {
    sink.writeln('''
Option<Transform/*<F, T>*/ > lookupTransform/*<F, T>*/(
    Type fromType, Type toType) {
  return new _TransformationContext(relations.rootPackageRelation)
      .lookupTransform/*<F, T>*/(fromType, toType);
}

class _TransformationContext extends BaseTransformationContext {
  final PackageRelation packageRelation;

  _TransformationContext(this.packageRelation) {
    transformers = (new MapBuilder<TransformKey, TransformFactory>()
${_perClassRelation((String fromName, String toName, _) =>
    '''
          ..[new TransformKey((b) => b
            ..from = $fromName
            ..to = $toName)] = _create${fromName}To${toName}Transform
''')})
        .build();
  }

${_perClassRelation((String fromName, String toName,
      [String transformField(String b(String f, String t))]) =>
    '''
  Transform<$fromName, $toName> _create${fromName}To${toName}Transform() {
    return ($fromName ${_unCapitalise(fromName)}) => new ${fromName}To${toName}Transformation(${_unCapitalise(fromName)}, this
  ${transformField((f, t) => '''
      , _create${f}To${t}Transform()''')})
        .transform();
  }
''')}

${_perRequiredAbstractToConcreteTransform((String fromName, String toName,
      String perSubTypeTransform(String b(String f, String t))) =>
    '''
  Transform<$fromName, $toName> _create${fromName}To${toName}Transform() {
${perSubTypeTransform((String f, String t) =>
    '''
    final ${_unCapitalise(f)}To${t}Transformation =
        _create${f}To${t}Transform();
''')}
    return ($fromName ${_unCapitalise(fromName)}) {
${perSubTypeTransform((String f, String t) =>
    '''
      if (${_unCapitalise(fromName)} is $f) {
        return ${_unCapitalise(f)}To${t}Transformation(${_unCapitalise(fromName)} as $f);
      }''')}
 else {
        throw new StateError(
            "No transform from \${${_unCapitalise(fromName)}.runtimeType} to $toName");
      }
    };
  }
''')}

${_perCustomTransform((String fromName, String toName,
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
''');
  }

  String _perClassRelation(
      String b(String fromName, String toName,
          [String transformField(String b(String f, String t))])) {
    return transformations.map((h) {
      return b(h.fromTypeName, h.toTypeName, h._transformField);
    }).join('\n');
  }

  String _perCustomTransform(
      String b(String fromName, String toName, String fromPathSegments,
          String toPathSegments)) {
    final propertyHelpers =
        transformations.expand((h) => h.propertyTransforms).toSet();
    return propertyHelpers.map((ph) {
      return ph.hasCustomTransform
          ? b(ph.fromTypeName, ph.toTypeName, ph.fromPathExpression,
              ph.toPathExpression)
          : "";
    }).join('\n');
  }

  String _perRequiredAbstractToConcreteTransform(
      String b(String fromName, String toName,
          String perAvailableTransform(String b(String f, String t)))) {
    final StringBuffer buffer = new StringBuffer();

    abstractTypeMappings.forEach((m) {
      final fromName = m.fromTypeName;
      final toName = m.toTypeName;
//      print('requiredAbstractTransforms: $fromName -> $toName');

      buffer.writeln(b(fromName, toName, m.perSubTypeTransform));
    });

    return buffer.toString();
  }
}

abstract class TransformationContextMetaModelBuilder
    implements
        Builder<TransformationContextMetaModel,
            TransformationContextMetaModelBuilder> {
  SetBuilder<TransformationMetaModelBuilder> transformations =
      new SetBuilder<TransformationMetaModelBuilder>();

  SetBuilder<AbstractTypeMappingBuilder> abstractTypeMappings =
      new SetBuilder<AbstractTypeMappingBuilder>();

  TransformationContextMetaModelBuilder._();

  factory TransformationContextMetaModelBuilder() =
      _$TransformationContextMetaModelBuilder;
}

abstract class AbstractTypeMapping
    implements Built<AbstractTypeMapping, AbstractTypeMappingBuilder> {
  String get fromTypeName;
  String get toTypeName;
  BuiltSet<TransformMetaModel> get subTypeMappings;

  AbstractTypeMapping._();

  factory AbstractTypeMapping([updates(AbstractTypeMappingBuilder b)]) =
      _$AbstractTypeMapping;

  String perSubTypeTransform(String b(String f, String t)) =>
      subTypeMappings.map((h) => b(h.fromName, h.toName)).join('\n');
}

abstract class AbstractTypeMappingBuilder
    implements Builder<AbstractTypeMapping, AbstractTypeMappingBuilder> {
  String fromTypeName;
  String toTypeName;
  SetBuilder<TransformMetaModelBuilder> subTypeMappings =
      new SetBuilder<TransformMetaModelBuilder>();

  AbstractTypeMappingBuilder._();

  factory AbstractTypeMappingBuilder() = _$AbstractTypeMappingBuilder;
}

// TODO: these should be in a util
String _capitalise(String s) =>
    s.substring(0, 1).toUpperCase() + s.substring(1);

String _unCapitalise(String s) =>
    s.substring(0, 1).toLowerCase() + s.substring(1);
