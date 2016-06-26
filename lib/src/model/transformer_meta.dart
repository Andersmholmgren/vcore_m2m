library transformer_meta;

import 'package:built_value/built_value.dart';

part 'transformer_meta.g.dart';

/// meta model for a [AbstractTransformation]
abstract class TransformationMetaModel
    implements Built<TransformationMetaModel, TransformationMetaModelBuilder> {
  String get fromTypeName;
  String get toTypeName;

  TransformationMetaModel._();

  factory TransformationMetaModel([updates(TransformationMetaModelBuilder b)]) =
      _$TransformationMetaModel;

  void generate(StringSink sink) {
    final className = "${fromTypeName}To${toTypeName}Transformation";
    sink.writeln('''
class $className extends AbstractTransformation<$fromTypeName,
    ${fromTypeName}Builder, $toTypeName, ${toTypeName}Builder> {
  ${transformField((f, t) => '''
  final Transform<$f, $t> ${_uncapitalise(f)}To${t}Transform;
  ''')}
  $className($fromTypeName from, TransformationContext context
  ${transformField((f, t) => '''
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
}

abstract class TransformationMetaModelBuilder
    implements
        Builder<TransformationMetaModel, TransformationMetaModelBuilder> {
  String fromTypeName;
  String toTypeName;
  TransformationMetaModelBuilder._();

  factory TransformationMetaModelBuilder() = _$TransformationMetaModelBuilder;
}

// TODO: these should be in a util
String _capitalise(String s) =>
    s.substring(0, 1).toUpperCase() + s.substring(1);

String _uncapitalise(String s) =>
    s.substring(0, 1).toLowerCase() + s.substring(1);
