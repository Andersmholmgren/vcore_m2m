library transformer_meta;

import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:option/option.dart';

part 'transformer_meta.g.dart';

/// meta model for a [AbstractTransformation]
abstract class TransformationMetaModel
    implements Built<TransformationMetaModel, TransformationMetaModelBuilder> {
  String get fromTypeName;
  String get toTypeName;
  BuiltList<TransformMetaModel> get requiredTransforms;
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
  final Transform<$f, $t> ${_uncapitalise(f)}To${t}Transform;
  ''')}
  $className($fromTypeName from, TransformationContext context
  ${_transformField((f, t) => '''
      , this.${_uncapitalise(f)}To${t}Transform''')})
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
      propertyTransforms.map((p) => p.toString()).join('\n');
}

abstract class TransformationMetaModelBuilder
    implements
        Builder<TransformationMetaModel, TransformationMetaModelBuilder> {
  String fromTypeName;
  String toTypeName;
  ListBuilder<TransformMetaModelBuilder> requiredTransforms =
      new ListBuilder<TransformMetaModelBuilder>();
  SetBuilder<PropertyTransformBuilder> propertyTransforms =
      new SetBuilder<PropertyTransformBuilder>();

  TransformationMetaModelBuilder._();

  factory TransformationMetaModelBuilder() = _$TransformationMetaModelBuilder;
}

abstract class TransformMetaModel
    implements Built<TransformMetaModel, TransformMetaModelBuilder> {
  String get fromName;
  String get toName;

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
  BuiltList<String> get fromPathSegments;
  BuiltList<String> get toPathSegments;
  Option<String> get transformName;
  bool get isCollection;
  bool get requiresToBuilder;

  PropertyTransform._();

  factory PropertyTransform([updates(PropertyTransformBuilder b)]) =
      _$PropertyTransform;

  String toString() => isCollection ? _toCollectionString() : _toSingleString();

  String get _fromPath => (['from']..addAll(fromPathSegments)).join('.');
  String get _toPath => (['toBuilder']..addAll(toPathSegments)).join('.');

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
  BuiltList<String> fromPathSegments;
  BuiltList<String> toPathSegments;
  Option<String> transformName;
  bool isCollection;
  bool requiresToBuilder = false;

  PropertyTransformBuilder._();

  factory PropertyTransformBuilder() = _$PropertyTransformBuilder;
}

// TODO: these should be in a util
String _capitalise(String s) =>
    s.substring(0, 1).toUpperCase() + s.substring(1);

String _uncapitalise(String s) =>
    s.substring(0, 1).toLowerCase() + s.substring(1);
