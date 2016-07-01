library transformer_meta;

import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';

part 'transformer_meta.g.dart';

/// meta model for a [AbstractTransformation]
abstract class TransformationMetaModel
    implements Built<TransformationMetaModel, TransformationMetaModelBuilder> {
  String get fromTypeName;
  String get toTypeName;
  BuiltList<TransformMetaModel> get requiredTransforms;

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

    ${mapProperties()}
  }
}
''');
  }

  String _transformField(String b(String f, String t)) =>
      requiredTransforms.map((f) => b(f.fromName, f.toName)).join('\n');
}

abstract class TransformationMetaModelBuilder
    implements
        Builder<TransformationMetaModel, TransformationMetaModelBuilder> {
  String fromTypeName;
  String toTypeName;
  ListBuilder<TransformMetaModelBuilder> requiredTransforms =
      new ListBuilder<TransformMetaModelBuilder>();

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

// TODO: these should be in a util
String _capitalise(String s) =>
    s.substring(0, 1).toUpperCase() + s.substring(1);

String _uncapitalise(String s) =>
    s.substring(0, 1).toLowerCase() + s.substring(1);
