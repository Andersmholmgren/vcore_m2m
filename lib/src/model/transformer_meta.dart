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
}

abstract class TransformationMetaModelBuilder
    implements
        Builder<TransformationMetaModel, TransformationMetaModelBuilder> {
  String fromTypeName;
  String toTypeName;
  TransformationMetaModelBuilder._();

  factory TransformationMetaModelBuilder() = _$TransformationMetaModelBuilder;
}
